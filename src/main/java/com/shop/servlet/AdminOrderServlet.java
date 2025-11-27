package com.shop.servlet;

import com.shop.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin-orders")
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        try {
            int id = Integer.parseInt(orderId);
            OrderDAO.updateStatus(id, status);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin/admin-orders.jsp");
    }
}


