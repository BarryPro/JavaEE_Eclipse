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
String opCode = "zg07";
String opName = "总对总冲正";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
activePhone = request.getParameter("activePhone");
String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.all.phone_no.value;
	var pay_time = document.all.begin_time.value;
	if(pay_time=="")
	{
		rdShowMessageDialog("请选择缴费日期!");
	}
	else
	{
		var times ="<%=dateStr%>";
		//alert(times);
		
		document.frm.action="zg07_2.jsp?phone_no="+phone_no+"&times="+times;
		//alert(document.frm.action);
		document.frm.submit();
	}
	
} 
 
 
 

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
 }



 
function fPopUpCalendarDlg(ctrlobj)
{
	showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;
	retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
 
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="12" colspan=2  onKeyPress="return isKeyNumberdot(0)" readonly value="<%=activePhone%>">
      </td>
      
       
    </tr>

	<tr> 
      <td class="blue" width="15%">缴费时间</td>
      <td width="35%">
		<input type="text" name="begin_time" id="begin_time" size="18" value="<%=dateStr%>" readonly="true" />&nbsp;
		 </td>
	  </td>
      
       
    </tr>
	 
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
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