<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Samkart</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #121212; /* Dark background */
            color: #e0e0e0; /* Light text color */
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #1e1e1e; /* Slightly lighter dark */
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .logo {
            font-size: 28px;
            font-weight: 700;
            color: #ffffff;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .nav-links {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 25px;
        }
        .nav-links a {
            color: #b0b0b0;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            text-transform: uppercase;
            transition: color 0.3s ease;
        }
        .nav-links a:hover {
            color: #ffffff;
        }
        .log-in-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 999px; /* Capsule effect */
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .log-in-btn:hover {
            background-color: #0056b3;
        }
        .main-content {
            padding-top: 80px;
        }
        .welcome-section {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1542281691-817349195b09') no-repeat center center/cover;
            color: #fff;
            margin-bottom: 40px;
            border-radius: 10px;
        }
        .welcome-section h1 {
            font-size: 5rem;
            margin: 0;
            font-weight: 700;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.4);
        }
        .welcome-section p {
            font-size: 1.5rem;
            margin-top: 10px;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            padding: 20px;
        }
        .product-card {
            background: #1e1e1e;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
        }
        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }
        .product-card:hover img {
            transform: scale(1.05);
        }
        .product-card h3 {
            font-size: 20px;
            margin: 10px 0;
            color: #fff;
        }
        .product-card .price {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 15px;
        }
        .product-card .btn {
            display: inline-block;
            background: #333;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 999px; /* Capsule effect */
            font-weight: 500;
            transition: background 0.3s ease;
        }
        .product-card .btn:hover {
            background: #555;
        }
    </style>
</head>
<body>

    <div class="header">
        <a href="index.jsp" class="logo">Samkart</a>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="products.jsp">Products</a></li>
            <li><a href="cart.jsp">Cart</a></li>
        </ul>
        <a href="login.jsp" class="log-in-btn">Log In</a>
    </div>

    <div class="main-content container">
        <div class="welcome-section">
            <h1>Welcome to Samkart</h1>
            <p>Your one-stop shop for the best .</p>
        </div>
        
        <h2>Featured Products</h2>
        
        <div class="product-grid">
            <div class="product-card">
                <img src="images/SMARTPHONE.jpg" alt="Smartphone">
                <h3>Sample Product 1</h3>
                <p class="price">₹115999</p>
                <a href="ProductController?action=view&id=2" class="btn">View Details</a>
            </div>

            <div class="product-card">
                <img src="images/LAPTOP.jpg" alt="Laptop">
                <h3>Sample Product 2</h3>
                <p class="price">₹145999</p>
                <a href="ProductController?action=view&id=1" class="btn">View Details</a>
            </div>

            <div class="product-card">
                <img src="images/HEADPHONE.jpg" alt="Headphones">
                <h3>Sample Product 3</h3>
                <p class="price">₹2799</p>
                <a href="ProductController?action=view&id=3" class="btn">View Details</a>
            </div>
        </div>
    </div>
</body>
</html>