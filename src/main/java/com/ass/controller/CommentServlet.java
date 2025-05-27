package com.ass.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.CommentDAO;
import com.ass.entity.Anime;
import com.ass.entity.Comment;
import com.ass.entity.User;
import com.ass.utils.RestIO;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/comment/insert")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
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
		        RestIO.writeEmptyObject(response);
		        return;
		    }
		    
		    @SuppressWarnings("unchecked")
		    Map<String, String> data = RestIO.readObject(request, Map.class);
		    
		    String slug = data.get("slug");
		    String content = data.get("content");

		    Anime anime = new AnimeDAO().selectByParam("slug", slug);

		    if (anime == null || content == null || content.trim().isEmpty()) {
		        RestIO.writeEmptyObject(response);
		        return;
		    }

		    Comment comment = new Comment(null, content.trim(), new Date(), anime, user);
		    new CommentDAO().insert(comment);

		    Map<String, Object> jsonResponse = Map.of(
		        "username", user.getUsername(),
		        "content", comment.getContent(),
		        "created", new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(comment.getCreated())
		    );

		    RestIO.writeObject(response, jsonResponse);
		
	}

}
