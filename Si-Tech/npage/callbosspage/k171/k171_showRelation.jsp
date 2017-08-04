<%@ page contentType= "text/html;charset=GBK" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.ws3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>来电原因-->IVR语音|知识库</title>
<script type="text/javascript">
	var pWindow = window.dialogArguments;
</script>
</head>
	<%
		String causeId = request.getParameter("causeId")==null?"":request.getParameter("causeId");
		String userClass = request.getParameter("userClass")==null?"":request.getParameter("userClass");
		String cityCode = request.getParameter("cityCode")==null?"":request.getParameter("cityCode");
		//add by hucw,加入呼叫流水号
		String contactId = request.getParameter("contactId")==null?"":request.getParameter("contactId");
	%>
	<frameset cols="50%, *">
		<frame src="k171_causeToIVR.jsp?causeId=<%=causeId%>&userClass=<%=userClass%>&cityCode=<%=cityCode%>&contactId=<%=contactId%>">
		<frame src="k171_causeToKnowledge.jsp?causeId=<%=causeId%>&contactId=<%=contactId%>">
	</frameset>
</html>