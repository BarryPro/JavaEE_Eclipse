<%
/********************
 version v1.0
������: si-tech
create by haoyy 2010-11-04
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%
	    String opCode = "b857";
        String opName = "WLAN��̬�����޸�";

		String work_no = (String)session.getAttribute("workNo");
		String ipAddr = (String)session.getAttribute("ipAddr");
		String group_id = (String)session.getAttribute("group_id");
		String password = (String)session.getAttribute("password");
		String regionCode=(String)session.getAttribute("regCode");

		String phone  = request.getParameter("phone"); 	   // �û�����
	    String BizType  = request.getParameter("BizType"); // ҵ������
	    String oldPass  = request.getParameter("oldPass"); // ԭ����
	    String newPass  = request.getParameter("newPass"); // ������

%>
	<wtc:service name="sb857Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=BizType%>"/>
		<wtc:param value="<%=oldPass%>"/>
		<wtc:param value="<%=newPass%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg  = retMsg;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("�����޸ĳɹ���",2);
	window.location="/npage/s9387/fb857.jsp?opCode=b857&opName=WLAN��̬�����޸�";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=errCode%>    <%=errMsg%>",0);
	window.location="/npage/s9387/fb857.jsp?opCode=b857&opName=WLAN��̬�����޸�";
</script>
<%}%>


