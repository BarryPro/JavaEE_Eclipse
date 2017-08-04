<% 
  /*
   * 功能: 垃圾短信与网管黑名单综合受理_添加
　 * 版本: v1.00
　 * 日期: 2010/03/23
　 * 作者: dujl
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
<title>垃圾短信与网管黑名单综合受理_添加</title>

<%
String opCode = "6945";
String opName = "垃圾短信与网管黑名单综合受理_添加";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String loginaccept = WtcUtil.repNull(request.getParameter("printAccept"));

System.out.println("#######################################phoneNo->" + phoneNo);
System.out.println("#######################################loginaccept->" + loginaccept);
%>

<script language=javascript>

onload=function()
{
	init();
}

function init()
{
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>举报处理</option><option value='02'>省内监控</option>");
}


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
	if(document.all.blackReason.value == "")
	{
		rdShowMessageDialog("操作原因不可为空！");
		return -3;
	}
	
	frm.submit();
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f6945Cfm.jsp">
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
	    		<!--<option value="" selected>请选择</option>   huangrong 备注 2011-6-21 -->
	    		<option value="A">添加为垃圾短信和黑名单用户</option>
	    	</select>
	    </td>
	    <td class="blue" width="10%" nowrap>延期标志</td>
	    <td class="blue" width="20%">
	    	<select name="delayType" id="delayType" class="button" >
	    		<!--<option value="" selected>请选择</option>   huangrong 备注 2011-6-21 -->
	    		<option value="N">关停7天</option>
	    		<option value="T" selected>长期关停</option><!--huangrong add 默认长期关停-->
	    	</select>
	    </td>	    
	</tr>
	           <TR id="bltys"  > 
	          <TD width="16%" class="blue">数据来源</TD>
              <TD colspan="5">
                 <select id="seled" name="seled" style="width:100px;">
									</select>

	          </TD>
	          </TR> 
	<tr>
	    <td class="blue" width="10%" nowrap>操作原因</td>
	    <td width="90%" class="blue" colspan="5">
	    	<input class="button" type="text" name="blackReason" id="blackReason" value="" size="140" maxlength="70">
	    	<!--huangrong add 修改页面展示样式，操作原因可输入70个汉字 2011-6-21 -->
	    </td>
	</tr>
	
    <tr>
        <td colspan="6" id="footer">
            <input class="b_foot" type="button" name="b_add" value="确认" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="返回" onClick="history.go(-1);">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="loginaccept" value="<%=loginaccept%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>