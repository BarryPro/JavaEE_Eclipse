<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
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
String opCode = "zg08";
String opName = "�ܶ����˷�";
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

	var pay_time2 = document.all.end_time.value;

	if(pay_time=="")
	{
		rdShowMessageDialog("��ѡ��ɷѿ�ʼ����!");
		return false;
	}
	else if(pay_time2=="")
	{
		rdShowMessageDialog("��ѡ��ɷѽ�������!");
		return false;
	}
	else
	{
		var times = pay_time.substr(0,4)+pay_time.substr(5,2)+pay_time.substr(8,2);
		var times2 = pay_time2.substr(0,4)+pay_time2.substr(5,2)+pay_time2.substr(8,2);
		//alert(times);
		if(pay_time.substr(0,4)!=pay_time2.substr(0,4) ||pay_time.substr(5,2) !=pay_time2.substr(5,2) )//�����Կ���
		{
			rdShowMessageDialog("�˷�ʱ�䲻���Կ���!");
			return false;
		}
	 
		else if(<%=dateStr%>==times2 ||<%=dateStr%>==times)
		{
			rdShowMessageDialog("���ս��ײ������˷�!");
			return false;
		}
		 
		else
		{
			document.frm.action="zg08_2.jsp?phone_no="+phone_no+"&times="+times+"&end_time="+times2;
			document.frm.submit();
		}
		
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
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="12" colspan=2  onKeyPress="return isKeyNumberdot(0)" readonly value="<%=activePhone%>">
      </td>
      
       
    </tr>

	<tr> 
      <td class="blue" width="15%">�ɷѿ�ʼʱ��</td>
      <td width="35%">
		<input type="text" name="begin_time" id="begin_time" size="18" readonly="true" />&nbsp;
		<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=�������������˵� align=absMiddle readonly></td>
	  </td>
	 </tr>

	 <tr> 
      <td class="blue" width="15%">�ɷѽ���ʱ��</td>
      <td width="35%">
		<input type="text" name="end_time" id="end_time" size="18" readonly="true" />&nbsp;
		<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time);return false' alt=�������������˵� align=absMiddle readonly></td>
	  </td>
	 </tr>
	 
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>