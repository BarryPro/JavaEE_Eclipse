<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<head>
<title>身份证录入</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="身份证录入";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	
	String regionCode= (String)session.getAttribute("regCode");
	String logacc = getMaxAccept();

%>

</head>

<body>
	
<form name="frm"  method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">身份证录入</div>
</div>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=logacc%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="opcodes" value="<%=opCode%>"  />

</jsp:include>

<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
<%@ include file="/npage/public/hwObject.jsp" %> 
</body>
</html>

