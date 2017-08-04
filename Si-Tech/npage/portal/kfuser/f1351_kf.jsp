<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/

%>
<%
   /*
   * 功能: 账单历史查询_条件输入页面
　 * 版本: v1.0
　 * 日期: 2009年6月25日
　 * 作者: zhanghonga,wangyia,libina
　 * 版权: sitech
   * 修改历史 
 　*/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.DateTrans"%>
<%
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);

		String currentDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
		
		int currentYearMonth = Integer.parseInt(currentDate),lastYearMonth;
		if(currentYearMonth%100==1){
			lastYearMonth=(currentYearMonth/100-1)*100+12;
		}else{
			lastYearMonth=currentYearMonth-1;
		}
		String opCode = "1351";
    String opName = "账单历史查询"; 
    
    String phone_no = (String)session.getAttribute("activePhone");
    if(phone_no==null||phone_no.equals("")){
      phone_no =request.getParameter("activePhone");
    } 
    System.out.println("f1351_kf.jsp——phone_no:"+phone_no);
%>
<HTML>
<HEAD>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
 public  String getCurrDateStr() {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMM");
		return objSimpleDateFormat.format(new java.util.Date());
	}	
%>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="/js/common/common_util.js"></script>
<script language="JavaScript" src="/js/common/date/date.js"></script>
<script language="JavaScript" src="/page/PayManage/common/common_1300.js"></script>
<script type="text/javascript" src="/js/common/common_check.js"></script>

<script language="JavaScript" src="/njs/redialog/redialog.js"></script>

<script language="JavaScript">
<!--
function docheck()
{
	vbYear  = parseInt(trim(document.frm.qry_begin_date.value).substring(0,4),10);
	vbMonth = parseInt(trim(document.frm.qry_begin_date.value).substring(4,6),10);
	veYear  = parseInt(trim(document.frm.qry_end_date.value).substring(0,4),10);
	veMonth = parseInt(trim(document.frm.qry_end_date.value).substring(4,6),10);   
	if(frm.phone_no.value == ""){
		showTip(document.frm.phone_no,"服务号码不能为空！");
		frm.phone_no.focus();
		return;
	}
	if(isNaN(frm.phone_no.value)){
		showTip(document.frm.phone_no,"服务号码数据类型不正确！");
		frm.phone_no.focus();
		return;
	}
	if(!forDate_YM(document.frm.qry_begin_date)) return;
	if(!forDate_YM(document.frm.qry_end_date)) return;
	
	if(parseFloat(document.frm.qry_begin_date.value)<190001){
		showTip(document.frm.qry_begin_date,"帐务年月不能小于1900年！");
		frm.qry_begin_date.focus();
		return;
	}

	if(parseInt(document.frm.qry_begin_date.value)>parseInt(document.frm.qry_end_date.value)){
		showTip(document.frm.qry_begin_date,"开始时间不能大于结束时间！");
		frm.qry_begin_date.focus();
		return ;			
	}
	
	if((veYear-vbYear)*12+veMonth-vbMonth > 5)
	{
		rdShowMessageDialog("只能查询6个月的数据！",0);
		return ;
	}	

  document.frm.action="f1351Cfm_kf.jsp";

	document.frm.query.disabled=true;
	document.frm.return1.disabled=true;
	document.frm.return2.disabled=true;
	document.frm.submit();
}


	function doclear() {
		frm.reset();
	}
	
	function doClose(){
		if(typeof(parent.removeTab)=="function"){
			parent.removeTab("1351");	
		}else{
			window.close();	
		}	
	}
-->
</script>

<title>山西BOSS-账单历史查询 </title>
</head>
<BODY>
<form action="" method="post" name="frm"  >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">查询条件</div>
<table cellspacing="0">
  <tr>    
    <td class="blue">查询号码</td>
    <td colspan="3">
      <input type="text" name="phone_no" id="phone_no" maxlength="11" value="<%=phone_no%>">
    </td>
  </tr> 
  <tr>
    <td class="blue">开始时间</td>
    <td>
      <input id="qry_begin_date" name="qry_begin_date" type="text" maxlength="6" value="<%=lastYearMonth%>" v_name="开始时间" onclick="WdatePicker({dateFmt:'yyyyMM',position:{top:'under'}});hiddenTip(document.frm.qry_begin_date);">
      <img onclick="WdatePicker({el:$dp.$('qry_begin_date'),dateFmt:'yyyyMM',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">		             
     </td>
    <td class="blue">结束时间</td>
    <td>
      <input id="qry_end_date" name="qry_end_date" type="text" maxlength="6" value="<%=currentYearMonth%>" v_name="结束时间" onclick="WdatePicker({dateFmt:'yyyyMM',position:{top:'under'}});hiddenTip(document.frm.qry_end_date);">
      <img onclick="WdatePicker({el:$dp.$('qry_end_date'),dateFmt:'yyyyMM',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">		             
     </td>
  </tr>
  <tr>
    <td colspan="4" id="footer">
    <input type="button" class="b_foot" name="query"    value="查询" onclick="docheck()" style="cursor:hand" index="9">
    &nbsp;
    <input type="button" class="b_foot" name="return1"  value="重置" onclick="doclear()" style="cursor:hand" index="10">
    &nbsp;
    <input type="button" class="b_foot" name="return2"  value="关闭" onClick="doClose()" style="cursor:hand" index="13">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>  
</form>
</BODY>
</HTML>