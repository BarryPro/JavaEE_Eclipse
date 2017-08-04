<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
	<title>提示内容</title>
<%
    String workNo = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode=org_code.substring(0,2);
	  String opName="任务提示";
	  String promptSeq = request.getParameter("promptSeq");
%>
<wtc:pubselect name="sPubSelect" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>select  t.title,t.content,to_char(t.selDate,'yyyy-mm-dd'),to_char(t.op_time,'yyyy-mm-dd'),t.login_no ,to_char(t.begin_time,'yyyy-mm-dd') ,to_char(t.end_time,'yyyy-mm-dd') from dTaskmsg t where to_char(t.login_accept) = '<%=promptSeq%>' and  login_no='<%=workNo%>'
	</wtc:sql>
</wtc:pubselect>
<wtc:array id ="result" scope = "end"/>

<META  http-equiv=Pragma>
<META  http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<link href="/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<head>

<script language="JavaScript">	
function closePage()
{
	this.window.opener = null;   
  window.close();   
}
</script>
</head>
<body>

		<div id="Operation_Title"><B><%=WtcUtil.repNull(opName)%></B></div>
		<div >
			<div id="form">
<table width="99%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td classes="grey" width="20%"><b>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题:</b> </td>
	<td classes="grey">
		<%=result.length>0?result[0][0]:"&nbsp;"%>
	</td>
</tr>
<tr>
	<td classes="grey"><b>任务开始时间:</b></td>
	<td classes="grey"><%=result.length>0?result[0][5]:"&nbsp;"%></td>
</tr>
<tr>
	<td classes="grey"><b>任务结束时间:</b></td>
	<td classes="grey"><%=result.length>0?result[0][6]:"&nbsp;"%></td>
</tr>
<tr>
	<td classes="grey"><b>任务内容:</b></td>
	<td classes="grey"><%=result.length>0?result[0][1]:"&nbsp;"%></td>
</tr>
<tr>
	<td classes="grey"><b>录入工号:</b></td>
	<td classes="grey"><%=result.length>0?result[0][4]:"&nbsp;"%></td>
</tr>
<tr>
<td align="center" colspan="2">
		<input class="b_foot" id="closeThis" type="button" value="关 闭" onclick="closePage()"/>
</td>
</tr>
</table>
</div>
</div> 
</body>
</html>		
		
		
		