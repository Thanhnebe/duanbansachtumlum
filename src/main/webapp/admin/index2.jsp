<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.shop.model.Products, com.shop.dao.ProductDAO" %>
<!DOCTYPE html>
<html>

<head>
    <title>Trang quan tri</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styleforadmin.css">
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

           
            <!--CÃ¡c thÃ nh pháº§n-->
            <div class="menu-hidde" id="menu">
                <ul>
                    <li><a href="#"><span class="material-symbols-sharp">dashboard</span>Trang chá»§</a></li>
                    <li><a href="admin-products.jsp"><span class="material-symbols-sharp">box</span>Quáº£n lÃ½ sáº£n pháº§m</a></li>
                    <li> <a href="#"><span class="material-symbols-sharp">orders</span> Quáº£n lÃ½ ÄÆ¡n hÃ ng</a></li>
                    <li><a href="#" class="active"><span class="material-symbols-sharp">user_attributes</span> Quáº£n lÃ½
                            ngÆ°á»i dÃ¹ng</a></li>
                    <li><a href="#"><span class="material-symbols-sharp">account_balance</span> Cáº¥u hÃ¬nh thanh toÃ¡n</a>
                    </li>
                    <li><a href="#"><span class="material-symbols-sharp">local_shipping</span> Cáº¥u hÃ¬nh váº­n chuyá»n</a>
                    </li>
                    <li><a href="#"><span class="material-symbols-sharp">bar_chart</span>Thá»ng kÃª bÃ¡o cÃ¡o</a></li>
                    <li><a href="#"><span class="material-symbols-sharp">settings</span>CÃ i Äáº·t</a></li>
                    <li><a href="#" id="logout"><span class="material-symbols-sharp">logout</span>ÄÄng xuáº¥t</a></li>
                </ul>
            </div>
        </aside>
        <!--aside ends-->

        <!--main start-->
       
        
        <%@ page import="java.util.*, com.shop.model.Products, com.shop.dao.ProductDAO" %>

<section id="product-management">
  <h2>Quản lý sản phẩm</h2>
  <table border="1">
    <tr>
      <th>ID</th>
      <th>Tên</th>
      <th>Mô tả</th>
      <th>Giá</th>
      <th>Ảnh</th>
      <th>Hành động</th>
    </tr>
    <%
      List<Products> list = ProductDAO.getAllProducts();
      for (Products p : list) {
    %>
    <tr>
      <td><%= p.getProductId() %></td>
      <td><%= p.getName() %></td>
      <td><%= p.getDescription() %></td>
      <td><%= p.getPrice() %></td>
      <td><img src="<%= p.getImageUrl() %>" width="50"></td>
      <td>
        <form action="admin-products" method="post" style="display:inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="productId" value="<%= p.getProductId() %>">
          <button type="submit" onclick="return confirm('Xóa sản phẩm này?')">Xóa</button>
        </form>
      </td>
    </tr>
    <% } %>
  </table>
</section>


        <section id="add-product">
  <h2>Thêm sản phẩm mới</h2>
  <form action="admin-products" method="post">
    <input type="hidden" name="action" value="add">
    Tên: <input type="text" name="name"><br>
    Mô tả: <input type="text" name="description"><br>
    Giá: <input type="number" step="0.01" name="price"><br>
    Ảnh URL: <input type="text" name="imageUrl"><br>
    <button type="submit">Thêm</button>
  </form>
</section>
        

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


</body>

</html>