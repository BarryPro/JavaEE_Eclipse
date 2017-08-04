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
		boolean flag = false;	
		String phoneNo = request.getParameter("phoneNo");
		String workno = (String)session.getAttribute("workNo");
		
			
		
		if(phoneNo == null)
		{
		    phoneNo = "";
		    flag = false;
		}
	  else
	  {
	      flag = true;
	  }	

    String return_code="";
	  String ret_msg="";
		String [] inParas = new String[2];
	  inParas[0]  = phoneNo;
	  inParas[1]  = workno;

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


 function doProcess(packet){
	var retResult   = packet.data.findValueByName("retResult");
	var SzxFlag     = packet.data.findValueByName("SzxFlag");
	var IsMarketing = packet.data.findValueByName("IsMarketing");
	var returnCode = packet.data.findValueByName("returnCode");
	
	if(returnCode=="999999"){
		rdShowMessageDialog("没有此用户的相关资料!");
		return;
	}
 
  commit();
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
<form action="e627_4.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">手机支付缴费/查询</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">选择方式</td>
        <td colspan="4"> 
          <input name="busyType1" type="radio" onClick="sel1()" value="1" >签约 
          <input name="busyType2" type="radio" onClick="sel2()" value="2" > 解约
          <input name="busyType3" type="radio" onClick="sel3()" value="3"> 变更 
          <input name="busyType4" type="radio" onClick="sel4()" value="4" checked> 查询
          
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">服务号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" value="<%=phoneNo%>" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange"> *</font>
        <input type="button" name="Button1" class="b_text" value="查询" onclick="commit()">
      </td>  
    </tr>
  </table>


  <br>
      

		<div class="title">
			<div id="title_zi">查询结果</div>
		</div>
    <table cellspacing="0">
      <tr align="center">
        <th>代扣金额</th>
        <th>开通时间</th>
        <th>变更时间</th>
        <th>开通工号</th>    
        <th>自动缴费日期</th>     
      </tr>
<%
   if(flag){
%>

	<wtc:service name="bs_6273Cfm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="7" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   if(tempArr.length != 0 && return_code.equals("000000"))
   {
     for(int i=0; i<tempArr.length ;i++)
     {
%>   
     <tr align="center">
        <td><%=tempArr[i][2]%></td>
        <td><%=tempArr[i][3]%></td>
        <td><%=tempArr[i][4]%></td>
        <td><%=tempArr[i][5]%></td>
        <td><%=tempArr[i][6]%></td>
      </tr>
<%}}}%>      
    </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>

