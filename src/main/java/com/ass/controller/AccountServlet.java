package com.ass.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.UserDAO;
import com.ass.entity.User;
import com.ass.utils.RestIO;

/**
 * Servlet implementation class AccountServlet
 */
@WebServlet({"/account/info", "/account/change-password"})
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uriString = request.getRequestURI();
		
		String requestedWith = request.getHeader("X-Requested-With"); // AJAX thường gửi header này
	    boolean isAjax = requestedWith != null && "XMLHttpRequest".equals(requestedWith);

	    if (isAjax && uriString.contains("/info")) { // Nếu AJAX yêu cầu /info, trả về JSON
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");

	        User user = (User) request.getSession().getAttribute("user");
	        response.getWriter().write("{\"username\": \"" + (user != null ? user.getUsername() : "Tài Khoản") + "\"}");
	    } else if(uriString.contains("/info")) {
			
			request.setAttribute("view", "/views/client/info.jsp");
			request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
		}else if(uriString.contains("/change-password")) {
			
			request.setAttribute("view", "/views/client/change-password.jsp");
			request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json");
		String uriString = request.getRequestURI();
		if(uriString.contains("/info")) {
			
			  	User user = (User) request.getSession().getAttribute("user");
		        if (user == null) {
		            response.getWriter().write("{\"status\":\"session_expired\",\"message\":\"Phiên đăng nhập đã hết hạn!\"}");
		            return;
		        }
		        
		        @SuppressWarnings("unchecked")
		        Map<String, String> requestData = RestIO.readObject(request, Map.class);
		        String newUsername = requestData.get("username");

		        if (newUsername == null || newUsername.trim().isEmpty()) {
		            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng nhập tên hợp lệ!\"}");
		            return;
		        }

		        UserDAO userDAO = new UserDAO();
		        boolean updated = userDAO.updateUsername(user.getId(), newUsername);

		        if (updated) {
		            user.setUsername(newUsername); 
		            request.getSession().setAttribute("user", user); 
		            response.getWriter().write("{\"status\":\"success\",\"message\":\"Tên đã được cập nhật thành công!\"}");
		        } else {
		            response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể cập nhật tên!\"}");
		        }
			
		}else if(uriString.contains("/change-password")) {
			
			User user = (User) request.getSession().getAttribute("user");
			if (user == null) {
	            RestIO.writeObject(response, Map.of("status", "session_expired", "message", "Phiên đăng nhập đã hết hạn!"));
	            return;
	        }
	        
	        @SuppressWarnings("unchecked")
	        Map<String, String> requestData = RestIO.readObject(request, Map.class);

	        String oldPassword = requestData.get("oldPassword");
	        String newPassword = requestData.get("newPassword");
	        String passwordConfirm = requestData.get("passwordConfirm");

	        Map<String, String> errors = new HashMap<>();

	        if (oldPassword == null || oldPassword.trim().isEmpty()) {
	            errors.put("oldPassword", "Vui lòng nhập mật khẩu hiện tại !");
	        }
	        if (newPassword == null || newPassword.trim().isEmpty()) {
	            errors.put("newPassword", "Vui lòng nhập mật khẩu mới !");
	        }
	        if (passwordConfirm == null || passwordConfirm.trim().isEmpty()) {
	            errors.put("passwordConfirm", "Vui lòng xác nhận mật khẩu !");
	        }
	        
	        if (!errors.isEmpty()) {
	            RestIO.writeObject(response, Map.of("status", "error", "errors", errors));
	            return;
	        }

	        if (!user.getPassword().equals(oldPassword)) {
	            errors.put("oldPassword", "Mật khẩu hiện tại không chính xác !");
	        }

	        if (!newPassword.equals(passwordConfirm)) {
	            errors.put("passwordConfirm", "Xác nhận mật khẩu không chính xác !");
	        }

	        if (!errors.isEmpty()) {
	            RestIO.writeObject(response, Map.of("status", "error", "errors", errors)); 
	            return;
	        }

	        UserDAO userDAO = new UserDAO();
	        boolean updated = userDAO.updatePassword(user.getEmail(), newPassword);

	        if (updated) {
	            request.getSession().invalidate(); 
	            RestIO.writeObject(response, Map.of(
	                "status", "success", 
	                "message", "Mật khẩu đã được cập nhật!",
	                "redirectUrl", request.getContextPath() + "/login"
	            ));
	        } else {
	            RestIO.writeObject(response, Map.of("status", "error", "message", "Không thể cập nhật mật khẩu!"));
	        }

	        
	        
			
		}
	}

}
