<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String loginAccept = request.getParameter("loginAccept");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 
//String activePhone = request.getParameter("activePhone");
String opNote = workNo + "进行四喜号码营销案冲正";
String backAccept = request.getParameter("backAccept");
String ipAddr = (String)session.getAttribute("ipAddr");

System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 0==== iLoginAccept = " + loginAccept);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 7==== opNote = " + opNote);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 8==== inOldAccept = " + backAccept);
System.out.println("====wanghfa====fe463_cfm.jsp====se463Cfm==== 9==== inIpAddr = " + ipAddr);

%>
<wtc:service name="se463Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=backAccept%>"/>
	<wtc:param value="<%=ipAddr%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
if (!retCode.equals("000000")) {
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=opName%>失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>", 0);
	window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
</script>
<%
} else {
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=opName%>成功！", 2);
	window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
</script>
<%
}
%>
