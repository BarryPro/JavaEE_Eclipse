<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>
<%
String serialnum  = (String)request.getParameter("serialnum");//当前质检流水
String object_id  = (String)request.getParameter("object_id");
String content_id = (String)request.getParameter("content_id");
%>

<frameset cols="250,*" frameborder="no" border="0" framespacing="0">
<frame src="./K214_qc_item_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>" name="leftFrame" scrolling="auto" noresize="noresize" id="leftFrame" frameborder="yes"/>
<frame src="./K214_modify_plan_qc_form.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>&belongserialnum=<%=serialnum%>" name="mainFrame" id="mainFrame" frameborder="yes"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>
