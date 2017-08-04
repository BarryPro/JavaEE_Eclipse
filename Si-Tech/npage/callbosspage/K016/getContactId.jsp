<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
%>
	<wtc:service name="sGetContactId" outnum="3">
	<wtc:param value="1111"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(!rows[0][0].equals("000000")){
	     retCode = "000001";
	     retMsg = "获取接触流水号失败";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("contactId","<%=rows[0][2]%>");
	core.ajax.receivePacket(response);
