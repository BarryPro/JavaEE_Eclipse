<%
  /*
   * ����: ���Ŀͻ�����
   * �汾: 1.0
   * ����: 2010/11/29
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100408 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******���ع��пؼ�ҳ KeeperClient ******** -->
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
	rdShowMessageDialog("�ύ�ɹ��� ",2);
    
    window.location="/npage/s1141/fb894_login.jsp?activePhone=<%=paraAray[0]%>&opCode=b894&opName=���Ŀͻ�����";
	</script>
<%
	}
	else{
		%>
		<script language="JavaScript">
	rdShowMessageDialog("���Ŀͻ�����ʧ��!(<%=errMsg%>",0);
	window.location="/npage/s1141/fb894_login.jsp?activePhone=<%=paraAray[0]%>&opCode=b894&opName=���Ŀͻ�����";
</script>
		<%
	}
%>
