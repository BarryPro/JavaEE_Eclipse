<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="com.sitech.crmpd.core.context.SpringContextFactory"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/si.tld" prefix="si"%>
<%@ taglib uri="/WEB-INF/si-html.tld" prefix="html"%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="K280";
	String opName="����������-��ˮ������ʾ";
%>

<html>
<head>
<title>��ʾ������ˮҳ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../public/css/nextPages.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>

<div id="Operation_Table" style="width:100%;padding-left:0px;">
	<div class="title"><div id="title_zi">��ʾ������ˮҳ��</div></div>
<si:pageinfo key="jlnewfunction-HANDLER.function-1" url="k280_newNodeWin_show.jsp">
	<DIV class="title"><font color="red">
	<si:paging pages="10"></si:paging></font>
		<span class="pages">�ܼ�¼����<%=totalNumberOfEntries%> </span> <span class="pages">��<%=pagingPage%>/<%=totalNumberOfPages%>ҳ</span>
	</DIV>
	<table cellspacing="0" style="width:100%">
		<tr>
			<td><b>����</b></td>
			<td><b>������Ϣ��ˮ��</b></td>
			<td><b>����ʱ��</b></td>
			<td><b>������</b></td>
			<td><b>�ڵ���</b></td>
		</tr>

		<si:pagelist id="rows" indexId="index">
			<tr>
				<td><%=rows[0]%></td>
				<td><%=rows[1]%></td>
				<td><%=rows[2]%></td>
				<td><%=rows[3]%></td>
				<td><%=rows[4]%></td>
			</tr>
		</si:pagelist>
	</table>
</si:pageinfo>
</div>
</body>
</html>
