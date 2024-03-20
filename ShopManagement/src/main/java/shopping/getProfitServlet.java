package shopping;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class getProfitServlet
 */
public class getProfitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "password";

    @SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String dateStr = request.getParameter("date");

        if (dateStr == null || dateStr.isEmpty()) {
            // If date is not entered, send an error message back to the JSP
            request.setAttribute("error", "Date not entered");
            request.getRequestDispatcher("get_profit.jsp").forward(request, response);
            return;
        }

        try {
            LocalDate date = LocalDate.parse(dateStr);
            LocalDateTime startOfDay = date.atStartOfDay();
            LocalDateTime endOfDay = date.atTime(LocalTime.MAX);

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement statement = connection.prepareStatement("SELECT SUM(amount) AS total_amount, SUM(tax) AS total_tax FROM bills WHERE date BETWEEN ? AND ?");
                statement.setTimestamp(1, Timestamp.valueOf(startOfDay));
                statement.setTimestamp(2, Timestamp.valueOf(endOfDay));
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    double totalAmount = resultSet.getDouble("total_amount");
                    double totalTax = resultSet.getDouble("total_tax");
                    double profit = totalAmount - totalTax;
                    request.setAttribute("profit", profit);
                } else {
                    request.setAttribute("error", "No bills found for the specified date.");
                }
            } catch (SQLException e) {
                request.setAttribute("error", "Error: " + e.getMessage());
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format. Please enter date in yyyy-MM-dd format.");
        }

        request.getRequestDispatcher("get_profit.jsp").forward(request, response);
    }
}