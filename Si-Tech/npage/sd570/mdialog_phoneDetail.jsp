<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:wanghfa@2010-8-25 购多部TD固话
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>确认副用户</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","No-cache");
	response.setDateHeader("Expires", 0);
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	
  String phoneNo = request.getParameter("phoneNo");
  String password = (String)session.getAttribute("password");
  String phoneType = request.getParameter("phoneType");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String comboType = request.getParameter("comboType");
  String newOfferId = request.getParameter("newOfferId");
	String result[] = new String[12];

	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====0==== inLoginAccept = 0");
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====1==== iChnSource = 01");
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====3==== inLoginNo = " + workNo);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====5==== inPhone = " + phoneNo);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====6==== inUserPwd = ");
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====7==== IPhoneType = " + phoneType);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====8==== iIpAddr = " + ipAddr);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init====9==== comboType = " + comboType);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init===10==== iNewOfferid = " + newOfferId);
	
	%>
		<wtc:service name="sd570Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=phoneType%>"/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=comboType%>"/>
			<wtc:param value="<%=newOfferId%>"/>
		</wtc:service>
		<wtc:array id="result1"  scope="end"/>
	<%
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init==== retCode1 = " + retCode1);
	System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init==== retMsg1 = " + retMsg1);
	
	if (retCode1.equals("000000")) {
		System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init==== result1.length = " + result1.length);
		if (result.length > 0) {
			for (int j = 0; j < result1[0].length; j ++) {
				System.out.println("====wanghfa====mdialog_phoneDetail.jsp====sd570Init==== result1[0]["+j+"] = " + result1[0][j]);
				result[j] = result1[0][j];
			}
		}
	}
%>



</head>
<script language="javascript">
	window.returnValue = 'n';
	var opCode = window.dialogArguments.getElementById("opCode").value;
	var opName = window.dialogArguments.getElementById("opName").value;
	if ("<%=retCode1%>" != "000000") {
		window.returnValue = "n|sd570Init服务：<%=retCode1%>，<%=retMsg1%>";
		window.close();
	}
	window.onload = function() {
		
	}
	
	function cfm() {
		window.returnValue="y|<%=result[2]%>|<%=phoneNo%>|<%=result[0]%>--<%=result[1]%>|<%=result[3]%>";
		window.close();
	}
</script>
<body>
<input type="hidden" id='opCode' name='opCode' value="<%=opCode%>">
<input type="hidden" id='opName' name='opName' value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">确认副用户</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=phoneNo%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			客户名称
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" value="<%=result[2]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			客户地址
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=result[3]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			品牌名称
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[6]%>" readonly>
		</td>
		<td class="blue" width="20%">
			<%=result[4]%>
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" value="<%=result[5]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			当前积分
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[10]%>" readonly>
		</td>
		<td class="blue" width="20%">
			当前余额
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" value="<%=result[11]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			当前主资费
		</td>
		<td colspan="3">
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="60" value="<%=result[0]%>--<%=result[1]%>" readonly>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td colspan="3" id="footer">
			<input class="b_foot" type="button" name="subPertain" value="确定" onClick="cfm();">
			<input class="b_foot" type="button" name="closePertain" value="关闭" onClick="window.close();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</body>
</html>
