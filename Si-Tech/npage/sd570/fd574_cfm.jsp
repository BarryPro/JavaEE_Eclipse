<%
/********************
 version v2.0
 开发商: si-tech
 模块: 取消欢乐家庭
 create by wanglma 20110518
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>

<%
	String work_no = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	String opName = "取消欢乐家庭";
	String opCode = request.getParameter("opCode");
    String phoneNo = request.getParameter("phoneNo");
    String phonePrice = request.getParameter("phonePrice");
    /* 流水 */
    String printAccept="";
    printAccept = getMaxAccept();

%>
	<wtc:service name="sd574Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=passWord%>"/>
	<wtc:param value="<%=phoneNo%>"/><!--成员号码-->
	<wtc:param value=""/><!--成员号码密码-->
	<wtc:param value="取消欢乐家庭"/><!--操作日志-->
	<wtc:param value="<%=phonePrice%>"/><!--补手机款-->
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

<%
	String errCode = retCode;
	String errMsg = retMsg;
	if ("000000".equals(errCode))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("业务办理成功!",2);
   window.location="fd570.jsp?opCode=d574&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("业务办理失败！errCode:<%=retCode%>   errMsg:<%=retMsg%>",0);
	window.location="fd570.jsp?opCode=d574&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%}%>
