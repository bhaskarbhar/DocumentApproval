package project;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@WebServlet("/Upload")
@MultipartConfig
public class Upload extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "your_upload_directory";
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String JDBC_USER = "";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        if (username == null) {
            response.getWriter().println("<script>alert('You are not logged in!'); window.location.href='userlogin.jsp';</script>");
            return;
        }
        
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        
        if (!fileName.toLowerCase().endsWith(".pdf")) {
            response.getWriter().println("<script>alert('Only PDF files are allowed!'); window.location.href='upload.jsp';</script>");
            return;
        }
        
        File file = new File(UPLOAD_DIRECTORY, fileName);
        
        try (InputStream fileContent = filePart.getInputStream(); FileOutputStream fos = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String query = "INSERT INTO status (name, status, user) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, fileName);
            stmt.setString(2, "submitted");
            stmt.setString(3, username);
            stmt.executeUpdate();
            conn.close();
            response.getWriter().println("<script>alert('File uploaded successfully!'); window.location.href='upload.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Upload failed: " + e.getMessage() + "'); window.location.href='upload.jsp';</script>");
        }
    }
}
