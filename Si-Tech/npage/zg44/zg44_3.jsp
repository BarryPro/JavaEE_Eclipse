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
		String opCode = "zg44";
		String opName = "���⼯�Ź�ϵ����";
 	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjtcx()
{
	var phoneNo = document.frm.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("�����뼯�������˺�!");
		return false;
	}
	else
	{
		//alert(phoneNo);
		var myPacket = new AJAXPacket("zg44_check.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
}
 function doPosSubInfo3(packet)
 {
	 //alert("2");
	 var s_flag =  packet.data.findValueByName("flag1");
	 var s_cust_name =  packet.data.findValueByName("s_cust_name");
	// alert("s_flag is "+s_flag+" and s_cust_name is "+s_cust_name);
	 if(s_flag=="0")
	 {
		document.getElementById("tj").disabled=false;
		document.frm.contract_name.value=s_cust_name;

	 }
	 else
	 {
		 rdShowMessageDialog("�����⼯���˺Ų�����,����������!");
		 document.frm.phoneNo.value="";
		 document.getElementById("tj").disabled=true;
	 }	
 }


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zg44_1.jsp';
 }

 function sel2(){
    window.location.href='zg44_3.jsp';
 }
 function sel3(){
    window.location.href='zg44_cx.jsp';
 }
 function sel4(){
    window.location.href='zg44_del.jsp';
 }

 function sel5(){
    window.location.href='zg44_pladd.jsp';
 }

 function cyzhtj()//��Ա���
 {
	 //alert("cyzhtj");
	 document.getElementById("tjdetail").style.display="block";
	 document.getElementById("tjdetail2").style.display="block";
	 document.getElementById("tj").disabled=true;
	
 }
 
 function inits()
 {
	 document.getElementById("tjdetail").style.display="none";
	 document.getElementById("tjdetail2").style.display="none";
 }

 function addgrp()
 {
	// alert("addgrp");//�ֻ�����ɿ�
	 var phoneNo = document.frm.phoneNo.value;
	 var contract_name =  document.frm.contract_name.value;
	 var detail_phone =  document.frm.detail_phone.value;
	 var detail_contract =  document.frm.detail_contract.value;
	 if(detail_phone=="" ||detail_contract=="")
	 {
		rdShowMessageDialog("��ӵ����⼯�ų�Ա����������Ա�˺Ŷ�������Ϊ��!");
		return false;
	 }	
	 else
	 {
		 var prtFlag=0;
		 prtFlag=rdShowConfirmDialog("�Ƿ�ȷ���������⼯����Ӳ���?");
		 if (prtFlag==1){
			var myPacket = new AJAXPacket("zg44_add.jsp","�����ύ�����Ժ�......");
			myPacket.data.add("unit_id",phoneNo);
			myPacket.data.add("contract_name",contract_name);
			myPacket.data.add("detail_phone",detail_phone);
			myPacket.data.add("detail_contract",detail_contract);
			core.ajax.sendPacket(myPacket,doPosSubInfo2);
			myPacket=null;
			
		 
		 }
		 else
		 { 
			return false;	
		 }
	 }
	 
 }

 function doPosSubInfo2(packet)
 {
	 //alert("2");
	 var s_flag =  packet.data.findValueByName("flag1");
	 var s_msg =   packet.data.findValueByName("s_msg");
	 var s_code =  packet.data.findValueByName("s_code");
	// alert("s_flag is "+s_flag);
	 if(s_flag=="0")
	 {
		rdShowMessageDialog("��ӳɹ�!");
		document.frm.detail_phone.value="";
		document.frm.detail_contract.value="";
	 }
	 else
	 {
		 rdShowMessageDialog("���ʧ��!�������"+s_code+",����ԭ��"+s_msg);
		 return false;
	 }
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">��ѡ�����÷�ʽ</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">���÷�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >���⼯����� 
        </q>
 
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> ���ų�Ա���
          </q>
         <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> ���⼯�Ų�ѯ��ɾ��
          </q>
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel3()" value="3"> ���ų�Ա��ϵ��ѯ
          </q>
		  <!--xl add  ��������-->
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel5()" value="3"> ������Ա���
          </q>
		  <!--
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> ���ų�Ա��ϵɾ��
          </q>
			 -->
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">���⼯���˺�</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      
    </tr>
	<tr> 
     
      <td class="blue" width="15%">���⼯������</td>
      <td> 
        <input type="text" readonly name="contract_name" size="49" maxlength="49"  >
		<input type="button" name="query" class="b_foot" value="���⼯�Ų�ѯ" onclick="xnjtcx()" >
	  </td>
      
    </tr>
	
	<tr id="tjdetail">
		<td class="blue" width="15%">��Ա�ֻ�����</td>
		<td> 
			<input type="text"  name="detail_phone" size="14" maxlength="14"  >(һ��֧���˺ų�Ա�ֻ�����������0)
		</td>
	</tr>
	<tr id="tjdetail2">
		<td class="blue" width="15%">��Ա�ʻ�����</td>
		<td> 
			<input type="text"  name="detail_contract" size="14" maxlength="14"  >
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="add" class="b_foot" value="���" onclick="addgrp()" >
		</td>
	</tr>
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="tj" name="query" class="b_foot" value="��Ա�˻����" disabled onclick="cyzhtj()" >
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