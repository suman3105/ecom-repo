<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Samkart | User Login</title>
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
        .login-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .login-btn:hover {
            background-color: #0056b3;
        }
        .login-container {
            max-width: 450px;
            margin: 80px auto;
            background: #1e1e1e;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
            text-align: center;
        }
        .login-container h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
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
            border: 1px solid #444;
            background-color: #333;
            color: #fff;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
        }
        .btn {
            background: #007bff;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 999px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            font-weight: 500;
            transition: background 0.3s, transform 0.2s;
        }
        .btn:hover {
            background: #0056b3;
            transform: scale(1.02);
        }
        .error {
            color: #fff;
            text-align: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #721c24; /* Dark red for error */
            border-radius: 8px;
            font-weight: 500;
        }
        .success {
            color: #fff;
            text-align: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #155724; /* Dark green for success */
            border-radius: 8px;
            font-weight: 500;
        }
        .link {
            text-align: center;
            margin-top: 25px;
        }
        .link a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .link a:hover {
            color: #4da6ff;
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
        <a href="login.jsp" class="login-btn">Log In</a>
    </div>

    <div class="login-container">
        <h2>Login to Your Account</h2>

        <% if(request.getParameter("error") != null) { %>
            <div class="error">Invalid email or password!</div>
        <% } %>

        <% if(request.getParameter("success") != null) { %>
            <div class="success">Registration successful! Please login.</div>
        <% } %>

        <form action="UserController" method="post">
            <input type="hidden" name="action" value="login">

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="btn">Login</button>
        </form>

        <div class="link">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>