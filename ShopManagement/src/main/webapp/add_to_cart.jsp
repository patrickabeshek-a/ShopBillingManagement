<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add to Cart</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        table {
	        width: 80%; /* Set the width to 80% of the viewport */
	        margin: 0 auto; /* Center the table horizontally */
	        border-collapse: collapse;
	    }
		label {
			font-weight: bold;
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
		    max-width: 700px; /* Limit container width for better readability */
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Add Product to Cart</h1>
        <form action="addtoCartServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
            <div class="form-group">
                <label for="productId">Product ID:</label>
                <input type="number" id="productId" name="productId" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            <button type="submit">Add to Cart</button>
            
        </form>
			
			<br>
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
    	<br><a href="<%= goBackPage %>"><button>Go back</button></a><a href='generate_bill.jsp?fromPage=<%= request.getParameter("fromPage") %>'><button>Checkout</button></a>
        <div class="message" style="text-align: center;">
            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
                <%= message %>
            <% } %>
        </div>

        <h2>Cart</h2>
        <table>
            <tr>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            
            <% @SuppressWarnings("unchecked")
            List<String[]> cartItems = (List<String[]>) request.getAttribute("cartItems"); %>
            <% if (cartItems != null && !cartItems.isEmpty()) { %>
                <% for (String[] cartItem : cartItems) { %>
                    <tr>
                        <td><%= cartItem[0] %></td> <!-- Product Name -->
                        <td><%= cartItem[1] %></td> <!-- Quantity -->
                        <td>₹ <%= cartItem[2] %></td> <!-- Price -->
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="3" style="text-align: center;">Cart is empty</td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
