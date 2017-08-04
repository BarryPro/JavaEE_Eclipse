<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:ningtn@2010-10-8 三码合一
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>二码合一</title>
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
		if(!check(frm)){
			return false;
		}
		if(!checkNo()){
			return false;
		}
		var startStr = $("#startTime").val().trim();
		var endStr   = $("#endTime").val().trim();
		if(endStr.length != 0){
			if(startStr.length == 0 || endStr < startStr){
				rdShowMessageDialog("开始时间与结束时间不正确",0);
				return false;
			}
		}else if(startStr.length != 0){
			if(endStr.length == 0 || endStr < startStr){
				rdShowMessageDialog("开始时间与结束时间不正确",0);
				return false;
			}
		}
		frameDiv.style.display="";
		frm.action="fb631_getMore.jsp?phoneNo=" + $("#phoneNo").val() 
		+ "&beginTime=" + $("#startTime").val() + "&endTime=" + $("#endTime").val();
		frm.target="ifm";
		frm.submit();
	}
	
	function closeDiv(){
		$("#frameDiv").hide();
	}
	
	function checkNo(){
		if(!checkElement($("#phoneNo")[0])){
			return false;
		}
		var queryWayObj = $("input[name='queryWay'][@checked]").val();
		if("0" == queryWayObj){
			//根据手机号码查询
			if(!forMobil($("#phoneNo")[0])){
				return false;
			}
		}else if("1" == queryWayObj){
			//根据IMEI码查询
		}
		return true;
	}
	
</script>
</head>
<body>

<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">二码合一</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">查询方式</td>
		<td>
			<input name="queryWay" id="queryWay" type="radio" value="0" checked onclick="checkNo()"/>手机号码 &nbsp;&nbsp;
			<input name="queryWay" id="queryWay" type="radio" value="1" onclick="checkNo()"/>IMEI码
		</td>
		<td class="blue">查询条件</td>
		<td>
			<input name="phoneNo" id="phoneNo" type="text" v_must="1" v_type="0_9" onblur="checkNo()" />
			<font class="orange">*</font>
		</td>
	</tr>
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
