<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create by lipf 20120509
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
	public  String getCurrDateStr(String format) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				format);
		return objSimpleDateFormat.format(new java.util.Date());
	}
%>
<html>
<head>
<title>认证失败信息查询</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	request.setCharacterEncoding("GBK");
	String iAccount=request.getParameter("iAccount");
	String iPhoneNo=request.getParameter("iPhoneNo");
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	
%>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>

	
	$(document).ready(function(){
		
	});
	function doCfm(){ 
		s3216.action="f1600_sAccessLogQry_list.jsp";
    s3216.submit();	
	}
</script>
</head>
<body>

<form name="s3216" method="POST">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="f1600_sAccessLogQry_main">
  <input type="hidden" name="iAccount" value="<%=iAccount%>">
  <input type="hidden" name="iPhoneNo" value="<%=iPhoneNo%>">
<%@ include file="/npage/include/header.jsp" %>     	
<table cellspacing="0">
<tr>
    <td class="blue">查询类型</td>
    <td>
        <select name="iQeyType" style="width:230px">
        	<option value="1">查询指定账期最后一次认证失败信息</option>
        	<option value="2">查询指定账期最后一次认证成功信息</option>
        	<option value="3">查询指定账期最后一次认证信息</option>
        </select>
    </td>
		<td class="blue">查询账期</td>
    <td  nowrap >
		  <input  id="iCycle" name ="iCycle" type="text" readonly 
		  onfocus="WdatePicker({dateFmt:'yyyyMM',position:{top:'under'}});" 
		  value="<%=getCurrDateStr("yyyyMM")%>">
	    <img onclick="WdatePicker({el:$dp.$('iCycle'),dateFmt:'yyyyMM',position:{top:'under'}});" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" style="width:16px;height:22px" align="absmiddle">
	    <font color="orange">*</font>
	  </td>
</tr>

<tr>
    <td colspan="5" id="footer">
      <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}">
      <input class="b_foot" type=button name=back value="清除" onClick="s3216.reset()">
      <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
      <input class="b_foot" type=button name=qryPage value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
</tr>
</table>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>