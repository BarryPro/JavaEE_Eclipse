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
		String opCode = "zg44";
		String opName = "虚拟集团关系配置";
 	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjtcx()
{
	var phoneNo = document.frm.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请输入集团虚拟账号!");
		return false;
	}
	else
	{
		//alert(phoneNo);
		var myPacket = new AJAXPacket("zg44_check.jsp","正在提交，请稍候......");
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
		 rdShowMessageDialog("该虚拟集团账号不存在,请重新输入!");
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

 function cyzhtj()//成员添加
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
	// alert("addgrp");//手机号码可空
	 var phoneNo = document.frm.phoneNo.value;
	 var contract_name =  document.frm.contract_name.value;
	 var detail_phone =  document.frm.detail_phone.value;
	 var detail_contract =  document.frm.detail_contract.value;
	 if(detail_phone=="" ||detail_contract=="")
	 {
		rdShowMessageDialog("添加的虚拟集团成员号码和虚拟成员账号都不可以为空!");
		return false;
	 }	
	 else
	 {
		 var prtFlag=0;
		 prtFlag=rdShowConfirmDialog("是否确定进行虚拟集团添加操作?");
		 if (prtFlag==1){
			var myPacket = new AJAXPacket("zg44_add.jsp","正在提交，请稍候......");
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
		rdShowMessageDialog("添加成功!");
		document.frm.detail_phone.value="";
		document.frm.detail_contract.value="";
	 }
	 else
	 {
		 rdShowMessageDialog("添加失败!错误代码"+s_code+",错误原因"+s_msg);
		 return false;
	 }
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请选择配置方式</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">配置方式</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" >虚拟集团添加 
        </q>
 
          <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel2()" value="2" checked> 集团成员添加
          </q>
         <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> 虚拟集团查询及删除
          </q>
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel3()" value="3"> 集团成员关系查询
          </q>
		  <!--xl add  批量导入-->
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel5()" value="3"> 批量成员添加
          </q>
		  <!--
		  <q vType="setNg35Attr">
          <input name="busyType2" type="radio" onClick="sel4()" value="4"> 集团成员关系删除
          </q>
			 -->
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">虚拟集团账号</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="14" maxlength="14"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      
    </tr>
	<tr> 
     
      <td class="blue" width="15%">虚拟集团名称</td>
      <td> 
        <input type="text" readonly name="contract_name" size="49" maxlength="49"  >
		<input type="button" name="query" class="b_foot" value="虚拟集团查询" onclick="xnjtcx()" >
	  </td>
      
    </tr>
	
	<tr id="tjdetail">
		<td class="blue" width="15%">成员手机号码</td>
		<td> 
			<input type="text"  name="detail_phone" size="14" maxlength="14"  >(一点支付账号成员手机号码请输入0)
		</td>
	</tr>
	<tr id="tjdetail2">
		<td class="blue" width="15%">成员帐户号码</td>
		<td> 
			<input type="text"  name="detail_contract" size="14" maxlength="14"  >
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="add" class="b_foot" value="添加" onclick="addgrp()" >
		</td>
	</tr>
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="tj" name="query" class="b_foot" value="成员账户添加" disabled onclick="cyzhtj()" >
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