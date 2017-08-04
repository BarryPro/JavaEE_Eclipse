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
String opCode = "zg33";
String opName = "增值税专用发票查询";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 
String begin_tm = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String end_tm = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var tax_number = document.all.tax_number.value;
	var tax_code = document.all.tax_code.value;
	var s_type_id = document.all.s_type[document.all.s_type.selectedIndex].value;
	var login_no = document.all.login_no.value;
	var begin_tm = document.all.begin_tm.value;
	var end_tm = document.all.end_tm.value;
	/*if(s_type_id=="0")
	{
		rdShowMessageDialog("请输增值税专票发票号码!");
		return false;
	}		
	
	if(tax_number=="" &&tax_code=="")
	{
		rdShowMessageDialog("请输增值税专票发票号码!");
		return false;
	}
	
	else if(tax_code=="")
	{
		rdShowMessageDialog("请输增值税专票发票代码!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("请输增值税专票发票代码!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("请输增值税专票发票代码!");
		return false;
	}
	else if(tax_code=="")
	{
		rdShowMessageDialog("请输增值税专票发票代码!");
		return false;
	}*/
	if((begin_tm=="" &&end_tm!="")||(begin_tm!="" &&end_tm==""))
	{
		rdShowMessageDialog("增值税查询开始、结束时间必须全部输入!");
		return false;
	}
	else
	{
		document.frm.action="zg33_2.jsp";
		document.frm.submit(); 
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
<div class="title">
	<div id="title_zi">请输入查询条件</div>
</div> 	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">查询工号</td>
      <td> 
        <input class="button"type="text" name="login_no"   size="20"  colspan=2    >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">查询开始时间(YYYYMMDD)</td>
      <td> 
        <input class="button"type="text" name="begin_tm" maxlength=8 size="20" value="<%=begin_tm%>"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">查询结束时间(YYYYMMDD)</td>
      <td> 
        <input class="button"type="text" name="end_tm" maxlength=8 size="20" value="<%=end_tm%>" colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">发票状态</td>
      <td> 
        <select id="s_type_id" name="s_type">
			<option value="">--请选择</option>
			<option value="1">已开具</option>
			<option value="2">冲红</option>
			<option value="3">待冲红</option>
			<option value="4">待传递</option>
			<option value="5">已传递</option>
			<option value="6">已作废</option>
			<option value="7">待作废</option>
			<option value="8">待审批</option>
		</select>
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">增值税专票发票号码</td>
      <td> 
        <input class="button"type="text" name="tax_number" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">增值税专票发票代码</td>
      <td> 
        <input class="button"type="text" name="tax_code" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)"  >
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