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
		String opCode = "i210";
		String opName = "����ʧ�ܲ�ѯ";
 
	 
%>
<%
	String contextPath = request.getContextPath();
%>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }

   function docheck3()
   {
	   //var s_paytype =  document.all.rpt_type[document.all.rpt_type.selectedIndex].value;
	   var begin_tm = document.all.begin_tm.value;
	   var end_tm = document.all.end_time1.value;
	   if(begin_tm=="")
	   {
		   rdShowMessageDialog("��ѡ���ѯ��ʼʱ��");
		   return false;
	   }
	   else if(end_tm=="")
	   {
		   rdShowMessageDialog("��ѡ���ѯ����ʱ��");
		   return false;
	   }
	   else
	   {
		   var begin_time = document.all.begin_tm.value.substring(0,4)+document.all.begin_tm.value.substring(5,7)+document.all.begin_tm.value.substring(8,10);
		   var end_time1 = document.all.end_time1.value.substring(0,4)+document.all.end_time1.value.substring(5,7)+document.all.end_time1.value.substring(8,10);
		   document.frm.action = "i210_1_qry.jsp?begin_tm="+begin_time+"&end_tm="+end_time1;
		   
		   document.frm.submit();	
	   }	
	   
	   
   }
 
    
   function sel1()
   {
			window.location.href='i210_1.jsp';
   }
    
  
-->
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
    
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">�������ѯ����</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		 
		<td class="blue" align="right">
			�����
		</td>
		<td colspan=3>
			 <select name="sel">
				<option value="1">���ײ˻</option>
			 </select>
		</td>
	</tr>
	<tr>
		<td class="blue" align="right">
			��ѯ��ʼʱ��
		</td>
		<td width="35%">
				<input type="text" name="begin_tm" id="begin_tm" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_tm);return false' alt=�������������˵� align=absMiddle readonly></td>
		</td>
		<td width="15%" class="blue" nowrap>����ʱ��</td>
		<td width="35%">
			<input type="text" name="end_time1" id="end_time1" size="18" readonly="true"/>&nbsp;
			<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time1);return false' alt=�������������˵� align=absMiddle readonly></td>
		</td>
	</tr> 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck3()" >
       
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
<script language="javascript">
function fPopUpCalendarDlg(ctrlobj)
{
	if(N)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}
	newWINwidth = 210 + 4 + 18;
	if(N)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = ctrlobj;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = ctrlobj;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
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