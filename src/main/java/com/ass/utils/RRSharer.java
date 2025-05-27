package com.ass.utils;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RRSharer {
	private static Map<Long, HttpServletRequest> requests = new HashMap<>(); 
	private static Map<Long, HttpServletResponse> responses = new HashMap<>(); 
	
	public static void add(HttpServletRequest request, HttpServletResponse response) {
		requests.put(Thread.currentThread().threadId(), request);
		responses.put(Thread.currentThread().threadId(), response);
	}
	
	public static void remove() {
		requests.remove(Thread.currentThread().threadId());
		responses.remove(Thread.currentThread().threadId());
	}
	
	public static HttpServletRequest getRequest() {
		return requests.get(Thread.currentThread().threadId());
	}
	
	public static HttpServletResponse getResponse() {
		return responses.get(Thread.currentThread().threadId());
	}
}
