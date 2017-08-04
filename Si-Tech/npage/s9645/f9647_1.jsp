<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:注意事项更新查询
   * 版本: 1.0
   * 日期: 2009/5/21
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
 
	String opCode = "9647";
	String opName = "注意事项更新查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

onload=function()
{	
	self.status="";
}

function commitJsp()
{
	if(document.all.beginTime.value.trim()=="")
	{
		rdShowMessageDialog("请输入开始时间!");
	  	return false;
	}
	if(document.all.endTime.value.trim()=="")
	{
		rdShowMessageDialog("请输入结束时间!");
	  	return false;
	}
	if(document.all.beginTime.value>document.all.endTime.value)
	{
		rdShowMessageDialog("开始时间不能大于结束时间!");
	  	return false;
	}
	if(document.all.updateType.value=="")
	{
		rdShowMessageDialog("请输入操作类型!");
	  	return false;
	}
	
	frm.submit();
}
 		
</script> 
 
<title>注意事项更新查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f9647_2.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">注意事项更新查询</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue">开始时间</td>
		<td> 
			<input name="beginTime" type="text" class="button" maxlength="8" v_name="开始时间">(YYYYMMDD)
    	</td>
		<td class="blue">结束时间</td>
		<td> 
			<input name="endTime" type="text" class="button"  maxlength="8" v_name="结束时间">(YYYYMMDD)
    	</td>
	</tr>
	<tr>
		<td class="blue" nowrap>操作类型</td>
		<td>
			<select name="updateType">
				<option value="" selected>--请选择--</option>
				<option value="U" >修改</option>
				<option value="A">增加</option>
        		<option value="D">删除</option>
			</select>
		</td>
		<td class="blue" nowrap>操作代码</td>
		<td> 
			<input name="op_code" type="text" class="button" id="op_code" >
    	</td>
	</tr>	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="查询" onclick="commitJsp()">
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
