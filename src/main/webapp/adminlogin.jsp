<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - DocApprove</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=League+Spartan:wght@400;700&display=swap');
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f75d5d;
            font-family: 'League Spartan', sans-serif;
            box-sizing: border-box;
        }
        h1 {
            font-size: 6rem;
            font-weight: bold;
            margin-bottom: 40px;
            text-align: center;
        }
        .container {
            background-color: #fbb040;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-align: center;
            width: 600px;
            height: 400px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        input {
            display: block;
            width: calc(100% - 30px);
            padding: 15px;
            margin: 15px auto;
            border: none;
            border-radius: 10px;
            background-color: #d3d3d3;
            font-size: 1.2rem;
            box-sizing: border-box;
            width: 400px;
        }
        button {
            padding: 15px 30px;
            background-color: #f75d5d;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1.2rem;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div>
        <h1>DocApprove - Admin</h1>
        <div class="container">
            <form action="adminLogin" method="post">
                <input type="text" name="username" placeholder="Admin Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
            </form>
        </div>
    </div>
</body>
</html>
