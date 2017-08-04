<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String filepath = WtcUtil.repNull(request.getParameter("filepath"));
		String loginNo = (String)session.getAttribute("workNo");  //取login_no
		String kfWorkNo = (String)session.getAttribute("kfWorkNo");  //取login_no		
	  String loginName = (String)session.getAttribute("workName"); //取login_name
    String contact_id=WtcUtil.repNull(request.getParameter("liscontactId"));
%>
	<wtc:service name="sRK042Insert" outnum="2">
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=filepath%>"/>
			<wtc:param value="<%=contact_id%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=kfWorkNo%>"/>				
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


