<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="${pageContext.request.contextPath}/assets/client/img/normal-breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Quên mật khẩu</h2>
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
                        <h3>Quên mật khẩu</h3>
                        <c:set var="errors" value="${requestScope.errors}" />
                        <form>
                            <div class="input__item">
                                <input type="email" placeholder="Email address" id="email" name="email" value="${user.email}" class="text-dark" required>
                                <span class="icon_mail"></span>
                                <small id="error-email" class="text-danger">${errors.email}</small>
                            </div>  
                            <button type="button" class="site-btn mb-3" onclick="sendOTP()">Gửi mã OTP</button>
                            <small id="countdown" class="text-muted d-none"></small>
                        </form>
                        <div class="d-none" id="otp-container">
                        	<h3>Nhập OTP</h3>
                        	<div class="otp-inputs">
						        <input type="text" maxlength="1" class="otp-box">
						        <input type="text" maxlength="1" class="otp-box">
						        <input type="text" maxlength="1" class="otp-box">
						        <input type="text" maxlength="1" class="otp-box">
						        <input type="text" maxlength="1" class="otp-box">
						        <input type="text" maxlength="1" class="otp-box">
						    </div>
						    <div id="error-otp" class="text-danger mt-2"></div>
						    <button id="sendOTPBtn" class="site-btn mt-4" onclick="verifyOTP()">Xác nhận</button>
                        </div>
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
 <script>
function sendOTP() {
    const emailField = document.getElementById("email").value.trim();
    const errorEmail = document.getElementById("error-email");

    // Xóa lỗi cũ trước khi kiểm tra
    errorEmail.textContent = "";

    fetch('${pageContext.request.contextPath}/forgot-password/send-otp', {
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: emailField })
    })
    .then(resp => resp.json())
    .then(json => {
        if (json.status === "ok") {
            document.getElementById("email").disabled = true;
            document.getElementById("otp-container").classList.remove("d-none");

            startCountdown();
        } else {
            errorEmail.textContent = json.message; // Hiển thị lỗi dưới email
        }
    })
    .catch(error => console.error("Lỗi gửi OTP:", error));
}

function startCountdown() {
    let timeLeft = 300;
    const countdown = document.getElementById("countdown");
    if (!countdown) return;

    countdown.classList.remove("d-none");
    
    const timer = setInterval(() => {
        countdown.innerText = "Mã OTP hết hạn sau " + Math.floor(timeLeft / 60) + ":" + (timeLeft % 60);
        timeLeft--;
        if (timeLeft <= 0) {
            clearInterval(timer);
            countdown.innerText = "Mã OTP đã hết hạn, vui lòng yêu cầu lại.";
        }
    }, 1000);
}

function verifyOTP() {
    let otpValue = "";
    document.querySelectorAll(".otp-box").forEach(box => otpValue += box.value);
    const errorOTP = document.getElementById("error-otp");

    errorOTP.textContent = "";

    fetch('${pageContext.request.contextPath}/forgot-password/verify-otp', {
        method: 'POST',
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ otp: otpValue })
    })
    .then(resp => resp.json())
    .then(json => {
        if (json.status === "ok") {
        	if (window.confirm("Mật khẩu mới đã được gửi đến email của bạn.")) {
                window.location.href = "${pageContext.request.contextPath}/login"; 
            }
        } else {
            errorOTP.textContent = json.message; 
        }
    })
    .catch(error => console.error("Lỗi xác nhận OTP:", error));
}
</script>