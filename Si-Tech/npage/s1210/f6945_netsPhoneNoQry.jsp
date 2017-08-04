<% 
  /*
   * 功能: 垃圾短信与网管黑名单综合受理_网间号码查询
　 * 版本: v1.00
　 * 日期: 2012/05/16
　 * 作者: diling
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>垃圾短信与网管黑名单综合受理_网间号码查询</title>

<%
String opCode = "e851";
String opName = "垃圾短信与网管黑名单综合受理_网间号码查询";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String phoneNoPw = "";

String isBlackName="";
String isGsmsName="";


System.out.println("#######################################phoneNo->" + phoneNo);
System.out.println("#######################################phoneNoPw->" + phoneNoPw);
%>

<wtc:service name="sE851Qry" routerKey="phone" routerValue="<%=phoneNo%>" retCode="initRetCode" retMsg="initRetMsg" outnum="4">
<wtc:param value="0"/>
<wtc:param value="01"/>
<wtc:param value="<%=opCode%>"/>
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=loginNoPass%>"/>
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=phoneNoPw%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
System.out.println("initRetCode=================="+initRetCode);
System.out.println("initRetMsg==================="+initRetMsg);

System.out.println("result[0][0]=================="+result[0][0]);
System.out.println("result[0][1]=================="+result[0][1]);
System.out.println("result[0][2]=================="+result[0][2]);
System.out.println("result[0][3]=================="+result[0][3]);


if(!(initRetCode.equals("000000")))
{
%>
	<script language=javascript>
		rdShowMessageDialog("错误代码：<%=initRetCode%><br>错误信息：<%=initRetMsg%>");
		window.location="s6945Login.jsp";
	</script>
<%
	return;
}else{
  if((result==null) || (result.length == 0))
  {
  %>
  	<script language=javascript>
  		rdShowMessageDialog("错误代码：<%=initRetCode%><br>错误信息：<%=initRetMsg%>");
  		window.location="s6945Login.jsp";
  	</script>
  <%
  	return;
  }
if(result[0][0].equals("Y"))
{
	isBlackName="是";
}
else if(result[0][0].equals("N"))
{
	isBlackName="否";
}

%>

<script language=javascript>
onload=function()
{
	init();
}

function init()
{
	if(("<%=result[0][0]%>" != "Y"))
	{
		document.all.b_add.disabled=false;
		document.all.b_change.disabled=true;
	}
	else
	{
		document.all.b_add.disabled=true;
		document.all.b_change.disabled=false;
	}
}

function add()
{
	frm.action="f6945_netsPhoneNoQry_add.jsp";
	frm.submit();
}

function change()
{
	frm.action="f6945_netsPhoneNoQry_chg.jsp";
	frm.submit();
}

function goBack(){
  window.location.href="s6945Login.jsp";
}

</script>

</head>
<body>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>手机号码</td>
	    <td colspan="3">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>是否是黑名单用户</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="isBlack" id="isBlack" value="<%=isBlackName%>" size="30" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>加入黑名单的原因</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackReason" id="blackReason" value="<%=result[0][1]%>" size="30" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>黑名单的操作工号</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackLogin" id="blackLogin" value="<%=result[0][2]%>" size="30" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>黑名单的操作时间</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="blackTime" id="blackTime" value="<%=result[0][3]%>" size="30" readonly>
	    </td>
	</tr>
    <tr>
        <td colspan="4" id="footer">
            <input class="b_foot" type="button" name="b_add" value="添加" onClick="add();" disabled>
            &nbsp;
            <input class="b_foot" type="button" name="b_change" value="修改" onClick="change();" disabled>
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="返回" onClick="goBack()">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%
  }
%>