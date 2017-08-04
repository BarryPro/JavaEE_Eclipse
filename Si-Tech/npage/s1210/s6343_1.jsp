<%
  /* *********************
   * 功能:号码过户限制时间修改
   * 版本: 1.0
   * 日期: 2010/01/26
   * 作者: cangjin
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>号码过户限制时间修改</title>
<%
	String opCode = "6343";
	String opName = "号码过户限制时间修改";
	String workNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode"); 
	String regionCode = (String)session.getAttribute("regCode");
	
	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
	String ProCode_Str = WtcUtil.repNull(request.getParameter("ProCodeStr"));
	String beginTime = WtcUtil.repNull(request.getParameter("beginTime"));
	String total_date = "";

	System.out.println("activePhone======================"+activePhone);
	System.out.println("workNo==========================="+workNo);
	System.out.println("opCode==========================="+opCode);
	System.out.println("phoneNo=========================="+phoneNo);
	System.out.println("orgCode=========================="+orgCode);
	System.out.println("ProCode_Str======================"+ProCode_Str);
%>

<wtc:service name="s6342Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="initRetCode22" retmsg="initRetMsg22" outnum="9">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
</wtc:service>
<wtc:array id="initStr22" scope="end"/>
<%
	System.out.println("initRetCode==="+initRetCode22);
	System.out.println("initRetMsg==="+initRetMsg22);
	if(!(initRetCode22.equals("000000")))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("错误代码：<%=initRetCode22%>，错误信息：<%=initRetMsg22%>");
			window.location="s6343_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
		return;
	}
	total_date = initStr22[0][3];
%>


<wtc:service name="s6952Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="initRetCode" retmsg="initRetMsg" outnum="9">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=orgCode%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>
<%
	System.out.println("initRetCode==="+initRetCode);
	System.out.println("initRetMsg==="+initRetMsg);
	if(!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("<%=initRetMsg%>");
			window.location="s6343_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
		return;
	}
%>




<script language=javascript>

//----------------验证及提交函数-----------------
function doCfm()
{
	if(!check(document.frm)){
		return false;
	}
	frm.submit();
}

</script>
<body>
<form name="frm" method="POST" action="s6343_2.jsp">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
			<td>
				<input name="phoneNo" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phoneNo" maxlength="20" size="40">
			</td>
			<td class="blue">用户ID</td>
			<td>
				<input name="id_no" value="<%=initStr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="id_no" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">客户名称</td>
			<td>
				<input name="cust_name" value="<%=initStr[0][3]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" size="40">
			</td>
			<td class="blue">客户地址</td>
			<td>
				<input name="cust_address" value="<%=initStr[0][4]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_address" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
			<td>
				<input name="sm_name" value="<%=initStr[0][5]%>" type="text" class="InputGrey" v_must=1 readonly id="sm_name" maxlength="20" size="40">
			</td>
			<td class="blue">当前状态</td>
			<td>
				<input name="run_name" value="<%=initStr[0][6]%>" type="text" class="InputGrey" v_must=1 readonly id="run_name" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<input name="id_name" value="<%=initStr[0][7]%>" type="text" class="InputGrey" v_must=1 readonly id="id_name" maxlength="20" size="40">
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input name="id_iccid" value="<%=initStr[0][8]%>" type="text" class="InputGrey" v_must=1 readonly id="id_iccid" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">修改后的过户限制时间</td>
			<td>
				<input name="beginTime" value="<%=beginTime%>" type="text" class="InputGrey" v_must=1 readonly id="id_beginTime" maxlength="20" size="40">
			</td>
			<td class="blue">修改前的过户限制时间为</td>
			<td>
				<input name="beginTime" value="<%=total_date%>" type="text" class="InputGrey" v_must=1 readonly id="id_beginTime" maxlength="20" size="40">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
	</table>
	<table cellspacing="0">
		<tr>
			<td colspan="6" id="footer">
				<input class="b_foot" type="button" name="b_print" value="确认" onClick="doCfm()">&nbsp;
				<input class="b_foot" type="button" name="b_clear" value="返回" onClick="window.location.href='s6343_login.jsp?opCode=6343&opName=号码过户限制时间修改&activePhone=<%=activePhone%>';">
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
