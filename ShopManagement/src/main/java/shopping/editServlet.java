package shopping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * Servlet implementation class editServlet
 */
public class editServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int productId = Integer.parseInt(request.getParameter("editProductId"));
		 String productName = request.getParameter("editProductName");
		 double productPrice = Double.parseDouble(request.getParameter("editProductPrice"));
		 int additionalQuantity = Integer.parseInt(request.getParameter("editProductQuantity"));
		
		 Connection con = null;
		 PreparedStatement statement = null;
		 try {
		     // Establish connection to the database
		 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password");
		
		 // Update product details
		 statement = con.prepareStatement("UPDATE products SET name = ?, price = ?, quantity = quantity + ? WHERE id = ?");
		 statement.setString(1, productName);
		 statement.setDouble(2, productPrice);
		 statement.setInt(3, additionalQuantity);
		 statement.setInt(4, productId);
		
		 // Execute the SQL statement
		 int rowsAffected = statement.executeUpdate();
		 if (rowsAffected > 0) {
		     String successMessage = "Product updated successfully.";
		 request.setAttribute("successMessage", successMessage);
		 } else {
		     String errorMessage = "Error: Unable to update product.";
		 request.setAttribute("errorMessage", errorMessage);
		     }
		 } catch (SQLException e) {
		     e.printStackTrace();
		     String errorMessage = "Database error: " + e.getMessage();
		 request.setAttribute("errorMessage", errorMessage);
		 } catch (NumberFormatException e) {
		     e.printStackTrace();
		     String errorMessage = "Invalid number format for product ID or additional quantity.";
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
		
		 // Forward the request to the appropriate JSP page
		 request.getRequestDispatcher("manage_product.jsp?fromPage=" + request.getParameter("fromPage")).forward(request, response);
		     }
		 }
}