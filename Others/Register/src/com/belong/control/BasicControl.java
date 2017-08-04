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
		})//ע��(ͨ��ע��������ֱ�ӷ�������Ӧ���಻��Ҫʵ�����Ϳ��Է���)
public class BasicControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String,String> map = new HashMap<String, String>();  //�Ѳ����ļ�ֵ�Դ��Ϻ÷���
    private static final String FIRST = "first";
    private static final String SECOND = "second";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BasicControl() {//1.������������Servletʵ���������ߵ�
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 3.�������
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String path = request.getParameter("action");//�õ�HTMLҳ�г����ӵĲ�����ֵ
		String page = map.get(path);//ͨ��map�ҵ�����Ӧ��ֵ
		//���´���ȼ��� ��<jsp:forward page=""> һ����Ӧ����ת
		RequestDispatcher dispatcher = request.getRequestDispatcher(page);
		dispatcher.forward(request, response);//һ����ת��������request��
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 3.�������
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	//servletConfig �Ǽ̳�config�� �����ǻ�ȡweb.xml�е������ļ��Ĳ���
	@Override
	public void init(ServletConfig config) throws ServletException {//2.��ʼ��
		// TODO Auto-generated method stub
		map.put(FIRST, config.getInitParameter(FIRST));//�ѵõ��Ĳ�������map�����й�������
		map.put(SECOND, config.getInitParameter(SECOND));
		super.init(config);
	}
	@Override
	public void destroy() {//4.����
		// TODO Auto-generated method stub
		super.destroy();
	}
}
