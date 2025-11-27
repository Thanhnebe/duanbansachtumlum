package com.shop.filter;

import com.shop.dao.CartDAO;
import com.shop.model.Cart;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebFilter("/*")
public class CartFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);
        
        if (session != null) {
            String email = (String) session.getAttribute("email");
            
            // Nếu user đã đăng nhập
            if (email != null && !email.isEmpty()) {
                Cart cart = (Cart) session.getAttribute("cart");
                
                // Nếu chưa có cart trong session, load từ DB
                if (cart == null) {
                    try {
                        cart = CartDAO.getCartByUserEmail(email);
                        session.setAttribute("cart", cart);
                    } catch (Exception e) {
                        e.printStackTrace();
                        // Nếu lỗi, tạo cart mới
                        cart = new Cart();
                        session.setAttribute("cart", cart);
                    }
                }
            }
        }
        
        chain.doFilter(request, response);
    }
}