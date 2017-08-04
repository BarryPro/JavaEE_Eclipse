<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contactId = WtcUtil.repNull(request.getParameter("contactId"));
   String filePath = WtcUtil.repNull(request.getParameter("filePath"));
%>
	<wtc:service name="sRRFInsert" outnum="2">
			<wtc:param value=""/>
			<wtc:param value="<%=filePath%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=contactId%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "±£´æ¹ØÏµÊ§°Ü";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);

