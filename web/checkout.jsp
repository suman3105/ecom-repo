<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.ecommerce.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Samkart | Checkout</title>
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
            max-width: 900px;
            margin: 40px auto;
            background: #1e1e1e;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
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
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            margin-bottom: 20px;
        }
        table th, table td {
            background-color: #2a2a2a;
            padding: 15px;
            text-align: left;
        }
        table th {
            background-color: #333;
            color: #b0b0b0;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        table tr {
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        table td:first-child { border-top-left-radius: 8px; border-bottom-left-radius: 8px; }
        table td:last-child { border-top-right-radius: 8px; border-bottom-right-radius: 8px; }
        .total-row {
            font-weight: bold;
            background-color: #2a2a2a;
            color: #fff;
        }
        .total-row td:first-child {
            font-size: 1.2rem;
        }
        .grand-total {
            color: #007bff;
            font-size: 1.5rem;
        }
        .btn-place-order {
            display: block;
            width: 100%;
            padding: 15px;
            text-align: center;
            background: #28a745;
            color: white;
            text-decoration: none;
            font-size: 1.2rem;
            border: none;
            border-radius: 999px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s ease;
            margin-top: 20px;
        }
        .btn-place-order:hover {
            background: #218838;
        }
        .form-section {
            background: #2a2a2a;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        .form-row {
            margin-bottom: 15px;
        }
        .form-row input, .form-row select, .form-row textarea {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #444;
            background-color: #333;
            color: #fff;
            border-radius: 6px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #b0b0b0;
        }
        .login-message {
            text-align: center;
            padding: 30px;
            background-color: #2a2a2a;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .login-message a {
            background: #007bff;
            color: white;
            padding: 10px 25px;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s ease;
        }
        .login-message a:hover {
            background: #0056b3;
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

    <div class="container">
        <h1>Checkout Summary</h1>

        <%
            HttpSession session1 = request.getSession(false);
            Integer userId = (session1 != null) ? (Integer) session1.getAttribute("userId") : null;
            if (userId == null) {
        %>
            <div class="login-message">
                <p>⚠️ You must be logged in to checkout.</p>
                <a href="login.jsp">Go to Login</a>
            </div>
        <%
            } else {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                double subtotal = 0.0;
                try {
                    conn = com.ecommerce.util.DBConnection.getConnection();
                    String sql = "SELECT p.id, p.name, p.price, c.quantity FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id=?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            boolean hasItems = false;
                            while (rs.next()) {
                                hasItems = true;
                                String pname = rs.getString("name");
                                double price = rs.getDouble("price");
                                int qty = rs.getInt("quantity");
                                double itemTotal = price * qty;
                                subtotal += itemTotal;
                        %>
                            <tr>
                                <td><%= pname %></td>
                                <td>₹<%= String.format("%.2f", price) %></td>
                                <td><%= qty %></td>
                                <td>₹<%= String.format("%.2f", itemTotal) %></td>
                            </tr>
                        <%
                            } // end while
        
                            if (!hasItems) {
                        %>
                            <tr>
                                <td colspan="4" style="text-align: center; color: #b0b0b0;">Your cart is empty.</td>
                            </tr>
                        <%
                            }
        
                            double shipping = (subtotal > 0) ? 50.0 : 0.0;
                            double tax = subtotal * 0.18;
                            double total = subtotal + shipping + tax;
                        %>
                        <tr class="total-row"><td colspan="3">Subtotal</td><td>₹<%= String.format("%.2f", subtotal) %></td></tr>
                        <tr class="total-row"><td colspan="3">Shipping</td><td>₹<%= String.format("%.2f", shipping) %></td></tr>
                        <tr class="total-row"><td colspan="3">Tax (18%)</td><td>₹<%= String.format("%.2f", tax) %></td></tr>
                        <tr class="total-row grand-total"><td colspan="3">Grand Total</td><td>₹<%= String.format("%.2f", total) %></td></tr>
                        </tbody>
                    </table>

                    <form action="CheckoutController" method="post">
                        <input type="hidden" name="action" value="placeOrder">
        
                        <div class="form-section">
                            <h3>Billing & Shipping</h3>
        
                            <div class="form-row">
                                <label for="fullName">Full name</label>
                                <input type="text" id="fullName" name="fullName" required>
                            </div>
        
                            <div class="form-row">
                                <label for="address">Address</label>
                                <textarea id="address" name="address" rows="2" required></textarea>
                            </div>
        
                            <div class="form-row" style="display:flex;gap:10px;">
                                <div style="flex:2;">
                                    <label for="city">City</label>
                                    <input type="text" id="city" name="city" required>
                                </div>
                                <div style="flex:1;">
                                    <label for="pincode">Pincode</label>
                                    <input type="text" id="pincode" name="pincode" required>
                                </div>
                            </div>
        
                            <div class="form-row">
                                <label for="phone">Phone</label>
                                <input type="text" id="phone" name="phone" required>
                            </div>
        
                            <div class="form-row">
                                <label for="paymentMethod">Payment method</label>
                                <select id="paymentMethod" name="paymentMethod" required>
                                    <option value="COD">Cash on Delivery</option>
                                    <option value="UPI">UPI</option>
                                    <option value="CARD">Credit/Debit Card</option>
                                </select>
                            </div>
                        </div>
        
                        <button type="submit" class="btn-place-order">Place Order</button>
                    </form>
        
        <%
                } catch(Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch(Exception ignored) {}
                    if (ps != null) try { ps.close(); } catch(Exception ignored) {}
                    if (conn != null) com.ecommerce.util.DBConnection.closeConnection(conn);
                }
            }
        %>
    </div>
</body>
</html>