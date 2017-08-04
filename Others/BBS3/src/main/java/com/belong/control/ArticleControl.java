package com.belong.control;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.belong.service.ArticleServiceImpl;
import com.belong.service.IArticleService;
import com.belong.vo.Article;
import com.belong.vo.BBSUser;
import com.belong.vo.PageBean;

/**
 * Servlet implementation class ArticleControl
 */
@WebServlet(
		name="ArticleControl",
		urlPatterns={"/ArticleControl"},
		initParams={
				@WebInitParam(name="show",value="show.jsp"),
				@WebInitParam(name="queryshow",value="/ArticleControl?action=queryshow&id="),
				@WebInitParam(name="query",value="/ArticleControl?action=query&curpage=1&userid="),
		})
public class ArticleControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private IArticleService service = new ArticleServiceImpl();  
    private Map<String,String> map = new HashMap<String,String>();
    private static final String SHOW = "show";
    private static final String ACTION = "action";
    private static final String USERID = "userid";
    private static final String CURPAGE = "curpage";
    private static final String QUERY = "query";
    private static final String PAGEBEAN = "pb";
    private static final String DEL = "del";
    private static final String ID = "id";
    private static final String QUERYSHOW = "queryshow";
    private static final String ROOTID = "rootid";
    private static final String ADD = "add";
    private static final String TITLE = "title";
    private static final String CONTENT = "content";
    private static final String USER = "globalUser";
    private static final String REPLAY = "replay";
    private boolean flag = false;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleControl() {
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
		String action = request.getParameter(ACTION);		
		switch (action) {
		case QUERY:
			query(request,response);
			break;
		case DEL:
			del(request,response);
			break;
		case ADD:
			flag = false;
			add(request,response);
			break;
		case REPLAY:
			flag = true;
			add(request,response);
			break;
		case QUERYSHOW:
			queryReply(request,response);
			break;
		default:
			break;
		}
		
	}
	private void queryReply(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("utf-8");//设置响应回去识别中文
		PrintWriter out;
		try {
			out = response.getWriter();
			String rootid = request.getParameter(ID);//rshow里传来的主帖id
			//以text json 的形式发送的前段
			String json = service.queryReplay(Integer.parseInt(rootid));
			System.out.println(json);
			out.write(json);//返回的是一个json字符串
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	private void add(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Article  article = new Article();
		String userid = request.getParameter(USERID);
		String rootid = request.getParameter(ROOTID);
		article.setRootid(Integer.parseInt(rootid));
		article.setTitle(request.getParameter(TITLE));
		article.setContent(request.getParameter(CONTENT));
		article.setUser((BBSUser) request.getSession().getAttribute(USER));
		RequestDispatcher dispatcher = null;
		if(service.insertArticle(article)){
			if(flag){
				dispatcher = request.getRequestDispatcher(map.get(QUERYSHOW)+rootid);
			} else {
				dispatcher = request.getRequestDispatcher(map.get(QUERY)+userid);
			}			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private void del(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String id = request.getParameter(ID);
		String userid = request.getParameter(USERID);
		String rootid = request.getParameter(ROOTID);
		RequestDispatcher dispatcher = null;
		service.delArticle(Integer.parseInt(id));
		if(rootid.equals("0")){
			dispatcher = request.getRequestDispatcher(map.get(QUERY)+userid);
		} else {
			dispatcher = request.getRequestDispatcher(map.get(QUERYSHOW)+rootid);
		}
		try {
			dispatcher.forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void query(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String curpage = request.getParameter(CURPAGE);
		String userid = request.getParameter(USERID);
		//路人id是999
		PageBean pb = service.queryArticleByPage(Integer.parseInt(curpage), Integer.parseInt(userid==null?"999":userid));
		RequestDispatcher dispatcher = null;
		dispatcher = request.getRequestDispatcher(map.get(SHOW));
		request.setAttribute(PAGEBEAN, pb);
		try {
			dispatcher.forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		map.put(SHOW, config.getInitParameter(SHOW));
		map.put(QUERY, config.getInitParameter(QUERY));
		map.put(QUERYSHOW, config.getInitParameter(QUERYSHOW));
	}
}
