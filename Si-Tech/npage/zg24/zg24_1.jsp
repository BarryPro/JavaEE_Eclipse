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
String opCode = "zg24";
String opName = "增值税红字专用发票开具申请";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var tax_number = document.all.tax_number.value;
	var tax_code = document.all.tax_code.value;
	var year_month =  document.all.year_month.value;
	if(tax_number=="")
	{
		rdShowMessageDialog("请输入蓝字发票号码!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("请输入蓝字发票号码!");
		return false;
	}
	else if(year_month=="")
	{
		rdShowMessageDialog("请输入红字发票开具年月!");
		return false;
	} 
	else
	{
		/*var checkPwd_Packet = new AJAXPacket("zg24_Qry.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("tax_number",tax_number);
		checkPwd_Packet.data.add("tax_code",tax_code);
		checkPwd_Packet.data.add("cust_id",cust_id);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
		*/
		//document.frm.action="zg24_2.jsp?s_good_name="+s_good_name+"&s_ggxh="+s_ggxh+"&s_dw="+s_dw+"&s_sl="+s_sl+"&s_dj="+s_dj+"&s_je="+s_je+"&s_tax_rate="+s_tax_rate+"&s_se="+s_se+"&tax_number="+tax_number+"&tax_code="+tax_code+"&cust_id="+cust_id;
		document.frm.action="zg24_2.jsp";
	    document.frm.submit();
	}
	
} 

	
function doProcess(packet)
{
	var tax_number = document.all.tax_number.value;
	var tax_code = document.all.tax_code.value;
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
		document.frm.action="zg24_2.jsp?s_good_name="+s_good_name+"&s_ggxh="+s_ggxh+"&s_dw="+s_dw+"&s_sl="+s_sl+"&s_dj="+s_dj+"&s_je="+s_je+"&s_tax_rate="+s_tax_rate+"&s_se="+s_se+"&tax_number="+tax_number+"&tax_code="+tax_code+"&cust_id="+cust_id;
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
      <td class="blue" width="15%">原蓝字发票号码</td>
      <td> 
        <input class="button"type="text" name="tax_number" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">原蓝字发票代码</td>
      <td> 
        <input class="button"type="text" name="tax_code" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">查询年月</td>
      <td> 
        <input class="button"type="text" name="year_month" size="20"  colspan=2 maxlength=6 onKeyPress="return isKeyNumberdot(0)"  >(YYYYMM)
      </td>
    </tr>
	 
	 
	 


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