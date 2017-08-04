<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "e356";
	String opName = "帐户余额提醒服务定制";
  String workno =(String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
  String orgcode =((String)session.getAttribute("orgCode")).substring(0, 2);//机构代码
  String userPhoneNo = (String)request.getParameter("activePhone");
%>

<head>
<title>黑龙江BOSS-帐户余额提醒服务定制</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0) {
		if(s_keycode>=48 && s_keycode<=57) {
			return true;
		} else {
			return false;
		}
    } else if (ifdot==1) {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46) {
		      return true;
		} else if(s_keycode==45) {
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		} else {
		    return false;
		}
    } else if (ifdot==2) {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46 || s_keycode==45) {
		      return true;
		} else {
		    return false;
		}
    }
}


function dosubmit()
{
	
  if (document.mainForm.busyType.value.length == 0) 
	{
      rdShowMessageDialog("请选择操作类型！！")
      return false;
  }
  
	if ( document.mainForm.busyType.value == "I"
		&& document.mainForm.i_awake_fee.value.length == 0) 
	{
      rdShowMessageDialog("提醒阀值不能为空，请重新输入 !!")
      document.mainForm.i_awake_fee.focus();
      return false;
  }
  
  document.mainForm.submit();
}

</script>
</head>

<body >

<form action="e356_2.jsp" method="post" name="mainForm">
	<%@ include file="/npage/include/header.jsp" %>
  <input type="hidden" id="opCode" name="opCode" value="<%=opCode%>">
		<div class="title">
			<div id="title_zi">帐户余额提醒服务定制</div>
		</div>   

				<table cellspacing="0">
					<tr>
						<td nowrap class="blue">受理号码</td>
						<td >
							<input class="button" type="text" name="phone_no" maxlength="11" value=<%=userPhoneNo%>
							<font class="orange"> *</font>
						</td>
						

				<td nowrap class="blue">操作类型</td>
				<td width="20%">
					<select name="busyType" onClick="" >
						<option value="" selected>--请选择操作类型</option>
						<option value="U">增加</option>
						<option value="D">删除</option>

					</select>
				</td>
				
						<td class="blue" nowrap>提醒阀值</td>
						<td width="35%">
							<input class="button" type="text" name="i_awake_fee" maxlength="6" onKeyPress="return isKeyNumberdot(0)">
							<font class="orange"> *</font>
						</td>
					</tr>

				</table>

				<!-- 功能按钮开始 -->
				<table cellspacing="1">
					<tr>
						<td noWrap id="footer" colspan="6">
						<input type="button" name="sure" class="b_foot" value="确认"	onClick="dosubmit()"> &nbsp; 
						<input type="button" name="close" class="b_foot" value="关闭" onClick="window.close()">
						</td>
					</tr>
				</table>
				  	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
