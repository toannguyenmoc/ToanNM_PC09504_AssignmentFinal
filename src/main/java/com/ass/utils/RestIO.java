package com.ass.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

public class RestIO {
	static private ObjectMapper mapper = new ObjectMapper();

	/**
	 * Đọc chuỗi JSON gửi từ client
	 */
	public static String readJson(HttpServletRequest request) throws IOException {
		request.setCharacterEncoding("utf-8");
		BufferedReader reader = request.getReader();
		String line;
		StringBuffer buffer = new StringBuffer();
		while ((line = reader.readLine()) != null) {
			buffer.append(line);

		}
		reader.close();
		return buffer.toString();
	}

	/**
	 * Gửi chuỗi JSON về client
	 */
	public static void writeJson(HttpServletResponse response, String json) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.getWriter().print(json);
		response.flushBuffer();
	}

	/**
	 * Đọc chuỗi JSON gửi từ client và chuyển đổi sang Java Object
	 */
	public static <T> T readObject(HttpServletRequest request, Class<T> clazz) throws IOException {
		String json = RestIO.readJson(request);
		T bean = mapper.readValue(json, clazz);
		return bean;
	}

	/**
	 * Chuyển đổi Java Object sang chuỗi JSON và gửi về client
	 */
	public static void writeObject(HttpServletResponse response, Object data) throws IOException {
		String json = mapper.writeValueAsString(data);
		RestIO.writeJson(response, json);
	}

	/**
	 * Gửi đối tượng rỗng về client
	 */
	public static void writeEmptyObject(HttpServletResponse response) throws IOException {
		RestIO.writeObject(response, Map.of());
	}

}
