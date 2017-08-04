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
		String opCode = "e627";
		String opName = "手机支付缴费";
		activePhone=(String)request.getParameter("activePhone"); 
		if(activePhone == null)
		{
			activePhone = "";
		}

%>
<HTML>
<HEAD>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript">

function commit(){

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
    
	 
		if( document.frm.payMoney.value=='')
   {
       rdShowMessageDialog("缴费金额不能为空，请重新输入 !");
       document.frm.payMoney.focus();
       return false;
    }   

  if(parseFloat(document.frm.payMoney.value) < 0)
  {
		 rdShowMessageDialog(" 缴费金额不能为负数！");
     document.frm.payMoney.focus();
     return false;
  }


	if( parseFloat(document.frm.payMoney.value)> 500 ) {
		rdShowMessageDialog("缴费金额不能大于500！");
		document.frm.payMoney.focus();
    return false;
	}
			

//   document.frm.payMoney.value = formatAsMoney(document.frm.payMoney.value);
 		 
 	 document.frm.submit();
	        
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

function doCheck()
 {

	if( document.frm.payMoney.value=='')
   {
       rdShowMessageDialog("缴费金额不能为空，请重新输入 !");
       document.frm.payMoney.focus();
       return false;
    }
   if(!dataValid( 'b' , document.frm.payMoney.value))
   {
       rdShowMessageDialog("您输入的是  "+ paymoney +" , 请输入有效的缴费金额！");
       document.frm.payMoney.focus();
       return false;
    }

	if ( document.frm.payMoney.value.indexOf(".")!=-1)
	{
		temp =  document.frm.payMoney.value.substring(document.frm.payMoney.value.indexOf(".")+1,document.frm.payMoney.value.length);
		if ( temp.length> 2 )
		{
			rdShowMessageDialog("缴费金额小数点后只能输入2位！");
			document.frm.payMoney.focus();
			return false;
		}
	}

  if(parseFloat(document.frm.payMoney.value) < 0)
  {
		 rdShowMessageDialog(" 缴费金额不能为负数！");
     document.frm.payMoney.focus();
     return false;
  }


	if( parseFloat(document.frm.payMoney.value)> 100000 ) {
		rdShowMessageDialog("缴费金额不能大于100,000！");
		document.frm.payMoney.focus();
    return false;
	}
			

   document.frm.payMoney.value = formatAsMoney(document.frm.payMoney.value);
 }
 
 function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("没有此用户的相关资料!");
		return;
	}
/*
  if(SzxFlag == "1"){
  	rdShowMessageDialog("此用户属于标准神州行用户,不可以进行缴费！");
  }
  if(IsMarketing !="0") {
  	 document.frm.ispopmarket.value="1";
  	 showMarketingDetail(IsMarketing);
  }
*/  
 // doCheck();
}
function sel1() {
 		window.location.href='e627.jsp';
 }

 function sel2(){
    window.location.href='e627_2.jsp';
 }
 
 function sel3(){
    window.location.href='e627_3.jsp';
 }
  function sel4(){
    window.location.href='e627_4.jsp';
 }

 function doclear() {
 		frm.reset();
 }
 </script> 
 
<title>黑龙江BOSS-手机支付缴费</title>
</head>
<BODY>
<form action="e627Cfm.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">手机支付缴费/签约</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">选择方式</td>
        <td colspan="4"> 
          <input name="busyType1" type="radio" onClick="sel1()" value="1" checked>签约 
          <input name="busyType2" type="radio" onClick="sel2()" value="2"> 解约
          <input name="busyType3" type="radio" onClick="sel3()" value="3"> 变更 
          <input name="busyType4" type="radio" onClick="sel4()" value="4"> 查询
          
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">服务号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  value="<%=activePhone%>"  readOnly>
        <font class="orange"> *</font>
      </td>
      <td class="blue" noWrap>缴费金额</td>
      <td>
        <input type="text" name="payMoney" maxlength="3"  onKeyPress="return isKeyNumberdot(0)" >
			  <font class="orange"> *</font>
			</td>
			<td class="blue" noWrap>自助缴费日期</td>
			<td>
        <input type="text" name="date" value="27" maxlength="2"  disabled  >
        <input type="hidden" name="date1" value="27"  >
			  <font class="orange"> *</font>
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
