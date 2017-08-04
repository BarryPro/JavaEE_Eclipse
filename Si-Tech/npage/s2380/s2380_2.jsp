<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>


<%
/*
   输入参数：手机号
   输出参数：错误代码 错误消息
*/
	
   

 
	  String phoneNo= request.getParameter("phoneNo");  
	  String workNo= request.getParameter("workno");     
	  System.out.println("--------zss------"+phoneNo);
	  System.out.println("--------zss------"+workNo);
	  String ret_code = "";      
    String retMessage = "";	
                      		
 %>
	<wtc:service name="cbopen" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode5" retmsg="retMsg5" outnum="2">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=workNo%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="2" scope="end"/>
<%
     ret_code=retCode5;
     retMessage=retMsg5;
     System.out.println("--------zss------"+ret_code);
     System.out.println("--------zss------"+retMessage);
		if((ret_code.trim()).compareTo("000000") == 0)
		{
%>
            <script language='jscript'>
                rdShowMessageDialog("拆包停机用户开机成功！");
                history.go(-1);
            </script>            
<%		
    }
    else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>