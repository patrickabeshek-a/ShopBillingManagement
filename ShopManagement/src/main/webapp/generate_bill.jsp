<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated Bill</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        thead th {
            background-color: #a9d8e6;
            color: #000000;
            text-align: left;
            padding: 8px;
        }
        tbody td {
            border-bottom: 1px solid #ddd;
            padding: 8px;
        }
        .total {
            text-align: right;
            font-weight: bold;
            font-size: 18px;
        }
        body {
		    background-color: #96ffff;
		    font-family: 'Roboto', sans-serif; /* Set font family */
		    margin: 0;
		    padding: 0;
		    color: #333333; /* Dark gray text color */
		    display: flex; /* Use flexbox */
		    justify-content: center; /* Center horizontally */
		    align-items: center; /* Center vertically */
		}
		label {
			font-weight: bold;
		}
		.container {
		    background-color: #ffffff; /* White background color for container */
		    border-radius: 10px; /* Add rounded corners to container */
		    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* Add subtle box shadow for depth */
		    padding: 40px;
		    text-align: center;
		    margin: auto; /* Center the container horizontally */
		    margin-top: 20vh; /* Adjust top margin to center vertically */
		    max-width: 900px; /* Limit container width for better readability */
		}
		
		h1, h2 {
		    color: #333333; /* Dark gray text color for headings */
		}
		
		.role-buttons {
		    margin-top: 30px;
		}
		
		button {
		    background-color: #f27d42; /* Unique button background color */
		    border: none;
		    
		    color: #000000; /* Set text color to black */
		    padding: 10px 20px;
		    text-align: center;
		    width: 150px;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 5px; /* Add rounded corners to buttons */
		    transition: background-color 0.3s ease; /* Add smooth transition */
		}
		
		button:hover {
		    background-color: #f25f42; /* Darken button color on hover */
		}
		input[type="text"],
		input[type="number"],
		input[type="password"] {
		    width: 50%; /* Set input field width to 100% of container */
		    padding: 10px; /* Add padding inside input fields */
		    border: 1px solid #ccc; /* Add border to input fields */
		    border-radius: 5px; /* Add rounded corners to input fields */
		    transition: border-color 0.3s ease; /* Add smooth transition for border color */
		}
		
		/* Change input field border color on hover */
		input[type="text"]:hover,
		input[type="number"]:hover,
		input[type="password"]:hover,
		input[type="text"]:focus,
		input[type="number"]:focus,
		input[type="password"]:focus {
		    border-color: #f27d42; /* Change border color on hover or focus */
		}
		@media screen {
            /* Add any screen-specific styles here */
        }

        /* Styles for printing */
        @media print {
            body {
                font-family: Arial, sans-serif;
            }

            table {
                border-collapse: collapse;
                width: 100%;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            .total {
                font-weight: bold;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Generated Bill</h1>
        <form action="generateBillServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
            <label for="customerName">Customer Name:</label>
            <input type="text" id="customerName" name="customerName" required><br>
            
            <label for="mobileNumber">Mobile Number:</label>
            <input type="text" id="mobileNumber" name="mobileNumber" required><br>
            <button type="submit">Generate Bill</button>
        </form>
        <br><br><br>
        <% // Check if billDetails attribute is not null, indicating that the bill has been generated %>
        <% if (request.getAttribute("billDetails") != null) { %>
        <% String customerName = request.getParameter("customerName");
            String mobileNumber = request.getParameter("mobileNumber");
            if (customerName != null && mobileNumber != null) { %>
            <div id="printSection">
                    <div class="customer-info">
                        <p>Customer Name: <%= customerName %></p>
                        <p>Mobile Number: <%= mobileNumber %></p><br>
                    </div>
        <% } %>
            <table>
                <thead>
                    <tr>
                        <th>S.No</th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Rate</th>
                        <th>Taxable Amount</th>
                        <th>CGST</th>
                        <th>SGST</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% @SuppressWarnings("unchecked")
                        List<String[]> billDetails = (List<String[]>) request.getAttribute("billDetails");
                        int serialNo = 1;
                        double totalAmount = 0;
                        for (String[] item : billDetails) {
                            double cgst = Double.parseDouble(item[3]);
                            double sgst = Double.parseDouble(item[4]);
                            double amount = Double.parseDouble(item[5]);
                            double taxableAmount = amount - cgst - sgst;
                            totalAmount += amount;
                    %>
                    <tr>
                        <td><%= serialNo++ %></td>
                        <td><%= item[0] %></td>
                        <td><%= item[1] %></td>
                        <td>₹ <%= item[2] %></td>
                        <td>₹ <%= String.format("%.2f", taxableAmount) %></td>
                        <td>₹ <%= String.format("%.2f", cgst) %></td> <!-- Rounded CGST -->
                        <td>₹ <%= String.format("%.2f", sgst) %></td> <!-- Rounded SGST -->
                        <td>₹ <%= String.format("%.2f", amount) %></td> <!-- Rounded Amount -->
                    </tr>
                    <% } %>
                    <tr class="total">
                        <td colspan="6" style="text-align:right">Total Amount:</td>
                        <td>₹ <%= String.format("%.2f", totalAmount) %></td>
                    </tr>
                </tbody>
            </table>
            </div>
            <button onclick="printBill()">Print</button>
        <% } %>
        <br><% 	String fromPage = request.getParameter("fromPage");
		        String goBackPage = ""; // Initialize the variable to hold the URL to which the user will be redirected
		        if (fromPage != null) {
		            if (fromPage.equals("manager")) {
		                goBackPage = "manager.jsp";
		            } else if (fromPage.equals("sales")) {
		                goBackPage = "sales.jsp";
		            }
		        } else {
		            // If the 'fromPage' parameter is not specified or invalid, redirect to the index.jsp page
		            goBackPage = "index.jsp";
		        }
		    %>
    	<br><a href="<%= goBackPage %>"><button>Go back</button></a>
    </div>
     <script>
        function printBill() {
            var printContent = document.getElementById("printSection").innerHTML;
            var originalContent = document.body.innerHTML;
            document.body.innerHTML = printContent;
            window.print();
            document.body.innerHTML = originalContent;
        }
    </script>
</body>
</html>
