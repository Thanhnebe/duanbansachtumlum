<%@ page import="com.shop.model.Cart" %>
<%@ page import="com.shop.dao.CartDAO" %>
<%
  String email = (String) session.getAttribute("email");
  Cart cart = (Cart) session.getAttribute("cart");
  
  // Nếu user đã đăng nhập và chưa có cart trong session, load từ DB
  if (cart == null) {
    if (email != null && !email.isEmpty()) {
      try {
        cart = CartDAO.getCartByUserEmail(email);
        session.setAttribute("cart", cart);
      } catch (Exception e) {
        e.printStackTrace();
        cart = new Cart();
      }
    } else {
      cart = new Cart();
    }
  }

  response.setContentType("application/json");
  out.print("{\"items\":" + cart.getTotalItems() + ",\"total\":" + cart.getTotalPrice() + "}");
%>
