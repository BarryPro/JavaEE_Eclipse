<%
  /*
   * 功能: 核心客户回馈
   * 版本: 1.0
   * 日期: 2010/11/29
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%
String phoneNo = request.getParameter("phoneNo");
String iOpCode = request.getParameter("iOpCode");
String loginNo = request.getParameter("loginNo");
String ProjectCode = request.getParameter("projectType");
String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
String paraAray[] = new String[4];
paraAray[0] = phoneNo;
paraAray[1] = iOpCode;
paraAray[2] = loginNo;
paraAray[3] = ProjectCode;
System.out.println(phoneNo+loginNo+iOpCode+ProjectCode);
%>
<wtc:service name="sb894Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
	
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("提交成功！ ",2);
    
    window.location="/npage/s1141/fb894_login.jsp?activePhone=<%=paraAray[0]%>&opCode=b894&opName=核心客户回馈";
	</script>
<%
	}
	else{
		%>
		<script language="JavaScript">
	rdShowMessageDialog("核心客户回馈失败!(<%=errMsg%>",0);
	window.location="/npage/s1141/fb894_login.jsp?activePhone=<%=paraAray[0]%>&opCode=b894&opName=核心客户回馈";
</script>
		<%
	}
%>
