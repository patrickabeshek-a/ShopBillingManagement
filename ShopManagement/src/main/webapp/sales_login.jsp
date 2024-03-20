<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Login</title>
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
	input[type="text"],
	input[type="password"] {
	    width: 50%; /* Set input field width to 100% of container */
	    padding: 10px; /* Add padding inside input fields */
	    border: 1px solid #ccc; /* Add border to input fields */
	    border-radius: 5px; /* Add rounded corners to input fields */
	    transition: border-color 0.3s ease; /* Add smooth transition for border color */
	}
	
	/* Change input field border color on hover */
	input[type="text"]:hover,
	input[type="password"]:hover,
	input[type="text"]:focus,
	input[type="password"]:focus {
	    border-color: #f27d42; /* Change border color on hover or focus */
	}
	label {
		font-weight: bold;
	}
	</style>
    <script>
        // JavaScript function to display popup alert
        function showAlert() {
            alert("Invalid credentials. Please try again.");
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Sales Login</h2>
        <form action="salesLoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <br>
            <button type="submit">Login</button>
        </form>
        <a href="index.jsp"><button>Go back</button></a><br>
    </div>
    <%-- Check if there is an error parameter in the URL --%>
    <% String error = request.getParameter("error"); %>
    <% if (error != null && !error.isEmpty()) { %>
        <%-- If error parameter exists, call the showAlert function --%>
        <script>
            showAlert();
        </script>
    <% } %>
</body>
</html>
