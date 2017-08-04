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

/**
 * Servlet implementation class BasicControl
 * first==first.html
 * second==second.html
 */
@WebServlet(name="/BasicControl",urlPatterns="*.do",
		initParams={
				@WebInitParam(name="first",value="first.html"),
				@WebInitParam(name="second",value="second.html")
		})//注解(通过注解名可以直接访问名对应的类不需要实例化就可以访问)
public class BasicControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String,String> map = new HashMap<String, String>();  //把参数的键值对存上好访问
    private static final String FIRST = "first";
    private static final String SECOND = "second";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BasicControl() {//1.构造器（创造Servlet实例）最早走的
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 3.服务对象
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = request.getParameter("action");//得到HTML页中超链接的参数的值
		String page = map.get(path);//通过map找到键对应的值
		//以下代码等价于 ：<jsp:forward page=""> 一次响应不跳转
		RequestDispatcher dispatcher = request.getRequestDispatcher(page);
		dispatcher.forward(request, response);//一次跳转（可以用request）
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 3.服务对象
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	//servletConfig 是继承config类 作用是获取web.xml中的配置文件的参数
	@Override
	public void init(ServletConfig config) throws ServletException {//2.初始化
		// TODO Auto-generated method stub
		map.put(FIRST, config.getInitParameter(FIRST));//把得到的参数传给map来进行关联保存
		map.put(SECOND, config.getInitParameter(SECOND));
		super.init(config);
	}
	@Override
	public void destroy() {//4.销毁
		// TODO Auto-generated method stub
		super.destroy();
	}
}
