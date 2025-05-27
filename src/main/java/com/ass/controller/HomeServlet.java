package com.ass.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.CommentDAO;
import com.ass.dao.EpisodeDAO;
import com.ass.entity.Anime;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String searchQuery = request.getParameter("searchQuery");
		String pageNumber = request.getParameter("pageNumber");
		String viewAll = request.getParameter("viewAll");

		int pageSize = 6;
		int currentPage = (pageNumber == null || pageNumber.isEmpty()) ? 1 : Integer.parseInt(pageNumber);

		AnimeDAO animeDAO = new AnimeDAO();
		List<Anime> list;
		int listSize;

		if (searchQuery != null && !searchQuery.trim().isEmpty()) {
			list = animeDAO.searchByParam("title", searchQuery, currentPage, pageSize);
			listSize = animeDAO.getSizeSearch("title", searchQuery);
		} else {
			if ("true".equals(viewAll)) {

				list = animeDAO.selectAll();
				listSize = list.size();
			} else {
				list = animeDAO.getPaginatonList(currentPage, pageSize);
				listSize = animeDAO.getSize();

			}
		}
		int totalPages = (int) Math.ceil((double) listSize / pageSize);
		int startPage = Math.max(1, currentPage - 1);
		int endPage = Math.min(totalPages, startPage + 2);
		
		request.setAttribute("searchQuery", searchQuery);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("list", list);

		// Lấy danh sách ID anime
		List<Integer> animeIds = list.stream().map(Anime::getId).collect(Collectors.toList());

		// lấy số tập theo từng anime
		EpisodeDAO episodeDAO = new EpisodeDAO();
		Map<Integer, Long> episodeCounts = episodeDAO.countEpisodesByAnimeIds(animeIds);

		request.setAttribute("episodeCounts", episodeCounts);

		// Lấy tổng số comment theo từng anime
		CommentDAO commentDAO = new CommentDAO();
		Map<Integer, Long> commentCounts = commentDAO.countCommentsByAnimeIds(animeIds);

		request.setAttribute("commentCounts", commentCounts);

		request.setAttribute("view", "/views/client/home.jsp");
		request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
