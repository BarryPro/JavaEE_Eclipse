package com.belong.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.belong.service.IUserService;
import com.belong.service.UserServiceImp;
import com.belong.vo.User;

/**
 * Servlet implementation class RegisterControl
 */
@WebServlet(name="/RegisterControl",urlPatterns="*.d2",
	initParams={
		@WebInitParam(name="success",value="success.jsp"),
		@WebInitParam(name="error",value="index.jsp")
	})
public class RegisterControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String,String> map = new HashMap<String,String>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		login(request,response);
	}
	public void login(HttpServletRequest request, HttpServletResponse response){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		IUserService service = new UserServiceImp();
		RequestDispatcher dispatcher = null;
		if(service.login(user)){
			request.getSession().setAttribute("username", username);
			dispatcher = request.getRequestDispatcher(map.get("success"));
		} else {
			dispatcher = request.getRequestDispatcher(map.get("error"));
		}
		try {
			dispatcher.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		map.put("success",config.getInitParameter("success"));
		map.put("error",config.getInitParameter("error"));
		super.init(config);
	}

}
