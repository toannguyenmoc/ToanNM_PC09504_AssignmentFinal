package com.ass.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.UserDAO;
import com.ass.utils.MailHelper;
import com.ass.utils.RestIO;

/**
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet({"/forgot-password","/forgot-password/send-otp","/forgot-password/verify-otp"})
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("view", "/views/client/forgot-password.jsp");
		request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json");
		    String uriString = request.getRequestURI();

		    @SuppressWarnings("unchecked") 
		    Map<String, String> requestData = RestIO.readObject(request, Map.class);

		    if (uriString.contains("/send-otp")) {
		        String email = requestData.get("email").trim();

		        if (email == null || email.isEmpty()) {
		            RestIO.writeObject(response, Map.of("status", "error", "message", "Email không được để trống"));
		            return;
		        }

		        UserDAO userDAO = new UserDAO();
		        if (userDAO.selectByEmail(email) == null) {
		            RestIO.writeObject(response, Map.of("status", "error", "message", "Email không tồn tại!"));
		            return;
		        }

		        String otp = String.format("%06d", new Random().nextInt(1000000)); 
		        long otpTimestamp = System.currentTimeMillis();
		        		        
		        request.getSession().setAttribute("otp", otp);
		        request.getSession().setAttribute("otpTimestamp", otpTimestamp);
		        request.getSession().setAttribute("email", email);

		        MailHelper.sendEmail(email, "Mã xác nhận của bạn là: ", otp);
		        RestIO.writeObject(response, Map.of("status", "ok"));
		        
		    } else if (uriString.contains("/verify-otp")) {
		    	
		        String inputOtp = requestData.get("otp");
		        String sessionOtp = (String) request.getSession().getAttribute("otp");
		        Long otpTimestamp = (Long) request.getSession().getAttribute("otpTimestamp");
		        String email = (String) request.getSession().getAttribute("email");

		        if (sessionOtp == null || otpTimestamp == null) {
		            RestIO.writeObject(response, Map.of("status", "error", "message", "OTP không tồn tại!"));
		            return;
		        }
		        
		        long currentTime = System.currentTimeMillis();
		        long otpExpiryTime = 5 * 60 * 1000;
		        
		        if (currentTime - otpTimestamp > otpExpiryTime) {
		            request.getSession().removeAttribute("otp"); 
		            request.getSession().removeAttribute("otpTimestamp");
		            RestIO.writeObject(response, Map.of("status", "error", "message", "Mã OTP đã hết hạn!"));
		            return;
		        }
		        
		        if (!inputOtp.equals(sessionOtp)) {
		            RestIO.writeObject(response, Map.of("status", "error", "message", "Mã OTP không chính xác!"));
		            return;
		        }

		        String newPassword = MailHelper.generateCode(8);
		        UserDAO userDAO = new UserDAO();
		        userDAO.updatePassword(email, newPassword);
		        MailHelper.sendEmail(email, "Mật khẩu mới của bạn là: ", newPassword);

		        request.getSession().removeAttribute("otp");
		        request.getSession().removeAttribute("otpTimestamp");
		        request.getSession().removeAttribute("email");

		        RestIO.writeObject(response, Map.of("status", "ok", "redirect", request.getContextPath() + "/login"));
		    }
    
	}

}
