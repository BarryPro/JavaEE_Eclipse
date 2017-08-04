<%
  /*
   * 功能: WLAN使用信息查询
   * 版本: 1.0
   * 日期: 20110715
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLAN使用信息查询</title>
<%
	String opCode="e067";
	String opName="WLAN使用信息查询";
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	onload=function() {
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		var startDateObj = document.getElementById("startDate");
		var endDateObj = document.getElementById("endDate");
		var startDate = new Date(startDateObj.value.substr(0, 4) + "/" + startDateObj.value.substr(4, 2) + "/" + startDateObj.value.substr(6, 2));
		var startDateLimit = new Date(endDateObj.value.substr(0, 4) + "/" + endDateObj.value.substr(4, 2) + "/" + endDateObj.value.substr(6, 2));
		startDateLimit.setMonth(endDateObj.value.substr(4, 2) - 3);

		controlBtn(true);
		
		if (!checkElement(startDateObj) || !checkElement(endDateObj)) {
			controlBtn(false);
			return false;
		} else if (!forDate(startDateObj) || !forDate(endDateObj)) {
			//rdShowMessageDialog("请按YYYYMMDD日期格式输入正确的日期！", 1);
			controlBtn(false);
			return false;
		} else if ((parseInt(endDateObj.value) - parseInt(startDateObj.value)) < 0) {
			rdShowMessageDialog("查询结束日期必须大于开始日期！", 1);
			controlBtn(false);
			return false;
		} else if (startDate < startDateLimit) {
			rdShowMessageDialog("查询区间必须在两个月内！", 1);
			controlBtn(false);
			return false;
		}
		
		document.frm.action = "fe067_main.jsp";
		document.frm.submit();
	}
	
	function closeWindow() {
		if(window.opener == undefined) {
			removeCurrentTab();
		} else {
			window.close();
		}
	}
</script>
</head>
<body>
<form name="frm" method="POST" >
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">输入查询条件</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
		<td colspan="3">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">开始时间 (格式YYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="startDate" id="startDate" value="<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>01" maxlength="8" v_must="1" v_type="0_9" v_format="yyyyMMdd"/>
		</td>
		<td class="blue" width="20%">结束时间 (格式YYYYMMDD)</td>
		<td width="30%">
			<input type="text" name="endDate" id="endDate" value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>" maxlength="8" v_must="1" v_type="0_9" v_format="yyyyMMdd"/>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="查询" onClick="doCfm(this)">    
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="closeWindow();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
