package com.shop.servlet;

import com.shop.dao.CartDAO;
import com.shop.dao.OrderDAO;
import com.shop.dao.ProductDAO;
import com.shop.model.Cart;
import com.shop.model.Order;
import com.shop.model.OrderItem;
import com.shop.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String paymentMethod = request.getParameter("paymentMethod");

        if (email == null || email.isEmpty()) {
            response.sendRedirect("account.html");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            try {
                cart = CartDAO.getCartByUserEmail(email);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("Cart.jsp");
            return;
        }

        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "COD";
        }

        Order order = new Order();
        order.setPaymentMethod(paymentMethod);
        order.setStatus("pending");

        double total = 0;
        for (Map.Entry<Integer, Integer> entry : cart.getItems().entrySet()) {
            int productId = entry.getKey();
            int quantity = entry.getValue();
            try {
                Products product = ProductDAO.getProductById(productId);
                if (product == null) {
                    continue;
                }
                double price = product.getPrice();
                double subtotal = price * quantity;
                total += subtotal;

                OrderItem item = new OrderItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setPrice(price);
                order.addItem(item);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        order.setTotalAmount(total);

        try {
            int orderId = OrderDAO.createOrder(email, order);
            session.setAttribute("cart", new Cart());
            response.sendRedirect("checkout-success.jsp?orderId=" + orderId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Cart.jsp");
        }
    }
}


