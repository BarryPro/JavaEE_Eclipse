
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
   String param2 = "phone="+phone_no;  
   String sqlStr = "select to_char(count(1))  as rowcount from dcustmsg where phone_no=:phone and substr(run_code,2,1)<'a' ";

%>
	<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=phone_no%>" outnum="1">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=param2%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("0")){
	     retCode = "0000001";
	     retMsg = "服务号码验证失败!";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);
