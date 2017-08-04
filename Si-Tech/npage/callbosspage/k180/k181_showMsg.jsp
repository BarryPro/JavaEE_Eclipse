<%
  /*
   * 功能: 显示短信全部内容
　 * 版本: 1.0
　 * 日期: 2009/0222
　 * 作者: hanjc 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String msg =  request.getParameter("msg");     
    String titlename =  WtcUtil.repNull(request.getParameter("titlename"));               
%>	

<html>
<head>
<title><%=titlename%>内容</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi"><%=titlename%>内容</div></div>
		<table cellspacing="0" >
     <tr>
     	<td>
     		<%=msg%>
     		</td>
     	</tr>
  </table>
</div>
</form>
</body>
</html>   