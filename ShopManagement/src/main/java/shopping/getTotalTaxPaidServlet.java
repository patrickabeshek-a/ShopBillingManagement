package shopping;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class getTotalTaxPaidServlet
 */
public class getTotalTaxPaidServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    @SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve the month from the request parameter
        String month = request.getParameter("month");

        // Initialize connection and result set
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Get the total tax paid for the specified month
            PreparedStatement statement = connection.prepareStatement("SELECT SUM(tax) FROM bills WHERE MONTH(date) = ?");
            statement.setString(1, month);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                double totalTaxPaid = resultSet.getDouble(1);
                request.setAttribute("totalTaxPaid", totalTaxPaid);
            } else {
                request.setAttribute("error", "Unable to get total tax paid.");
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        // Forward the request to the JSP for displaying results
        request.getRequestDispatcher("get_total_tax.jsp").forward(request, response);
    }
}