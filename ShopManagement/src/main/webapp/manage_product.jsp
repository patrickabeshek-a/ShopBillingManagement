<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import='java.sql.*' %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
        	
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h1, h2 {
            margin-top: 20px;
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
		    width: 115px;
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

        form {
            margin-top: 20px;
        }

        form label {
            display: inline-block;
            width: 150px;
            text-align: right;
        }
		input[type="text"],
		input[type="number"],
		input[type="password"],
		select {
		    width: 50%; /* Set input field width to 50% of container */
		    padding: 10px; /* Add padding inside input fields */
		    border: 1px solid #ccc; /* Add border to input fields */
		    border-radius: 5px; /* Add rounded corners to input fields */
		    transition: border-color 0.3s ease; /* Add smooth transition for border color */
		}
		
		/* Change input field border color on hover */
		input[type="text"]:hover,
		input[type="number"]:hover,
		input[type="password"]:hover,
		select:hover,
		input[type="text"]:focus,
		input[type="number"]:focus,
		input[type="password"]:focus,
		select:focus {
		    border-color: #f27d42; /* Change border color on hover or focus */
		}
        form input, select {
            padding: 5px;
            margin: 5px;
            width: 200px;
            box-sizing: border-box;
        }
        label {
			font-weight: bold;
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
		#addEditForm,#editForm,#removeForm {
		    background-color: #ffffff; /* White background color for container */
		    border-radius: 10px; /* Add rounded corners to container */
		    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* Add subtle box shadow for depth */
		    padding: 40px;
		    text-align: center;
		    margin: auto; /* Center the container horizontally */
		    margin-top: 20vh; /* Adjust top margin to center vertically */
		    max-width: 600px; /* Limit container width for better readability */
		}
	    th {
	        background-color: #a9d8e6; /* Different background color for the header row */
	        color: #333; /* Dark text color for table headers */
	    }

        .hidden {
            display: none;
            
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
		tr:nth-child(even) {
	        background-color: #f9f9f9; /* Light background color for even rows */
	    }
	    tr:nth-child(odd) {
	        background-color: #eaeaea; 
	    }
    </style>
   
</head>
<body>
    <div class='container'>
    <h1>Product Management</h1>
    
    <!-- Buttons to select action -->
    <button onclick="showForm('addEditForm')">Add</button>
    <button onclick="showForm('editForm')">Edit</button>
    <button onclick="showForm('removeForm')">Remove</button>
    </div>
    <div class="success-message">
        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% if (successMessage != null) { %>
            <%= successMessage %>
        <% } %>
    </div>
     <!-- Product table -->
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
            <!-- Retrieve product details from the database and display in the table -->
            <% 
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password");
                    PreparedStatement statement = con.prepareStatement("SELECT * FROM products");
                    ResultSet rs = statement.executeQuery();
                    while (rs.next()) {
                        int productId = rs.getInt("id");
                        String productName = rs.getString("name");
                        double productPrice = rs.getDouble("price");
                        int productQuantity = rs.getInt("quantity");
            %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td>₹ <%= productPrice %></td>
                    <td><%= productQuantity %></td>
                </tr>
            <% 
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
    <!-- Add/Edit Product Form -->
    <div id="addEditForm" class="hidden">
        <h2>Add New Product</h2>
        <form id="addEditProductForm" action="addEditServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
            <label for="productId">Product ID:</label>
            <input type="number" id="productId" name="productId" required><br>
            
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required><br>
            
            <label for="productPrice">Product Price:</label>
            <input type="number" id="productPrice" name="productPrice" step="0.01" required><br>
            
            <label for="productQuantity">Product Quantity:</label>
            <input type="number" id="productQuantity" name="productQuantity" required><br>
            
            <label for="productType">Product Type:</label>
            <select id="productType" name="productType">
                <!-- Dynamic options will be added here -->
                <%-- Add dynamic options using Java code below --%>
                <% 
                    try {
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password");
                        PreparedStatement statement = con.prepareStatement("SELECT product_type FROM tax");
                        ResultSet rs = statement.executeQuery();
                        while (rs.next()) {
                            String type = rs.getString("product_type");
                %>
                    <option value="<%= type %>"><%= type %></option>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </select><br>
            
            <button type="submit">Add Product</button>
        </form>
    </div>
    
    <!-- Edit Product Form -->
	<div id="editForm" class="hidden">
	    <h2>Edit Product</h2>
	    <form id="editProductForm" action="editServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
	        <label for="editProductId">Select Product:</label>
	        <select id="editProductId" name="editProductId">
	            <!-- Populate dropdown with product IDs fetched from the database -->
	            <% 
	                try {
	                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "password");
	                    PreparedStatement statement = con.prepareStatement("SELECT id, name FROM products");
	                    ResultSet rs = statement.executeQuery();
	                    while (rs.next()) {
	                        int productId = rs.getInt("id");
	                        String productName = rs.getString("name");
	            %>
	                <option value="<%= productId %>"><%= productId %> - <%= productName %></option>
	            <% 
	                    }
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            %>
	        </select><br>
	        
	        <label for="editProductName">New Product Name:</label>
	        <input type="text" id="editProductName" name="editProductName" required><br>
	        
	        <label for="editProductPrice">New Product Price:</label>
	        <input type="number" id="editProductPrice" name="editProductPrice" step="0.01" required><br>
	        
	        <label for="editProductQuantity">Additional Quantity:</label>
	        <input type="number" id="editProductQuantity" name="editProductQuantity" required><br>
	        
	        <button type="submit">Update Product</button>
	    </form>
	</div>
    
    <!-- Remove Product Form -->
    <div id="removeForm" class="hidden">
        <h2>Remove Product</h2>
        <form id="removeProductForm" action="removeServlet?fromPage=<%= request.getParameter("fromPage") %>" method="post">
            <label for="removeProductId">Product ID :</label>
            <input type="number" id="removeProductId" name="removeProductId" required><br>
            
            <button type="submit">Remove Product</button>
        </form>
    </div>
	<% 
        String fromPage = request.getParameter("fromPage");
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
    <script>
        function showForm(formId) {
            var forms = document.querySelectorAll('div[id$="Form"]');
            forms.forEach(function(form) {
                if (form.id === formId) {
                    form.classList.remove('hidden');
                } else {
                    form.classList.add('hidden');
                }
            });
        }
    </script>
</body>
</html>
