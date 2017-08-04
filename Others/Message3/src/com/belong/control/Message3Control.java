package com.belong.control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.belong.service.IMessage3Service;
import com.belong.service.Message3ServiceImp;
import com.belong.vo.Message3;

/**
 * Servlet implementation class Message3Control
 */
@WebServlet(name="/Message3Control",urlPatterns="*.do",
initParams={
		@WebInitParam(name="show",value="/Message3Control.do?action=show"),
		@WebInitParam(name="success",value="show.jsp"),
		@WebInitParam(name="index",value="index.jsp")
})
public class Message3Control extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String,String> map = new HashMap<String,String>();
    private IMessage3Service service =  new Message3ServiceImp();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Message3Control() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		switch (action) {
		case "add":
			add(request,response);
			break;
		case "del":
			del(request,response);
			break;
		case "show":
			show(request,response);
			break;
		default:
			break;
		}
	}
	public void add(HttpServletRequest request, HttpServletResponse response){
		try {
			RequestDispatcher dispatcher = null;
			String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"utf-8");
			String email = new String(request.getParameter("email").getBytes("ISO8859-1"),"utf-8");
			String title = new String(request.getParameter("title").getBytes("ISO8859-1"),"utf-8");
			String content = new String(request.getParameter("content").getBytes("ISO8859-1"),"utf-8");
			if(!service.check(email)){		
				request.setAttribute("email", "” œ‰¥ÌŒÛ");
				dispatcher = request.getRequestDispatcher(map.get("index"));				
			} else {
				Message3 message = new Message3();
				message.setName(name);
				message.setEmail(email);
				message.setTitle(title);
				message.setContent(content);
				if(service.addMessage(message)){
					dispatcher = request.getRequestDispatcher(map.get("show"));
				} else {	
					request.setAttribute("mess", "ÃÌº” ß∞‹");
					dispatcher = request.getRequestDispatcher(map.get("index"));					
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
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void del(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		Message3 message = new Message3();
		message.setId(Integer.parseInt(id));
		RequestDispatcher dispatcher = null;
		if(service.delMessage(message)){
			dispatcher = request.getRequestDispatcher(map.get("show"));
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
	public void show(HttpServletRequest request, HttpServletResponse response){
		List<Message3> list = service.queryMessage();
		RequestDispatcher dispatcher = null;
		dispatcher = request.getRequestDispatcher(map.get("success"));
		request.setAttribute("mlist", list);
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
		map.put("show", config.getInitParameter("show"));
		map.put("success", config.getInitParameter("success"));
		map.put("index", config.getInitParameter("index"));
	}

}
