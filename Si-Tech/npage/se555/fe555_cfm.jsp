<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String opCode =  "e555";
	String jsonText = request.getParameter("jsonText");
	String[] jsons = new String[20];
	int start = 0;
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 7 = " + jsonText);
	for (int i = 0; i < (jsonText.length() / 100) + 1; i ++) {
		if (i == (jsonText.length() / 100)) {
			jsons[i] = jsonText.substring(start, jsonText.length());
		} else {
			jsons[i] = jsonText.substring(start, start + 100);
			start += 100;
		}
		System.out.println("====wanghfa====fe555_cfm.jsp====jsons["+i+"] = " + jsons[i]);
	}
	
	String opType = request.getParameter("opType");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 0 = 0");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 1 = 01");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 2 = e555");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 3 = " + workNo);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 4 = " + password);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 5 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 6 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 7 = " + jsonText);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 8 = " + opType);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 9 = " + realip);
%>
	<wtc:service name="se555Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="e555"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:params value="<%=jsons%>"/>
		<wtc:param value="<%=opType%>"/>
		<wtc:param value="<%=realip%>"/>
	</wtc:service>
<%
	//retMsg = retMsg.replaceAll(System.getProperty("line.separator")," ");
	if("000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交成功！", 2);
			location="fe555.jsp";
		</script>
<%
	} else {
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交失败！se555Cfm，<%=retCode1%>，<%=retMsg1%>", 0);
			location="fe555.jsp";
		</script>
<%
	}
%>
