<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String plan_id=request.getParameter("plan_id");
String content_id=request.getParameter("content_id");
String object_id=request.getParameter("object_id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<frameset rows="500" cols="48%,48%,1%" frameborder="no" border="0" framespacing="0">
  <frame src="K310_mend_bqcNo.jsp?plan_id=<%=plan_id%>&content_id=<%=content_id%>&object_id=<%=object_id%>" name="leftFrame"  id="leftFrame" FRAMEBORDER="0" title="leftFrame" frameborder="yes" />
  <frame src="K310_mend_qcNo.jsp?plan_id=<%=plan_id%>&content_id=<%=content_id%>&object_id=<%=object_id%>" name="rightFrame" FRAMEBORDER="0" id="rightFrame" title="rightFrame" frameborder="yes"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

