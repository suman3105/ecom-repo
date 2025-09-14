<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Samkart | Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #1a1a1a;
            color: #f0f0f0;
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
        .admin-actions {
            display: flex;
            gap: 15px;
            align-items: center;
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
        .logout-btn {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .container-content {
            max-width: 700px;
            margin: 40px auto;
            padding: 30px;
            background-color: #2c2c2c;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
        }
        h1, h2, h3 {
            text-align: center;
            color: #ffffff;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .form-section {
            background: #3a3a3a;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
        }
        .form-section h3 {
            margin-top: 0;
            color: #fff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #b0b0b0;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #555;
            background-color: #444;
            color: #fff;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            border-color: #dc3545;
            outline: none;
        }
        .btn {
            background: #dc3545;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 999px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            font-weight: 500;
            transition: background 0.3s, transform 0.2s;
        }
        .btn:hover {
            background: #c82333;
            transform: scale(1.02);
        }
        .error-message {
            color: #fff;
            text-align: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #721c24;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp" class="logo">Samkart</a>
        <ul class="nav-links">
            <li><a href="index.jsp">Back To Home</a></li>
            
            <%
                String adminUser = (String) session.getAttribute("adminUser");
                if (adminUser != null) {
            %>
                <li><a href="admin.jsp">Admin</a></li>
                <li><a href="AdminController?action=logout" class="logout-btn">Logout</a></li>
            <% } else { %>
                <li><a href="admin.jsp">Admin</a></li>
                <li><a href="login.jsp" class="action-btn">Log In</a></li>
            <% } %>
        </ul>
    </div>

    <div class="container-content">
        <%
            if (adminUser == null) {
        %>
            <h2>Admin Login</h2>
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">Invalid username or password!</div>
            <% } %>
            <div class="form-section">
                <form action="AdminController" method="post">
                    <input type="hidden" name="action" value="login">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn">Login</button>
                </form>
            </div>
        <% } else { %>
            <h2>Welcome, <%= adminUser %>!</h2>

            <div class="form-section">
                <h3>Add Product</h3>
                <form action="AdminController" method="post">
                    <input type="hidden" name="action" value="addProduct">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="text" id="price" name="price" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description" required>
                    </div>
                    <div class="form-group">
                        <label for="image">Image (filename):</label>
                        <input type="text" id="image" name="image" required>
                    </div>
                    <div class="form-group">
                        <label for="stock">Stock:</label>
                        <input type="text" id="stock" name="stock" required>
                    </div>
                    <button type="submit" class="btn">Add Product</button>
                </form>
            </div>

            <div class="form-section">
                <h3>Update Product</h3>
                <form action="AdminController" method="post">
                    <input type="hidden" name="action" value="updateProduct">
                    <div class="form-group">
                        <label for="productId">Product ID:</label>
                        <input type="text" id="productId" name="productId" required>
                    </div>
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label for="price">Price:</label>
                        <input type="text" id="price" name="price">
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description">
                    </div>
                    <div class="form-group">
                        <label for="image">Image (filename):</label>
                        <input type="text" id="image" name="image">
                    </div>
                    <div class="form-group">
                        <label for="stock">Stock:</label>
                        <input type="text" id="stock" name="stock">
                    </div>
                    <button type="submit" class="btn">Update Product</button>
                </form>
            </div>

            <div class="form-section">
                <h3>Delete Product</h3>
                <form action="AdminController" method="post">
                    <input type="hidden" name="action" value="deleteProduct">
                    <div class="form-group">
                        <label for="deleteProductId">Product ID:</label>
                        <input type="text" id="deleteProductId" name="productId" required>
                    </div>
                    <button type="submit" class="btn">Delete Product</button>
                </form>
            </div>
        <% } %>
    </div>
</body>
</html>