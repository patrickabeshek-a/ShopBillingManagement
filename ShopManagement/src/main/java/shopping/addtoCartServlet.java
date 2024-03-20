package shopping;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class addtoCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html");

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String message = "";

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password")) {
            con.setAutoCommit(false);

            // Check if the product exists
            PreparedStatement getProduct = con.prepareStatement("SELECT * FROM products WHERE id = ?");
            getProduct.setInt(1, productId);
            try (ResultSet productResultSet = getProduct.executeQuery()) {

                if (productResultSet.next()) {
                    double price = productResultSet.getDouble("price");
                    int availableQuantity = productResultSet.getInt("quantity");
                    if (quantity > availableQuantity) {
                        // If requested quantity exceeds available quantity, send error message
                        message = "Error: Not enough stock available for this product.";
                    } else {
                        // Calculate total price
                        double totalPrice = price * quantity;

                        // Update product quantity in the products table
                        PreparedStatement updateProduct = con.prepareStatement("UPDATE products SET quantity = ? WHERE id = ?");
                        updateProduct.setInt(1, availableQuantity - quantity);
                        updateProduct.setInt(2, productId);
                        updateProduct.executeUpdate();

                        // Check if the product is already in the cart
                        PreparedStatement checkCart = con.prepareStatement("SELECT * FROM cart WHERE product_id = ?");
                        checkCart.setInt(1, productId);
                        try (ResultSet cartResultSet = checkCart.executeQuery()) {
                            if (cartResultSet.next()) {
                                // Product is already in the cart, update the quantity
                                int currentQuantity = cartResultSet.getInt("quantity");
                                int updatedQuantity = currentQuantity + quantity;

                                // Update the quantity in the cart
                                PreparedStatement updateCart = con.prepareStatement("UPDATE cart SET quantity = ?, total_price = ? WHERE product_id = ?");
                                updateCart.setInt(1, updatedQuantity);
                                updateCart.setDouble(2, price * updatedQuantity);
                                updateCart.setInt(3, productId);
                                updateCart.executeUpdate();
                                message = "Product quantity updated in cart.";
                            } else {
                                // Product not in the cart, add it
                                PreparedStatement addToCart = con.prepareStatement("INSERT INTO cart (product_id, quantity, total_price) VALUES (?, ?, ?)");
                                addToCart.setInt(1, productId);
                                addToCart.setInt(2, quantity);
                                addToCart.setDouble(3, totalPrice);
                                addToCart.executeUpdate();
                                message = "Product added to cart.";
                            }
                        }
                    }
                } else {
                    message = "Error: Product not found.";
                }
            }

            // Retrieve all items from the cart
            List<String[]> cartItems = new ArrayList<>();
            try (PreparedStatement getCartItems = con.prepareStatement("SELECT products.name, cart.quantity, cart.total_price FROM cart JOIN products ON cart.product_id = products.id")) {
                try (ResultSet cartResultSet = getCartItems.executeQuery()) {
                    while (cartResultSet.next()) {
                        String productName = cartResultSet.getString("name");
                        int cartQuantity = cartResultSet.getInt("quantity");
                        double cartPrice = cartResultSet.getDouble("total_price");

                        String[] cartItem = { productName, String.valueOf(cartQuantity), String.valueOf(cartPrice) };
                        cartItems.add(cartItem);
                    }
                }
            }

            // Commit the transaction
            con.commit();

            // Set cart items and message as request attributes
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("message", message);

            // Forward the request to the JSP page
            request.getRequestDispatcher("add_to_cart.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
            message = "Error: An unexpected error occurred.";
            request.setAttribute("message", message);
            request.getRequestDispatcher("add_to_cart.jsp?fromPage=" + request.getParameter("fromPage")).forward(request, response);

        }
    }
}