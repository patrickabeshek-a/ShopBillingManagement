<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Menu</title>
    <link rel="stylesheet" href="styles.css">
    <style>
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
		    text-decoration: none;
		    display: inline-block;
		    width: 350px;
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
    <div class="container">
        <h2>Sales Menu</h2>
        <div class="menu-options">
            <a href="manage_product.jsp?fromPage=sales"><button>Manage Products</button></a>
            <a href="add_to_cart.jsp?fromPage=sales"><button>Add Product to Cart</button></a>
            <a href="generate_bill.jsp?fromPage=sales"><button>Generate Bill</button></a>
            <a href="display_history.jsp?fromPage=sales"><button>History Management</button></a>
            <a href="index.jsp"><button>Logout</button></a>
        </div>
    </div>
</body>
</html>
