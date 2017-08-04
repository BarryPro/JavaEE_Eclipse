package com.belong.control;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
		name="/article",
		urlPatterns={"/ArticleControl"}
		)
public class ArticleControl extends HttpServlet {
	private IArticleService service=new ArticleServiceImpl();
	private static final long serialVersionUID = 1L;

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
		///ArticleControl?action=query&curpage=1&userid=999
		String action=request.getParameter("action");
		String curpage=request.getParameter("curpage");
		String userid=request.getParameter("userid");
		RequestDispatcher dispatcher=null;
		switch (action) {
		case "query"://分页查询帖子		
			PageBean pb=service.queryArticleByPage(Integer.parseInt(curpage), Integer.parseInt(userid==null?"999":userid));		
			request.setAttribute("pb",pb);
			dispatcher=request.getRequestDispatcher("show.jsp");		
			break;
		case "del"://删除自己发的帖子
			int id=Integer.parseInt(request.getParameter("id"));
			service.delArticle(id);
			dispatcher=request.getRequestDispatcher("/ArticleControl?action=query&curpage=1&userid="+userid);		
			break;
		case "add"://增加帖子
			Article a = new Article();
			a.setRootid(0);//主帖
			a.setTitle(request.getParameter("title"));
			a.setContent(request.getParameter("content"));
			BBSUser user = (BBSUser) request.getSession().getAttribute("user");
			a.setUser(user);
			if(service.insertArticle(a)){//增加成功
				//走查询
				dispatcher=request.getRequestDispatcher("/ArticleControl?action=query&curpage=1&userid="+userid);		
			}
			break;
		default:
			break;
		}
		try {
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

