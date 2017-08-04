<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * 功能:彩铃用户数据实时同步
   * 版本: 1.0
   * 日期: 2009/11/13
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
    
	String opCode = "8360";
	String opName = "彩铃用户数据实时同步";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

onload=function()
{		
	
}

function conFirm()
{
	if(document.all.phoneNo.value.trim()=="")
	{
		rdShowMessageDialog("请输入手机号码！");
		return;
	}
		
	frm.submit();
}

function resetJsp()
{
	
}

</script> 
 
<title>彩铃用户数据实时同步</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f8360Cfm.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">彩铃用户数据实时同步</div>
	</div>

<table cellspacing="0">
    <tr>
		<td class="blue" width="20%">手机号码</td>
    	<td colspan="3">
    		<input name="phoneNo" type="text" class="button" size="25" maxlength="15" id="phoneNo"  v_must=1 v_type=0_9 v_name="手机号码">
    	</td>
  	</tr>
  	<tr> 
		<td align="center" id="footer" colspan="4">
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="conFirm()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="清除" onclick="resetJsp()">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
