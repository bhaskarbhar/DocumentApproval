<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/your_database";
    String jdbcUser = "";
    String jdbcPassword = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Status</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=League+Spartan:wght@400;700&display=swap');
        body { font-family: Arial, sans-serif; background-color: #ff6347; margin: 0; padding: 0; }
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
        .container { background-color: #fdbb4c; width: 80%; margin: auto; padding: 20px; border-radius: 10px; position: relative; top: 80px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; text-align: left; }
        th { background-color: #ff5733; color: white; }
        select, button { padding: 8px; border-radius: 5px; border: none; }
        .download { color: blue; font-weight: bold; text-decoration: none; }
    </style>
</head>
<body>
   <div class="navbar">
        <div>
            <a href="admindashboard.jsp.jsp">View Status</a>
        </div>
        <a href="logout">Log Out</a>
    </div>
    <div class="container">
        <form action="UpdateStatusServlet" method="post">
            <table border="1">
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>User</th>
                    <th>Current Status</th>
                    <th>Update Status</th>
                    <th>Download</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "", "");
                        String query = "SELECT * FROM status";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String user = rs.getString("user");
                            String status = rs.getString("status");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><b><%= name %></b></td>
                    <td><%= user %></td>
                    <td><%= status %></td>
                    <td>
                        <select name="status_<%= id %>">
                            <option value="submitted" <%= status.equals("submitted") ? "selected" : "" %>>submitted</option>
                            <option value="pending" <%= status.equals("pending") ? "selected" : "" %>>pending</option>
                            <option value="accepted" <%= status.equals("accepted") ? "selected" : "" %>>accepted</option>
                            <option value="rejected" <%= status.equals("rejected") ? "selected" : "" %>>rejected</option>
                        </select>
                    </td>
                    <td><a class="download" href="DownloadServlet?file=<%= name %>">download</a></td>
                </tr>
                <% 
                        }
                        conn.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </table>
            <br>
            <button type="submit" style="background-color:red; color:white;">Save</button>
        </form>
    </div>
</body>
</html>
