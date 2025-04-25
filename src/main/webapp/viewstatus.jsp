<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("userlogin.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Status</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border-bottom: 2px solid black;
            font-weight: bold;
        }
        th {
            text-align: left;
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
            <table>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Status</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "", "");

                        String sql = "SELECT ID, name, status FROM status WHERE user = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, username);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("ID") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("status") %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
