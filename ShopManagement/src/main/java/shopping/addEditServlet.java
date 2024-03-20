package shopping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class addEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        int productId = Integer.parseInt(productIdStr);
        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("productPrice"));
        int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
        String productType = request.getParameter("productType");

        Connection con = null;
        PreparedStatement statement = null;
        try {
            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password");

            // Prepare SQL statement to insert or update product details
            statement = con.prepareStatement("INSERT INTO products (id, name, price, quantity, type) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE name = ?, price = ?, quantity = ?, type = ?");
            statement.setInt(1, productId);
            statement.setString(2, productName);
            statement.setDouble(3, productPrice);
            statement.setInt(4, productQuantity);
            statement.setString(5, productType);
            statement.setString(6, productName);
            statement.setDouble(7, productPrice);
            statement.setInt(8, productQuantity);
            statement.setString(9, productType);

            // Execute the SQL statement
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                String successMessage = "Product added successfully.";
                request.setAttribute("successMessage", successMessage);
            } else {
                String errorMessage = "Error: Unable to add/update product.";
                request.setAttribute("errorMessage", errorMessage);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String errorMessage = "Database error: " + e.getMessage();
            request.setAttribute("errorMessage", errorMessage);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            String errorMessage = "Invalid number format for product ID, price, or quantity.";
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
