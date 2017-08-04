package com.belong.control;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.belong.service.IWrite;
import com.belong.service.XMLWriteService;

/**
 * Servlet implementation class TecControl
 */
@WebServlet(name="/TecControl",
		urlPatterns={"/TecControl"})
public class TecControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IWrite service = new XMLWriteService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TecControl() {
    	
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
		String lan = request.getParameter("lan");
		String xml = service.write(lan);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(xml);
		out.flush();
		out.close();
	}

}
