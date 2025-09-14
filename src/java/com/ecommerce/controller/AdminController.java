package com.ecommerce.controller;
import com.ecommerce.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            adminLogin(request, response);
        } else if ("addProduct".equals(action)) {
            addProduct(request, response);
        } else if ("updateProduct".equals(action)) {
            updateProduct(request, response);
        } else if ("deleteProduct".equals(action)) {
            deleteProduct(request, response);
        } else if ("updateOrderStatus".equals(action)) {
            updateOrderStatus(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            adminLogout(request, response);
        }
    }

    private void adminLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT username FROM admin WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminUser", rs.getString("username"));
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("admin.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=1");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private void adminLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("adminUser");
        response.sendRedirect("admin.jsp");
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUser");

        if (adminUser == null) {
            response.sendRedirect("admin.jsp");
            return;
        }

        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String stock = request.getParameter("stock");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO products (name, price, description, stock) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, price);
            stmt.setString(3, description);
            stmt.setString(4, stock);

            stmt.executeUpdate();
            response.sendRedirect("admin.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=1");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUser");

        if (adminUser == null) {
            response.sendRedirect("admin.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int stock = Integer.parseInt(request.getParameter("stock"));

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE products SET name = ?, price = ?, description = ?, stock = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, description);
            stmt.setInt(4, stock);
            stmt.setInt(5, productId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("admin.jsp?success=1");
            } else {
                response.sendRedirect("admin.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=1");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUser");

        if (adminUser == null) {
            response.sendRedirect("admin.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("admin.jsp?success=1");
            } else {
                response.sendRedirect("admin.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=1");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String adminUser = (String) session.getAttribute("adminUser");

        if (adminUser == null) {
            response.sendRedirect("admin.jsp");
            return;
        }

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, orderId);

            stmt.executeUpdate();
            response.sendRedirect("admin.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=1");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}