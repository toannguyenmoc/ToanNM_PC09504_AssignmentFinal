<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/normal-breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Đăng ký</h2>
                        <p>Chào mừng đến với blog Anime chính thức.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->
       
    <!-- Signup Section Begin -->
    <section class="signup spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="login__form">
                        <h3>Đăng ký</h3>
                        <c:set var="errors" value="${requestScope.errors}" />
                        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                            <div class="input__item">
                                <input type="text" placeholder="Email address" name="email" value="${user.email}" class="text-dark" required>
                                <span class="icon_mail"></span>
                                <div class="invalid-feedback">Vui lòng nhập email</div>
                                <small class="text-danger">${errors.email}</small>
                            </div>
                            <div class="input__item">
                                <input type="text" placeholder="Your Name" name="username" value="${user.username}" class="text-dark" required>
                                <span class="icon_profile"></span>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên</div>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="Password" name="password" value="${user.password}" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback">Vui lòng nhập mật khẩu</div>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="Confirm Password" name="passwordConfirm" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback">Vui lòng xác nhận mật khẩu</div>
                                <small class="text-danger">${errors.passwordConfirm}</small>
                            </div>
                            <button type="submit" class="site-btn">Đăng ký</button>
                        </form>
                        <h5>Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></h5>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__social__links">
                        <h3>Đăng nhập:</h3>
                        <ul>
                            <li><a href="#" class="facebook"><i class="fa fa-facebook"></i> Đăng nhập bằng Facebook</a>
                            </li>
                            <li><a href="#" class="google"><i class="fa fa-google"></i> Đăng nhập bằng Google</a></li>
                            <li><a href="#" class="twitter"><i class="fa fa-twitter"></i> Đăng nhập bằng Twitter</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Signup Section End -->