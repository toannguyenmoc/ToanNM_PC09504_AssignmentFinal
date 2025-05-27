<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!-- Page Preloder -->
<div id="preloder">
	<div class="loader"></div>
</div>

<!-- Header Section Begin -->
<header class="header">
	<div class="container">
		<div class="row">
			<div class="col-lg-2">
				<div class="header__logo">
					<a href="${pageContext.request.contextPath}/home"> <img
						src="${pageContext.request.contextPath}/assets/client/img/logo.png"
						alt="">
					</a>
				</div>
			</div>
			<div class="col-lg-7 d-flex justify-content-between">
				<div class="header__nav">
					<nav class="header__menu mobile-menu">
						<ul>
							<li class=""><a
								href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
							<c:if test="${not empty sessionScope.user}">
								<li><a
									href="${pageContext.request.contextPath}/favorite/list">Yêu
										Thích</a></li>
							</c:if>
							<li><a href="${pageContext.request.contextPath}/blog">Our
									Blog</a></li>
						</ul>
					</nav>
				</div>
				<div class="my-auto">
					<form action="${pageContext.request.contextPath}/home" method="get">
					    <input type="search" class="form-control" name="searchQuery" placeholder="Tìm kiếm..." value="${param.searchQuery}">
					</form>

				</div>
			</div>
			<div class="col-lg-3 d-flex justify-content-end">
				<div class="header__nav">
					<nav class="header__menu mobile-menu">
						<ul>
							<li><a href="#"><span class="icon_profile"></span>
									<span id="headerUsername">${sessionScope.user != null ? sessionScope.user.username : "Tài Khoản"}</span>
									<span class="arrow_carrot-down"></span></a>
								<ul class="dropdown">
									<c:if test="${empty sessionScope.user}">
										<li><a href="${pageContext.request.contextPath}/login">Đăng
												Nhập</a></li>
										<li><a href="${pageContext.request.contextPath}/register">Đăng
												Ký</a></li>
										<li><hr class="m-0"></li>
										<li><a
											href="${pageContext.request.contextPath}/forgot-password">Quên
												mật khẩu</a></li>
									</c:if>
									<c:if test="${not empty sessionScope.user}">
										<c:if test="${sessionScope.role == false}">
											<li><a href="${pageContext.request.contextPath}/account/info">Thông
													tin</a></li>
											<li><a
												href="${pageContext.request.contextPath}/account/change-password">Đổi
													mật khẩu</a></li>
										</c:if>
										<c:if test="${sessionScope.role == true}">
											<li><a
												href="${pageContext.request.contextPath}/admin/dashboard">Quản
													lý</a></li>
										</c:if>
										<li><hr class="m-0"></li>
										<li><a href="${pageContext.request.contextPath}/logout">Đăng
												xuất</a></li>
									</c:if>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>

		</div>
		<div id="mobile-menu-wrap"></div>
	</div>
</header>
<!-- Header End -->
<script>
function updateHeaderUsername() {
    fetch("${pageContext.request.contextPath}/account/info", {
        headers: { "X-Requested-With": "XMLHttpRequest" } // Định danh đây là AJAX request
    })
    .then(response => response.json()) 
    .then(data => {
        document.querySelector("#headerUsername").textContent = data.username;
    })
    .catch(error => console.error("Lỗi:", error));
}


</script>