<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import='java.util.*' %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>History Management</title>
    <link rel="stylesheet" href="styles.css">
    <style>
     	body {
            font-family: Arial, sans-serif;
            text-align: center; /* Align content to the center */
        }
        h2 {
            margin-top: 20px; /* Add margin above the heading */
        }
        form {
            margin-bottom: 20px; /* Add margin below the form */
        }
	    table {
	        width: 80%; /* Set the width to 80% of the viewport */
	        margin: 0 auto; /* Center the table horizontally */
	        border-collapse: collapse;
	    }
	
	    th, td {
	        padding: 10px;
	        text-align: left;
	        border-bottom: 1px solid #ddd;
	    }
	
	    th {
	        background-color: #a9d8e6; /* Different background color for the header row */
	        color: #333; /* Dark text color for table headers */
	    }
	
	    tr:nth-child(even) {
	        background-color: #f9f9f9; /* Light background color for even rows */
	    }
	    tr:nth-child(odd) {
	        background-color: #eaeaea; 
	    }
	    
		body {
		    background-color: #96ffff;
		    font-family: 'Roboto', sans-serif; /* Set font family */
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
		    max-width: 600px; /* Limit container width for better readability */
		}
	    .product-image {
	        max-width: 100px;
	        height: auto;
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
    </style>
</head>
<body>
<div class='container'>
    <h2>History Management</h2>
    
    <form action="displayHistoryServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
        <button type="submit">Show History</button>
    </form> 
    <% 	String fromPage = request.getParameter("fromPage");
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
</div><br>
    <%-- Check if the button has been clicked and bills data is available --%>
    <% if (request.getAttribute("bills") != null) { %>
        <table>
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Date</th>
                    <th>Items Bought</th>
                    <th>Mode of Payment</th>
                    <th>Tax</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% @SuppressWarnings("unchecked")
                List<String[]> bills = (List<String[]>) request.getAttribute("bills"); %>
                <% for (String[] bill : bills) { %>
                    <tr>
                        <td><%= bill[0] %></td>
                        <td><%= bill[1] %></td>
                        <td><%= bill[2] %></td>
                        <td><%= bill[3] %></td>
                        <td>₹<%= String.format("%.2f", Double.parseDouble(bill[4])) %></td> <!-- Rounding off -->
                        <td>₹<%= String.format("%.2f", Double.parseDouble(bill[5])) %></td> <!-- Rounding off -->
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>