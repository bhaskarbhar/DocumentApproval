<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DocApprove</title>
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
        .tabs {
            display: flex;
            justify-content: center;
            gap: 80px;
            margin-bottom: 40px;
            font-weight: bold;
            font-size: 3rem;
        }
        .tab {
            cursor: pointer;
        }
        .active {
            color: white;
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
        <h1>DocApprove...</h1>
        <div class="container">
            <div class="tabs">
                <span id="loginTab" class="tab active" onclick="toggleForm('login')">Login</span>
                <span id="registerTab" class="tab" onclick="toggleForm('register')">Register</span>
            </div>
            <form id="authForm" action="login" method="post">
    			<input type="hidden" name="action" id="action" value="login">
    			<input type="text" name="username" placeholder="Username" required>
    			<input type="password" name="password" placeholder="Password" required>
   				 <button type="submit" id="actionButton">Login</button>
			</form>
        </div>
    </div>

    <script>
        function toggleForm(mode) {
            const loginTab = document.getElementById('loginTab');
            const registerTab = document.getElementById('registerTab');
            const actionButton = document.getElementById('actionButton');
            const actionInput = document.getElementById('action');

            if (mode === 'register') {
                registerTab.classList.add('active');
                loginTab.classList.remove('active');
                actionButton.textContent = 'Register';
                actionInput.value = 'register';
            } else {
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
                actionButton.textContent = 'Login';
                actionInput.value = 'login';
            }
        }
    </script>
</body>
</html>
