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

<%
		String opCode = "b864";
		String opName = "新入网用户赠送话费";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
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
		rdShowMessageDialog("没有此用户的相关资料!");
		return;
	}

  if(SzxFlag == "1"){
  	rdShowMessageDialog("此用户属于标准神州行用户,不可以进行缴费！");
  }
 
  if(IsMarketing !="0") {
  	 document.frm.ispopmarket.value="1";
  	 showMarketingDetail(IsMarketing);
  }
  
  docheck();
}


function getUser() {
	 
    var h=450;
    var w=500;

   	var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
    var mphone_no=document.frm.phoneNo.value;
	  var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    var path="getUser1.jsp?phoneNo="+mphone_no;
	  window.showModalDialog(path,"",prop);
	  //var returnValue = window.open(path,"",prop);
}



function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.focus();
     return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	            
	var phone_no = document.all.phoneNo.value;
  var busy_type = "1";
	var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("phone_no",phone_no);
	checkPwd_Packet.data.add("busy_type",busy_type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

 


function docheck()
{
	if(document.frm.phoneNo.value=="")
  {
      rdShowMessageDialog("请输入服务号码!");
     	document.frm.phoneNo.focus();
     	return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
   document.frm.action="s4864Cfm.jsp";
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




-->
 </script> 
 
<title>新入网用户赠送话费</title>
</head>
<BODY onload="javascript:document.frm.phoneNo.focus();">
<form action="" method="post" name="frm">
		<input type="hidden" name="busy_type"  value="1">
		<input type="hidden" name="op_code"  value="1302">
		<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
		<input type="hidden" name="billdate"  value="<%=dateStr.substring(0,6)%>">
		<input type="hidden" name="water_number">
		<input type="hidden" name="ispopmarket" value="0" >
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">新入网用户赠送话费</div>
		</div>

    
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">服务号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
        <input name=checkfeequery type=button class="b_text" style="cursor:hand" onClick="getUser()" value=查询>    
      </td>
      <td class="blue">金额</td>
      <td> 
        <input type="text" name="money" size="20" maxlength="20" value="20"  readonly>
      </td>
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="确认" onclick="docheck()" >
          &nbsp;
          
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
        
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="window.close()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>