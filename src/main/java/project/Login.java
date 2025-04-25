package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String JDBC_USER = "";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            if ("register".equals(action)) {
                if (registerUser(conn, username, password)) {
                    out.println("<script>alert('Registration Successful!'); window.location.href='userlogin.jsp';</script>");
                } else {
                    out.println("<script>alert('Username already exists!'); window.location.href='userlogin.jsp';</script>");
                }
            } else {
            	if (validateLogin(conn, username, password)) {
            	    HttpSession session = request.getSession();
            	    session.setAttribute("username", username);
            	    response.sendRedirect("upload.jsp");
            	}else {
                    out.println("<script>alert('Invalid Credentials!'); window.location.href='userlogin.jsp';</script>");
                }
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='userlogin.jsp';</script>");
        }
    }

    private boolean validateLogin(Connection conn, String username, String password) throws Exception {
        String query = "SELECT * FROM users WHERE username=? AND password=?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();
        return rs.next();
    }

    private boolean registerUser(Connection conn, String username, String password) throws Exception {
        String checkQuery = "SELECT * FROM users WHERE username=?";
        PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
        checkStmt.setString(1, username);
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next()) return false; // Username already exists
        
        String insertQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, username);
        insertStmt.setString(2, password);
        insertStmt.executeUpdate();
        return true;
    }
}
