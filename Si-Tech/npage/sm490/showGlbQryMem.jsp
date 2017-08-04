<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
  
  String regionCode = (String)session.getAttribute("regCode");  
  
  String id_no = WtcUtil.repNull(request.getParameter("id_no"));
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
  String custName = WtcUtil.repNull(request.getParameter("custName"));
  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
  String opName = WtcUtil.repNull(request.getParameter("opName"));  
%>
<wtc:service name="s3257QryMem" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=id_no%>" />
</wtc:service>
<wtc:array id="result" scope="end"   />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
	<title><%=opName%></title>
</head>
<body>
	<div id="operation">
		<form name="frm1">
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div id="operation_table">
			<div class="list">
				<table >
					<tr>
						 <td class="blue">用户号码</td>
						<td><%=phoneNo%></td>
						 <td class="blue">用户姓名</td>
						<td><%=custName%></td>
					</tr>
				</table>
				<table>
					<tr>
						<th>家庭号码</th>
						<th>成员号码</th>
					  <th>生效时间</th>
						<th>失效时间</th>
					</tr>	
				<%
				if(code.equals("000000"))
				{
					for(int i=0; i<result.length; i++)
					{
				%>
					<tr>
						<td><%=result[i][0]%></td>
						<td><%=result[i][1]%></td>
						<td><%=result[i][2].substring(0,8)%></td>
						<td><%=result[i][3].substring(0,8)%></td>
					</tr>
				<%
					}
				}
				%>
				</table>
			</div>
		</div>
		<div id="operation_button">
			<input name="" type="button" class="b_foot" value="关闭" onclick="window.close();"/>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</div>
</body>
</html>

