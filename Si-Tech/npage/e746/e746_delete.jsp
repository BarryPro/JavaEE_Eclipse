<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "e746";
		String opName = "渠道发票录入";
		String login_no = (String)session.getAttribute("workNo");
		int max=0;
%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
  if(document.frm.delete_number.value=="")  {
     rdShowMessageDialog("请输入删除发票数量!");
     document.frm.delete_number.value = "";
     document.frm.delete_number.focus();
     return false;
  }
  
  if(Number(document.frm.delete_number.value) > Number(document.frm.max_delete_number.value))  {
     rdShowMessageDialog("输入删除发票数量超过营业员发票数量，请重新输入!");
     document.frm.delete_number.value = "";
     document.frm.delete_number.focus();
     return false;
  }
  
	document.frm.submit();
	            
}

 function sel1() {
 		 
		window.location.href='e746_1.jsp';
 }

 function sel2(){
 
	window.location.href='e746_3.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
 //删除
function sel4(){
    //alert("4");
	window.location.href='e746_delete.jsp';
 }	

 function doclear() {
 		frm.reset();
 }
 
	
 function doQry()
 {
	 //alert("doQry");
	 var qd_login = document.all.qdgh.value;
	 if(qd_login=="")
	 {
		rdShowMessageDialog("请输入渠道工号，单击查询按钮!");
		return false;
	 }
	 else
	 {
		//xl add
		var myPacket = new AJAXPacket("e746_doQry.jsp","正在提交，请稍候......");
		myPacket.data.add("qd_login",qd_login);
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
		//end of add
	 }	
 }
 function doProcess(packet)
 {
	 var s_result = packet.data.findValueByName("s_result");
	 var s_out_sinvoice = packet.data.findValueByName("s_out_sinvoice");
	 var s_out_einvoice = packet.data.findValueByName("s_out_einvoice");
	 var s_out_invoicecode = packet.data.findValueByName("s_out_invoicecode");
	 //alert("s_result is "+s_result+" and s_out_invoicecode is "+s_out_invoicecode);
	 if(s_result==0)
	 {
		 //查询成功
		 document.getElementById("show1").style.display="block";
		 document.getElementById("s_Invoice_number1").value=s_out_sinvoice;
		 document.getElementById("e_Invoice_number1").value=s_out_einvoice;
		 document.getElementById("Invoice_code1").value=s_out_invoicecode;
		 document.all.max_delete_number.value=s_out_einvoice-s_out_sinvoice+1;
		 document.all.query.disabled=false;
	 
	 }
	 else
	 {
		 document.getElementById("show1").style.display="none";
		 document.all.query.disabled=true;
	 }
 }
 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY onload="document.getElementById('show1').style.display='none',document.all.query.disabled=true">
<form action="e746DeleteCfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">渠道发票信息查询和录入</div>
		</div> 
	<!--
  <table cellspacing="0">
  
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
        	
          <input name="busyType2" type="radio" onClick="sel1()" value="1" >按流水查询 
          <input name="busyType21" type="radio" onClick="sel2()" value="2" > 按发票号码查询 
          <input name="busyType22" type="radio" onClick="sel3()" value="3" checked> 录入发票号码和发票代码
      </td>
      
    </tr>
    
  </table>-->

 <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        
		<td colspan="4">           
          <input name="busyType22" type="radio" onClick="sel1()"  value="3" > 渠道录入发票号码和发票代码
		  <input name="busyType23" type="radio" onClick="sel4()" value="4" checked> 营业员发票删除
		</td>
      
    </tr>
  </table>
  
  <table cellspacing="0">
	
	<!--xl add 先输入渠道工号-->
	<tr>
    	
      <td colspan=3 class="blue" width="15%">渠道工号:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="qdgh"  size="10" maxlength="6"  >
		<input type="button" class="b_foot" value="查询" onclick="doQry()">
      </td>
         
          
    </tr>

	<div id ="show">
	<tr id ="show1">
    	<td align="left" class="blue" width="15%">起始发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="s_Invoice_number1" id="s_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">终止发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="e_Invoice_number1" id="e_Invoice_number1" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">发票代码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" readonly name="Invoice_code1" id="Invoice_code1" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>     
    </tr>
	</div>
	<tr>
    	<td align="left" class="blue" width="15%">删除发票数量:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="delete_number" size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">最多删除数量:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="max_delete_number" readonly size="10" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;       
      </td>      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="确认" onclick="commit()" >
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

