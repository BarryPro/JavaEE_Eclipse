<%
  /*
   * ����: m245��ʵ��ʹ������Ϣ�޸� 
   * �汾: 1.0
   * ����: 2015/3/30 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String regionCode = (String) session.getAttribute("regCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    String phoneNo = (String)request.getParameter("phoneNo");
    String opNote = "�û�"+phoneNo+"������["+opName+"]�޸Ĳ���";
    String realUserIdType = (String)request.getParameter("realUserIdType");
    String realUserIccId = (String)request.getParameter("realUserIccId");
    String realUserName = (String)request.getParameter("realUserName");
    String realUserAddr = (String)request.getParameter("realUserAddr");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="sm245Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=printAccept%>"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value=""/>	
    <wtc:param value="<%=opNote%>"/>
    <wtc:param value="<%=realUserIdType%>"/>
    <wtc:param value="<%=realUserIccId%>"/>
    <wtc:param value="<%=realUserName%>"/>
    <wtc:param value="<%=realUserAddr%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script language="JavaScript">
			rdShowMessageDialog('������룺<%=retCode%><br>������Ϣ��<%=retMsg%>',0);
			window.location.href="fm245_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
	}else{
%>	
		<script language="JavaScript">
			rdShowMessageDialog("�޸ĳɹ���",2);
			window.location.href="fm245_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%}%>