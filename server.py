import bottle, sqlite3, secrets

db = sqlite3.connect('pinwand.db')
db.row_factory = sqlite3.Row

logged_in_users = {}

def check_credentials(username, password):
    cur = db.execute('SELECT password FROM User WHERE userid = ?;', (username, ))
    row = cur.fetchone()
    return row and row['password'] == password

def is_logged_in():
    token = bottle.request.get_cookie('USER_TOKEN')
    return token in logged_in_users

def get_loggedin_username():
    token = bottle.request.get_cookie('USER_TOKEN')
    if token in logged_in_users:
        return logged_in_users[token]
    else:
        return None

@bottle.get('/')
def show_index():
    if is_logged_in():
        bottle.redirect('/messages')
    else:
        bottle.redirect('/login')

@bottle.get('/static/<filename>')
def get_static_file(filename):
    return bottle.static_file(filename, 'static')

@bottle.get('/login')
def show_login():
    return bottle.template('login', username='')

@bottle.post('/login')
def do_login():
    username = bottle.request.forms.username.strip().lower()
    password = bottle.request.forms.password
    if check_credentials(username, password):
        token = ''
        while not token or token in logged_in_users:
            token = secrets.token_hex(16)
        logged_in_users[token] = username
        bottle.response.set_cookie('USER_TOKEN', token)
        bottle.redirect('/messages')
    else:
        return bottle.template('login', username=username)

@bottle.post('/logout')
def do_logout():
    token = bottle.request.get_cookie('USER_TOKEN')
    if token in logged_in_users:
        logged_in_users.pop(token)
    bottle.response.delete_cookie('USER_TOKEN')
    bottle.redirect('/')

@bottle.get('/messages')
def show_messages():
    return show_messages('')

@bottle.post('/messages')
def filter_messages():
    author_id = bottle.request.forms.author_id
    return show_messages(author_id)

def make_user_dict(users):
    user_dict = {}
    for user in users:
        user_dict[user['userid']] = user['fullname']
    return user_dict

def show_messages(author_id):
    cur = db.execute('SELECT * FROM User ORDER BY fullname ASC;')
    users = cur.fetchall()
    if author_id == '':
        cur = db.execute('SELECT * FROM Message ORDER BY date DESC;')
    else:
        cur = db.execute('SELECT * FROM Message WHERE author_id = ? ORDER BY date DESC;', (author_id, ))
    messages = cur.fetchall()
    return bottle.template('messages', users=users, messages=messages, user_dict=make_user_dict(users), selected_author=author_id)

@bottle.get('/newmessage')
def edit_message():
    user_id = get_loggedin_username()
    if not user_id:
        bottle.redirect('/login')
    return bottle.template('newmessage')

@bottle.post('/newmessage')
def post_message():
    user_id = get_loggedin_username()
    if not user_id:
        bottle.redirect('/login')
    text = bottle.request.forms.text
    db.execute('INSERT INTO Message (text, date, author_id) VALUES (?, datetime("now", "localtime"), ?);', (text, user_id))
    db.commit()
    return show_messages('')

bottle.run(host='localhost', port=8080, reloader=True)
