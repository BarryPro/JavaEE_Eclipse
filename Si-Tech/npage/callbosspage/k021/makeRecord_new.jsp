<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="java.lang.Math.*"%>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contactId = WtcUtil.repNull(request.getParameter("contactId"));
   String filePath = WtcUtil.repNull(request.getParameter("filePath"));
   String loginNo = (String)session.getAttribute("workNo");  //取login_no

%>
	<wtc:service name="sRRFInsert" outnum="2">
			<wtc:param value=""/>
			<wtc:param value="<%=filePath%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	     out.println("0000001");
	  }
	else
		{
		  out.println("000000");
		}
	%>



