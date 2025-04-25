<% 
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("userlogin.jsp");
        return;
    }
%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Page</title>
    <link href="https://fonts.googleapis.com/css2?family=League+Spartan:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'League Spartan', sans-serif;
            background-color: #f87171;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        .navbar {
            background-color: #facc15;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
            color: black;
            margin: 0 15px;
        }
        .navbar a:hover {
            color: white;
        }
        .container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .box {
            background-color: #facc15;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .box h1, .box p {
            margin: 0 0 15px;
            font-weight: bold;
        }
        .upload-btn {
            background-color: #f87171;
            color: white;
            font-weight: bold;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .upload-btn:hover {
            background-color: #ef4444;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div>
            <a href="upload.jsp">Upload</a>
            <a href="viewstatus.jsp">View Status</a>
        </div>
        <a href="logout">Log Out</a>
    </div>
    <div class="container">
        <div class="box">
            <h1>Upload your documents</h1>
            <p>(pdfs are only allowed)</p>
            <form action="Upload" method="post" enctype="multipart/form-data">
			    <input type="file" name="file" accept=".pdf" required>
			    <button type="submit" class="upload-btn">Upload</button>
			</form>
        </div>
    </div>
</body>
</html>
