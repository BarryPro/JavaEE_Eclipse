package com.belong.control;

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
 * Servlet implementation class ArtcleControl
 */
@WebServlet(
		name="/ArtcleControl",
		urlPatterns={"/ArticleControl"},
		initParams={@WebInitParam(name="show",value="show.jsp")
		})
public class ArtcleControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IArticleService service = new ArticleServiceImpl();
	private Map<String,String> map = new HashMap<String,String>();
    private static final String ACTION = "action";  
    private static final String CURPAGE = "curpage";
    private static final String USERID = "userid";
    private static final String PB = "pb";
    private static final String QUERY = "query";
    private static final String DEL = "del";
    private static final String ADD = "add";
    private static final String SHOW = "show";
    private static final String ID = "id";
    private static final String TITLE = "title";
    private static final String CONTENT = "content";
    private static final String USER = "user";
    private static final String QUERYSHOW = "queryshow";
    private static final String ROOTID = "rootid";
    private static final String REPLY = "reply";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArtcleControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)  {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
			String action = request.getParameter(ACTION);
			String userid = request.getParameter(USERID);//得到登录后的那个用户id
			String curpage = request.getParameter(CURPAGE);
			RequestDispatcher dispatcher = null;
			switch (action) {
			case QUERY:
				PageBean pb = service.queryArticleByPage(Integer.parseInt(curpage), Integer.parseInt(userid==null?"999":userid));
				request.setAttribute(PB, pb);//发送到前端
				dispatcher = request.getRequestDispatcher(map.get(SHOW));
				dispatcher.forward(request, response);
				break;
			case DEL:
				String id = request.getParameter(ID);//article的id帖子id
				String rootid = request.getParameter(ROOTID);//用于区分是删主帖还是删从贴
				service.delArticle(Integer.parseInt(id));
				if(rootid.equals("0")){//主帖
					dispatcher = request.getRequestDispatcher("/ArticleControl?action=query&curpage=1&userid="+userid);
				} else {//删除从贴
					dispatcher = request.getRequestDispatcher("/ArticleControl?action=queryshow&id="+rootid);
				}
				//已登录者的显示帖子
				
				dispatcher.forward(request, response);
				break;
			case ADD:
				Article article = new Article();
				BBSUser user = new BBSUser();
				article.setRootid(0);
				article.setTitle(request.getParameter(TITLE));
				article.setContent(request.getParameter(CONTENT));
				user = (BBSUser) request.getSession().getAttribute(USER);
				article.setUser(user);
				if(service.insertArticle(article)){
					dispatcher = request.getRequestDispatcher("/ArticleControl?action=query&curpage=1&userid="+userid);
					dispatcher.forward(request, response);
				}				
				break;
			case QUERYSHOW:
				response.setCharacterEncoding("utf-8");//设置响应回去识别中文
				PrintWriter out = response.getWriter();
				String rootid1 = request.getParameter(ID);//rshow里传来的主帖id
				//以text json 的形式发送的前段
				String json = service.queryReply(Integer.parseInt(rootid1));
				System.out.println(json);
				out.write(json);//返回的是一个json字符串
				out.flush();
				out.close();
				break;
			case REPLY:
				Article article1 = new Article();
				BBSUser user1 = new BBSUser();
				String rootid2 = request.getParameter(ROOTID);
				article1.setRootid(Integer.parseInt(rootid2));
				article1.setTitle(request.getParameter(TITLE));
				article1.setContent(request.getParameter(CONTENT));
				user1 = (BBSUser) request.getSession().getAttribute(USER);
				article1.setUser(user1);
				if(service.insertArticle(article1)){
					dispatcher = request.getRequestDispatcher("/ArticleControl?action=queryshow&id="+rootid2);
					dispatcher.forward(request, response);
				}				
				break;
			default:
				break;
			}
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		map.put(SHOW, config.getInitParameter(SHOW));
	}

}
