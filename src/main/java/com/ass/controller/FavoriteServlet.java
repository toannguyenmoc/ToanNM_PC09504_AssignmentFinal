package com.ass.controller;

import java.io.IOException;
import java.util.Date;
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
import com.ass.dao.FavoriteDAO;
import com.ass.entity.Anime;
import com.ass.entity.Favorite;
import com.ass.entity.User;
import com.ass.utils.RestIO;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet({ "/favorite/list", "/favorite/action" })
public class FavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FavoriteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");

		List<Anime> list = new AnimeDAO().findAnimeByUserId(user.getId());
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

		request.setAttribute("view", "/views/client/favorite.jsp");
		request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");

		User user = (User) request.getSession().getAttribute("user");

		if (user == null) {
			RestIO.writeEmptyObject(response);
			return;
		}

		FavoriteDAO favoriteDAO = new FavoriteDAO();
		AnimeDAO animeDAO = new AnimeDAO();

		@SuppressWarnings("unchecked")
		Map<String, Object> data = (Map<String, Object>) RestIO.readObject(request, Map.class);

		if (!data.containsKey("animeId")) {
			RestIO.writeObject(response, Map.of("error", "animeId missing"));
			return;
		}

		int animeId = (int) data.get("animeId");
		boolean favorited = false;

		Favorite favoriteExist = favoriteDAO.findUserFavoriteByAnime(animeId, user.getId());
		if (favoriteExist != null) {
			favoriteDAO.delete(favoriteExist.getId());
		} else {
			Anime anime = animeDAO.selectByID(animeId);
			if (anime != null) {
				Favorite favorite = new Favorite();
				favorite.setFavoriteDate(new Date());
				favorite.setUser(user);
				favorite.setAnime(anime);

				favoriteDAO.insert(favorite);
				favorited = true;
			} else {
				RestIO.writeObject(response, Map.of("error", "video not found"));
				return;
			}
		}
		RestIO.writeObject(response, Map.of("status", "ok", "message", "success", "favorited", favorited));

	}

}
