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

import com.belong.service.BBSUserServiceImp;
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
	    }
	)
public class UserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private IBBSUserService service=new BBSUserServiceImp();
    private Map<String,String> map=new HashMap<String,String>();
    private static final String SHOW="show";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserControl() {
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
	private void login(HttpServletRequest request, HttpServletResponse response){
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		BBSUser user=new BBSUser();
		user.setUsername(username);
		user.setPassword(password);
		RequestDispatcher dispatcher=null;		
		BBSUser usr=service.login(user);		
		if(usr!=null){//如果登录成功！
			dispatcher=request.getRequestDispatcher(map.get(SHOW).toString()+"&userid="+usr.getId());
			//判断是否勾住了记住一星期
			if(request.getParameter("sun")!=null){//已经勾住
				Cookie c=new Cookie("http://www.bbs.com/username",username);
				c.setMaxAge(7*24*3600);
				Cookie c1=new Cookie("http://www.bbs.com/password",password);
				c1.setMaxAge(7*24*3600);
				response.addCookie(c);
				response.addCookie(c1);				
			}
			request.getSession().setAttribute("user", usr);//??
			
			request.setAttribute("msg", "登录成功！欢迎"+username+"进入贴吧！");
		}else{//登录不成功
			
			request.setAttribute("msg", "登录失败，请重新登录！");
		}
		//<jsp:forward
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
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		map.put(SHOW, config.getInitParameter(SHOW));
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");		
		if(ServletFileUpload.isMultipartContent(request)){//是二进制流上传enctype="multipart/form-data" 
			register(request,response);
		}else{//application/x-www-form-urlencoded:键值对
			if(action.equals("login")){//登录
				login(request,response);//
			}else if(action.equals("pic")){//相应照片请求
				String id=request.getParameter("id");
				if(!id.equals("")){
					byte[] buffer=service.getPic(Integer.parseInt(id));					
					response.setContentType("image/jpeg");
					ServletOutputStream out=response.getOutputStream();					
					out.write(buffer);					
					out.flush();
					out.close();					
				}				
			} else if (action.equals("num")){
				String uid = request.getParameter("userid");
				String row = request.getParameter("row");
				service.editPageNum(Integer.parseInt(row), Integer.parseInt(uid));
				RequestDispatcher dispatcher = request.getRequestDispatcher(map.get(SHOW).toString()+"&userid="+uid);
				dispatcher.forward(request, response);
			}
		}		
	}

	private void register(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		//找到Tomcat路径
		//C:\Software\web-server\apache-tomcat-8.0.15-windows-x64\apache-tomcat-8.0.15\wtpwebapps\C8
		String tpath=request.getServletContext().getRealPath("/");		
		String tmp=System.getProperty("file.separator")+"tmp";		
		File tmpDir=new File(tmp);//创建临时目录		
		DiskFileItemFactory dff=new DiskFileItemFactory();
		dff.setRepository(tmpDir);//设置临时存储目录
		dff.setSizeThreshold(1024*1024);//设置临时存储文件的缓存大小		
		ServletFileUpload sfu=new ServletFileUpload(dff);
		sfu.setFileSizeMax(1024*1024*10);//单个文件大小
		sfu.setSizeMax( 1024*1024*10*10);//总共所有文件大小		
		try {//遍历所有上传组件的遍历器
			FileItemIterator fi=sfu.getItemIterator(request);			
			BBSUser user=service.upload(tpath,fi);					
			if(service.register(user)){
				try {
					RequestDispatcher dispatcher=null;
					request.setAttribute("msg", "注册成功！");
					dispatcher=request.getRequestDispatcher(map.get(SHOW));					
					dispatcher.forward(request, response);
				} catch (ServletException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 		
	}
}

