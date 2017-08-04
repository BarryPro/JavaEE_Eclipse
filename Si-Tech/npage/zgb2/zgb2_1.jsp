<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zgb2";
String opName = "增值税专票开具申请取消";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%> 
<HTML>
<HEAD>
<script language="JavaScript">
 function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
 }
 function sel1()
 {
	window.location.href='zg12_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg12_tax.jsp';
 }
 function doQry(phone_no)
 {
	document.frm.action="zgb2_2.jsp";
	document.frm.submit();
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
<%@ include file="/npage/include/header.jsp" %>   
   
 
 
  </table>
  <table cellSpacing="0">
    <tr>
		<td>
			当前工号:<%=workno%>
		</td>
	</tr>
	<tr>
		<td>
			注意:只能删除该工号申请过的开具记录.
		</td>
	</tr>
	<tr>
		<td>开始时间 
			<input type="text"   name="begin_time" value=<%=dateStr%> size="8" maxlength="8">
		</td>
	</tr>
	<tr>
		<td>结束时间 
			<input type="text"   name="end_time" value=<%=dateStr%> size="8" maxlength="8">
		</td>
	</tr>
	<tr> 
      <td id="footer"> 
	 	 
 
	  <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="doQry()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
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