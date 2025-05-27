package com.ass.controller.admin;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.EpisodeDAO;
import com.ass.entity.Anime;
import com.ass.entity.Episode;

/**
 * Servlet implementation class EpisodeManagementServlet
 */
@WebServlet({ "/admin/episode/list", "/admin/episode/insert", "/admin/episode/update", "/admin/episode/delete" })
public class EpisodeManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EpisodeManagementServlet() {
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
		if (uriString.contains("/episode/insert")) {

			List<Anime> animes = new AnimeDAO().selectAll();

			request.setAttribute("animes", animes);

			request.setAttribute("view", "/views/admin/episode/insert.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		} else if (uriString.contains("/episode/update")) {
			String id = request.getParameter("id");
			List<Anime> animes = new AnimeDAO().selectAll();
			Episode episode = new EpisodeDAO().selectByID(Integer.parseInt(id));

			request.setAttribute("animes", animes);
			request.setAttribute("episode", episode);

			request.setAttribute("view", "/views/admin/episode/update.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		} else if (uriString.contains("/episode/delete")) {
			
			try {

				String id = request.getParameter("id");
				new EpisodeDAO().delete(Integer.parseInt(id));

				response.sendRedirect(request.getContextPath() + "/admin/episode/list");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/admin/episode/list");
			}
		} else {

			request.setAttribute("list", new EpisodeDAO().selectAll());
			request.setAttribute("view", "/views/admin/episode/list.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uriString = request.getRequestURI();
		if (uriString.contains("/episode/insert")) {

			try {
				int animeId = Integer.parseInt(request.getParameter("animeId"));
				int episodeNumber = Integer.parseInt(request.getParameter("episodeNumber"));
				String videoUrl = request.getParameter("videoUrl");

				EpisodeDAO episodeDAO = new EpisodeDAO();
				Episode episode = new Episode();
				Anime anime = new AnimeDAO().selectByID(animeId);
				List<Anime> animes = new AnimeDAO().selectAll();

				episode.setAnime(anime);
				episode.setEpisodeNumber(episodeNumber);
				episode.setReleaseDate(new Date());
				episode.setVideoUrl(videoUrl);

				request.setAttribute("animes", animes);
				request.setAttribute("episode", episode);

				Episode existingEpisodes = episodeDAO.selectByAnimeIdAndEpisodeNumberExceptId(animeId, episodeNumber, -1);
				if (existingEpisodes != null) {
					request.setAttribute("epMessage", "Tập " + episodeNumber + " đã tồn tại");

					request.setAttribute("view", "/views/admin/episode/insert.jsp");
					request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
					return;
				}

				episodeDAO.insert(episode);

				response.sendRedirect(request.getContextPath() + "/admin/episode/list");

			} catch (Exception e) {
				e.printStackTrace();

				request.setAttribute("view", "/views/admin/episode/insert.jsp");
				request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
			}

		} else if (uriString.contains("/episode/update")) {
			try {
				int episodeId = Integer.parseInt(request.getParameter("episodeId"));
				int animeId = Integer.parseInt(request.getParameter("animeId"));
				int episodeNumber = Integer.parseInt(request.getParameter("episodeNumber"));
				String videoUrl = request.getParameter("videoUrl");

				EpisodeDAO episodeDAO = new EpisodeDAO();
				Episode episode = new Episode();
				Anime anime = new AnimeDAO().selectByID(animeId);
				List<Anime> animes = new AnimeDAO().selectAll();

				episode.setId(episodeId);
				episode.setAnime(anime);
				episode.setReleaseDate(new Date());
				episode.setEpisodeNumber(episodeNumber);
				episode.setVideoUrl(videoUrl);

				request.setAttribute("animes", animes);
				request.setAttribute("episode", episode);

				Episode existingEpisodes = episodeDAO.selectByAnimeIdAndEpisodeNumberExceptId(animeId, episodeNumber,
						episodeId);
				if (existingEpisodes != null) {
					request.setAttribute("epMessage", "Tập " + episodeNumber + " đã tồn tại");

					request.setAttribute("view", "/views/admin/episode/update.jsp");
					request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
					return;
				}

				episodeDAO.update(episode);

				response.sendRedirect(request.getContextPath() + "/admin/episode/list");

			} catch (Exception e) {
				e.printStackTrace();

				request.setAttribute("view", "/views/admin/episode/update.jsp");
				request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
			}
		}
	}

}
