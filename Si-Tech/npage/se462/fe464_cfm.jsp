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
String opNote = workNo + "进行四喜号码营销案取消";
String accept = request.getParameter("accept");
String ipAddr = (String)session.getAttribute("ipAddr");
String offerId = request.getParameter("offerId");

System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 0==== iLoginAccept = " + loginAccept);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 7==== opNote = " + opNote);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 8==== inOldAccept = " + accept);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 9==== inIpAddr = " + ipAddr);
System.out.println("====wanghfa====fe464_cfm.jsp====se464Cfm==== 9==== inOfferId = " + offerId);

%>
<wtc:service name="se464Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=accept%>"/>
	<wtc:param value="<%=ipAddr%>"/>
	<wtc:param value="<%=offerId%>"/>
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
