<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
	  <html lang="vi">
	  <head>
	    <meta charset="UTF-8">
	    <title>Trang chu</title>
	    <link rel="stylesheet" href="css/styles.css">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	
	  </head>
	  <body>
	    <header class="navbar">
	      <div class="logo"><img src="images/living-word-christian-church.png.webp" alt="logoweb" id="logoweb"></div>
	      <nav class="menu">
	        <a href="WhoWeAre.html">Who We Are</a>
	        <a href="#">Location</a>
	        <a href="#">Minitries</a>
	        <a href="#">Music</a>
	        <a href="#">Videos</a>
	        <a href="#">Events</a>
	        <a href="#">Contact</a>
	        <a id="donate" href="#">Give</a>
	
	      </nav>
	    </header>
	
	    <div class="iconbutton">
	      <p class="search"><img src="images/icons8_search_30px.png"></p>
	      <a href="Cart.jsp">
  <button class="cart">
    <img src="images/icons8_shopping_cart_64px.png">
    <span>0 VND</span>
  </button>
</a>
	<a href="<%= (session.getAttribute("email") == null) ? "account.html" : "myaccount.html" %>">
	    <img src="images/icons8_account_32px_1.png" alt="Account">
	</a>
	    </div>
	
	    <div id="centertext">
	      <a>Online BookStore</a>
	      <h1>Living Word eBook</h1>
	      <button class="browsebook">Browse Books</button>
	    </div>
	    <div class="toamazon">
	    <a href="https://www.amazon.com/Enough-Learn-How-Be-Content-ebook/dp/B0DWJDBP8Y/" target="_blank">
	                  <div class="linkto">
	                  <img src="images\Enough-is-Enough-min-pbg9aalaeusgykbnbjb9oty3cwtj0f6ewdhepnjn40 copy.png" alt="anh" id="imagebook">
	                  </div>
	    </a>
	                      <p id="noteto">Enough is Enough Kindle</p>
	                      <p id="noteto2">Note: You will be redirected to AMAZON website</p>
	
	                      <h1>Danh sách sản phẩm</h1>
	                      <div id="sanpham"></div>
	                 <script>
	                      function addToCart(productId, button) {
	                    	  button.disabled = true;
	                    	  button.textContent = 'Đang xử lý...';

	                    	  fetch('cart', {
	                    	    method: 'POST',
	                    	    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                    	    body: `action=add&productId=${productId}`
	                    	  })
	                    	  .then(response => response.json())
	                    	  .then(data => {
	                    		  
	                    	    if (data.error) {
	                    	      alert("Có lỗi: " + data.error);
	                    	      button.textContent = 'Thêm vào giỏ hàng';
	                    	      button.disabled = false;
	                    	      return;
	                    	    }
	                    	    button.textContent = 'Đã thêm';
	                    	    button.disabled = false;

	                    	    // ✅ Cập nhật trực tiếp nút giỏ hàng
	                    	    const cartSpan = document.querySelector('.cart span');
	                    	    cartSpan.textContent = `${data.items} ₫${data.total.toFixed(2)}`;
	                    	  })
	                    	  .catch(() => {
	                    	    button.textContent = 'Thêm vào giỏ hàng';
	                    	    button.disabled = false;
	                    	  });
	                    	}
	                    	function updateCartDisplay() {
	                    	  fetch('cart-info.jsp')
	                    	    .then(response => response.json())
	                    	    .then(data => {
	                    	      const cartButton = document.querySelector('.cart span');
	                    	      cartButton.textContent = `${data.items} ₱${data.total.toFixed(2)}`;
	                    	    });
	                    	}

	                    	document.addEventListener('DOMContentLoaded', () => {
	                    	  updateCartDisplay();
	                    	});

	                    	fetch('products')
	                    	  .then(response => response.json())
	                    	  .then(data => {
	                    		console.log(data);
	                    	    const container = document.getElementById('sanpham');
	                    	    data.forEach(p => {
	                    	      const item = document.createElement('div');
	                    	      item.className = 'product-item';
	                    	      item.innerHTML = `
	                    	        <img src="${p.imageUrl}" alt="${p.name}" width="150">
	                    	        <h3>${p.name}</h3>
	                    	        <p>${p.description}</p>
	                    	        <p><strong>Giá:</strong> ${p.price}$</p>
	                    	        <button onclick="addToCart(${p.id}, this)">Thêm vào giỏ hàng</button>
	                    	      `;
	                    	      container.appendChild(item);
	                    	    });
	                    	  })
	                    	  .catch(error => {
	                    	    console.error('Lỗi khi tải sản phẩm:', error);
	                    	  });
</script>
	
	  </body>
	  </html>