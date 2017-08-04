<%
	/* 
	 * version v2.0
	 * 开发商: si-tech
	 * zhouby 20130313
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
	<script language="javascript">
		var msg = '';
<%
	request.setCharacterEncoding("GBK");
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String sysAccept = (String)request.getParameter("sysAccept");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String phoneNo = (String)request.getParameter("phoneNo");
  
  String spCode = (String)request.getParameter("spCode");
  String bizCode = (String)request.getParameter("bizCode");
  String oprCode = (String)request.getParameter("oprCode");
  String timeLong = (String)request.getParameter("timeLong");
  
  String inLoginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
  System.out.println("zhouby: sysAccept   " + sysAccept);
  System.out.println("zhouby: opCode   " + opCode);
  System.out.println("zhouby: inLoginNo   " + inLoginNo);
  System.out.println("zhouby: password   " + password);
  System.out.println("zhouby: phoneNo   " + phoneNo);
  System.out.println("zhouby: spCode   " + spCode);
  System.out.println("zhouby: bizCode   " + bizCode);
  System.out.println("zhouby: oprCode   " + oprCode);
  System.out.println("zhouby: timeLong   " + timeLong);
  
%>
	<wtc:service name="sg511Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    <wtc:param value="<%=sysAccept%>"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=inLoginNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value=""/>
    <wtc:param value="<%=spCode%>"/>
    <wtc:param value="<%=bizCode%>"/>
    <wtc:param value="<%=oprCode%>"/>
    <wtc:param value="<%=timeLong%>"/>
	</wtc:service>
<%
	System.out.println("zhouby: retCode   " + retCode);
  
	if("000000".equals(retCode)){
%>
			rdShowMessageDialog("提交成功！");
<%
	} else{
%>
			rdShowMessageDialog("提交失败，请重试！<%=retCode%><%=retMsg%>", 1);
<%
	}
%>	
		function goBack(){
				window.location= 'f<%=opCode%>Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneNo%>&broadPhone=';
		}
		goBack();
</script>
</head>
<body>
<form id="" method="POST">
	<%@ include file="/npage/include/header.jsp" %>
	<div>
		<div class="title">
			<div id="title_zi">导入结果</div>
		</div>
	
		<table cellspacing="0">
			<tr>
				<td width="100%"></td>
			</tr>
		</table>
		
		<div class="title">
			<div id="title_zi">错误提示</div>
		</div>
		<table cellspacing="0">
			<tr>
				<th>序号</th>
				<th>电话号</th>
				<th>提示信息</th>
			</tr>
	
		  <tr>
		  	<td id="footer" colspan="3">
		  		<input type="button" name="back" class="b_foot" value="返回" onClick="goback()">
		  	</td>
		  </tr>
	  </table>
	</div>
  <%@ include file="/npage/include/footer.jsp"%>
</form>
</body>
</html>