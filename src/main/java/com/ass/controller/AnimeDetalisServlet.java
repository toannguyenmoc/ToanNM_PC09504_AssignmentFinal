package com.ass.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.CommentDAO;
import com.ass.dao.FavoriteDAO;
import com.ass.dao.RatingDAO;
import com.ass.entity.Anime;
import com.ass.entity.Comment;
import com.ass.entity.Favorite;
import com.ass.entity.Rating;
import com.ass.entity.User;

/**
 * Servlet implementation class AnimeDetalisServlet
 */
@WebServlet("/anime-details")
public class AnimeDetalisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnimeDetalisServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String slug = request.getParameter("slug");		
		System.out.println(slug);
		
		Anime anime = new AnimeDAO().selectByParam("slug",slug);
		request.setAttribute("anime", anime);
		
		User user = (User) request.getSession().getAttribute("user");
		Favorite favorite = new Favorite();
		Rating rating = new Rating();
		
		if(user != null) {
			favorite = new FavoriteDAO().findUserFavoriteByAnime(anime.getId(), user.getId());
			request.setAttribute("favorite", favorite != null ? true : false);
			
			rating = new RatingDAO().findUserRatingByAnime(anime.getId(), user.getId());
			request.setAttribute("rating", rating);
		}
		
		List<Comment> comments = new CommentDAO().getCommentsByAnimeId(anime.getId());
		request.setAttribute("comments", comments);
		
		
		request.setAttribute("view", "/views/client/anime-details.jsp");
		request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
