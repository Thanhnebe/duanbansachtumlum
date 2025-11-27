package com.shop.dao;

import com.shop.db.DBUtil;
import com.shop.model.Cart;

import java.sql.*;
import java.util.Map;

public class CartDAO {
    
    /**
     * Lấy giỏ hàng của user từ database
     */
    public static Cart getCartByUserEmail(String email) throws Exception {
        Cart cart = new Cart();
        try (Connection conn = DBUtil.getConnection()) {
            // Lấy user_id từ email
            int userId = getUserIdByEmail(conn, email);
            if (userId == 0) return cart;
            
            // Lấy các items trong giỏ hàng
            PreparedStatement ps = conn.prepareStatement(
                "SELECT product_id, quantity FROM cart_items WHERE user_id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                cart.addProduct(productId, quantity);
            }
        }
        return cart;
    }
    
    /**
     * Lưu giỏ hàng vào database
     */
    public static void saveCart(String email, Cart cart) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            // Lấy user_id từ email
            int userId = getUserIdByEmail(conn, email);
            if (userId == 0) return;
            
            // Xóa giỏ hàng cũ
            PreparedStatement deletePs = conn.prepareStatement(
                "DELETE FROM cart_items WHERE user_id = ?");
            deletePs.setInt(1, userId);
            deletePs.executeUpdate();
            
            // Thêm các items mới
            PreparedStatement insertPs = conn.prepareStatement(
                "INSERT INTO cart_items (user_id, product_id, quantity, updated_at) VALUES (?, ?, ?, GETDATE())");
            
            Map<Integer, Integer> items = cart.getItems();
            for (Map.Entry<Integer, Integer> entry : items.entrySet()) {
                insertPs.setInt(1, userId);
                insertPs.setInt(2, entry.getKey());
                insertPs.setInt(3, entry.getValue());
                insertPs.addBatch();
            }
            insertPs.executeBatch();
        }
    }
    
    /**
     * Merge giỏ hàng tạm (session) với giỏ hàng trong DB
     */
    public static Cart mergeCarts(Cart sessionCart, Cart dbCart) {
        Cart merged = new Cart();
        
        // Copy items từ DB cart
        Map<Integer, Integer> dbItems = dbCart.getItems();
        for (Map.Entry<Integer, Integer> entry : dbItems.entrySet()) {
            merged.addProduct(entry.getKey(), entry.getValue());
        }
        
        // Merge với session cart (session cart sẽ override nếu có cùng product)
        Map<Integer, Integer> sessionItems = sessionCart.getItems();
        for (Map.Entry<Integer, Integer> entry : sessionItems.entrySet()) {
            merged.addProduct(entry.getKey(), entry.getValue());
        }
        
        return merged;
    }
    
    /**
     * Lấy user_id từ email
     */
    private static int getUserIdByEmail(Connection conn, String email) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
        return 0;
    }
}

