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

/**
 * Servlet implementation class displayHistoryServlet
 */
public class displayHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            List<String[]> bills = new ArrayList<>();

            // Retrieve data from the database
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM bills");
            ResultSet resultSet = statement.executeQuery();

            // Process the result set and store data in a list of String arrays
            while (resultSet.next()) {
                String[] billData = new String[6]; // Array to store each bill's data
                billData[0] = String.valueOf(resultSet.getInt("id"));
                billData[1] = resultSet.getString("date");
                billData[2] = resultSet.getString("items_bought");
                billData[3] = resultSet.getString("mode_of_pay");
                billData[4] = String.valueOf(resultSet.getDouble("tax"));
                billData[5] = String.valueOf(resultSet.getDouble("amount"));
                bills.add(billData);
            }

            // Pass the list of bills to the JSP for rendering
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("display_history.jsp?fromPage=" + request.getParameter("fromPage")).forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception as needed
        }
    }
}