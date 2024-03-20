package shopping;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class generatePdfServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/shop";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";

    @SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=test.pdf");

        List<String[]> billDetails = new ArrayList<>();
        double totalAmount = 0;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PDDocument document = new PDDocument()) {

            PDPage page = new PDPage();
            document.addPage(page);

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                PDFont font = PDType1Font.HELVETICA;
                int fontSize = 12;
                PDRectangle pageSize = page.getMediaBox();
                float pageWidth = pageSize.getWidth();
                float pageHeight = pageSize.getHeight();

                contentStream.beginText();
                contentStream.setFont(font, fontSize);
                contentStream.newLineAtOffset(50, pageHeight - 50);
                contentStream.showText("Customer Name: " + request.getParameter("customerName"));
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Mobile Number: " + request.getParameter("mobileNumber"));
                contentStream.endText();

                // Fetch cart items from the database
                String sql = "SELECT products.name, products.type, cart.quantity, products.price FROM cart JOIN products ON cart.product_id = products.id";
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {

                    // Calculate and store each item in the bill details list
                    while (resultSet.next()) {
                        String productName = resultSet.getString("name");
                        String productType = resultSet.getString("type");
                        int quantity = resultSet.getInt("quantity");
                        double price = resultSet.getDouble("price");

                        // Fetch tax rate for the product type
                        double taxPercentage = getTaxPercentage(connection, productType);

                        double totalPrice = price * quantity; // Total price for the item
                        double cgst = ((taxPercentage / 2) / 100) * totalPrice; // CGST
                        double sgst = ((taxPercentage / 2) / 100) * totalPrice; // SGST
                        double amount = totalPrice + cgst + sgst; // Total amount for the item
                        totalAmount += amount;

                        // Round off CGST and SGST values
                        cgst = Math.round(cgst * 100.0) / 100.0;
                        sgst = Math.round(sgst * 100.0) / 100.0;

                        // Add item details to the billDetails list
                        String[] itemDetails = {productName, String.valueOf(quantity), String.valueOf(price), String.valueOf(cgst), String.valueOf(sgst), String.valueOf(amount)};
                        billDetails.add(itemDetails);
                    }
                }

                // Insert the bill into the bills table
                insertBill(connection, billDetails, totalAmount);

                // Draw the bill table
                float tableX = 50;
                float tableY = pageHeight - 150;
                drawBillTable(contentStream, billDetails, tableX, tableY, font, fontSize);

                // Display total amount
                contentStream.beginText();
                contentStream.setFont(font, fontSize);
                contentStream.newLineAtOffset(50, tableY - 20);
                contentStream.showText("Total Amount: " + String.format("%.2f", totalAmount));
                contentStream.endText();
            }

            // Save and send the PDF response
            document.save(response.getOutputStream());

            // Clear the cart after generating the bill
            clearCart(connection);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    // Get tax percentage for the given product type from the database
    private double getTaxPercentage(Connection connection, String productType) throws SQLException {
        double taxPercentage = 0;
        String sql = "SELECT tax_percentage FROM tax WHERE product_type = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, productType);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    taxPercentage = resultSet.getDouble("tax_percentage");
                }
            }
        }
        return taxPercentage;
    }

    // Insert the bill into the bills table
    private void insertBill(Connection connection, List<String[]> billDetails, double totalAmount) throws SQLException {
        double tax = calculateTax(billDetails); // Calculate total tax
        String sql = "INSERT INTO bills (date, items_bought, mode_of_pay, tax, amount) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
            statement.setString(2, formatBillDetails(billDetails));
            statement.setString(3, "Cash"); // Assuming mode of payment is not handled in this example
            statement.setDouble(4, tax);
            statement.setDouble(5, totalAmount); // Insert total amount
            statement.executeUpdate();
        }
    }

    // Calculate total tax based on CGST and SGST
    private double calculateTax(List<String[]> billDetails) {
        double totalTax = 0;
        for (String[] item : billDetails) {
            double cgst = Double.parseDouble(item[3]);
            double sgst = Double.parseDouble(item[4]);
            totalTax += cgst + sgst;
        }
        return totalTax;
    }

    // Format bill details into a string
    private String formatBillDetails(List<String[]> billDetails) {
        StringBuilder sb = new StringBuilder();
        for (String[] item : billDetails) {
            sb.append(item[0]).append(" (Qty: ").append(item[1]).append("), ");
        }
        return sb.toString();
    }

    // Draw the bill table
    @SuppressWarnings("unused")
 // Draw the bill table
    private void drawBillTable(PDPageContentStream contentStream, List<String[]> billDetails, float x, float y, PDFont font, int fontSize) throws IOException {
        float colWidth = 80; // Adjust as needed
        float cellMargin = 5;

        // Draw table headers
        float textX = x;
        float textY = y; // Adjust text position vertically center

        // Draw table headers
        String[] headers = {"S.no", "Product Name", "Quantity", "Price", "CGST", "SGST", "Amount"};
        drawTableRow(contentStream, headers, textX, textY, font, fontSize);
        textY -= fontSize;

        // Draw table rows
        int serialNumber = 1;
        for (String[] rowData : billDetails) {
            String[] formattedRowData = new String[rowData.length + 1];
            formattedRowData[0] = String.valueOf(serialNumber++);
            System.arraycopy(rowData, 0, formattedRowData, 1, rowData.length);
            drawTableRow(contentStream, formattedRowData, textX, textY, font, fontSize);
            textY -= fontSize;
        }
    }

    // Draw a table row
    @SuppressWarnings("unused")
	private void drawTableRow(PDPageContentStream contentStream, String[] rowData, float x, float y, PDFont font, int fontSize) throws IOException {
        float colWidth = 80; // Adjust as needed
        float cellMargin = 5;

        float textX = x;
        for (String data : rowData) {
            contentStream.beginText();
            contentStream.setFont(font, fontSize);
            contentStream.newLineAtOffset(textX, y);
            contentStream.showText(data);
            contentStream.endText();

            // Draw lines between columns
            contentStream.moveTo(textX, y - fontSize);
            contentStream.lineTo(textX + colWidth, y - fontSize);
            contentStream.stroke();

            textX += colWidth;
        }

        // Draw lines between rows
        contentStream.moveTo(x, y);
        contentStream.lineTo(x + (rowData.length * colWidth), y);
        contentStream.stroke();
    }

    // Clear the cart after generating the bill
    private void clearCart(Connection connection) throws SQLException {
        PreparedStatement clearCart = connection.prepareStatement("DELETE FROM cart");
        clearCart.executeUpdate();
    }
}