		   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>         

<%@page contentType="text/html;charset=gbk"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");               //工号
	String regionCode= (String)session.getAttribute("regCode");
	
	Logger logger = Logger.getLogger("f5110_delSub.jsp");
	
	DateFormat df = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String sysdate=df.format(new Date());
	
	
	//获取输入的信息
	String prodDirect = request.getParameter("prodDirect");										//结点
	
  String paramsIn[] = new String[4];
  paramsIn[0] = workNo;																			//工号
  paramsIn[1] = "2951";																			//OP_CODE
  paramsIn[2] = "操作员："+workNo+"进行业务目录删除操作";		//备注
  paramsIn[3] = prodDirect;																	//父结点

  String errCode="";
  String errMsg="";
	try
	{   
	 //	acceptList = impl.callFXService("sSiDirDel",paramsIn,"2");
%>

    <wtc:service name="sSiDirDel" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>

<%	 	
		errCode=code;   
		errMsg=msg; 		 	 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call sProdDirDel is Failed!");
	}
	       
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("操作成功！",2);
        	 document.location.replace("<%=request.getContextPath()%>/npage/s2951/f2951.jsp"); 
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	          history.go(-1);
	      </script>         
<%            
    }
%>
