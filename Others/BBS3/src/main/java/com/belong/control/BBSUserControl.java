package com.belong.control;

import com.belong.service.BBSUserServiceImpl;
import com.belong.service.IBBSUserService;
import com.belong.vo.BBSUser;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet implementation class BBSUserControl
 */
@WebServlet(
		name="BBSUserControl",
		urlPatterns={"/BBSUserControl"},
		initParams={
				@WebInitParam(name="show",value="/ArticleControl?action=query&curpage=1")
		})
public class BBSUserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private IBBSUserService service = new BBSUserServiceImpl();  
    private Map<String,String> map = new HashMap<String,String>();
    private static final String ACTION = "action";
    private static final String LOGIN = "login";
    private static final String USERNAME = "username";
    private static final String PASSWORD = "password";
    private static final String GLOBALUSER = "globalUser";
    private static final String SHOW = "show";
    private static final String MSG = "msg";
    private static final String SUCCESS = "登录成功！ 欢迎";
    private static final String POST = "光临本帖";
    private static final String FAILED = "对不起！登录失败，请重新登录或注册新的用户";
    private static final String SUN = "sun";
    private static final String COOKIEUSERNAME = "com.belong.username";
    private static final String COOKIEPASSWORD = "com.belong.password";
    private static final String REGISTERSUCCESS = "恭喜你！注册成功";
    private static final String REGISTERFAILED = "对不起！注册失败";   
    private static final String SEPARATOR = "/";
    private static final String FILESEPAEAROR = "file.separator";
    private static final String TMP = "tmp";
    private static final String PIC = "pic";
    private static final String ID = "id";
    private static final String IMAGETYPE = "image/jpeg";
    private static final String PAGE = "page";
    private static final String ROW = "row";
    private static final String USERID = "userid";
    private static final String NUMSUCCESS = "设置成功";
    private static final String NUMFAILED = "设置失败";
    private static final String USERIDFLAG = "&userid=";
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
		if(ServletFileUpload.isMultipartContent(request)){//说名是二进制流
			register(request,response);
		} else { //说明是键直对儿
			String action = request.getParameter(ACTION);
			switch(action){
			case LOGIN:
				login(request,response);
				break;
			case PIC:
				getPic(request,response);
				break;
			case PAGE:
				editPagenum(request,response);
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
		BBSUser globalUser = service.ligin(user);
		RequestDispatcher dispathcher = null;
		if(globalUser!=null){//登录成功
			String sun = request.getParameter(SUN);
			if(sun!=null){
				Cookie c1 = new Cookie(COOKIEUSERNAME,username);
				c1.setMaxAge(7*3600);
				Cookie c2 = new Cookie(COOKIEPASSWORD,password);
				c2.setMaxAge(7*3600);
				response.addCookie(c1);
				response.addCookie(c2);
			}
			request.getSession().setAttribute(GLOBALUSER, globalUser);
			request.setAttribute(MSG, SUCCESS+username+POST);			
		} else {//登录失败
			request.setAttribute(MSG, FAILED);
		}
		dispathcher = request.getRequestDispatcher(map.get(SHOW).toString()+USERIDFLAG+globalUser.getId());
		try {
			dispathcher.forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void register(HttpServletRequest request, HttpServletResponse response){
		//得到tomcat的路径
		String tpath = request.getServletContext().getRealPath(SEPARATOR);
		//临时文件的名/tmp
		String tmp = System.getProperty(FILESEPAEAROR)+TMP;
		File tmpDir = new File(tmp);
		DiskFileItemFactory dfif = new DiskFileItemFactory();
		dfif.setRepository(tmpDir);
		dfif.setSizeThreshold(1024*1024);
		ServletFileUpload sfu = new ServletFileUpload(dfif);
		sfu.setFileSizeMax(1024*1024);
		sfu.setSizeMax(1024*1024*10);		
		try {
			FileItemIterator fii = sfu.getItemIterator(request);
			BBSUser user = service.upload(fii, tpath);
			RequestDispatcher dispatcher = null;
			if(service.register(user)){ //注册成功
				request.setAttribute(MSG, REGISTERSUCCESS);
			} else { //注册失败
				request.setAttribute(MSG, REGISTERFAILED);
			}						
			dispatcher = request.getRequestDispatcher(map.get(SHOW));
			dispatcher.forward(request, response);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	private void getPic(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter(ID);
		byte[] buffer = service.getPic(Integer.parseInt(id));
		response.setContentType(IMAGETYPE);
		try {
			ServletOutputStream sos = response.getOutputStream();
			sos.write(buffer);
			sos.flush();
			sos.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void editPagenum(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String pagenum = request.getParameter(ROW);
		String id = request.getParameter(USERID);
		RequestDispatcher dispatcher;
		if(service.editPagenum(Integer.parseInt(id), Integer.parseInt(pagenum))){
			request.setAttribute(MSG, NUMSUCCESS);
		} else {
			request.setAttribute(MSG, NUMFAILED);
		}
		dispatcher = request.getRequestDispatcher(map.get(SHOW).toString()+USERIDFLAG+id);
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
	}
}
