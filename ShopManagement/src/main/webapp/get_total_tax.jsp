<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get Total Tax Paid</title>
    <link rel="stylesheet" href="styles.css">
    <style>
    	label {
			font-weight: bold;
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
		    max-width: 600px; /* Limit container width for better readability */
		    display: flex;
		    flex-direction: column; /* Stack child elements vertically */
		    align-items: center; /* Center child elements horizontally */
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
		    width: 200px;
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
		.tax-paid {
		    color: red;
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Get Total Tax Paid</h2>
        <form action="getTotalTaxPaidServlet" method="post">
            <label for="month">Enter Month (MM):</label>
            <input type="text" id="month" name="month" pattern="\d{2}" title="Please enter the month in MM format" required>
            <button type="submit">Get Total Tax Paid</button>
            <br>
        </form>
		<a href="manager.jsp"><button>Go back</button></a>
        <!-- Display total tax paid if available -->
        <% Double totalTaxPaid = (Double) request.getAttribute("totalTaxPaid"); %>
		<% if (totalTaxPaid != null) { %>
		    <h3>Total Tax Paid:  <span class="tax-paid">₹<%= String.format("%.2f", totalTaxPaid) %></span></h3>
		<% } %>
        <!-- Display error message if any -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null && !error.isEmpty()) { %>
            <h3>Error: <%= error %></h3>
        <% } %>
    </div>
</body>
</html>