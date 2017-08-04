<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String broadPhone = request.getParameter("broadPhone");
	String contact_name = request.getParameter("contact_name");
	String contact_phoneno = request.getParameter("contact_phoneno");
	String loginAccept = request.getParameter("loginAccept");
	
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String work_no = (String)session.getAttribute("workNo");
  
%>
	<wtc:service name="sE474Cfm" outnum="2" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=broadPhone%>"/>
		<wtc:param value="<%=contact_name%>"/>
		<wtc:param value="<%=contact_phoneno%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
if("000000".equals(retCode)){
		%>
	<script language="javascript">
		rdShowMessageDialog("变更成功");
		location="/npage/se474/fe474.jsp?activePhone=<%=phoneNo%>&broadPhone=<%=broadPhone%>";
	</script>
		<%
}else{
		%>
	<script language="javascript">
		rdShowMessageDialog("变更失败<%=retCode%> : <%=retMsg%>");
		removeCurrentTab();
	</script>
		<%
}
%>
