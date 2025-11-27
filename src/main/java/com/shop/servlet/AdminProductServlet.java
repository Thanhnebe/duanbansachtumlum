package com.shop.servlet;

import com.shop.dao.ProductDAO;
import com.shop.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-products")
public class AdminProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                Products p = new Products();
                p.setName(request.getParameter("name"));
                p.setDescription(request.getParameter("description"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setImageUrl(request.getParameter("imageUrl"));
                ProductDAO.insertProduct(p);
            } else if ("update".equals(action)) {
                Products p = new Products();
                p.setProductId(Integer.parseInt(request.getParameter("productId")));
                p.setName(request.getParameter("name"));
                p.setDescription(request.getParameter("description"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setImageUrl(request.getParameter("imageUrl"));
                ProductDAO.updateProduct(p);
            } else if ("delete".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                ProductDAO.deleteProduct(productId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin/admin-products.jsp");
    }
}
