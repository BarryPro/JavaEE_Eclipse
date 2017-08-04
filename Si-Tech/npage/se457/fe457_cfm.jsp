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
String opCode = request.getParameter("opCode");;
String opName = request.getParameter("opName");;
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 
String loginAccept = request.getParameter("loginAccept");
String projectTypeSel = request.getParameter("projectTypeSel");
String fileName = request.getParameter("fileName");
String fileNo = request.getParameter("fileNo");
String auditPhone = request.getParameter("auditPhone");
String auditName = request.getParameter("auditName");
String beginTime = request.getParameter("beginTime");
String stopTime = request.getParameter("stopTime");

String projectType = "";
String projectTypeName = "";
if ("one".equals(projectTypeSel)) {
	projectType = request.getParameter("projectType");
	projectTypeName = "";
} else if ("two".equals(projectTypeSel)) {
	projectType = request.getParameter("projectTypeAdd");
	projectTypeName = request.getParameter("projectNameAdd");
}
String projectCode = request.getParameter("projectCode");
String projectName = request.getParameter("projectName");
String leastPrepay = request.getParameter("leastPrepay");
String offerId = request.getParameter("offerId");
String expDate = request.getParameter("expDate") + " 23:59:59";
String workNoMem1 = request.getParameter("workNoMem1");
String workNoMem2 = request.getParameter("workNoMem2");
String activeNote = request.getParameter("activeNote");

System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 0==== iLoginAccept = " + loginAccept);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 7==== iProjectTypeSel = " + projectTypeSel);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 8==== iFileName = " + fileName);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm==== 9==== iFileNo = " + fileNo);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====10==== iAuditPhone = " + auditPhone);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====11==== auditName = " + auditName);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====12==== iBeginTime = " + beginTime);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====13==== iEndTime = " + stopTime);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====14==== iProjectType = " + projectType);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====15==== iProjectName = " + projectTypeName);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====16==== iProjectCode = " + projectCode);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====17==== iProjectName = " + projectName);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====18==== least_prepay = " + leastPrepay);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====19==== offer_id = " + offerId);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====20==== exp_date = " + expDate);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====21==== iWorkNoMem1 = " + workNoMem1);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====22==== iWorkNoMem2 = " + workNoMem2);
System.out.println("====wanghfa====fe457_cfm.jsp====se457Cfm====23==== activeNote = " + activeNote);
%>
<wtc:service name="se457Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=projectTypeSel%>"/>
	<wtc:param value="<%=fileName%>"/>
	<wtc:param value="<%=fileNo%>"/>
	<wtc:param value="<%=auditPhone%>"/>
	<wtc:param value="<%=auditName%>"/>
	<wtc:param value="<%=beginTime%>"/>
	<wtc:param value="<%=stopTime%>"/>
	<wtc:param value="<%=projectType%>"/>
	<wtc:param value="<%=projectTypeName%>"/>
	<wtc:param value="<%=projectCode%>"/>
	<wtc:param value="<%=projectName%>"/>
	<wtc:param value="<%=leastPrepay%>"/>
	<wtc:param value="<%=offerId%>"/>
	<wtc:param value="<%=expDate%>"/>
	<wtc:param value="<%=workNoMem1%>"/>
	<wtc:param value="<%=workNoMem2%>"/>
	<wtc:param value="<%=activeNote%>"/>
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
