<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String code = WtcUtil.repNull(request.getParameter("code"));
    String name = WtcUtil.repNull(request.getParameter("name"));
	
		String sql= " INSERT INTO scalloutfailreson(failure_code,failure_name) " 
		+ " VALUES(:v1,:v2) ";
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=code%>"/>
			<wtc:param value="<%=name%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "±£´æ¹ØÏµÊ§°Ü";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);





