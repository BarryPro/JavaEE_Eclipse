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
String opCode = "e459";     
String opName = "四喜号码营销方案配置修改";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");

String opNote = workNo + "进行进行四喜号码营销方案配置修改";
String projectType = request.getParameter("projectType");
String projectCode = request.getParameter("projectCode");
String offerId = request.getParameter("offerId");
String stopTime = request.getParameter("stopTime");

System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 7==== opNote = " + opNote);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 8==== regionCode = " + regionCode);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm==== 9==== projectType = " + projectType);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm====10==== projectCode = " + projectCode);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm====11==== offerId = " + offerId);
System.out.println("====wanghfa====fe459_cfm.jsp====se459Cfm====12==== expDate = " + stopTime);

%>
<wtc:service name="se459Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
	<wtc:param value="<%=stopTime%>"/>
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
