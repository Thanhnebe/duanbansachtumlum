package com.shop.servlet;

import com.shop.dao.CartDAO;
import com.shop.model.Cart;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String action = request.getParameter("action");
        String productId = request.getParameter("productId");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        
        Cart cart = (Cart) session.getAttribute("cart");
        
        // Nếu user đã đăng nhập và chưa có cart trong session, load từ DB
        if (cart == null) {
            if (email != null && !email.isEmpty()) {
                try {
                    cart = CartDAO.getCartByUserEmail(email);
                } catch (Exception e) {
                    e.printStackTrace();
                    cart = new Cart();
                }
            } else {
                cart = new Cart();
            }
        }

        if ("add".equals(action) && productId != null) {
            try {
                int id = Integer.parseInt(productId);
                cart.addProduct(id);
            } catch (NumberFormatException e) {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"invalid_product_id\"}");
                return;
            }
        }

        session.setAttribute("cart", cart);
        
        // Nếu user đã đăng nhập, lưu giỏ hàng vào DB
        if (email != null && !email.isEmpty()) {
            try {
                CartDAO.saveCart(email, cart);
            } catch (Exception e) {
                e.printStackTrace();
                // Không throw exception, vẫn trả về response thành công
            }
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"items\":" + cart.getTotalItems() +
                                   ",\"total\":" + cart.getTotalPrice() + "}");
    }
}