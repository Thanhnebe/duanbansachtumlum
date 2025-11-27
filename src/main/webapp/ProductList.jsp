<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Danh sách sản phẩm</title>
  <script>
    function updateCartDisplay() {
      fetch('cart-info.jsp')
        .then(response => response.json())
        .then(data => {
          document.getElementById('cart-count').textContent = `${data.items} ₱${data.total.toFixed(2)}`;
        });
    }

    function addToCart(productId, button) {
      button.disabled = true;
      button.textContent = 'Đang xử lý...';

      fetch('cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `action=add&productId=${productId}`
      })
      .then(() => {
        button.textContent = 'Đã thêm';
        button.disabled = false;
        updateCartDisplay();
      })
      .catch(() => {
        button.textContent = 'Thêm vào giỏ hàng';
        button.disabled = false;
      });
    }

    window.onload = updateCartDisplay;
  </script>
</head>
<body>
  <h1>Danh sách sản phẩm</h1>
  <div>
    <button onclick="addToCart(1, this)">Thêm Sản phẩm 1</button>
    <button onclick="addToCart(2, this)">Thêm Sản phẩm 2</button>
    <button onclick="addToCart(3, this)">Thêm Sản phẩm 3</button>
  </div>
  <div>
    <h3>🛒 Giỏ hàng: <span id="cart-count">0 ₱0.00</span></h3>
  </div>
</body>
</html>
