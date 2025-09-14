package com.ecommerce.controller;

import com.ecommerce.util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class CheckoutController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("placeOrder".equals(action)) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                conn.setAutoCommit(false); // ✅ Transaction

                // 1️⃣ Get all cart items with price and quantity
                String cartSQL = "SELECT c.product_id, c.quantity, p.price " +
                                 "FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id=?";
                ps = conn.prepareStatement(cartSQL);
                ps.setInt(1, userId);
                rs = ps.executeQuery();

                double subtotal = 0;
                java.util.List<int[]> cartItems = new java.util.ArrayList<>();
                java.util.List<Double> prices = new java.util.ArrayList<>();

                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int qty = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    subtotal += price * qty;
                    cartItems.add(new int[]{productId, qty});
                    prices.add(price);
                }
                rs.close();
                ps.close();

                if (cartItems.isEmpty()) {
                    response.getWriter().println("<script>alert('Your cart is empty!'); window.location='cart.jsp';</script>");
                    return;
                }

                // 2️⃣ Insert order
                double shipping = 50.0;
                double tax = subtotal * 0.18;
                double grandTotal = subtotal + shipping + tax;

                String insertOrder = "INSERT INTO orders (user_id, total_amount, order_date) VALUES (?, ?, NOW())";
                ps = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, userId);
                ps.setDouble(2, grandTotal);
                ps.executeUpdate();

                rs = ps.getGeneratedKeys();
                int orderId = 0;
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
                rs.close();
                ps.close();

                // 3️⃣ Insert into order_items
                String insertItem = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(insertItem);

                for (int i = 0; i < cartItems.size(); i++) {
                    int[] item = cartItems.get(i);
                    ps.setInt(1, orderId);
                    ps.setInt(2, item[0]);
                    ps.setInt(3, item[1]);
                    ps.setDouble(4, prices.get(i));
                    ps.addBatch();
                }
                ps.executeBatch();
                ps.close();

                // 4️⃣ Clear cart
                String clearCart = "DELETE FROM cart WHERE user_id=?";
                ps = conn.prepareStatement(clearCart);
                ps.setInt(1, userId);
                ps.executeUpdate();
                ps.close();

                conn.commit(); // ✅ Commit all together

                // 5️⃣ Success response
                response.setContentType("text/html");
                response.getWriter().println(
                    "<script>alert('✅ Order placed successfully!'); window.location='index.jsp';</script>"
                );

            } catch (Exception e) {
                e.printStackTrace();
                if (conn != null) try { conn.rollback(); } catch (Exception ignored) {}
                response.setContentType("text/html");
                response.getWriter().println(
                    "<script>alert('❌ Failed to place order: " + e.getMessage() + "'); window.location='checkout.jsp';</script>"
                );
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                DBConnection.closeConnection(conn);
            }
        }
    }
}
