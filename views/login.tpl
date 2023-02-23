<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <title>Pinwand - Login</title>
</head>
<body>
<div class="container m-3">
<h3>Login</h3>
<form action="/login" method="post">
  <div class="mb-3">
    <label>Username</label>
    <input type="text" class="form-control" name="username" placeholder="Gib deinen Accountnamen ein." value="{{username}}" required>
  </div>
  <div class="mb-3">
    <label>Passwort</label>
    <input type="password" class="form-control" name="password" placeholder="Gib dein Passwort ein." required>
  </div>
  <button type="submit" class="btn btn-primary">Einloggen</button>
</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
</html>
