<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
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
		String charGetTime = "";
		String faultTimes= "";
%>
  <wtc:service name="sD312Qry"  routerKey="region" routerValue="<%=regionCode%>" 
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
	if(result != null && result.length > 0){
		charGetTime = result[0][0];
		faultTimes = result[0][1];
	}
}else{
%>
	<script language="javascript">
		rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMessage%>",0);
		removeCurrentTab();
	</script>
<%
}

%>		
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript">
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue">手机号码</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" value="<%=activePhone%>" 
				Class="InputGrey" readOnly />
			</td>
			<td class="blue">每月可代人充值最大次数</td>
			<td>
				<input type="text" name="charGetTime" id="charGetTime"  value = "<%=charGetTime%>"
				Class="InputGrey" readOnly />
			</td>
		</tr>
		<tr>
			<td class="blue">本月代人充值次数</td>
			<td colspan="3">
				<input type="text" name="faultTimes" id="faultTimes"  value = "<%=faultTimes%>"
				Class="InputGrey" readOnly />
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="4"> 
         <input type="button" name="closeButton" class="b_foot" value="关闭" 
          style="cursor:hand;" onClick="removeCurrentTab()">&nbsp;
      </td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

