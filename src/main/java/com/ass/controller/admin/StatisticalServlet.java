package com.ass.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.StatisticalDAO;

/**
 * Servlet implementation class StatisticalServlet
 */
@WebServlet({"/admin/statistical/top-active-users","/admin/statistical/anime-statistics"})
public class StatisticalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StatisticalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uriString = request.getRequestURI();
		StatisticalDAO statisticalDAO = new StatisticalDAO();
		
		if(uriString.contains("/top-active-users")) {
			List<Object[]> getTopActiveUsers = statisticalDAO.getTopActiveUsers();
			request.setAttribute("getTopActiveUsers", getTopActiveUsers);
			
			request.setAttribute("view", "/views/admin/statistical/top-active-users.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
			
		}else {
			
			List<Object[]> getAnimeStatistics = statisticalDAO.getAnimeStatistics();
			request.setAttribute("getAnimeStatistics", getAnimeStatistics);
			
			request.setAttribute("view", "/views/admin/statistical/anime-statistics.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
