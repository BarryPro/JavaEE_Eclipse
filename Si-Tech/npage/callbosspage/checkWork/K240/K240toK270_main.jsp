<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%
	String opCode = request.getParameter("opCode");
	String jsp_name = new String();
	int int_op_code = Integer.parseInt(opCode.substring(1,4));
	switch(int_op_code){
		case 240:jsp_name = "../K240/fK240.jsp";break;
		case 250:jsp_name = "../K250/fK250.jsp";break;
		case 260:jsp_name = "../K260/fK260.jsp";break;
		case 270:jsp_name = "../K270/fK270.jsp";break;
		//add by hucw,20100531
		case 271:jsp_name = "../K271/fK271.jsp";break;
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title></title>
	</head>
	<frameset rows="*" cols="200,*" frameborder="no" border="0" framespacing="0">
		<script language="javascript">alert(<%=jsp_name%>)</script>
	  <frame src="fK240toK270_tree.jsp?op_code=<%=opCode%>" name="leftFrame" scrolling="auto" id="leftFrame" title="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
	  <frame src="<%=jsp_name%>" name="rightFrame" scrolling="auto" id="rightFrame" title="rightFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
	</frameset>
</html>
