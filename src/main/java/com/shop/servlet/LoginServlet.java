package com.shop.servlet;

import com.shop.dao.CartDAO;
import com.shop.db.DBUtil;
import com.shop.model.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String email = request.getParameter("emaillogin");
        String password = request.getParameter("passwordlogin");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("account.html?error=missing");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {

            // Truy vấn người dùng theo email
            PreparedStatement ps = conn.prepareStatement(
                "SELECT password, role FROM users WHERE email = ?");
            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                // Không tìm thấy email
                response.sendRedirect("account.html?error=notfound");
                return;
            }

            String storedPassword = rs.getString("password");
            String role = rs.getString("role");

            boolean match = password.equals(storedPassword);

            if (match) {
                // Đăng nhập thành công → lưu session
                HttpSession session = request.getSession();
                
                // Lấy giỏ hàng tạm từ session (nếu có)
                Cart sessionCart = (Cart) session.getAttribute("cart");
                if (sessionCart == null) {
                    sessionCart = new Cart();
                }
                
                // Lấy giỏ hàng từ database
                Cart dbCart = CartDAO.getCartByUserEmail(email);
                
                // Merge giỏ hàng: session cart + DB cart
                Cart mergedCart = CartDAO.mergeCarts(sessionCart, dbCart);
                
                // Lưu giỏ hàng đã merge vào DB
                CartDAO.saveCart(email, mergedCart);
                
                // Cập nhật session với giỏ hàng đã merge
                session.setAttribute("cart", mergedCart);
                session.setAttribute("email", email);
                session.setAttribute("role", role);

                // Phân quyền chuyển hướng
                if ("admin".equals(role)) {
                    response.sendRedirect("admin/index.html");
                } else {
                    response.sendRedirect("myaccount.html");
                }
            } else {
                // Mật khẩu sai
                response.sendRedirect("account.html?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("account.html?error=server");
        }
    }
}
