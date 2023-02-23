<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <title>Pinwand - Nachrichten</title>
</head>
<body>
<div class="container m-3">
<h3>Nachrichten</h3>
<form action="/messages" method="post">
  <div class="mb-3">
    <label>Person auswählen</label>
    <select class="form-select" name="author_id">
      <option value="">Alle</option>
% for user in users:
      <option value="{{user['userid']}}" {{'selected' if user['userid'] == selected_author else ''}}>{{user['fullname']}}</option>
% end
    </select>
    <button type="submit" class="btn btn-primary mb-3">Nachrichten filtern</button>
  </div>
</form>

<a href="/newmessage" class="btn btn-primary mb-3">Neue Nachricht posten</a>

<table class="table table-striped">
  <tr>
    <th>Von</th>
    <th>Zeit</th>
    <th>Text</th>
  </tr>
% for message in messages:
  <tr>
    <!--<td>{{message['author_id']}}</td>-->
    <td>{{user_dict[message['author_id']]}}</td>    
    <td>{{message['date']}}</td>
    <td>{{message['text']}}</td>
  </tr>
% end
</table>
<form action="/logout" method="post">
  <button type="submit" class="btn btn-danger mb-3">Logout</button>
</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
</html>
