<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop</title>
    <link rel='stylesheet'>
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
	</style>
</head>
<body>
    <div class="container">
        <h1>Shop Billing Management</h1>
        <h2>Login</h2>
        <div class="role-buttons">
            <a href="sales_login.jsp"><button>Sales</button></a>
            <a href="manager_login.jsp"><button>Manager</button></a>
        </div>
    </div>
</body>
</html>
