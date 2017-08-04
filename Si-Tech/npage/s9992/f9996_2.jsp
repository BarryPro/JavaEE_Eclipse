<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * 功能:手机支付账户信息查询
   * 版本: 1.0
   * 日期: 2009/7/09
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = "9996";
	String opName = "手机支付账户信息查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String work_no = (String) session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String srv_no = request.getParameter("phoneNo");
	String op_code = request.getParameter("opCode");
	String trueName="";
	String sAccStatus="";
	String icType="";
%>

<wtc:service name="s9996Qry" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="15">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=op_code%>"/>
<wtc:param value="<%=srv_no%>"/>
<wtc:param value="<%=pass%>"/>
<wtc:param value="<%=orgCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
	
<%
	if(!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
        	rdShowMessageDialog("错误信息：<%=initRetMsg%>");
        	window.location="f9996_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
<%
		
	}
	else if(!(result[0][0].equals("000000")))
	{
%>
		<script language=javascript>
        	rdShowMessageDialog("错误信息：<%=initRetMsg%>");
        	window.location="f9996_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
<%	
		
	}
	else if(initRetCode.equals("000000"))
	{
		if(result[0][3].equals("00"))
		{
			icType="身份证件";
		}
		else if(result[0][3].equals("01"))
		{
			icType="VIP卡";
		}
		else if(result[0][3].equals("02"))
		{
			icType="护照";
		}
		else if(result[0][3].equals("04"))
		{
			icType="军官证";
		}
		else if(result[0][3].equals("05"))
		{
			icType="武装警察身份证";
		}
		else if(result[0][3].equals("99"))
		{
			icType="其他证件";
		}
		
		if(result[0][7].equals("01"))
		{
			trueName="实名";
		}
		else if(result[0][7].equals("02"))
		{
			trueName=" 弱实名";
		}
		if(result[0][8].equals("0"))
		{
			sAccStatus="开通";
		}
		else if(result[0][8].equals("1"))
		{
			sAccStatus=" 未开通";
		}
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

onload=function()
{		
	self.focus();
}

</script>
 
<title>手机支付账户信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form method="post" name="frm">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">手机支付账户信息查询</div>
	</div>
<table cellspacing="0">
    <tr>
		<td class="blue" width="15%">手机号码</td>
    	<td width="35%"><%=result[0][2]%></td>
    	<td class="blue" width="15%" nowrap>用户名</td>
  		<td><%=result[0][5]%></td>
  	</tr>
  	<tr>
  		<td class="blue" width="15%" nowrap>证件类型</td>
    	<td width="35%"><%=icType%></td>
    	<td class="blue" width="15%" nowrap>证件号码</td>
    	<td><%=result[0][4]%></td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>昵称</td>
		<td width="35%"><%=result[0][6]%></td>
    	<td class="blue" width="15%" nowrap>实名标志</td>
		<td width="35%"><%=trueName%></td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>现场支付子账户属性</td>
		<td width="35%"><%=sAccStatus%></td>
    	<td class="blue" width="15%" nowrap>主账户状态</td>
    	<td><%=result[0][9]%></td>
	</tr>
	<tr>
		<td class="blue" width="15%">子账户状态</td>
		<td width="35%"><%=result[0][10]%></td>
		<td class="blue" width="15%">现金账户</td>
		<td width="35%"><%=result[0][11]%></td>
	</tr>
	<tr>
		<td class="blue" width="15%">充值卡账户</td>
		<td><%=result[0][12]%></td>
		<td class="blue" width="15%">待充值（厘）</td>
		<td width="35%"><%=result[0][13]%></td>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="4">
			<input type="button" name="reset" class="b_foot" value="返回" onclick="history.go(-1);">
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
