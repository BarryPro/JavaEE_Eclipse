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

<%
		String[] inParas2 = new String[2];
		String opCode = "1302";
		String opName = "����ɷ�";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
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
	var s_sm_code = packet.data.findValueByName("s_sm_code");
	//alert(s_sm_code);
	if(returnCode=="999999"){
		rdShowMessageDialog("û�д��û����������!");
		return;
	}

  if(SzxFlag == "1"){
  	rdShowMessageDialog("���û����ڱ�׼�������û�,�����Խ��нɷѣ�");
  }
  if(IsMarketing !="0") {
  	 document.frm.ispopmarket.value="1";
  	 showMarketingDetail(IsMarketing);
  }
 // s_sm_code="dn";
  if(s_sm_code=="PB")
  {
	  rdShowMessageDialog("�������û���������нɷѲ���!");
	  return false;
  }
  else
  {
	  docheck();
  }	
  
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
     rdShowMessageDialog("������������!");
     document.frm.phoneNo.focus();
     return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  //xl add 207�����Խɷ�
  if(document.frm.phoneNo.value.substring(0,3)=="207")
  {
	 rdShowMessageDialog("207���벻������ͨ�ɷ�,����g659�½��м�ͥ�ɷѲ���!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  //xl add 209 ��ͨ��������Խɷ�
  if(document.frm.phoneNo.value.substring(0,3)=="209")
  {
	 rdShowMessageDialog("209���벻������ͨ�ɷ�,����e006�½�����ͨ����ɷѲ���!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
	/*xl add for ����У�� 
	if(document.frm1500.cus_pass.value.trim().length>0 && document.frm1500.cus_pass.value.trim().length !=6)
	{
	   rdShowMessageDialog("����λ������ȷ��");
	   document.frm1500.cus_pass.focus();
	   return false;
	}*/
	document.frm.custPass.value=document.frm.cus_pass.value;			
				
	var phone_no = document.all.phoneNo.value;
	var busy_type = "1";
	//alert("1");
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
      rdShowMessageDialog("������������!");
     	document.frm.phoneNo.focus();
     	return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("�������ֻ����11λ!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
   document.frm.action="s1300Cfm.jsp?ispopmarket="+document.frm.ispopmarket.value;
   document.frm.query.disabled=true;
   document.frm.return1.disabled=true;
 //  document.frm.reprint.disabled=true;
   document.frm.return2.disabled=true;
   document.frm.submit();
} 

 function sel1() {
 		window.location.href='s1300.jsp';
 }

 function sel2(){
    window.location.href='s1300_2.jsp';
 }

 function sel3() {
    window.location.href='s1300_3.jsp';
 }

 function sel4() {
    window.location.href='s1300_4.jsp';
 }
 function sel5() {
    window.location.href='s1300_5.jsp';
 }

 function doclear() {
 		frm.reset();
 }
 function sel6() {
    window.location.href='s1300_v.jsp';
 }

function querylast()
{
			var opcode = document.all.op_code.value;
		  var returnValue="-1";
			if(frm.phoneNo.value.length<11  )
			{
			     rdShowMessageDialog("��������ȷ�ķ�����룡");
			     document.frm.phoneNo.focus();
			     return "-1";
	    }
 		    returnValue = window.showModalDialog('getCount.jsp?phoneNo='+document.frm.phoneNo.value,"",prop);
	  
			if(returnValue==null){
			 
					rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�");
					document.frm.phoneNo.focus();
					return "-1";
			  }
			  if(returnValue=="")
			 {
					rdShowMessageDialog("��û��ѡ���ʺţ�");
					document.frm.phoneNo.focus();
					return "-1";
			  }
		    document.frm.contractno.value = returnValue;   
 


		  	 returnValue=window.showModalDialog('getlast.jsp?phoneNo='+document.frm.phoneNo.value+'&contractno='+document.frm.contractno.value+'&yearmonth='+document.frm.yearmonth.value+'&op_code='+document.frm.op_code.value,"",prop);
	  
 			if( returnValue==null )
	    {
					 
					rdShowMessageDialog("��ѯʧ�ܣ��ú������δ��ҵ��");

					document.all.contractno.value="";
					document.frm.phoneNo.focus();
					return "-1";
		  }
 			
			document.frm.water_number.value=returnValue;
			return "1";
}

function doreprint()
{
       var opname="����ɷ�";
       var returnValue= querylast();
			if(returnValue=="-1"){
				return false;
      }
            
			var totalDate = document.frm.totaldate.value.substring(0,4) +document.frm.totaldate.value.substring(5,7)+document.frm.totaldate.value.substring(8,10);
			document.frm.action='s1352_print.jsp?contractno='+document.all.contractno.value+'&payAccept='+document.frm.water_number.value+'&total_date='+totalDate+'&workno=<%=workno%>'+'&returnPage=s1300.jsp';
			document.frm.submit();
}
function inits()
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
		 
		<input type="hidden" name="op_code"  value="1302">
		<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
		<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
		<input type="hidden" name="water_number">
		<input type="hidden" name="ispopmarket" value="0" >
		<input type="hidden" name="custPass"  value="">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">��ѡ��ɷѷ�ʽ</div>
		</div>

    <table cellspacing="0">
      <tbody> 
	  <!--������tr id������
	  <tr class="blue" style="display:none" id="sptime3">
	  -->
      <tr> 
        <td class="blue" width="15%">�ɷѷ�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>������� 
        </q>
          <!--��������ֽɷ��´�������-->
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> �ʻ����� 
          </q>
          <q vType="setNg35Attr">
          <input name="busyType5" type="radio" onClick="sel5()" value="5"> �����û�����
          </q>
          <q vType="setNg35Attr">
		      <input name="busyType3" type="radio" onClick="sel3()" value="3"> ���յ�
		      </q>
          <!--<input name="busyType4" type="radio" onClick="sel4()" value="4">���Ѻ���-->
		  <!--xl add for huxl
		   <q vType="setNg35Attr">
		      <input name="busyType6" type="radio" onClick="sel6()" value="6" > ���ų�Ա�ɷ�
		      </q>	
			  -->
				</td>
     </tr>
	   
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">�������</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      <td class="blue" width="15%">�ʻ�����</td>
      <td> 
        <input type="text" name="contractno" size="20" maxlength="20" readOnly >
      </td>
    </tr>
	<tr> 
      <td class="blue"  width="15%">�û�����</td>
          <td colspan=3>
           	<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>
       </td>
     
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="��ѯ" onclick="check_HidPwd()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
         <!--
		  <input type="button" name="reprint"  class="b_foot" value="�ش�Ʊ" onclick="doreprint()">
		  -->
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