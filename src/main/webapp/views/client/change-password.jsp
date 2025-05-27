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
                        <h3>Đổi mật khẩu</h3>
                        <c:set var="errors" value="${requestScope.errors}" />
                        <form id="changePasswordForm" class="needs-validation" novalidate>
                            <div class="input__item">
                                <input type="text" placeholder="Email address" name="email" value="${user.email}" readonly>
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="Password" name="oldPassword" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback" id="errorOldPassword"></div>
                               
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="New Password" name="newPassword" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback" id="errorNewPassword"></div>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="Confirm Password" name="passwordConfirm" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback" id="errorPasswordConfirm"></div>
                            </div>
                            <button type="button" class="site-btn" id="changePasswordBtn">Đổi mật khẩu</button>
                        </form>
                    </div>
                </div>
             	<div class="col-lg-6">
                    <div class="login__register">
                        <h3>Cập nhật thông tin?</h3>
                        <a href="${pageContext.request.contextPath}/account/info" class="primary-btn">Cập nhật</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login Section End -->
    <script>
    document.querySelector("#changePasswordBtn").addEventListener("click", function(event) {
        event.preventDefault();

        const form = document.querySelector("#changePasswordForm");
        const passwordInput = document.querySelector("input[name='oldPassword']");
        const newPasswordInput = document.querySelector("input[name='newPassword']");
        const passwordConfirmInput = document.querySelector("input[name='passwordConfirm']");

        const errorOldPassword = document.querySelector("#errorOldPassword");
        const errorNewPassword = document.querySelector("#errorNewPassword");
        const errorPasswordConfirm = document.querySelector("#errorPasswordConfirm");

        // Xóa lỗi trước đó
        form.classList.remove("was-validated");
        [passwordInput, newPasswordInput, passwordConfirmInput].forEach(input => input.classList.remove("is-invalid"));
        [errorOldPassword, errorNewPassword, errorPasswordConfirm].forEach(error => error.textContent = "");

        const requestData = {
            oldPassword: passwordInput.value,
            newPassword: newPasswordInput.value,
            passwordConfirm: passwordConfirmInput.value
        };

        fetch('${pageContext.request.contextPath}/account/change-password', {
            method: 'POST',
            body: JSON.stringify(requestData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "session_expired") {
                window.location.href = "${pageContext.request.contextPath}/login"; // Nếu phiên làm việc hết hạn, chuyển hướng đến login
            } else if (data.status === "success") {
            	alert(data.message);
                window.location.href = data.redirectUrl;
            } else if (data.errors) { 
                Object.keys(data.errors).forEach(field => {
                	const inputError = document.querySelector("input[name='" + field + "']");
                	const feedbackError = document.querySelector("#error" + field.charAt(0).toUpperCase() + field.slice(1));

                    if (inputError && feedbackError) {
                        inputError.classList.add("is-invalid");
                        feedbackError.textContent = data.errors[field]; 
                    }
                });

                document.querySelector("#changePasswordForm").classList.add("was-validated");  
            }
        })
        .catch(error => console.error("Lỗi:", error));
    });


    </script>