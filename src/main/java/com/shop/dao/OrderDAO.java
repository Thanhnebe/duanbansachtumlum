package com.shop.dao;

import com.shop.db.DBUtil;
import com.shop.model.Order;
import com.shop.model.OrderItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public static int createOrder(String email, Order order) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            int userId = getUserIdByEmail(conn, email);
            if (userId == 0) {
                throw new IllegalStateException("User not found for email " + email);
            }

            conn.setAutoCommit(false);

            try {
                int orderId = insertOrder(conn, userId, order);
                insertOrderItems(conn, orderId, order.getItems());
                conn.commit();
                return orderId;
            } catch (Exception e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public static List<Order> getAllOrders() throws Exception {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT o.id, o.user_id, o.total_amount, o.payment_method, o.status, o.created_at " +
                             "FROM orders o ORDER BY o.created_at DESC")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        }
        return orders;
    }

    public static void updateStatus(int orderId, String status) throws Exception {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE orders SET status = ?, updated_at = GETDATE() WHERE id = ?")) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }

    private static int insertOrder(Connection conn, int userId, Order order) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO orders (user_id, total_amount, payment_method, status, created_at, updated_at) " +
                        "VALUES (?, ?, ?, ?, GETDATE(), GETDATE())",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getPaymentMethod());
            ps.setString(4, order.getStatus());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        throw new SQLException("Failed to insert order");
    }

    private static void insertOrderItems(Connection conn, int orderId, List<OrderItem> items) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)")) {
            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    private static int getUserIdByEmail(Connection conn, String email) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE email = ?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }
        return 0;
    }
}


