package com.belong.control;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.belong.service.BBSUserServiceImpl;
import com.belong.service.IBBSUserService;
import com.belong.vo.BBSUser;

/**
 * Servlet implementation class BBSUserControl
 */
@WebServlet(
		name="/UserControl",
		urlPatterns={"/UserControl"},
		initParams={
			@WebInitParam(name="show",value="/ArticleControl?action=query&curpage=1")
	})
public class BBSUserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String,String> map = new HashMap<String,String>();
    private IBBSUserService service = new BBSUserServiceImpl();
    private static final String SHOW = "show";//显示
    private static final String ACTION = "action";//活动
    private static final String LOGIN = "login";//登录
    private static final String PIC = "pic";//图片
    private static final String NUM = "num";//设置页数
    private static final String USERNAME = "username";
    private static final String PASSWORD = "password";
    private static final String MSG = "msg";//消息名
    private static final String SUCCESSPRE = "登录成功！欢迎";
    private static final String SUCCESSPOST = "光临本帖";//输出信息
    private static final String USER = "user";//用户别名
    private static final String FAILED = "对不起！登录失败！/n(可能是您的用户名和密码不一致或是您还没有注册本贴吧的账号)";
    private static final String USERIDFLAG = "&userid=";
    private static final String FLAG = "sun";
    private static final String COOKIEU = "http://www.bbs.com/username";
    private static final String COOKIEP = "http://www.bbs.com/password";
    private static final String SEPARATOR = "/";
    private static final String FILESEPAROTOR = "file.separator";
    private static final String TMP = "tmp";
    private static final String REGISTER = "恭喜你！注册成功！";
    private static final String ID = "id";
    private static final String NULL = "";
    private static final String PICTYPE = "image/jpeg";
    private static final String USERID = "userid";
    private static final String ROW = "row";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BBSUserControl() {
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
		if(ServletFileUpload.isMultipartContent(request)){//为二进制流请求
			register(request,response);//注册
		} else {//为键直对请求
			String action = request.getParameter(ACTION);
			switch (action) {
			case LOGIN://登录
				login(request,response);
				break;
			case PIC://从服务器得到图片
				String id = request.getParameter(ID);
				if(!id.equals(NULL)){//已经登录的(防止空指针)
					byte[] buffer = service.getPic(Integer.parseInt(id));
					response.setContentType(PICTYPE);//设置响应图片的类型
					ServletOutputStream out = response.getOutputStream();//服务器输出流
					out.write(buffer);
					out.flush();
					out.close();
				}
				break;
			case NUM://得到每页显示帖子的数量
				String uid = request.getParameter(USERID);
				String row = request.getParameter(ROW);//每页有多少笔贴
				service.editPagenum(Integer.parseInt(row), Integer.parseInt(uid));
				RequestDispatcher dispatcher = request.getRequestDispatcher(map.get(SHOW).toString()+USERIDFLAG+uid);
				dispatcher.forward(request, response);
				break;
			default:
				break;
			}
		}		
	}
	private void login(HttpServletRequest request, HttpServletResponse response){
		String username = request.getParameter(USERNAME);
		String password = request.getParameter(PASSWORD);
		BBSUser user = new BBSUser();
		user.setUsername(username);
		user.setPassword(password);
		BBSUser iduser = service.login(user);//登录后的用户iduser
		RequestDispatcher dispatcher = null;
		if(iduser!=null){//登录成功
			if(request.getParameter(FLAG)!=null){//保存到cookie中用response
				Cookie cookieU = new Cookie(COOKIEU,username);
				cookieU.setMaxAge(7*24*3600);
				Cookie cookieP = new Cookie(COOKIEP,password); 
				cookieP.setMaxAge(7*24*3600);
				response.addCookie(cookieU);
				response.addCookie(cookieP);
			}
			request.getSession().setAttribute(USER, iduser);//发送到全局来实现信息共响
			request.setAttribute(MSG, SUCCESSPRE+username+SUCCESSPOST);
			dispatcher = request.getRequestDispatcher(map.get(SHOW).toString()+USERIDFLAG+iduser.getId());
		} else {//登录失败
			request.setAttribute(MSG, FAILED);
			dispatcher = request.getRequestDispatcher(map.get(SHOW).toString()+USERIDFLAG+999);
		}
		try {
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void register(HttpServletRequest request, HttpServletResponse response){
		//得到tomcat的路径
		String tpath = request.getServletContext().getRealPath(SEPARATOR);
		//组成临时文件目录
		String tmp = System.getProperty(FILESEPAROTOR)+TMP;
		File tmpDir = new File(tmp);
		DiskFileItemFactory dfif = new DiskFileItemFactory();
		dfif.setRepository(tmpDir);//临时中转文件
		dfif.setSizeThreshold(1024*1024);//定义缓存大小
		ServletFileUpload sfu = new ServletFileUpload(dfif);
		sfu.setFileSizeMax(1024*1024);//单个文件的大小
		sfu.setSizeMax(1024*1024*10);//上传的总文件不超过的大小
		try {
			FileItemIterator fii = sfu.getItemIterator(request);//注册用户的信息都在这里
			BBSUser user = service.upload(tpath, fii);//用户的注册信息都传到了user里
			if(service.register(user)){//注册成功
				RequestDispatcher dispatcher = null;
				request.setAttribute(MSG, REGISTER);
				dispatcher = request.getRequestDispatcher(map.get(SHOW));//显示首页
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
		}
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		map.put(SHOW, config.getInitParameter(SHOW));
	}

}
