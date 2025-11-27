<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shop.model.Order" %>
<%@ page import="com.shop.dao.OrderDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Quản lý đơn hàng</title>
  <link rel="stylesheet" href="../styleforproductmodify.css">
</head>
<body>
  <h1>Quản lý đơn hàng</h1>
  <table border="1" cellpadding="8" cellspacing="0">
    <tr>
      <th>ID</th>
      <th>User ID</th>
      <th>Total</th>
      <th>Payment</th>
      <th>Status</th>
      <th>Action</th>
    </tr>
    <%
      List<Order> orders = OrderDAO.getAllOrders();
      for (Order o : orders) {
    %>
    <tr>
      <td><%= o.getId() %></td>
      <td><%= o.getUserId() %></td>
      <td>₱<%= String.format("%.2f", o.getTotalAmount()) %></td>
      <td><%= o.getPaymentMethod() %></td>
      <td><%= o.getStatus() %></td>
      <td>
        <form action="../admin-orders" method="post">
          <input type="hidden" name="orderId" value="<%= o.getId() %>">
          <select name="status">
            <option value="pending" <%= "pending".equals(o.getStatus()) ? "selected" : "" %>>Chưa thanh toán</option>
            <option value="processing" <%= "processing".equals(o.getStatus()) ? "selected" : "" %>>Đang xử lý</option>
            <option value="completed" <%= "completed".equals(o.getStatus()) ? "selected" : "" %>>Đã hoàn thành</option>
          </select>
          <button type="submit">Cập nhật</button>
        </form>
      </td>
    </tr>
    <% } %>
  </table>
</body>
</html>


