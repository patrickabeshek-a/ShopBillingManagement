package shopping;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class removeServlet
 */
public class removeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	String productIdStr = request.getParameter("removeProductId");
	        int productId = Integer.parseInt(productIdStr);

	        Connection con = null;
	        PreparedStatement statement = null;
	        try {
	            // Assuming you have already established a connection to your database
	        	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop","root","password");
	            statement = con.prepareStatement("DELETE FROM products WHERE id = ?");
	            statement.setInt(1, productId);
	            
	            int rowsAffected = statement.executeUpdate();
	            if (rowsAffected > 0) {
	                String successMessage = "Product removed successfully.";
	                request.setAttribute("successMessage", successMessage);
	            } else {
	                String errorMessage = "Product with the specified ID not found.";
	                request.setAttribute("errorMessage", errorMessage);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            String errorMessage = "Database error: " + e.getMessage();
	            request.setAttribute("errorMessage", errorMessage);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	            String errorMessage = "Invalid number format for product ID.";
	            request.setAttribute("errorMessage", errorMessage);
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
	            RequestDispatcher dispatcher = request.getRequestDispatcher("manage_product.jsp?fromPage=" + request.getParameter("fromPage"));
	            dispatcher.forward(request, response);
	        }
	    }	
}
