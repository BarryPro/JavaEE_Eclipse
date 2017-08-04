package com.belong.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserControl
 */
@WebServlet(name="/UserControl",
		urlPatterns={"/UserControl"}
)
public class UserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String [] name = {"belong","tom","jack","rose"};
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String result="false";
		for(String s:name){
			if(s.equals(username)){
				result = "true";
				break;
			}
		}
		PrintWriter out = response.getWriter();
		out.write(result);
		out.flush();
		out.close();
		
	}

}
