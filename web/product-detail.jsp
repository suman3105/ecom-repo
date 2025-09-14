<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Samkart | Product Detail</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #121212;
            color: #e0e0e0;
        }
        .header {
            background-color: #2c2c2c;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
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
        .action-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .action-btn:hover {
            background-color: #0056b3;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background: #1e1e1e;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
        }
        .product-detail {
            display: flex;
            gap: 50px;
            align-items: flex-start;
        }
        .product-image-container {
            flex-shrink: 0;
            width: 400px;
            height: 400px;
            padding: 20px;
            background: #2c2c2c;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .product-image-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 8px;
        }
        .product-info {
            flex-grow: 1;
        }
        .product-info h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 10px;
        }
        .product-info p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #b0b0b0;
        }
        .price {
            font-size: 2.2rem;
            font-weight: bold;
            color: #28a745;
            margin-top: 20px;
            margin-bottom: 25px;
        }
        .btn-cart {
            background: #28a745;
            color: white;
            padding: 15px 30px;
            border-radius: 999px;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            transition: background 0.3s, transform 0.2s;
            display: inline-block;
        }
        .btn-cart:hover {
            background: #218838;
            transform: scale(1.02);
        }
        .not-found {
            text-align: center;
            font-size: 1.5rem;
            margin-top: 50px;
            color: #b0b0b0;
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
            <li><a href="login.jsp" class="action-btn">Log In</a></li>
            <li><a href="register.jsp" class="action-btn">Register</a></li>
            <li><a href="admin.jsp" class="action-btn">Admin</a></li>
        </ul>
    </div>

    <div class="container">
        <%
            ResultSet product = (ResultSet) request.getAttribute("product");
            if(product != null) {
        %>
            <div class="product-detail">
                <div class="product-image-container">
                    <img src="images/<%=product.getString("image")%>" alt="<%=product.getString("name")%>">
                </div>
                <div class="product-info">
                    <h2><%=product.getString("name")%></h2>
                    <p><%=product.getString("description")%></p>
                    <p class="price">₹<%=product.getDouble("price")%></p>
                    <a href="CartController?action=add&productId=<%=product.getInt("id")%>" class="btn-cart">Add to Cart</a>
                </div>
            </div>
        <%
            } else {
        %>
            <div class="not-found">Product not found.</div>
        <%
            }
        %>
    </div>
</body>
</html>