<%
  /*
   * 功能: 关于“家庭合帐分享”业务需求
   * 版本: 1.0
   * 日期: 20110701
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
<title>家庭合账分享申请</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String printAccept = WtcUtil.repStr(request.getParameter("printAccept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String phone = WtcUtil.repStr(request.getParameter("activePhone"), "");
	String addMemberPhone = WtcUtil.repStr(request.getParameter("addMemberPhone"), "");
	
	String workNo = (String)session.getAttribute("workNo");
	
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====0==== main_card = " + phone);
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====1==== mem_num = " + addMemberPhone);
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====2==== pay_fee = ");
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====3==== theop_code = " + opCode);
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====4==== thework_no = " + workNo);
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====5==== op_flag = a");
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm====6==== stream = " + printAccept);
	
%>
	<wtc:service name="s7327Cfm" routerKey="phone" routerValue="<%=phone%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=phone%>"/>
		<wtc:param value="<%=addMemberPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="a"/>
		<wtc:param value="<%=printAccept%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
	
<%
	System.out.println("====wanghfa====fd977_cfm.jsp====s7327Cfm==== " + retCode1 + ", " + retMsg1);
	
	if ("000000".equals(retCode1)) {
	%>
		<script language="javascript">
			rdShowMessageDialog("业务办理申请成功！", 2);
			window.location = "fd977.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone%>";
		</script>
	<%
	} else {
	%>
		<script language="javascript">
			rdShowMessageDialog("s7327Cfm服务：<%=retCode1%>，<%=retMsg1%>", 0);
			window.location = "fd977.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone%>";
		</script>
	<%
	}
%>
