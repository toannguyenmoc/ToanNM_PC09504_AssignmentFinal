<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    
    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/normal-breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Tài Khoản</h2>
                        <p>Chào mừng đến với blog Anime chính thức.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Login Section Begin -->
    <section class="login spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="login__form">
                        <h3>Thông tin cá nhân</h3>
                        <c:set var="errors" value="${requestScope.errors}" />
                        <form class="needs-validation" novalidate>
                            <div class="input__item">
                                <input type="text" placeholder="Email address" name="email" value="${user.email}" readonly>
                                <span class="icon_mail"></span>
                             
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="Your Name" name="username" value="${user.username}" class="text-dark" required>
                                <span class="icon_profile"></span>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên</div>
                            </div>
                            <button type="button" class="site-btn" id="updateUsernameBtn">Cập nhật</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__register">
                        <h3>Bạn muốn đổi mật khẩu?</h3>
                        <a href="${pageContext.request.contextPath}/account/change-password" class="primary-btn">Đổi mật khẩu</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login Section End -->
    <script>
    document.querySelector("#updateUsernameBtn").addEventListener("click", function(event) {
        event.preventDefault();

        const usernameInput = document.querySelector("input[name='username']");
        const newUsername = usernameInput.value;

        fetch('${pageContext.request.contextPath}/account/info', {
            method: 'POST',
            body: JSON.stringify({ username: newUsername })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "session_expired") {
                window.location.href = "${pageContext.request.contextPath}/login";
            } else if (data.status === "success") {  	
                usernameInput.value = newUsername; 
                alert(data.message); 
                updateHeaderUsername();
            } else {
                alert(data.message); 
            }
        })
        .catch(error => console.error("Lỗi:", error));
    });

    </script>