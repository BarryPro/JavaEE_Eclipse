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
		String opCode = "zg60";
		String opName = "流量统付优惠查询";
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
	var yearMonth = document.getElementById("yearMonth").value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入手机号码！");
		return false;
	}else if(yearMonth=="")
	{
		rdShowMessageDialog("请输入查询年月！");
		return false;
	}
	else
	{
		document.frm.action="zg60_2.jsp?phoneNo="+phoneNo+"&yearMonth="+yearMonth;
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
	<table cellspacing="0">  
	<tr > 
      <td class="blue">手机号码 </td>
     	<td> 
			<input class="button"type="text" id="phone_no" name="phone_no" onKeyPress="return isKeyNumberdot(0)" size="11" maxlength="11"   >
		  </td>      
      <td class="blue">查询年月(YYYYMM) </td>
     	<td> 
			<input class="button"type="text" id="yearMonth" name="yearMonth" onKeyPress="return isKeyNumberdot(0)" size="6" maxlength="6"   >
		  </td>      
  </tr>
  <tr>
	<td class="blue" colspan=4>
	查询条件：
	<select name="cxtj">
		<option value="j" selected>指定用户</option>
		<option value="J">不限用户</option>
		<option value="A">全部</option>
	</select>
  </td>
  </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
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