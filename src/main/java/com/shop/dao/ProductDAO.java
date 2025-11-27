package com.shop.dao;

import com.shop.db.DBUtil;
import com.shop.model.Products;

import java.sql.*;
import java.util.*;

public class ProductDAO {
	
	public static Products getProductById(int productId) throws Exception {
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE product_id = ?")) {
	        ps.setInt(1, productId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            Products p = new Products();
	            p.setProductId(rs.getInt("product_id"));
	            p.setName(rs.getString("name"));
	            p.setDescription(rs.getString("description"));
	            p.setPrice(rs.getDouble("price"));
	            p.setImageUrl(rs.getString("image_url"));
	            return p;
	        }
	    }
	    return null;
	}

    public static List<Products> getAllProducts() throws Exception {
        List<Products> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM products ORDER BY created_at DESC")) {

            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        }
        return list;
    }
    
    public static void insertProduct(Products p) throws Exception {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "INSERT INTO products (name, description, price, image_url, created_at) VALUES (?, ?, ?, ?, GETDATE())")) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImageUrl());
            ps.executeUpdate();
        }
    }
    
    
    public static void updateProduct(Products p) throws Exception {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE products SET name=?, description=?, price=?, image_url=? WHERE product_id=?")) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImageUrl());
            ps.setInt(5, p.getProductId());
            ps.executeUpdate();
        }
    }
    public static void deleteProduct(int productId) throws Exception {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE product_id=?")) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

}


