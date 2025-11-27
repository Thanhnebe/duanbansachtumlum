<%@ page import="com.shop.model.Cart" %>
<%@ page import="com.shop.model.Products" %>
<%@ page import="com.shop.dao.CartDAO" %>
<%@ page import="com.shop.dao.ProductDAO" %>
<%
  String email = (String) session.getAttribute("email");
  Cart cart = (Cart) session.getAttribute("cart");

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
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Cart</title>
  <link rel="stylesheet" href="css/cart.css">
</head>
<body>
  <div class="cart-page">
    <h1 class="cart-title">Cart</h1>
    <div class="cart-layout">
      <div>
        <table class="cart-table">
          <thead>
            <tr>
              <th></th>
              <th>Product</th>
              <th>Price</th>
              <th>Quantity</th>
              <th>Subtotal</th>
            </tr>
          </thead>
          <tbody>
          <%
            double total = 0;
            for (java.util.Map.Entry<Integer, Integer> entry : cart.getItems().entrySet()) {
              int productId = entry.getKey();
              int quantity = entry.getValue();
              Products product = ProductDAO.getProductById(productId);
              if (product == null) {
                continue;
              }
              double price = product.getPrice();
              double subtotal = price * quantity;
              total += subtotal;
          %>
            <tr>
              <td>
                <a href="#" class="cart-remove">×</a>
              </td>
              <td>
                <div class="cart-product">
                  <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="cart-product-image">
                  <a href="#" class="cart-product-name"><%= product.getName() %></a>
                </div>
              </td>
              <td>₱<%= String.format("%.2f", price) %></td>
              <td>
                <input type="number" class="cart-quantity-input" value="<%= quantity %>" min="1" disabled>
              </td>
              <td>₱<%= String.format("%.2f", subtotal) %></td>
            </tr>
          <%
            }
          %>
          </tbody>
        </table>
        <div class="cart-actions"></div>
      </div>
      <div class="cart-totals">
        <h2 class="cart-totals-title">Cart totals</h2>
        <div class="cart-totals-row">
          <span>Subtotal</span>
          <span>₱<%= String.format("%.2f", total) %></span>
        </div>
        <div class="cart-totals-row">
          <span>Total</span>
          <span>₱<%= String.format("%.2f", total) %></span>
        </div>
        <form action="checkout" method="post">
          <p>
            <label>
              <input type="radio" name="paymentMethod" value="COD" checked>
              Thanh toán khi nhận hàng (COD)
            </label>
          </p>
          <p>
            <label>
              <input type="radio" name="paymentMethod" value="QR">
              Thanh toán bằng QR Code
            </label>
          </p>
          <button type="submit" class="cart-checkout-button">Proceed to checkout →</button>
        </form>
      </div>
    </div>
  </div>
</body>
</html>


