<%
  /*
   * 功能: 充值卡营销案转赠
   * 版本: 1.0
   * 日期: 20110908
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title></title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
String printAccept = WtcUtil.repStr(request.getParameter("printAccept"), "");
String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
String opName = WtcUtil.repStr(request.getParameter("opName"), "");
String phone = WtcUtil.repStr(request.getParameter("activePhone"), "");
String opNote = WtcUtil.repStr(request.getParameter("opNote"), "");
String prePayFee = WtcUtil.repStr(request.getParameter("prePayFee"), "");
String myFee = WtcUtil.repStr(request.getParameter("myFee"), "");
String toPhone1 = WtcUtil.repStr(request.getParameter("toPhone1"), "");
String toPhone2 = WtcUtil.repStr(request.getParameter("toPhone2"), "");
String toPhone3 = WtcUtil.repStr(request.getParameter("toPhone3"), "");
String toFee1 = WtcUtil.repStr(request.getParameter("toFee1"), "");
String toFee2 = WtcUtil.repStr(request.getParameter("toFee2"), "");
String toFee3 = WtcUtil.repStr(request.getParameter("toFee3"), "");
String toPhoneOld1 = WtcUtil.repStr(request.getParameter("toPhoneOld1"), "");
String toPhoneOld2 = WtcUtil.repStr(request.getParameter("toPhoneOld2"), "");
String toPhoneOld3 = WtcUtil.repStr(request.getParameter("toPhoneOld3"), "");

String tranPhoneStr = "";
String tranPhoneOldStr = "";
String tranFeeStr = "";
if (!"".equals(toPhone1)) {
	tranPhoneStr = tranPhoneStr + toPhone1;
	tranPhoneOldStr = tranPhoneOldStr + toPhoneOld1;
	tranFeeStr = tranFeeStr + toFee1;
}
if (!"".equals(toPhone2)) {
	if ("".equals(tranPhoneStr)) {
		tranPhoneStr = tranPhoneStr + toPhone2;
		tranPhoneOldStr = tranPhoneOldStr + toPhoneOld2;
		tranFeeStr = tranFeeStr + toFee2;
	} else {
		tranPhoneStr = tranPhoneStr + "|" + toPhone2;
		tranPhoneOldStr = tranPhoneOldStr + "|" + toPhoneOld2;
		tranFeeStr = tranFeeStr + "|" + toFee2;
	}
}
if (!"".equals(toPhone3)) {
	if ("".equals(tranPhoneStr)) {
		tranPhoneStr = tranPhoneStr + toPhone3;
		tranPhoneOldStr = tranPhoneOldStr + toPhoneOld3;
		tranFeeStr = tranFeeStr + toFee3;
	} else {
		tranPhoneStr = tranPhoneStr + "|" + toPhone3;
		tranPhoneOldStr = tranPhoneOldStr + "|" + toPhoneOld3;
		tranFeeStr = tranFeeStr + "|" + toFee3;
	}
}

String partInAccept = WtcUtil.repStr(request.getParameter("partInAccept"), "");
String projectCode = WtcUtil.repStr(request.getParameter("projectCode"), "");
String sGradeCode = WtcUtil.repStr(request.getParameter("sGradeCode"), "");

String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");
String ipAddr = (String)session.getAttribute("ipAddr");

System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====0==== iLoginAccept = " + printAccept);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====1==== iChnSource = 01");
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====5==== iPhoneNo = " + phone);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====6==== iUserPwd = ");
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====7==== iOpNote = " + opNote);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====8==== iAllFee = " + prePayFee);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm====9==== iMyFee = " + myFee);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===10==== iTranPhoneStr = " + tranPhoneStr);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===11==== iTranFeeStr = " + tranFeeStr);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===12==== iWinAccept = " + partInAccept);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===13==== iSProjectCode = " + projectCode);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===14==== iSGradeCode = " + sGradeCode);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===15==== iOldTranPhoneStr = " + tranPhoneOldStr);
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm===16==== iIpAddr = " + ipAddr);
%>
<wtc:service name="se257Cfm" routerKey="phone" routerValue="<%=phone%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=prePayFee%>"/>
	<wtc:param value="<%=myFee%>"/>
	<wtc:param value="<%=tranPhoneStr%>"/>
	<wtc:param value="<%=tranFeeStr%>"/>
	<wtc:param value="<%=partInAccept%>"/>
	<wtc:param value="<%=projectCode%>"/>
	<wtc:param value="<%=sGradeCode%>"/>
	<wtc:param value="<%=tranPhoneOldStr%>"/>
	<wtc:param value="<%=ipAddr%>"/>
</wtc:service>
<wtc:array id="result1"  scope="end"/>
<%
System.out.println("====wanghfa====fe258_cfm.jsp====se257Cfm==== " + retCode1 + ", " + retMsg1);

if ("000000".equals(retCode1)) {
	%>
	<script language="javascript">
		rdShowMessageDialog("业务办理申请成功！", 2);
		window.location = "fe257.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone%>";
	</script>
	<%
} else {
	%>
	<script language="javascript">
		rdShowMessageDialog("se257Cfm服务：<%=retCode1%>，<%=retMsg1%>", 0);
		window.location = "fe257.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone%>";
	</script>
	<%
}
%>
