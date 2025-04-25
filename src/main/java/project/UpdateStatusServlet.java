package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String JDBC_USER = "";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            
            for (String param : request.getParameterMap().keySet()) {
                if (param.startsWith("status_")) {
                    int id = Integer.parseInt(param.split("_")[1]);
                    String newStatus = request.getParameter(param);

                    String query = "UPDATE status SET status=? WHERE id=?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, newStatus);
                    stmt.setInt(2, id);
                    stmt.executeUpdate();
                }
            }
            conn.close();
            response.sendRedirect("admindashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
