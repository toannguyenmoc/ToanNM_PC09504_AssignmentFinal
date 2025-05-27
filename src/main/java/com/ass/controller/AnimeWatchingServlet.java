package com.ass.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.AnimeDAO;
import com.ass.dao.CommentDAO;
import com.ass.dao.EpisodeDAO;
import com.ass.entity.Anime;
import com.ass.entity.Comment;
import com.ass.entity.Episode;

/**
 * Servlet implementation class AnimeWatchingServlet
 */
@WebServlet("/anime-watching")
public class AnimeWatchingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnimeWatchingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String slug = request.getParameter("slug");
		String episodeParam = request.getParameter("episode");
		int episodeNumber = (episodeParam != null ) ? Integer.parseInt(episodeParam) : -1;
		
		Anime anime = new AnimeDAO().selectByParam("slug", slug);	
		
		if(anime == null) {
			return;
		}
		
		List<Episode> episodes = new EpisodeDAO().selectByAnimeId(anime.getId());
		
		Episode selectedEpisode = null;
        for (Episode episode : episodes) {
            if (episode.getEpisodeNumber() == episodeNumber) {
                selectedEpisode = episode;
                break;
            }
        }
        
        if (selectedEpisode != null) {
            request.setAttribute("selectedEpisode", extractVideoId(selectedEpisode.getVideoUrl()));
        }
        
		request.setAttribute("slug", slug);	
		request.setAttribute("episodes", episodes);
		
		List<Comment> comments = new CommentDAO().getCommentsByAnimeId(anime.getId());
		request.setAttribute("comments", comments);
		
		// xử lý views
		int animeId = anime.getId();
        String ipAddress = request.getRemoteAddr(); 
        long currentTime = System.currentTimeMillis();
        long tenMinutesInMillis = 10 * 60 * 1000; 

        ServletContext context = getServletContext();
        
        @SuppressWarnings("unchecked")
        Map<String, Map<Integer, Long>> animeViews = (Map<String, Map<Integer, Long>>) context.getAttribute("animeViews");

        boolean shouldIncreaseViews = false;

        synchronized (animeViews) {
            Map<Integer, Long> userViews = animeViews.getOrDefault(ipAddress, new HashMap<>());
            Long lastViewTime = userViews.get(animeId);

            if (lastViewTime == null || (currentTime - lastViewTime) > tenMinutesInMillis) {
                shouldIncreaseViews = true;
                userViews.put(animeId, currentTime);
                animeViews.put(ipAddress, userViews);
            }
        }

        if (shouldIncreaseViews) {
            AnimeDAO dao = new AnimeDAO();
            dao.increaseViews(animeId); 
        }
		
		request.setAttribute("view", "/views/client/anime-watching.jsp");
		request.getRequestDispatcher("/views/client/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public String extractVideoId(String url) {
	    String videoId = null;
	    String regex = "v=([a-zA-Z0-9_-]+)";
	    Pattern pattern = Pattern.compile(regex);
	    Matcher matcher = pattern.matcher(url);
	    if (matcher.find()) {
	        videoId = matcher.group(1);
	    }
	    return videoId;
	}


}
