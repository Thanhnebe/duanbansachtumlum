package com.shop.model;

import com.shop.dao.ProductDAO;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, Integer> items = new HashMap<>();

    public void addProduct(int productId) {
        items.put(productId, items.getOrDefault(productId, 0) + 1);
    }
    
    public void addProduct(int productId, int quantity) {
        items.put(productId, items.getOrDefault(productId, 0) + quantity);
    }
    
    public Map<Integer, Integer> getItems() {
        return new HashMap<>(items);
    }

    public int getTotalItems() {
        return items.values().stream().mapToInt(i -> i).sum();
    }

    public double getTotalPrice() {
        double total = 0;
        for (Map.Entry<Integer, Integer> entry : items.entrySet()) {
            double price = getPriceById(entry.getKey());
            total += price * entry.getValue();
        }
        return total;
    }

    private double getPriceById(int productId) {
        try {
            Products product = ProductDAO.getProductById(productId);
            if (product != null) {
                return product.getPrice();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
