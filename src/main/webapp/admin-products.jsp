<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.shop.model.Products, com.shop.dao.ProductDAO" %>

<!DOCTYPE html>
<html>

<head>
    <title>Trang quan tri</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styleforproductmodify.css">
    <script src="toggle.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>

<body>
    <div class="container">
        <aside>
            <!--navbar start-->
            <div class="top">
                <div class="logo">
                    <img src="https://github.com/Bruh-Fly/imagesforweb/blob/main/living-word-christian-church.png.webp?raw=true"
                        alt="logoweb" id="logo">
                </div>
                <div class="close" id="close_btn">
                    <span class="material-symbols-sharp">close</span>
                </div>
            </div>

            <!--navbar ends-->

            <!--aside start-->

           
            <!--Các thành phần-->
            <div class="menu-hidde" id="menu">
                <ul>
                    <li><a href="#"><span class="material-symbols-sharp">dashboard</span>Trang chủ</a></li>
                    <li><a href="admin-products.jsp"><span class="material-symbols-sharp">box</span>Quản lý sản phầm</a></li>
                    <li> <a href="#"><span class="material-symbols-sharp">orders</span> Quản lý đơn hàng</a></li>
                    <li><a href="#" class="active"><span class="material-symbols-sharp">user_attributes</span> Quản lý
                            người dùng</a></li>
                    <li><a href="#"><span class="material-symbols-sharp">account_balance</span> Cấu hình thanh toán</a>
                    </li>
                    <li><a href="#"><span class="material-symbols-sharp">local_shipping</span> Cấu hình vận chuyển</a>
                    </li>
                    <li><a href="#"><span class="material-symbols-sharp">bar_chart</span>Thống kê báo cáo</a></li>
                    <li><a href="#"><span class="material-symbols-sharp">settings</span>Cài đặt</a></li>
                    <li><a href="#" id="logout"><span class="material-symbols-sharp">logout</span>Đăng xuất</a></li>
                </ul>
            </div>
        </aside>
        <!--aside ends-->

        <!--main start-->
        <main>
            	<h2>Thêm sản phẩm mới</h2>
	<form action="admin-products" method="post">
	  <input type="hidden" name="action" value="add" class="box">
	  Tên: <input type="text" name="name" class="box"><br>
	  Mô tả: <input type="text" name="description" class="box"><br>
	  Giá: <input type="text" name="price" class="box"><br>
	  Ảnh: <input type="text" name="imageUrl" class="box"><br>
	  <button type="submit" id="addbutton">Thêm</button>
	</form>
	
	<h2>Danh sách sản phẩm</h2>
	<%
	  List<Products> list = ProductDAO.getAllProducts();
	  for (Products p : list) {
	%>
	  <form action="admin-products" method="post">
	    <input type="hidden" name="action" value="update">
	    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
	    Tên: <input type="text" name="name" value="<%= p.getName() %>" class="box">
	    Mô tả: <input type="text" name="description" value="<%= p.getDescription() %>" class="box">
	    Giá: <input type="text" name="price" value="<%= p.getPrice() %>"class="box">
	    Ảnh: <input type="text" name="imageUrl" value="<%= p.getImageUrl() %>"class="box">
	    <button type="submit" class="modifyanddeletebutton">Sửa</button>
	  </form>
	  <form action="admin-products" method="post" style="display:inline;">
	    <input type="hidden" name="action" value="delete">
	    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
	    <button type="submit" class="modifyanddeletebutton">Xóa</button>
	  </form>
	  <hr>
	<% } %> 
        </main>

        <!--main end-->

        <!--right start-->
        <div class="right">
            <div class="top">
                <button id="menu_bar">
                    <span class="material-symbols-sharp">menu</span>

                </button>

                <div class="theme_toggle">
                    <span class="material-symbols-sharp active">light_mode</span>
                    <span class="material-symbols-sharp">dark_mode</span>
                </div>

                <div class="profile">
                    <div class="infor">
                        <p><b>Nguyen Thai Duong</b></p>
                        <p>admin</p>
                        <small class="text-muted"></small>
                    </div>

                    <div class="photo-profile">
                        <img src="../images/7235cef8c9260c1dcdbfa88f64afb1f3.jpg" alt="photo-profile" id="photo-profile">
                    </div>
                </div>
            </div>
            <!--end top-->
            <!--Start recent update-->
            <div class="recent_updates">
                <h2>Recent Updates</h2>
                <div class="updates">
                <div class="update">
                    <div class="photo-profile"><img src="../images/7235cef8c9260c1dcdbfa88f64afb1f3.jpg" alt="photo-profile" id="photo-profile"> </div>
                    <div class="message"><p><b>Duong</b> received his order</p></div>
                </div>

                <div class="update">
                    <div class="photo-profile"><img src="../images/7235cef8c9260c1dcdbfa88f64afb1f3.jpg" alt="photo-profile" id="photo-profile"> </div>
                    <div class="message"><p><b>Duong</b> received his order</p></div>
                </div>

                <div class="update">
                    <div class="photo-profile"><img src="../images/7235cef8c9260c1dcdbfa88f64afb1f3.jpg" alt="photo-profile" id="photo-profile"> </div>
                    <div class="message"><p><b>Duong</b> received his order</p>
                    </div>
                </div>
            </div>
            </div>

            <!--end recent update-->

            <div class="sales_analytics">
        <h2>Sales Analytics</h2>
        <div class="item online">
            <div class="icon">
                <span class="material-symbols-sharp">shopping_cart</span>
            </div>
            <div class="right_text">
                <div class="infor">
                    <h3>online orders</h3>
                    <small class="text-muted">
                        Last seen 2 Hours
                    </small>
                </div>
                <h5 class="danger">-17%</h5>
                <h3>3849</h3>
            </div> 
        </div>

         <div class="item online">
            <div class="icon">
                <span class="material-symbols-sharp">shopping_cart</span>
            </div>
            <div class="right_text">
                <div class="infor">
                    <h3>online orders</h3>
                    <small class="text-muted">
                        Last seen 2 Hours
                    </small>
                </div>
                <h5 class="danger">-17%</h5>
                <h3>3849</h3>
            </div> 
        </div>

         <div class="item online">
            <div class="icon">
                <span class="material-symbols-sharp">shopping_cart</span>
            </div>
            <div class="right_text">
                <div class="infor">
                    <h3>online orders</h3>
                    <small class="text-muted">
                        Last seen 2 Hours
                    </small>
                </div>
                <h5 class="danger">-17%</h5>
                <h3>3849</h3>
            </div> 
        </div>
        </div>
       

        <!--start sale analystic-->
        <div class="item add_products">
        <div>
            <span class="material-symbols-sharp">
                add
            </span>
        </div>
    </div>
        </div>
    


        <!--end right section-->

    </div>
    <script>
    const currentPage = window.location.pathname;
    const menuLinks = document.querySelectorAll('.menu-hidde ul li a');

    menuLinks.forEach(link => {
        if (link.getAttribute('href') === currentPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
</script>
    


</body>

</html>