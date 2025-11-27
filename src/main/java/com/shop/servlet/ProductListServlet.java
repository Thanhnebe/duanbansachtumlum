package com.shop.servlet;

import com.shop.dao.ProductDAO;
import com.shop.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            List<Products> products = ProductDAO.getAllProducts();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < products.size(); i++) {
                Products p = products.get(i);
                json.append("{")
                    .append("\"id\":").append(p.getProductId()).append(",")
                    .append("\"name\":\"").append(p.getName()).append("\",")
                    .append("\"description\":\"").append(p.getDescription()).append("\",")
                    .append("\"price\":").append(p.getPrice()).append(",")
                    .append("\"imageUrl\":\"").append(p.getImageUrl()).append("\"")
                    .append("}");
                if (i < products.size() - 1) json.append(",");
            }
            json.append("]");
            out.print(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
