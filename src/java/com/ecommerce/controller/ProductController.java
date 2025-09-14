package com.ecommerce.controller;

import com.ecommerce.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            viewProduct(request, response);
        } else if ("search".equals(action)) {
            searchProducts(request, response);
        }
    }
    
    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productId = request.getParameter("id");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, productId);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("product", rs);
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("products.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products.jsp");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
    
    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String query = request.getParameter("query");
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM products WHERE name LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");
            
            ResultSet rs = stmt.executeQuery();
            request.setAttribute("products", rs);
            request.getRequestDispatcher("products.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products.jsp");
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}