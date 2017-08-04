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
String opCode = "zg11";
String opName = "GPRS流量状态查询";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
//activePhone = request.getParameter("activePhone");

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.all.phone_no.value;
 
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("zg11_check.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
} 
function doProcess(packet)
{
	var s_flag   = packet.data.findValueByName("s_flag"); 
	var s_result   = packet.data.findValueByName("s_result"); 
	//alert("s_flag is "+s_flag+" and s_result is "+s_result);
	var s_qqw_flag = packet.data.findValueByName("s_qqw_flag"); 
	var s_qqw_result = packet.data.findValueByName("s_qqw_result");
	//alert("s_qqw_flag is "+s_qqw_flag+" and s_qqw_result is "+s_qqw_result);
	if(s_flag=="N")
	{
		rdShowMessageDialog("手机号码不存在，请重新输入!");
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		return false;
	}
	else
	{
		if(s_result=="0")//开通
		{
			document.getElementById("div2").style.display="block";
			document.getElementById("div1").style.display="none";
		}
		else
		{
			document.getElementById("div2").style.display="none";
			document.getElementById("div1").style.display="block";
		}
	}
	//亲情网记录
	//alert("s_qqw_flag is "+s_qqw_flag);
	if(s_qqw_flag=="kt")
	{
		//alert("开通");
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="block";
	}
	else
	{
		//alert("关闭");
		document.getElementById("div3").style.display="block";
		document.getElementById("div4").style.display="none";
	}
}
	
 
 

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	 document.getElementById("div1").style.display="none";
	 document.getElementById("div2").style.display="none";
	 //xl add for lidsa
	 document.getElementById("div3").style.display="none";
	 document.getElementById("div4").style.display="none";
 }

 function doGb()
 {
	 //alert("1");
	 var phone_no = document.all.phone_no.value;
	 document.frm.action="zg11_2.jsp?phone_no="+phone_no+"&flag=1";
	 document.frm.submit();
 }
 function doKt()
 {
	// alert("3");
	 var phone_no = document.all.phone_no.value;
	 document.frm.action="zg11_2.jsp?phone_no="+phone_no+"&flag=3";
	 document.frm.submit();
 }
 function doqry()
 {
	//alert("2");
	var phone_no = document.all.phone_no.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
	}
	else
	{
		document.frm.action="zg11_qry.jsp?phone_no="+phone_no;
		document.frm.submit();
	}

 }
 function qqw_Gb()
 {
	 //alert("1 关闭");
	 var phone_no = document.all.phone_no.value;
	 var	prtFlag = rdShowConfirmDialog("是否确定关闭?");
	 if (prtFlag==1)
	 {
	 	document.frm.action="zg11_qqw.jsp?phone_no="+phone_no+"&flag=gb";
	 	document.frm.submit();
	 }
	 else
	 {
	 	return false;
	 }	
 }
 function qqw_Kt()
 {
 		//alert("0 开通");
 		var phone_no = document.all.phone_no.value;
 		var	prtFlag = rdShowConfirmDialog("是否确定开通?");
		if (prtFlag==1)
		{
		  document.frm.action="zg11_qqw.jsp?phone_no="+phone_no+"&flag=kt";
	  	document.frm.submit();
		}
		else
		{
		 	return false;
		}	
	  
 }
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phone_no" size="20"  maxlength="12" colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>

	<tr id="div1">
		<td>用户流量提醒短信状态为关闭</td>
		<td><input type="button" name="gb" class="b_foot" value="开通" onclick="doKt()" ></td>
	</tr> 
	<tr id="div2">
		<td>用户流量提醒短信状态为开通</td>
		<td><input type="button" name="gb" class="b_foot" value="关闭" onclick="doGb()" ></td>
	</tr> 

	<!--xl add for lidsa begin-->
	<tr id="div3">
		<td>用户亲情网状态为关闭</td>
		<td><input type="button" name="kt" class="b_foot" value="开通" onclick="qqw_Kt()" ></td>
		
	</tr> 
	<tr id="div4">
		<td>用户亲情网状态为开通</td>
		<td><input type="button" name="gb" class="b_foot" value="关闭" onclick="qqw_Gb()" ></td>
	</tr>
	<!--xl add for lidsa end-->
	 
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" id="query_id" name="query" class="b_foot" value="状态查询" onclick="docheck()" >
          &nbsp;
		   <input type="button" id="query_id" name="query" class="b_foot" value="优惠信息提醒变更记录查询" onclick="doqry()" >
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