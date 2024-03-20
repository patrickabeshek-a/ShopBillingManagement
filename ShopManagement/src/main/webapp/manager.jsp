<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Menu</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #f1f1f1;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 9999;
            display: none;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 9998;
            display: none;
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
		
		.container {
		    background-color: #ffffff; /* White background color for container */
		    border-radius: 10px; /* Add rounded corners to container */
		    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* Add subtle box shadow for depth */
		    padding: 40px;
		    text-align: center;
		    margin: auto; /* Center the container horizontally */
		    margin-top: 10vh; /* Adjust top margin to raise the container */
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
		.menu-options {
		    max-width: 500px; /* Limit the width of the menu options */
		    margin: 0 auto; /* Center the menu options horizontally */
		}
    </style>
</head>
<body>
    <div class="container">
        <h2>Manager Menu</h2>
        <div class="menu-options">
            <a href="manage_product.jsp?fromPage=manager"><button>Manage Products</button></a>
            <a href="displayProductsServlet"><button>Display Products</button></a>
            <a href="add_to_cart.jsp?fromPage=manager"><button>Add Product to Cart</button></a>
            <a href="generate_bill.jsp?fromPage=manager"><button>Generate Bill</button></a>
            <a href="get_profit.jsp"><button>Get Profit on a Particular Date</button></a>
            <a href="get_total_tax.jsp"><button>Get Total Tax Paid for Particular Month</button></a>
            <a href="display_history.jsp?fromPage=manager"><button>History Management</button></a>
            <a href="index.jsp"><button>Logout</button></a>
        </div>
    </div>

    <%-- Popup for low stock products --%>
    <div class="overlay" id="overlay"></div>
    <div class="popup" id="popup">
        <h3 id="popupText"></h3>
    </div>

    <%-- JavaScript to call the manager servlet on page load and handle low stock alert --%>
    <script>
        window.onload = function() {
            checkStock();
        };

        function checkStock() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("Response received from servlet:");
                    console.log(xhr.responseText);
                    var lowStockProducts = JSON.parse(xhr.responseText);
                    if (lowStockProducts.length > 0) {
                        var message = "Low stock alert:\n";
                        for (var i = 0; i < lowStockProducts.length; i++) {
                            message += lowStockProducts[i] + "\n";
                        }
                        alert(message);
                    }
                }
            };
            xhr.open('POST', 'managerServlet', true);
            xhr.send();
        };
    </script>
</body>
</html>