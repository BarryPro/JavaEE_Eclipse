<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<html>
<head>
<title>扣费主动提醒短信处理明细查询</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
  String workNo=(String)session.getAttribute("workNo");
  String printAccept="";
  printAccept = getMaxAccept();
  String[] inParam1 = new String[2];
	inParam1[0]="select to_char(sysdate,'yyyymmdd') from dual";
	String sysdate="";

%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam1[0]%>"/> 
	</wtc:service>
	<wtc:array id="newDateArr" scope="end" />
<%	

	if(newDateArr!=null&&newDateArr.length>0){
    sysdate = newDateArr[0][0].substring(0,6);        
  }	
%>
<script language=javascript>
	$(document).ready(function(){
		initPage();
	});
	
	function initPage(){
		hiddenTip(document.getElementById("startTime"));
		$("#startTime")[0].focus();
	}
	
	function onQuery(){
		if(!check(frm)){
			return false;
		}
		var startStr = $("#startTime").val().trim();
		var endStr   = $("#endTime").val().trim();
		var thisMonth=0;
		if(startStr.length == 0){
			rdShowMessageDialog("开始时间不能为空",0);
			$("#startStr")[0].focus();
			return false;
		}else if(endStr.length == 0){
			rdShowMessageDialog("结束时间不能为空",0);
			$("#endStr")[0].focus();
			return false;
		}else if(endStr < startStr){
			rdShowMessageDialog("开始时间不能大于结束时间",0);
			return false;
		}else if (endStr.substring(0,6) != startStr.substring(0,6)){
			rdShowMessageDialog("开始时间与结束时间应为同一个月",0);
			return false;		
		}
		//alert(endStr);
		//frm.action="zg91_getMore.jsp?beginTime=" + $("#startTime").val() + "&endTime=" + $("#endTime").val();
	//	frm.target="ifm";
	//	frm.submit();
			if("<%=sysdate%>"==startStr.substring(0,6)){
				thisMonth=1;
			}
			document.frm.hTableName.value="rfo006";
			document.frm.hParams1.value= "dbcustadm.PRC_zg91_RPT('"+thisMonth+"','"+startStr+"','"+endStr+"','<%=workNo%>','<%=workNo%>'";	
			document.frm.queryBtn.disabled=true;
			document.all.frm.submit();
	}
	
</script>
</head>
<body>

<form action="/npage/rpt/print_rpt_boss.jsp" method="post" name="frm" >
 	<input type="hidden" name="opcode" value = "zg91" >
	<input type="hidden" name="opname" value = "扣费主动提醒短信处理明细查询" >
	<input type="hidden" name="hParams1" value="">
	<input type="hidden" name="hTableName" value="">
	<input type="hidden" name="hDbLogin" value ="dbchange">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">扣费主动提醒短信处理明细查询</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input name="startTime" id="startTime" type="text" v_type="date" onblur="checkElement(this)" />
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input name="endTime" id="endTime" type="text" v_type="date" onblur="checkElement(this)" />
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type="button" name="queryBtn" id="queryBtn" value="查询" onclick="onQuery()">
	      <input class="b_foot" type="reset" name="back" value="清除" onclick="initPage()">
	      <input class="b_foot" type="button" name="qryPage" value="关闭" onClick="removeCurrentTab()">
	    </td>
	</tr>
</table>
  <%@ include file="/npage/include/footer.jsp" %> 
   </form>
</body>
</html>
