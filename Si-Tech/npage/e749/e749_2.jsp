<%
/********************
 version v2.0
������: si-tech
*
*create:zhangyta@2012-04-17
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String[] inParas2 = new String[2];
		String opCode = "e749";
		String opName = "��������-�����ƻ�";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String dateStr2 = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		inParas2[0]="select account_type from dloginmsg where login_no =:login_no";
		inParas2[1]="login_no="+workno;
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("û�д��û����������!");
		return;
	}

 
  if(IsMarketing !="0") {
  	 document.frm.ispopmarket.value="1";
  	 showMarketingDetail(IsMarketing);
  }
  
  docheck();
}


function showMarketingDetail(IsMarketing) {
	
    var h=450;
    var w=500;
   	var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
    var mphone_no=document.frm.phoneNo.value;
	  var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var path="s1300_MarketMsg.jsp?phoneNo="+mphone_no+"&MarketCounts="+IsMarketing;
	  var returnValue = window.showModalDialog(path,"",prop);
	  //var returnValue = window.open(path,"",prop);
}



function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("�������ֻ�����!");
     document.frm.phoneNo.focus();
     return false;
  }
  if(document.all.sDate.value.length > 0 && document.all.sDate.value.length < 6){
           rdShowMessageDialog("��ѯ������������������ѯ���£�");
           document.all.sDate.focus();
     			 return false;
        }


  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	            
	var phone_no = document.all.phoneNo.value;
  var busy_type = "1";
	var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("phone_no",phone_no);
	checkPwd_Packet.data.add("busy_type",busy_type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

 
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

function docheck()
{
	if(document.frm.phoneNo.value=="")
  {
      rdShowMessageDialog("�������ֻ�����!");
     	document.frm.phoneNo.focus();
     	return false;
  }
  
	if(document.all.sDate.value.length > 0 && document.all.sDate.value.length < 6){
           rdShowMessageDialog("��ѯ������������������ѯ���£�");
           document.all.sDate.focus();
     			 return false;
        }

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
 
   document.frm.action="e749_2_show.jsp";
   document.frm.query.disabled=true;
   document.frm.return1.disabled=true;
 //  document.frm.reprint.disabled=true;
   document.frm.return2.disabled=true;
   document.frm.submit();
} 

 function doclear() {
 		frm.reset();
 }

function sel1()
 {
    window.location.href='e749_1.jsp';
 }

 function sel2(){
    window.location.href='e749_2.jsp';
 }

function doCfm()
{
	//alert("123 is "+"<%=workno%>"+" and is "+"<%=ret_val[0][0]%>"); 
	//if("<%=workno%>"!="aaaaxp")
	if("<%=ret_val[0][0]%>"=="4")
	{
		document.all.busyType2.value=2;
		//document.all.flag_channel.value=0;
		sel2();
	}
	else
	{
		//����������
		
	}
}
-->
	   
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()"> 
<form action="" method="post" name="frm">
		<input type="hidden" name="busy_type"  value="1">
		 
		<input type="hidden" name="op_code"  value="aa12">
		<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
		<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
		<input type="hidden" name="water_number">
		<input type="hidden" name="ispopmarket" value="0" >
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ѡ���ѯ��ʽ</div>
		</div>
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��ѯ��ʽ</td>
        <td colspan="4"> 
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1">ȫ���Ż���Ϣ��ѯ 
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> ��ϸ�Ż���Ϣ��ѯ 
				</td>
    </tr>
  </table>
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�ֻ�����</td>
      <td> 
        <input class="button" type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      <td class="blue" width="15%">��ѯ����</td>
      <td> 
        <input class="button" type="text" style="ime-mode:disabled" name="sDate" maxlength="6" onKeyPress="return isKeyNumberdot(0)"   onKeyDown="if(event.keyCode==13) check_HidPwd();">
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
