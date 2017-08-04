<% 
  /*
   * 功能: 垃圾短信与网管黑名单综合受理_网间号码查询_添加
　 * 版本: v1.00
　 * 日期: 2012/05/16
　 * 作者: diling
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>垃圾短信与网管黑名单综合受理_网间号码查询_添加</title>

<%
String opCode = "e851";
String opName = "垃圾短信与网管黑名单综合受理_网间号码查询_添加";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));

System.out.println("#######################################phoneNo->" + phoneNo);
%>

<script language=javascript>

function confirm()
{
	if(document.all.opType.value == "")
	{
		rdShowMessageDialog("操作类型不可为空！");
		return -1;
	}
	if(document.all.delayType.value == "")
	{
		rdShowMessageDialog("延期标志不可为空！");
		return -2;
	}
	frm.submit();
}

function goBack(){
  window.location.href="f6945_netsPhoneNoQry.jsp?phoneNo=<%=phoneNo%>";
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f6945_netsPhoneNoQryCfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="10%" nowrap>手机号码</td>
	    <td class="blue" width="20%">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="30" readonly>
	    </td>
	    <td class="blue" width="10%" nowrap>操作类型</td>
	    <td class="blue" width="20%">
	    	<select name="opType" id="opType" class="button" >
	    		<option value="A">添加为网间黑名单用户</option>
	    	</select>
	    </td>
	    <td class="blue" width="10%" nowrap>延期标志</td>
	    <td class="blue" width="20%">
	    	<select name="delayType" id="delayType" class="button" >
	    		<option value="N">关停7天</option>
	    		<option value="T" selected>长期关停</option>
	    	</select>
	    </td>	    
	</tr>
    <tr>
        <td colspan="6" id="footer">
            <input class="b_foot" type="button" name="b_add" value="确认" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="返回" onClick="goBack()">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>