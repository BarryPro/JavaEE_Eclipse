package com.belong.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseControl extends HttpServlet {
	private static final String FIRST = "first";
	private static final String SECOND = "second";
	private Map<String,String> map = new HashMap<String,String>();
	public BaseControl() {//1.
		// TODO Auto-generated constructor stub
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = req.getParameter("action");
		String page = map.get(path);
		RequestDispatcher dispatcher = req.getRequestDispatcher(page);
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
	@Override
	public void init(ServletConfig config) throws ServletException {//2.
		// TODO Auto-generated method stub
		map.put(FIRST, config.getInitParameter(FIRST));
		map.put(SECOND, config.getInitParameter(SECOND));
		super.init(config);
	}
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}
	
}
