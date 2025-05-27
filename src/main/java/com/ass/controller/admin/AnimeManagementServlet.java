package com.ass.controller.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.ass.dao.AnimeDAO;
import com.ass.entity.Anime;

/**
 * Servlet implementation class AnimeManagementServlet
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
@WebServlet({ "/admin/anime/list", "/admin/anime/insert", "/admin/anime/update", "/admin/anime/delete" })
public class AnimeManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AnimeManagementServlet() {
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

		if (uriString.contains("/anime/insert")) {

			request.setAttribute("view", "/views/admin/anime/insert.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		} else if (uriString.contains("/anime/update")) {
			String id = request.getParameter("id");

			Anime anime = new AnimeDAO().selectByID(Integer.parseInt(id));

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			df.format(anime.getReleaseDate());

			request.setAttribute("anime", anime);

			request.setAttribute("view", "/views/admin/anime/update.jsp");
			request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
		} else if (uriString.contains("/anime/delete")) {
			try {

				String id = request.getParameter("id");
				new AnimeDAO().delete(Integer.parseInt(id));

				response.sendRedirect(request.getContextPath() + "/admin/anime/list");
			} catch (Exception e) {

				response.sendRedirect(request.getContextPath() + "/admin/anime/list");

			}
		} else if (uriString.contains("/anime/list")) {

			request.setAttribute("list", new AnimeDAO().selectAll());
			request.setAttribute("view", "/views/admin/anime/list.jsp");
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

		if (uriString.contains("/anime/insert")) {

			try {
				Anime anime = new Anime();

				String title = request.getParameter("title");
				String slug = request.getParameter("slug");
				String author = request.getParameter("author");
				String genre = request.getParameter("genre");
				String totalEpisodes = request.getParameter("totalEpisodes");
				String status = request.getParameter("status");
				String duration = request.getParameter("duration");
				String description = request.getParameter("description");

				String releaseDate = request.getParameter("releaseDate");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

				Part part = request.getPart("poster");
				if (part != null && part.getSize() > 0) {
					String fileName = Path.of(part.getSubmittedFileName()).getFileName().toString();
					anime.setPoster(fileName);

					String folderPath = request.getServletContext().getRealPath("/images/");
					Path upload = Path.of(folderPath);

					if (!Files.exists(upload)) {
						Files.createDirectories(upload);
					}

					System.out.println("Writable: " + Files.isWritable(upload));
					System.out.println("File Path: " + folderPath + fileName);

					Path filePath = upload.resolve(fileName);
					part.write(filePath.toString());
				}
				
				anime.setTitle(title);
				anime.setSlug(slug);
				anime.setAuthor(author);
				anime.setGenre(genre);
				anime.setTotalEpisodes(Integer.parseInt(totalEpisodes));
				anime.setStatus(Boolean.parseBoolean(status));
				anime.setDuration(Integer.parseInt(duration));
				anime.setDescription(description);
				anime.setReleaseDate(formatter.parse(releaseDate));


				if (new AnimeDAO().selectBySlug(slug)) {
					request.setAttribute("errorSlug", "Đường dẫn đã tồn tại, vui lòng chọn đường dẫn khác.");
					request.setAttribute("anime", anime);
				      
			        request.setAttribute("view", "/views/admin/anime/insert.jsp");
			        request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
					return;
				}

				new AnimeDAO().insert(anime);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
			response.sendRedirect(request.getContextPath() + "/admin/anime/list");

		} else if (uriString.contains("/anime/update")) {
			try {
				String idStr = request.getParameter("id");
				Integer id = 0;

				if (idStr != null && !idStr.isEmpty()) {
					id = Integer.parseInt(idStr);

				}

				AnimeDAO animeDAO = new AnimeDAO();

				Anime anime = (id > 0) ? animeDAO.selectByID(id) : new Anime();

				anime.setId(id);

				String title = request.getParameter("title");
				String slug = request.getParameter("slug");
				String author = request.getParameter("author");
				String genre = request.getParameter("genre");
				String totalEpisodes = request.getParameter("totalEpisodes");
				String status = request.getParameter("status");
				String duration = request.getParameter("duration");
				String description = request.getParameter("description");

				anime.setTitle(title);
				anime.setSlug(slug);
				anime.setAuthor(author);
				anime.setGenre(genre);
				anime.setTotalEpisodes(Integer.parseInt(totalEpisodes));
				anime.setStatus(Boolean.parseBoolean(status));
				anime.setDuration(Integer.parseInt(duration));
				anime.setDescription(description);

				Part part = request.getPart("poster");
				if (part != null && part.getSize() > 0) {
					String fileName = Path.of(part.getSubmittedFileName()).getFileName().toString();
					anime.setPoster(fileName);

					String folderPath = request.getServletContext().getRealPath("/images/");
					Path upload = Path.of(folderPath);

					if (!Files.exists(upload)) {
						Files.createDirectories(upload);
					}

					Path filePath = upload.resolve(fileName);
					part.write(filePath.toString());
				}
				// Nếu không có file mới, giữ nguyên ảnh cũ
				else if (id > 0) {
					anime.setPoster(animeDAO.selectByID(id).getPoster());
				}
				
				if (new AnimeDAO().isSlugExist(slug, id)) {
					request.setAttribute("errorSlug", "Đường dẫn đã tồn tại, vui lòng chọn đường dẫn khác.");
					request.setAttribute("anime", anime);
				      
			        request.setAttribute("view", "/views/admin/anime/update.jsp");
			        request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
					return;
				}

				new AnimeDAO().update(anime);

			} catch (Exception e) {

				e.printStackTrace();
			}
			response.sendRedirect(request.getContextPath() + "/admin/anime/list");

		}
	}

}
