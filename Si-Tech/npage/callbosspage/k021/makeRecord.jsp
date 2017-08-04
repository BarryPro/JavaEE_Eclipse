<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="java.lang.Math.*"%>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contactId = WtcUtil.repNull(request.getParameter("contactId"));
   String filePath = WtcUtil.repNull(request.getParameter("filePath"));
   String loginNo = (String)session.getAttribute("workNo");  //取login_no
   int tempNum1 = (int)(Math.random()*16);
   int tempNum2 = (int)(Math.random()*240);
   String lineNo="VRS1-N"+tempNum1+"-M"+tempNum2;
%>
	<wtc:service name="sRRFInsert" outnum="2">
			<wtc:param value=""/>
			<wtc:param value="<%=filePath%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=lineNo%>"/>
			<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);

