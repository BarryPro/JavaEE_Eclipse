<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
%>
  <wtc:service name="sD308Cfm"  routerKey="region" routerValue="<%=regionCode%>" 
  	 retcode="retCode" retmsg="retMessage" outnum="2">
	 		<wtc:param value="" />
			<wtc:param value="01" />
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />	
			<wtc:param value="<%=activePhone%>"/>
		  <wtc:param value=""/> 
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
if("000000".equals(retCode)){
%>
	<script language="javascript">
		rdShowMessageDialog("�����ɹ�",2);
		removeCurrentTab();
	</script>
<%
}else{
%>
	<script language="javascript">
		rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMessage%>",0);
		removeCurrentTab();
	</script>
<%
}
%>
<html>
<head>
	<title>�мۿ����������</title>
	<script language="javascript">
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�мۿ����������</div>
	</div>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
