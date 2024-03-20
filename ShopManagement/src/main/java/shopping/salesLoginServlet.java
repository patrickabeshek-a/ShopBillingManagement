package shopping;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class salesLoginServlet
 */
public class salesLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check credentials against database
        boolean validCredentials = false;
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String query = "SELECT * FROM sales WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            validCredentials = resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect to login page with error parameter if credentials are invalid
        if (!validCredentials) {
            response.sendRedirect("sales_login.jsp?error=invalid");
        } else {
            // Redirect to dashboard or another page upon successful login
            response.sendRedirect("sales.jsp");
        }
    }
}