<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String funcid = WtcUtil.repNull(request.getParameter("funcid"));
   String funcrel = WtcUtil.repNull(request.getParameter("funcrel"));
%>
	<wtc:service name="sRK160Insert" outnum="2">
			<wtc:param value="<%=funcid%>"/>
			<wtc:param value="<%=funcrel%>"/>
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
