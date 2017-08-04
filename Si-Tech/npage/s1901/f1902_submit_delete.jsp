<%
   /*
   * 功能: 集团合同协议录入-提交删除
　 * 版本: v1.0
　 * 日期: 2006/11/05
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	
	Logger logger = Logger.getLogger("f1902_submit_delete.jsp");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();	
		
	String agreeId=request.getParameter("agreeId");


 	ArrayList acceptList = new ArrayList();

    String paramsIn[] = new String[6];
    paramsIn[0] = workNo;
	paramsIn[1] = nopass;
	paramsIn[2] = "1902";
	paramsIn[3] = "";
    paramsIn[4] = agreeId;
    paramsIn[5] = ip_Addr;

    int errCode=-1;
    String errMsg="";
	try
	{   
	  	acceptList = impl.callFXService("s1902AgrDel",paramsIn,"2");
		errCode=impl.getErrCode();   
		errMsg=impl.getErrMsg(); 		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call s1902AgrMod is Failed!");
	}
	       
	
	if(errCode == 0)
  {
%>
        <script language='javascript'>
        	rdShowMessageDialog("操作成功！");
           	history.go(-1);
           	window.location.reload(); 
        </script>
<%}
  else
  {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("错误代码：<%=errCode%>；错误信息：<%=errMsg%>");
	          history.go(-1);
	   	</script>         
<%            
    }
%>
