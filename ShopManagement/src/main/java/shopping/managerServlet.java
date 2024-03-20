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
import org.json.simple.JSONArray;

public class managerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET requests here
        doPost(request, response); // Or call another method to handle both GET and POST requests
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        List<String> lowStockProducts = getLowStockProducts();

        // Capitalize the first letter of each product name
        for (int i = 0; i < lowStockProducts.size(); i++) {
            String productName = lowStockProducts.get(i);
            String capitalizedProductName = capitalizeFirstLetter(productName);
            lowStockProducts.set(i, capitalizedProductName);
        }

        // Convert the list of low stock products to a JSON array
        JSONArray jsonArray = new JSONArray();
        for (String product : lowStockProducts) {
            jsonArray.add(product);
        }

        // Set the JSON array as the response content
        response.setContentType("application/json");
        response.getWriter().print(jsonArray.toJSONString());
    }

    private List<String> getLowStockProducts() {
        List<String> lowStockProducts = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop","root","password")) {
            PreparedStatement statement = connection.prepareStatement("SELECT name FROM products WHERE quantity < 5");
            ResultSet resultSet = statement.executeQuery();

            // Add product names with quantity less than 5 to the list
            while (resultSet.next()) {
                lowStockProducts.add(resultSet.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception as needed
        }

        return lowStockProducts;
    }

    private String capitalizeFirstLetter(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
}