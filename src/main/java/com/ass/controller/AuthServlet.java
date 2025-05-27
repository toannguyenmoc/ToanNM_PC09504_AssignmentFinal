package com.ass.controller;

import java.io.IOException;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.codec.binary.Base64;

import com.ass.dao.UserDAO;
import com.ass.entity.User;
import com.ass.utils.MailHelper;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet({ "/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AuthServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uriString = request.getRequestURI();

		if (uriString.contains("/register")) {
			request.setAttribute("view", "/views/client/register.jsp");
			request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
		} else if(uriString.contains("/login")) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
			    for (Cookie cookie : cookies) {
			        if (cookie.getName().equals("user")) {
			            String encoded = cookie.getValue();
			            byte[] bytes = Base64.decodeBase64(encoded);
			            String[] userInfo = new String(bytes).split(",");
			            
			            request.getSession().setAttribute("email", userInfo[0]);
			            request.getSession().setAttribute("password", userInfo[1]);

			        }
			    }
			}

			request.setAttribute("view", "/views/client/login.jsp");
			request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);

		}else if(uriString.contains("/logout")) {
			HttpSession session = request.getSession(false);
			
			if (session != null) {
		        session.removeAttribute("user");
		        session.removeAttribute("role");
		    }
			
		    Cookie[] cookies = request.getCookies();
		    if (cookies != null) {
		        for (Cookie cookie : cookies) {
		            if (cookie.getName().equals("user")) { // Xóa cookie lưu email (nếu có)
		            	cookie.setValue("");
		                cookie.setMaxAge(0);
		                cookie.setPath("/");
		                response.addCookie(cookie);
		            }
		        }
		    }
		    response.sendRedirect(request.getContextPath() + "/home");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uriString = request.getRequestURI();
		if (uriString.contains("/register")) {
			try {
				User user = new User();
				BeanUtils.populate(user, request.getParameterMap());
				String passwordConfirm = request.getParameter("passwordConfirm");

				Map<String, String> errors = new LinkedHashMap<>();

				if (new UserDAO().selectByEmail(user.getEmail()) != null) {
					errors.put("email", "Email đã tồn tại");
				}

				if (passwordConfirm == null || !user.getPassword().equals(passwordConfirm)) {
					errors.put("passwordConfirm", "Xác nhận mật khẩu không đúng");
				}

				if (!errors.isEmpty()) {
					request.setAttribute("errors", errors);
					request.setAttribute("user", user);
					request.setAttribute("view", "/views/client/register.jsp");
					request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
					return;
				}

				user.setCreated(new Date());
				user.setActive(true);
				user.setRole(false);
				new UserDAO().insert(user);

				// gửi mail
				if (user.getEmail() != null) {
					new Thread(() -> {
						MailHelper.sendEmail(user.getEmail(), "Đăng ký thành công",
								"Chào mừng " + user.getUsername() + " đến với chúng tôi");
					}).start();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			response.sendRedirect(request.getContextPath() + "/home");
		}else if(uriString.contains("/login")) {
			try {
			    String email = request.getParameter("email");
			    String password = request.getParameter("password");
			    String remember = request.getParameter("remember");

			    Map<String, String> errors = new LinkedHashMap<>();

			    User user = new UserDAO().selectByEmail(email);

			    if (user == null) {
			        errors.put("email", "Tài khoản không tồn tại!");
			    } else {
			        if (!user.getPassword().equals(password)) {
			            errors.put("password", "Mật khẩu không chính xác!");
			        }

			        if (user.getActive() == false) {
			            errors.put("email", "Tài khoản của bạn đã bị khóa!");
			        }
			    }

			    if (!errors.isEmpty()) {
			        request.setAttribute("errors", errors);
			        request.setAttribute("view", "/views/client/login.jsp");
			        request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
			        return;
			    }

			    request.getSession().setAttribute("user", user);	    
			    request.getSession().setAttribute("role", user.getRole());

			    // Ghi nhớ đăng nhập
			    if (remember != null) {
			    	byte[] bytes = (email + "," + password).getBytes();
			        String userInfo = Base64.encodeBase64String(bytes);

			        Cookie cookie = new Cookie("user", userInfo);
			        cookie.setMaxAge(10 * 60 * 60); // 10 phút
			        cookie.setPath("/");
			        response.addCookie(cookie);
			    }

			    response.sendRedirect(request.getContextPath() + "/home");

			} catch (Exception e) {
			    e.printStackTrace();
			    request.setAttribute("message", "Đã có lỗi xảy ra. Vui lòng thử lại!");
			    request.setAttribute("view", "/views/client/login.jsp");
			    request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
			}

		}
	}

}
