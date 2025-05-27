<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    
    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/normal-breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Đăng Nhập</h2>
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
                        <h3>Đăng Nhập</h3>
                        <c:set var="errors" value="${requestScope.errors}" />
                        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                            <div class="input__item">
                                <input type="text" placeholder="Email address" name="email" value="${user.email}" class="text-dark" required>
                                <span class="icon_mail"></span>
                                <div class="invalid-feedback">Vui lòng nhập email</div>
                                <small class="text-danger">${errors.email}</small>
                            </div>
                            <div class="input__item">
                                <input type="password" placeholder="Password" name="password" value="${user.password}" class="text-dark" required>
                                <span class="icon_lock"></span>
                                <div class="invalid-feedback">Vui lòng nhập mật khẩu</div>
                                <small class="text-danger">${errors.password}</small>
                            </div>
                            <div class="form-check">
								<input class="form-check-input" type="checkbox" value="" id="remember" name="remember">
								<label class="form-check-label text-light" for="remember">Nhớ tài khoản?</label>
							</div>
                            <button type="submit" class="site-btn">Đăng Nhập</button>
                        </form>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="forget_pass">Quên mật khẩu?</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__register">
                        <h3>Bạn chưa có tài khoản?</h3>
                        <a href="${pageContext.request.contextPath}/register" class="primary-btn">Đăng ký</a>
                    </div>
                </div>
            </div>
            <div class="login__social">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-6">
                        <div class="login__social__links">
                            <span>or</span>
                            <ul>
                                <li><a href="#" class="facebook"><i class="fa fa-facebook"></i> Đăng nhập bằng Facebook</a></li>
                                <li><a href="#" class="google"><i class="fa fa-google"></i> Đăng nhập bằng Google</a></li>
                                <li><a href="#" class="twitter"><i class="fa fa-twitter"></i> Đăng nhập bằng Twitter</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login Section End -->