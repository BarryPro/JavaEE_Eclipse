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
	
	String phoneNo = request.getParameter("phoneNo");
	String bizType = request.getParameter("bizType");
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<wtc:service name="sd125Init" retcode="errCode" retmsg="errMsg" outnum="6" >
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="sb125InitResult" scope="end" />
<%
if(!errCode.equals("000000"))
{
%> 
<script language="JavaScript">
rdShowMessageDialog("用户基本信息错误!");
window.location="fd125_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
}
%>
<script language="JavaScript">
function frmCfm()
{
	frm.submit();
}
function printCommit()
{
	//document.all.commit.disabled = true;//为防止二次确认
	var CustStatus = $("input[@name='CustStatus'][@checked]").val();
	var OldCustStatus = <%=sb125InitResult[0][3]%>;
	
	if(CustStatus == OldCustStatus)
	{
		if(CustStatus == '0')
		{
			rdShowMessageDialog("APN已经开通");
			return false;
		}
		else
		{
			rdShowMessageDialog("APN已经关闭");
			return false;
		}
		
	}

	//提交表单

	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	{
		frmCfm();
	}
	
	return true;
}
</script>
</head>
               
<body>
<form name="frm" method="post" action="fd125Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input  type="hidden" name="bizType" id="bizType" value="<%=bizType%>" size="20" >
	<input  type="hidden" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="20" >
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>手机号码</td>
	    <td width="35%">
	    	<%=phoneNo%>
	    </td>
	    <td class="blue" width="15%" nowrap>客户姓名</td>
	    <td width="35%">
	    	<%=sb125InitResult[0][0]%>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>客户状态</td>
	    <td width="35%">
	    	<%=sb125InitResult[0][1]%>
	    </td>
	    <td class="blue" width="15%" nowrap>客户品牌</td>
	    <td width="35%">
	    	<%=sb125InitResult[0][2]%>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>APN状态</td>
	    <td width="35%" colspan=3>
	    <%
	    if(sb125InitResult[0][3].equals("0"))
	    {
	    %>
	    <input type="radio"  id="CustStatus" name="CustStatus" value="0" disabled checked>开
	    <input type="radio"  id="CustStatus" name="CustStatus" value="1" >关
	    (注：如客户反馈问题，即使查询APN状态为开通，也建议先进行关闭操作，再重新开通 !)
	    <%
	    }
	    else
	    {
	    %>
	    <input type="radio" id="CustStatus" name="CustStatus" value="0">开
	    <input type="radio" id="CustStatus" name="CustStatus" value="1" disabled checked>关
	    <%
	    }
	    %>
	    
	    </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
			&nbsp;
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
