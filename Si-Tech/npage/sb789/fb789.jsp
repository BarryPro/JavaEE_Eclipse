<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:lichaoa@2010-10-18 代理商空中选号交易明细查询
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>代理商空中选号交易明细查询</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>

<script language=javascript>
	$(document).ready(function(){
		initPage();
	});
	
	function initPage(){
		hiddenTip(document.getElementById("phoneNo"));
		closeDiv();
		$("#phoneNo")[0].focus();
	}
	
	function onQuery(){
		var startStr = $("#startTime").val().trim();
		var endStr   = $("#endTime").val().trim();
		
		if(!check(frm)){
			return false;
		}
		if(endStr < startStr){
			rdShowMessageDialog("开始时间与结束时间不正确",0);
			return false;
		}
		if (startStr.substring(0,6) != endStr.substring(0,6)) {
			rdShowMessageDialog("开始时间和结束时间必须在同一个月内！",0);
			return false;
		}
		frameDiv.style.display="";
		frm.action="fb789_qry.jsp?phoneNo=" + $("#phoneNo").val() 
		+ "&beginTime=" + $("#startTime").val() + "&endTime=" + $("#endTime").val();
		frm.target="ifm";
		frm.submit();
	}
	
	function closeDiv(){
		$("#frameDiv").hide();
	}
	
</script>
</head>
<body>

<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">代理商空中选号交易明细查询</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">代理商手机号</td>
		<td colspan="3">
			<input name="phoneNo" id="phoneNo" type="text" v_type="mobphone" maxlength="11" v_must="1" onblur="checkElement(this);"/>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">开始时间</td>
		<td>
			<input name="startTime" id="startTime" type="text" v_type="date" value=<%=new java.text.SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime())%> v_must="1" onblur="checkElement(this);"/>
			<font class="orange">*</font>
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input name="endTime" id="endTime" type="text" v_type="date" value=<%=new java.text.SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime())%> v_must="1" onblur="checkElement(this);" />
			<font class="orange">*</font>
		</td>
	</tr>
</table>
<div id="frameDiv" style="display:none">
	<iframe name="ifm" width="98%" height="380" align="center"
			frameborder="0" cellspacing="0" src="blank.htm">
	</iframe>
</div>
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
