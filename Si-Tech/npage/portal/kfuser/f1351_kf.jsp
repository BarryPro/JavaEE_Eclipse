<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/

%>
<%
   /*
   * ����: �˵���ʷ��ѯ_��������ҳ��
�� * �汾: v1.0
�� * ����: 2009��6��25��
�� * ����: zhanghonga,wangyia,libina
�� * ��Ȩ: sitech
   * �޸���ʷ 
 ��*/
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
    String opName = "�˵���ʷ��ѯ"; 
    
    String phone_no = (String)session.getAttribute("activePhone");
    if(phone_no==null||phone_no.equals("")){
      phone_no =request.getParameter("activePhone");
    } 
    System.out.println("f1351_kf.jsp����phone_no:"+phone_no);
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
		showTip(document.frm.phone_no,"������벻��Ϊ�գ�");
		frm.phone_no.focus();
		return;
	}
	if(isNaN(frm.phone_no.value)){
		showTip(document.frm.phone_no,"��������������Ͳ���ȷ��");
		frm.phone_no.focus();
		return;
	}
	if(!forDate_YM(document.frm.qry_begin_date)) return;
	if(!forDate_YM(document.frm.qry_end_date)) return;
	
	if(parseFloat(document.frm.qry_begin_date.value)<190001){
		showTip(document.frm.qry_begin_date,"�������²���С��1900�꣡");
		frm.qry_begin_date.focus();
		return;
	}

	if(parseInt(document.frm.qry_begin_date.value)>parseInt(document.frm.qry_end_date.value)){
		showTip(document.frm.qry_begin_date,"��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
		frm.qry_begin_date.focus();
		return ;			
	}
	
	if((veYear-vbYear)*12+veMonth-vbMonth > 5)
	{
		rdShowMessageDialog("ֻ�ܲ�ѯ6���µ����ݣ�",0);
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

<title>ɽ��BOSS-�˵���ʷ��ѯ </title>
</head>
<BODY>
<form action="" method="post" name="frm"  >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">��ѯ����</div>
<table cellspacing="0">
  <tr>    
    <td class="blue">��ѯ����</td>
    <td colspan="3">
      <input type="text" name="phone_no" id="phone_no" maxlength="11" value="<%=phone_no%>">
    </td>
  </tr> 
  <tr>
    <td class="blue">��ʼʱ��</td>
    <td>
      <input id="qry_begin_date" name="qry_begin_date" type="text" maxlength="6" value="<%=lastYearMonth%>" v_name="��ʼʱ��" onclick="WdatePicker({dateFmt:'yyyyMM',position:{top:'under'}});hiddenTip(document.frm.qry_begin_date);">
      <img onclick="WdatePicker({el:$dp.$('qry_begin_date'),dateFmt:'yyyyMM',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">		             
     </td>
    <td class="blue">����ʱ��</td>
    <td>
      <input id="qry_end_date" name="qry_end_date" type="text" maxlength="6" value="<%=currentYearMonth%>" v_name="����ʱ��" onclick="WdatePicker({dateFmt:'yyyyMM',position:{top:'under'}});hiddenTip(document.frm.qry_end_date);">
      <img onclick="WdatePicker({el:$dp.$('qry_end_date'),dateFmt:'yyyyMM',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">		             
     </td>
  </tr>
  <tr>
    <td colspan="4" id="footer">
    <input type="button" class="b_foot" name="query"    value="��ѯ" onclick="docheck()" style="cursor:hand" index="9">
    &nbsp;
    <input type="button" class="b_foot" name="return1"  value="����" onclick="doclear()" style="cursor:hand" index="10">
    &nbsp;
    <input type="button" class="b_foot" name="return2"  value="�ر�" onClick="doClose()" style="cursor:hand" index="13">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>  
</form>
</BODY>
</HTML>