<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.ecommerce.util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Samkart Products</title>
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
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #1e1e1e;
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
        .page-title {
            text-align: center;
            font-size: 3rem;
            font-weight: 700;
            margin-top: 40px;
            margin-bottom: 40px;
            text-transform: uppercase;
            letter-spacing: 1px;
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
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            display: inline-block;
            background: #333;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 999px; /* Capsule effect */
            font-weight: 500;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #555;
        }
        .btn-cart {
            background: #28a745;
        }
        .btn-cart:hover {
            background: #218838;
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
            <li><a href="register.jsp">Register</a></li>
            <li><a href="admin.jsp">Admin</a></li>
        </ul>
        <a href="login.jsp" class="log-in-btn">Log In</a>
    </div>

    <div class="main-content container">
        <h2 class="page-title">All Products</h2>
        <div class="product-grid">
            <%
                Connection conn = null;
                try {
                    conn = com.ecommerce.util.DBConnection.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM products");
                    while(rs.next()) {
            %>
                        <div class="product-card">
                            <img src="images/<%=rs.getString("image")%>" alt="<%=rs.getString("name")%>">
                            <h3><%=rs.getString("name")%></h3>
                            <p class="price">₹<%=rs.getDouble("price")%></p>
                            <p><%=rs.getString("description")%></p>
                            <div class="btn-group">
                                <a href="ProductController?action=view&id=<%=rs.getInt("id")%>" class="btn">View Details</a>
                                <a href="CartController?action=add&productId=<%=rs.getInt("id")%>" class="btn btn-cart">Add to Cart</a>
                            </div>
                        </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    com.ecommerce.util.DBConnection.closeConnection(conn);
                }
            %>
        </div>
    </div>
</body>
</html>