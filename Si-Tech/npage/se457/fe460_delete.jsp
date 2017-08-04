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
String opCode = "e460";
String opName = "四喜号码营销方案配置删除";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");

String opNote = workNo + "进行进行四喜号码营销方案配置删除";
int opNum = Integer.parseInt(request.getParameter("opNum"));
String projectType = request.getParameterValues("projectType")[opNum];
String projectCode = request.getParameterValues("projectCode")[opNum];
String offerId = request.getParameterValues("offerId")[opNum];

System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 7==== opNote = " + opNote);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 8==== regionCode = " + regionCode);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm==== 9==== projectType = " + projectType);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm====10==== projectCode = " + projectCode);
System.out.println("====wanghfa====fe460_cfm.jsp====se460Cfm====11==== offerId = " + offerId);

%>
<wtc:service name="se460Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=projectType%>"/>
	<wtc:param value="<%=projectCode%>"/>
	<wtc:param value="<%=offerId%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
if (!retCode.equals("000000")) {
%>
<script language="JavaScript">
	rdShowMessageDialog("删除失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>", 0);
	window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
} else {
%>
<script language="JavaScript">
	rdShowMessageDialog("删除成功！", 2);
	window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
}
%>
