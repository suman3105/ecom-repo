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

public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addToCart(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("remove".equals(action)) {
            removeFromCart(request, response);
        } else if ("updateQuantity".equals(action)) {
            updateQuantity(request, response);
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String productId = request.getParameter("productId");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            
            // Check if item already in cart
            String checkSql = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setString(2, productId);
            
            var rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // Update quantity
                String updateSql = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, userId);
                updateStmt.setString(2, productId);
                updateStmt.executeUpdate();
            } else {
                // Add new item
                String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, productId);
                insertStmt.executeUpdate();
            }
            
            response.sendRedirect("cart.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products.jsp");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String productId = request.getParameter("productId");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setString(2, productId);
            
            stmt.executeUpdate();
            response.sendRedirect("cart.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
    
    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String productId = request.getParameter("productId");
        String change = request.getParameter("change");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, change);
            stmt.setInt(2, userId);
            stmt.setString(3, productId);
            
            stmt.executeUpdate();
            response.sendRedirect("cart.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}