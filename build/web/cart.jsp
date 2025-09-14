<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.ecommerce.util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Samkart | Shopping Cart</title>
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
            border-radius: 999px;
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
        .cart-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px; /* Adds space between rows */
            margin-top: 20px;
        }
        .cart-table th, .cart-table td {
            padding: 15px;
            text-align: center;
            background-color: #1e1e1e;
            border: none;
        }
        .cart-table th {
            font-weight: 700;
            color: #b0b0b0;
            text-transform: uppercase;
        }
        .cart-item {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            transition: transform 0.3s ease;
        }
        .cart-item:hover {
            transform: translateY(-5px);
        }
        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: 5px;
            background-color: #333;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .quantity-controls button {
            background: #333;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .quantity-controls button:hover {
            background: #555;
        }
        .remove-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 999px; /* Capsule effect */
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .remove-btn:hover {
            background: #c82333;
        }
        .cart-summary {
            background: #1e1e1e;
            padding: 30px;
            margin-top: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
        }
        .total-price {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            margin: 10px 0;
        }
        .checkout-btn {
            background-color: #28a745;
            color: white;
            padding: 15px 40px;
            text-decoration: none;
            border-radius: 999px;
            font-size: 1.2rem;
            font-weight: 500;
            transition: background-color 0.3s ease;
            display: inline-block;
            margin-top: 20px;
        }
        .checkout-btn:hover {
            background-color: #218838;
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
        <h2 class="page-title">Your Shopping Cart</h2>
        
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    double subtotal = 0;
                    try {
                        conn = com.ecommerce.util.DBConnection.getConnection();
                        String sql = "SELECT c.product_id, c.quantity, p.name, p.price, p.image " +
                                     "FROM cart c JOIN products p ON c.product_id = p.id";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);
                        
                        while(rs.next()) {
                            int pid = rs.getInt("product_id");
                            int qty = rs.getInt("quantity");
                            double price = rs.getDouble("price");
                            double total = qty * price;
                            subtotal += total;
                %>
                <tr class="cart-item">
                    <td><img src="images/<%=rs.getString("image")%>" alt="<%=rs.getString("name")%>"></td>
                    <td><%=rs.getString("name")%></td>
                    <td>₹<%=price%></td>
                    <td>
                        <div class="quantity-controls">
                            <form action="CartController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="updateQuantity">
                                <input type="hidden" name="productId" value="<%=pid%>">
                                <input type="hidden" name="change" value="-1">
                                <button type="submit">-</button>
                            </form>
                            <span><%=qty%></span>
                            <form action="CartController" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="updateQuantity">
                                <input type="hidden" name="productId" value="<%=pid%>">
                                <input type="hidden" name="change" value="1">
                                <button type="submit">+</button>
                            </form>
                        </div>
                    </td>
                    <td>₹<%=total%></td>
                    <td>
                        <form action="CartController" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="productId" value="<%=pid%>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </td>
                </tr>
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
            </tbody>
        </table>

        <div class="cart-summary">
            <h3>Order Summary</h3>
            <p class="total-price">Total: ₹<%=subtotal%></p>
            <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
        </div>
    </div>
</body>
</html>