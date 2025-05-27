package com.ass.listener;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class AppListener implements ServletContextListener, HttpSessionListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// bắt đầu chạy ứng dụng
		Map<String, Map<Integer, Long>> animeViews = new HashMap<>();
        sce.getServletContext().setAttribute("animeViews", animeViews);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// trước khi shutdown

//		ServletContext context = sce.getServletContext();
//		Integer visitors = (Integer) context.getAttribute("visitors");
//
//		if (visitors == null) {
//			visitors = 0;
//		}
//		saveVisitorCountToFile(visitors);
//
//		System.out.println("contextDestroyed"+visitors);
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// bắt đầu phiên làm việc
//		HttpSession session = se.getSession();
//		if (session.getAttribute("hasVisited") == null) {
//	
//			ServletContext context = session.getServletContext();
//			Integer visitors = (Integer) context.getAttribute("visitors");
//			if (visitors == null) {
//				visitors = 0;
//			}
//			visitors++;
//			context.setAttribute("visitors", visitors);
//
//			session.setAttribute("hasVisited", true);
//			System.out.println("sessionCreated"+visitors);
//		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// kết thúc phiên làm việc
//		HttpSession session = se.getSession();
//		System.out.println("sessionDestroyed");
	}

//	private Integer readVisitorCountFromFile() {
//		int count = 0;
//		File file = new File("visitor_count.txt");
//		if (file.exists()) {
//			try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
//				count = Integer.parseInt(reader.readLine());
//			} catch (IOException | NumberFormatException e) {
//				e.printStackTrace();
//			}
//		}
//		return count;
//	}
//
//	private void saveVisitorCountToFile(int count) {
//		try (BufferedWriter writer = new BufferedWriter(new FileWriter("visitor_count.txt"))) {
//			writer.write(String.valueOf(count));
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}

}
