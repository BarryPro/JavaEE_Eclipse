package com.belong.control;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
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

import com.belong.service.IMessageService;
import com.belong.service.MessageServiceImp;
import com.belong.vo.Message;

/**
 * Servlet implementation class MessageControl
 */
@WebServlet(name="/MessageControl",urlPatterns={"*.do"},
		initParams={
				@WebInitParam(name="show",value="/MessageControl.do?action=show"),
				@WebInitParam(name="success",value="show.jsp"),
				@WebInitParam(name="index",value="index.jsp")
		})//这样写的目的就是让success变量中转一下来接键值对show只用传个show的参数servlet才会根据action的值来选择执行的方法
public class MessageControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private IMessageService service = new MessageServiceImp();
    private Map<String,String> map = new HashMap<String,String>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MessageControl() {//1.
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		switch(action){
		case "add":
			add(request,response);
			break;
		case "show":
			show(request,response);
			break;
		case "del":
			del(request,response);
			break;
		default:
			break;
		}		
	}
	public void del(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		Message message = new Message();
		message.setId(Integer.parseInt(id));
		RequestDispatcher dispatcher = null;
		//删处完之后要进行显示
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
	public void add(HttpServletRequest request, HttpServletResponse response){
		String email=request.getParameter("email");
		RequestDispatcher dispatcher=null;		
		if(!service.checkEmail(email)){
			request.setAttribute("email", "邮箱地址错误！");
			dispatcher = request.getRequestDispatcher(map.get("index"));						
		}else{			
			Message message=new Message();
			try {
				String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"utf-8");
				String title = new String(request.getParameter("title").getBytes("ISO8859-1"),"utf-8");
				String content = new String(request.getParameter("content").getBytes("ISO8859-1"),"utf-8");				
				message.setContent(content);
				message.setEmail(email);
				message.setName(name);
				message.setTitle(title);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
			if(service.addMessage(message)){
				dispatcher=request.getRequestDispatcher(map.get("show"));				
			}else{
				dispatcher=request.getRequestDispatcher(map.get("index"));
				request.setAttribute("mess", "添加失败！");
			}			
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
		RequestDispatcher dispatcher = null;
		List<Message> list = service.queryMessage();
		request.setAttribute("mlist", list);
		dispatcher = request.getRequestDispatcher(map.get("success"));
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
	public void init(ServletConfig config) throws ServletException {//2.
		// TODO Auto-generated method stub
		map.put("show", config.getInitParameter("show"));
		map.put("index",config.getInitParameter("index"));
		map.put("success",config.getInitParameter("success"));
	}
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}
}
