<%
/********************
 version v2.0
开发商: si-tech
*
*huangqi
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%
		String opCode = "zg59";
		String opName = "WLAN暂停恢复";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");		
%>
<HTML>
<HEAD>
<script language="JavaScript">
 function inits(){
 	
 }
 function docheck()
 {
	var phoneNo = document.getElementById("phone_no").value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入手机号码！");
		return false;
	}
	else
	{		
		document.frm.action="zg59_2.jsp?phoneNo="+phoneNo+"&workno="+"<%=workno%>";
		document.frm.submit();
	}
 }
  
 function doclear() {
 		frm.reset();
 }

-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">		
		<%@ include file="/npage/include/header.jsp" %>  
 
     
  	<div class="title">
			<div id="title_zi">请输入手机号码</div>
		</div>
	<table cellspacing="0">  
	<tr > 
      <td class="blue">手机号码 </td>
     	<td> 
			<input class="button"type="text" id="phone_no" name="phone_no" onKeyPress="return isKeyNumberdot(0)" size="11" maxlength="11"   >
		  </td>      
  </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="确认" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="重置" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>