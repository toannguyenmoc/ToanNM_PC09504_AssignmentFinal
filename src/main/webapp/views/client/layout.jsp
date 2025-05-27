<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="assetPath"
	value="${pageContext.request.contextPath}/assets/client" />

<!-- Css Styles -->
<link rel="stylesheet" href="${assetPath}/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/plyr.css" type="text/css">
<link rel="stylesheet" href="${assetPath}/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="${assetPath}/css/style.css" type="text/css">
<style>
.rating-star.disabled {
	pointer-events: none;
}

.rating {
	display: inline-block;
}

.rating i {
	cursor: pointer;
	transition: color 0.3s;
	color: #ced4da;
}

.rating i.active, .rating i.hover {
	color: yellow !important;
}

.otp-inputs {
	display: flex;
	gap: 5px;
}

.otp-box {
	width: 40px;
	height: 40px;
	text-align: center;
	font-size: 20px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="${view}"></jsp:include>
	<jsp:include page="footer.jsp"></jsp:include>


	<!-- Js Plugins -->
	<script src="${assetPath}/js/jquery-3.3.1.min.js"></script>
	<script src="${assetPath}/js/bootstrap.min.js"></script>
	<script src="${assetPath}/js/player.js"></script>
	<script src="${assetPath}/js/jquery.nice-select.min.js"></script>
	<script src="${assetPath}/js/mixitup.min.js"></script>
	<script src="${assetPath}/js/jquery.slicknav.js"></script>
	<script src="${assetPath}/js/owl.carousel.min.js"></script>
	<script src="${assetPath}/js/main.js"></script>

	<script>
		(function() {
			'use strict'

			var forms = document.querySelectorAll('.needs-validation')

			Array.prototype.slice.call(forms).forEach(function(form) {
				form.addEventListener('submit', function(event) {
					if (!form.checkValidity()) {
						event.preventDefault()
						event.stopPropagation()
					}

					form.classList.add('was-validated')
				}, false)
			})
		})()
	</script>

</body>
</html>