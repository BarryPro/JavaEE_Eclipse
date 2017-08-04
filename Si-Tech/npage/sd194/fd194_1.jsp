<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
    /*
   * 功能: APN管理
   * 版本: 1.0
   * 日期: 2011/1/17
   * 作者: jianglei
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">

function frmCfm()
{
	frm.submit();
}

function query()
{
	if(document.all.phoneNo.value == "")
	{
		rdShowMessageDialog("请填写手机号！");
		return false;
	}
	var phoneNo = document.all.phoneNo.value;
	var opCode = document.all.phoneNo.opCode;
	var opName = document.all.phoneNo.opName;
	document.middle.location="fd194info.jsp?phoneNo="+phoneNo+"&opCode=" + opCode+"&opName="+opName;
	loading("正在加载查询信息，请稍候······");
	
}

function UnLoad(){
	unLoading();
}

</script>

</head>
<body>
<form name="frm" method="post" action="fd194Cfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input  type="hidden" name="opCode" id="opCode" value="<%=opCode%>" size="20" >
	<input  type="hidden" name="opName" id="opName" value="<%=opName%>" size="20" >
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%" nowrap>手机号码</td>
	    <td width="80%">
	    	<input  type="text" name="phoneNo" id="phoneNo" value="" size="20" >
	    </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="查询" onClick="query();">
		</td>
	</tr>
</table>

<TABLE id="tabBtn1" style="display:''" id="mainOne" cellspacing="0" >
	<TR id="footer"> 
		<TD colspan = "4" align="center"  > 
			<IFRAME frameBorder='0' id=middle name=middle style="HEIGHT: 306px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
			</IFRAME>
		</TD>
	</TR>
</TABLE> 
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
