<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Order received</title>
</head>
<body>
  <h1>Order received</h1>
  <p>Your order ID is <%= request.getParameter("orderId") %>.</p>
  <p>Thank you for your purchase.</p>
</body>
</html>


