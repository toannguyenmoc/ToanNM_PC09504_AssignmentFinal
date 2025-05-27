package com.ass.controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ass.dao.UserDAO;
import com.ass.entity.User;



/**
 * Servlet implementation class UserManagementServlet
 */
@WebServlet({"/admin/user/list","/admin/user/insert","/admin/user/update","/admin/user/delete"})
public class UserManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		request.setAttribute("list", new UserDAO().selectAll());
		request.setAttribute("view", "/views/admin/user/list.jsp");
		request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO userDAO = new UserDAO();
		
		String id = request.getParameter("id");
		String active = request.getParameter("status");
		
		System.out.println(id);
		System.out.println(active);
				
		userDAO.adminUpdate(new User(Integer.parseInt(id),Boolean.parseBoolean(active)));
	}

}
