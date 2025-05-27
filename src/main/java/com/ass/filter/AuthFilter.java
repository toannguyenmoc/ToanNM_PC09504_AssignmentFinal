package com.ass.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.entity.User;

@WebFilter({"/favorite/*","/account/*","/comment/*","/rating","/admin/*"})
public class AuthFilter implements HttpFilter{

	@Override
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String url = request.getRequestURI() + "?"+ request.getQueryString();
		
		request.getSession().setAttribute("url", url);
		
		User user = (User) request.getSession().getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/error?code=404");
			return;
		}
		
		String uriString = request.getRequestURI();
		if(uriString.contains("/admin") && !user.getRole()) {
			response.sendRedirect(request.getContextPath()+"/error?code=404");
			return;
		}
		
		chain.doFilter(request, response);
		
	}

}
