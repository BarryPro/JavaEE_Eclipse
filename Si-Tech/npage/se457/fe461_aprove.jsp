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
String opCode = "e461";
String opName = "四喜号码营销方案配置审批";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 
String opNote = workNo + "进行四喜号码营销方案配置审批";

int opNum = Integer.parseInt(request.getParameter("opNum"));

String accept = request.getParameterValues("accept")[opNum];
String isAuditPass = request.getParameter("isAuditPass");
String auditSuggestion = request.getParameter("auditSuggestionSub");

System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 7==== iOpNote = " + opNote);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 8==== accept = " + accept);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm==== 9==== isAuditPass = " + isAuditPass);
System.out.println("====wanghfa====fe461_delete.jsp====se461Cfm====10==== auditSuggestion = " + auditSuggestion);

%>
<wtc:service name="se461Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=accept%>"/>
	<wtc:param value="<%=isAuditPass%>"/>
	<wtc:param value="<%=auditSuggestion%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
if (!retCode.equals("000000")) {
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=opName%>失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>", 0);
	window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
} else {
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=opName%>成功！", 2);
	window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
}
%>
