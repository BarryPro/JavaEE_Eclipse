<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% 
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String sucssece = WtcUtil.repNull(request.getParameter("sucssece"));
		String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));
%>
	<wtc:service name="sRK029Update" outnum="2">
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=sucssece%>"/>	
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "��ѯ����ʧ��";
	  }
	    else if(rows[0][0].equals("000002")){
	     retCode = "000001";
	     retMsg = "�޸�����ʧ��";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);



