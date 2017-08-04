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
String opCode = "zg32";
String opName = "电子有价卡充值";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.all.phone_no.value;
	var pay_accept = document.all.pay_accept.value;
	/**var cust_id = document.all.cust_id.value; **/
	if(phone_no=="")
	{
		rdShowMessageDialog("请输入手机号码!");
		return false;
	}
	else if(pay_accept=="")
	{
		rdShowMessageDialog("请输入订单流水!");
		return false;
	}
	/**else if(cust_id=="")
	{
		rdShowMessageDialog("请输入客户ID!");
		return false;
	}**/
	else
	{
		/*var checkPwd_Packet = new AJAXPacket("zg24_Qry.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("pay_accept",pay_accept);
		checkPwd_Packet.data.add("cust_id",cust_id);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
		*/
		//document.frm.action="zg24_2.jsp?s_good_name="+s_good_name+"&s_ggxh="+s_ggxh+"&s_dw="+s_dw+"&s_sl="+s_sl+"&s_dj="+s_dj+"&s_je="+s_je+"&s_tax_rate="+s_tax_rate+"&s_se="+s_se+"&phone_no="+phone_no+"&pay_accept="+pay_accept+"&cust_id="+cust_id;
		document.frm.action="zg32_2.jsp";
	    document.frm.submit();
	}
	
} 

	
function doProcess(packet)
{
	var phone_no = document.all.phone_no.value;
	var pay_accept = document.all.pay_accept.value;
	var cust_id = document.all.cust_id.value;
	var s_flag = packet.data.findValueByName("s_flag");
	var s_good_name = packet.data.findValueByName("s_good_name");
	var s_ggxh = packet.data.findValueByName("s_ggxh");
	var s_dw = packet.data.findValueByName("s_dw");
	var s_sl = packet.data.findValueByName("s_sl");
	var s_dj = packet.data.findValueByName("s_dj");
	var s_je = packet.data.findValueByName("s_je");
	var s_tax_rate = packet.data.findValueByName("s_tax_rate");
	var s_se = packet.data.findValueByName("s_se");
 
	
	//alert("s_flag is "+s_flag+" and s_contract_no is "+s_contract_no);
	if(s_flag=="Y")
	{
		document.frm.action="zg24_2.jsp?s_good_name="+s_good_name+"&s_ggxh="+s_ggxh+"&s_dw="+s_dw+"&s_sl="+s_sl+"&s_dj="+s_dj+"&s_je="+s_je+"&s_tax_rate="+s_tax_rate+"&s_se="+s_se+"&phone_no="+phone_no+"&pay_accept="+pay_accept+"&cust_id="+cust_id;
	    document.frm.submit();
	}
	else
	{
		alert("蓝字发票信息不存在，请重新输入!");
		return false;
	}
}	
 

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	
 }

 
  function doExport()
  {
	  
	  document.frm.action="zg12_export.jsp";
	  document.frm.submit();

  }
  function doImport()
  {
	  alert("1");
	  document.frm.action="zg12_import.jsp";
	  document.frm.submit();
  }
  function doTest()
  {
	  alert("1");
	  document.frm.action="zg12_xmltest.jsp";
	  document.frm.submit();
  }
  function do_paynote()
  {
	  alert("?");
	  document.frm.action="zg12_paynote.jsp";
	  document.frm.submit();
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
        <input class="button"type="text" name="phone_no" size="11" maxlength=11 colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">订单流水</td>
      <td> 
        <input class="button"type="text" name="pay_accept" size="20" maxlength=20  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
<!--
	<tr> 
      <td class="blue" width="15%">客户ID</td>
      <td> 
        <input class="button"type="text" name="cust_id" size="20"  colspan=2 value="23002348611"  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr> 
	 -->
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="测试展示pay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="导出" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="导入" onclick="doImport()" >	
        -->
      <input type="button" id="query_id" name="query" class="b_foot" value="查询" onclick="docheck()" >
        
	  <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >

	  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
	  </td>
	   
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>