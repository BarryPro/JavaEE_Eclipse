<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String workName = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);

String sPOOrderNumber = request.getParameter("p_POOrderNumber");
String OperationSubTypeIDRadio = request.getParameter("OperationSubTypeIDRadio");
System.out.println("====wanghfa==== sPOOrderNumber = " + sPOOrderNumber);
System.out.println("====wanghfa==== OperationSubTypeIDRadio = " + OperationSubTypeIDRadio);
%>
<wtc:service name="s9102DetQry" outnum="13" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=sPOOrderNumber%>"/>
	<wtc:param value="<%=OperationSubTypeIDRadio%>"/>
	<wtc:param value="8"/>
</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />
<wtc:array id="result0" start="3" length="4" scope="end" />
<wtc:array id="result1" start="7" length="3" scope="end" />
<wtc:array id="result2" start="10" length="3" scope="end" />
<%
	System.out.println("====wanghfa==== result[0][0] = " + result[0][0]);
	System.out.println("====wanghfa==== result1.length = " + result1.length);
	if (result0 != null && result0.length > 0) {
		for (int i = 0; i < result0.length; i ++) {
			%>
			addRow("poAttachmentMsg", "<%=result0[i][0]%>", "<%=result0[i][1]%>", "<%=result0[i][2]%>", "<%=result0[i][3]%>");
			<%
		}
		%>
		$("#poAttachmentMsg").slideDown(300);
		$("#poAttachment_switch").attr({src: "../../../nresources/default/images/jian.gif"});
		$("#poAttachment_switch").attr("state", "open");
		<%
	}
	System.out.println("====wanghfa==== result1.length = " + result1.length);
	if (result1 != null && result1.length > 0) {
		for (int i = 0; i < result1.length; i ++) {
			%>
			addRow("poAuditMsg", "<%=result1[i][0]%>", "<%=result1[i][1]%>", "<%=result1[i][2]%>");
			<%
		}
		%>
		$("#poAuditMsg").slideDown(300);
		$("#poAudit_switch").attr({src: "../../../nresources/default/images/jian.gif"});
		$("#poAudit_switch").attr("state", "open");
		<%
	}
	System.out.println("====wanghfa==== result2.length = " + result2.length);
	if (result2 != null && result2.length > 0) {
		for (int i = 0; i < result2.length; i ++) {
			%>
			addRow("contactorInfoMsg", "<%=result2[i][0]%>", "<%=result2[i][1]%>", "<%=result2[i][2]%>");
			<%
		}
		%>
		$("#contactorInfoMsg").slideDown(300);
		$("#contactorInfo_switch").attr({src: "../../../nresources/default/images/jian.gif"});
		$("#contactorInfo_switch").attr("state", "open");
		<%
	}
	%>
