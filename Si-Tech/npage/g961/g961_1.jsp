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
		String opCode = "g961";
		String opName = "���г�ֵ����ת�������ѯ";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,0);
    /*Ĭ�ϣ�12����֮ǰ*/
    String startTime = sdf.format(today.getTime());
	String contextPath = request.getContextPath();	
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneno.value=="")
  {
     rdShowMessageDialog("������������!");
     document.frm.phoneno.focus();
     return false;
  }
  

  if( document.frm.phoneno.value!="" && document.frm.phoneno.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneno.value = "";
     document.frm.phoneno.focus();
     return false;
  }
	            
	
}

	function docheck()
	{
	  var s_begin = document.all.begin_tm.value.substring(0,4)+document.all.begin_tm.value.substring(5,7)+document.all.begin_tm.value.substring(8,10);
	  var s_end = document.all.end_tm.value.substring(0,4)+document.all.end_tm.value.substring(5,7)+document.all.end_tm.value.substring(8,10);
	  //alert(year_month);
	  if(document.all.phone_no.value=="")
	  {
		  rdShowMessageDialog("�������û��ֻ�����!");
			document.all.phone_no.focus();
			return false;
	  }
	  //alert("123");
	  if(document.all.begin_tm.value=="")
	  {
		  rdShowMessageDialog("��ѡ���ѯ��ֵ�ɹ��Ŀ�ʼʱ��!");
			document.all.begin_tm.focus();
			return false;
	  }	
	  if(document.all.end_tm.value=="")
	  {
		  rdShowMessageDialog("��ѡ���ѯ��ֵ�ɹ��Ľ���ʱ��!");
			document.all.end_tm.focus();
			return false;
	  }
	  //�жϳɹ�����ʧ��
	  /*
	  var temp=document.getElementsByName("busyType1");
	  for (i=0;i<temp.length;i++)
	  {
		if(temp[i].checked)
		{
			if(temp[i].value=="1")
			{
				alert("��ѯ�ɹ���");
				document.frm.action="g961_2.jsp?phoneno="+document.all.phone_no.value+"&year_month="+year_month+"&s_flag=1";
		 
			    document.frm.submit();
			}
			if(temp[i].value=="2")
			{
				alert("��ѯʧ�ܵ�");
				document.frm.action="g961_2.jsp?phoneno="+document.all.phone_no.value+"&year_month="+year_month+"&s_flag=2";
		 
			    document.frm.submit();
			}
		}
	  }	
	  */
	  document.frm.action="g961_2.jsp?phoneno="+document.all.phone_no.value+"&s_begin="+s_begin+"&s_end="+s_end;	 
	  document.frm.submit();	   
	 
		 
	 } 
//�����²�ĺ���
function DateDiff2(date1,date2){
	  var year1 =  date1.substr(0,4);
	  var year2 =  date2.substr(0,4); 
	  var month1 = date1.substr(4,2);
	  var month2 = date2.substr(4,2);
	  
	  var len=(year2-year1)*12+(month2-month1);
	  
	  return len;


}
 


 
 
  function doclear() {
 		frm.reset();
 }


//��ȡ��ʼ����ʱ���
function GetDateT(){
	
  var d,s;
  d = new Date();
  //ȡ���
  s = d.getYear().toString() ;
  //ȡ�·�
  if(d.getMonth()<9){
		s = s + "0"+((d.getMonth() + 1).toString()) ;
  }
  else{
		s = s + ((d.getMonth() + 1).toString()) ;
  }
  //ȡ����
  /*if(d.getDate()<10){
	  s = s+"0"+d.getDate().toString() ;
  }
  else{
	  s = s+d.getDate().toString() ;
  }*/
  document.getElementById("edate").value=s ;
  //��ʼʱ�� �����鷳���㷨
  var s1,s2;
  alert("d.getMonth is "+d.getMonth());
  if(d.getMonth()>5 ){ // ���ֵ �Ժ�������
		s2 = d.getMonth() + 1-12;
		if(s2<10){
		 s2 = "0"+s2.toString();
		}
		s1 = d.getYear().toString() ;
  }
  else if(d.getMonth()< 5){
    s2 = d.getMonth() + 1+12-12;
		if(s2<10){
		s2 = "0"+s2.toString();
		}
		s1 = (d.getYear()-1).toString() ;
  }
  else{
	  s2 = 12;
	  s1 = (d.getYear()-1).toString() ;
  }
  s1 = s1 + s2 ;//ȡ�·�
  //ȡ����
  /*
  if(d.getDate() <10 ){
		s1 = s1+ "0"+d.getDate().toString() ;
  }
  else{
		s1 = s1+ d.getDate().toString() ;
  }*/
  document.getElementById("bdate").value=s1 ;
  alert('full is '+s);
}



-->
 </script> 
 <SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>

 <script language=javascript>
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
		winPopupWindow.win = window.open("<%=contextPath%>/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	
	else
	{
	 
		retval = window.showModalDialog("<%=contextPath%>/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
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
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">�����뱻��ֵ�û��ֻ�����</div>
		</div>
	<table cellspacing="0">
	<!--
	<tr> 
                  <td class="blue" width="15%">��ѯ����</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" value="1" checked >
                    ��ֵ�ɹ� 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" value="2"  >
                    ��ֵʧ�� 
                    </q>
                    <q vType="setNg35Attr">
                     
					</td>
                 </tr>
    <tr>
	-->
	<tr>
      <td class="blue" width="15%">����ֵ�ֻ�����</td>
      <td colspan=3> 
        <input class="button"type="text" name="phone_no" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" >
      </td>
       
       
    </tr>
	<tr>
      <td class="blue" width="15%">��ֵ��ѯ��ʼʱ��</td>
	  <td width="35%">
				<input type="text" name="begin_tm" id="begin_tm" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_tm);return false' alt=�������������˵� align=absMiddle readonly></td>
	  </td>
       
      <td class="blue" width="15%">��ֵ��ѯ����ʱ��</td>
      
	  <td width="35%">
				<input type="text" name="end_tm" id="end_tm" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_tm);return false' alt=�������������˵� align=absMiddle readonly></td>
	  </td>
    </tr>
	 

	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
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