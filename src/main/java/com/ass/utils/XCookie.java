package com.ass.utils;

import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class XCookie {
	static public Cookie get(String name) {
		HttpServletRequest request = RRSharer.getRequest();
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for (Cookie cookie : cookies) {
				if(cookie.getName().equalsIgnoreCase(name)){
					return cookie;
				}
			}
		}
		return null;
	}
	
	static public String getValue(String name) {
		Cookie cookie = XCookie.get(name);
		if(cookie != null) {
			String value = cookie.getValue();
			byte[] bytes = Base64.getDecoder().decode(value);
			return new String(bytes);
		}
		return "";
	}
	
	static public Cookie add(String name, String value, int expiry) {
		byte[] bytes = value.getBytes();
		String encodedValue = Base64.getEncoder().encodeToString(bytes);
		Cookie cookie = new Cookie(name, encodedValue);
		cookie.setMaxAge(expiry);
		cookie.setPath("/");
		HttpServletResponse response = RRSharer.getResponse();
		response.addCookie(cookie);
		return cookie;	
	}
	
	static public void delete(String name) {
		XCookie.add(name, "", 0);
	}
}
