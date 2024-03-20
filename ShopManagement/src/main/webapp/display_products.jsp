<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Product Display</title>
	<style>
	    body {
	        font-family: Arial, sans-serif;
	        background-color: #f4f4f4;
	        margin: 0;
	        padding: 20px; /* Add padding to create some space around the table */
	    }
	
	    h1 {
	        text-align: center;
	        margin-top: 20px;
	        color: #333;
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
		    max-width: 900px; /* Limit container width for better readability */
		}
	</style>
</head>
<body>
<div class='container'>
    <h1>Products</h1>
    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Retrieve the productResultSet attribute set by the servlet
                ResultSet resultSet = (ResultSet) request.getAttribute("productResultSet");
                if (resultSet != null) {
                    while (resultSet.next()) {
                        int productId = resultSet.getInt("id");
                        String productName = resultSet.getString("name");
                        double productPrice = resultSet.getDouble("price");
                        int productQuantity = resultSet.getInt("quantity");
            %>
                        <tr>
                            <td><%= productId %></td>
                            <td style="text-transform: capitalize;"><%= productName %></td>
                            <td>₹<%= productPrice %></td>
                            <td><%= productQuantity %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4">No products found.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <div style="text-align: center;"><br><a href="manager.jsp"><button>Go back</button></a></div>
    </div>
</body>
</html>
