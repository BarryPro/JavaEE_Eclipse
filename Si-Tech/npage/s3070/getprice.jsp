   
<%
/********************
 version v2.0
 ¿ª·¢ÉÌ si-tech
 update hejw@2009-2-13
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<script language="JavaScript">
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0);
	String card_no = request.getParameter("card_no");
	String card_type = request.getParameter("card_type");
	String regionCode = (String)session.getAttribute("regCode");
	
  //String [] initBack = impl.callService("s3074Init",inputParsm,outputNumber);
%>

   <wtc:service name="s3074Init" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=card_no%>" />
			<wtc:param value="<%=card_type%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%
   
	String return_code= code;
	String error_msg = msg;
	System.out.println("sunzx:"+error_msg);
  
	System.out.println("sunzx:"+result_t[0][0]);
	System.out.println("sunzx:"+result_t[0][1]);
	System.out.println("sunzx:"+result_t[0][2]);
	System.out.println("sunzx:"+result_t[0][3]);
	
	if (return_code.equals("000000"))
	{
%>
		
		window.returnValue="0<%=result_t[0][2]%>"+"||"+"<%=result_t[0][3]%>";
		window.close();
<%
	}
	else{					
%>
		window.returnValue="1<%=error_msg%>";
		window.close(); 
<%
	}
%>
 
</script>
