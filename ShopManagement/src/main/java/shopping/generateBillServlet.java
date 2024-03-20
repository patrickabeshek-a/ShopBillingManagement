package shopping;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class generateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Fetch items from the cart
            Connection connection = getConnection();
            PreparedStatement getCartItems = connection.prepareStatement("SELECT products.name, products.type, cart.quantity, products.price FROM cart JOIN products ON cart.product_id = products.id");
            ResultSet cartResultSet = getCartItems.executeQuery();

            // Store bill details in a list of arrays
            List<String[]> billDetails = new ArrayList<>();
            double totalAmount = 0;
            double totalCGST = 0;
            double totalSGST = 0;

            // Calculate and store each item in the bill details list
            while (cartResultSet.next()) {
                String productName = cartResultSet.getString("name");
                String productType = cartResultSet.getString("type");
                int quantity = cartResultSet.getInt("quantity");
                double price = cartResultSet.getDouble("price");

                // Fetch tax rate for the product type
                double taxPercentage = getTaxPercentage(connection, productType);

                double totalPrice = price * quantity; // Total price for the item
                double cgst = ((taxPercentage / 2)/100) * totalPrice; // CGST
                double sgst = ((taxPercentage / 2)/100) * totalPrice; // SGST
                double amount = totalPrice + cgst + sgst; // Total amount for the item
                totalAmount += amount;
                totalCGST += cgst;
                totalSGST += sgst;

                // Round off CGST and SGST values
                cgst = Math.round(cgst * 100.0) / 100.0;
                sgst = Math.round(sgst * 100.0) / 100.0;

                // Add item details to the billDetails list
                String[] itemDetails = { productName, String.valueOf(quantity), String.valueOf(price), String.valueOf(cgst), String.valueOf(sgst), String.valueOf(amount) };
                billDetails.add(itemDetails);
            }

            // Insert the bill into the bills table
            PreparedStatement insertBill = connection.prepareStatement("INSERT INTO bills (date, items_bought, mode_of_pay, tax, amount) VALUES (?, ?, ?, ?, ?)");
            insertBill.setDate(1, Date.valueOf(LocalDate.now()));
            insertBill.setString(2, formatBillDetails(billDetails));
            // Assuming mode of payment is not handled in this example, you can modify it accordingly
            insertBill.setString(3, "Cash");
            // Tax calculation based on total CGST and SGST
            double tax = totalCGST + totalSGST;
            double roundedTax = Math.round(tax * 100.0) / 100.0; // Rounded to 2 decimal digits
            insertBill.setDouble(4, roundedTax);
            insertBill.setDouble(5, totalAmount); // Insert total amount
            insertBill.executeUpdate();

            // Clear the cart after generating the bill
            PreparedStatement clearCart = connection.prepareStatement("DELETE FROM cart");
            clearCart.executeUpdate();

            connection.close();

            // Set billDetails attribute in request
            request.setAttribute("billDetails", billDetails);

            // Forward to generate_bill.jsp
            request.getRequestDispatcher("generate_bill.jsp?fromPage=" + request.getParameter("fromPage")).forward(request, response);

        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        }
    }

    // Get tax percentage for the given product type from the database
    private double getTaxPercentage(Connection connection, String productType) throws SQLException {
        double taxPercentage = 0;
        PreparedStatement statement = connection.prepareStatement("SELECT tax_percentage FROM tax WHERE product_type = ?");
        statement.setString(1, productType);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            taxPercentage = resultSet.getDouble("tax_percentage");
        }
        return taxPercentage;
    }


    // Format bill details into a string
    private String formatBillDetails(List<String[]> billDetails) {
        StringBuilder sb = new StringBuilder();
        for (String[] item : billDetails) {
            sb.append(item[0]).append(" (Qty: ").append(item[1]).append("), ");
        }
        return sb.toString();
    }

    // Implement this method to get your database connection
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/shop";
        String username = "root";
        String password = "password";
        return DriverManager.getConnection(url, username, password);
    }
}