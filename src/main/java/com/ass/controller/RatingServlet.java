package com.ass.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.RatingDAO;
import com.ass.entity.Anime;
import com.ass.entity.Rating;
import com.ass.entity.User;
import com.ass.utils.RestIO;

/**
 * Servlet implementation class RatingServlet
 */
@WebServlet("/rating")
public class RatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RatingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json");

	        User user = (User) request.getSession().getAttribute("user");
	        if (user == null) {
	            RestIO.writeObject(response, Map.of("error", "Vui lòng đăng nhập!"));
	            return;
	        }

	        @SuppressWarnings("unchecked")
	        Map<String, Object> data = RestIO.readObject(request, Map.class);

	        if (!data.containsKey("animeId") || !data.containsKey("rating")) {
	            RestIO.writeObject(response, Map.of("error", "Thiếu thông tin animeId hoặc rating"));
	            return;
	        }

	        int animeId = Integer.parseInt(data.get("animeId").toString());
	        int ratingValue = Integer.parseInt(data.get("rating").toString());

	        Anime anime = new AnimeDAO().selectByID(animeId);
	        if (anime == null) {
	            RestIO.writeObject(response, Map.of("error", "Anime không tồn tại"));
	            return;
	        }

	        RatingDAO ratingDAO = new RatingDAO();
	        Rating existingRating = ratingDAO.findUserRatingByAnime(animeId, user.getId());

	        if (existingRating != null) {
	            existingRating.setRating(ratingValue);
	            existingRating.setCreated(new Date());
	            ratingDAO.update(existingRating);
	        } else {
	            Rating newRating = new Rating(null, ratingValue, new Date(), anime, user);
	            ratingDAO.insert(newRating);
	        }

	        RestIO.writeObject(response, Map.of("status", "ok", "message", "Đánh giá thành công!", "rating", ratingValue));
	    }
		

}
