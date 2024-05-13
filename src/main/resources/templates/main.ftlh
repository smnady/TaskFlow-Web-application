<!DOCTYPE html>
<html lang="en">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300..700&display=swap" rel="stylesheet">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <title>TaskFlow</title>
    <style>
        body {
            font-family: "Comfortaa", sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
        }

        .title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }

        .register {
            background-color: #3498db;
            color: white;
        }

        .login {
            background-color: #2ecc71;
            color: white;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="title"> TaskFlow </div>

    <button class="button register" onclick="showRegistrationForm()">Зарегистрироваться</button>
    <button class="button login" onclick="showLoginForm()">Войти</button>

    <div id="registrationForm" style="display: none;">
        <h2>Форма регистрации</h2>
        <form action="/register" method="POST">
            <label for="username">Имя: </label>
            <input type="text" id="username" name="username" required><br>
            <label for="email">Email: </label>
            <input type="text" id="email" name="email" required><br>
            <label for="password">Пароль:</label>
            <input type="password" id="password" name="password" required><br>
            <button type="submit">Зарегистрироваться</button>
        </form>
    </div>

    <div id="loginForm" style="display: none;">
        <h2>Форма входа</h2>
        <form action="/login" method="POST">
            <label for="email">Email: </label>
            <input type="text" name="email" required><br>
            <label for="password">Пароль: </label>
            <input type="password" name="password" required><br>
            <button type="submit">Войти</button>
        </form>
    </div>
</div>

<script>
    function showRegistrationForm() {
        document.getElementById('registrationForm').style.display = 'block';
        document.getElementById('loginForm').style.display = 'none';
    }

    function showLoginForm() {
        document.getElementById('registrationForm').style.display = 'none';
        document.getElementById('loginForm').style.display = 'block';
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>

</html>