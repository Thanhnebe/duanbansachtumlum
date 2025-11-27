package com.shop.servlet;

import com.shop.db.DBUtil;
import com.shop.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("emailregister");
        String password = request.getParameter("passwordregister");	

        if (email == null || email.isEmpty() || password == null || password.length() < 6) {
            response.sendRedirect("account.html?error=invalid");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            // Kiểm tra email đã tồn tại
            try (PreparedStatement check = conn.prepareStatement("SELECT id FROM users WHERE email = ?")) {
                check.setString(1, email);
                ResultSet rs = check.executeQuery();
                if (rs.next()) {
                    response.sendRedirect("account.html?error=exists");
                    return;
                }
            }

            // Mã hóa mật khẩu
           //String hash = PasswordUtil.hashPassword(password);

            // Chèn vào bảng users
         // Không dùng hash nữa, lưu trực tiếp password
            try (PreparedStatement insert = conn.prepareStatement(
                    "INSERT INTO users (email, password, created_at) VALUES (?, ?, GETDATE())")) {
                insert.setString(1, email);
                insert.setString(2, password); // ✅ lưu mật khẩu gốc
                insert.executeUpdate();
            }


            // Chuyển sang trang quản lý tài khoản
            response.sendRedirect("myaccount.html");

        } catch (Exception e) {
            response.sendRedirect("account.html?error=server");
        }

    }
}
