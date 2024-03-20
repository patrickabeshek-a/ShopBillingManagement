package shopping;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class displayProductsServlet
 */
public class displayProductsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
        Statement statement = null;
        try {
            // Assuming you have already established a connection to your database
        	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop","root","password");
            statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT * FROM products");

            // Store the product data in a request attribute to pass to the JSP
            request.setAttribute("productResultSet", resultSet);
            
            // Forward the request to the display_products.jsp page
            RequestDispatcher dispatcher = request.getRequestDispatcher("display_products.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Redirect to an error page if needed
            response.sendRedirect("error.html");
        } finally {
            // Close the statement and connection
            try {
                if (statement != null) {
                    statement.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
