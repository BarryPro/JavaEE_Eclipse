<%
/*
zhangyan@2012-10-10 15:11:43
*/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String regCode	=(String)session.getAttribute("regCode");

String iLoginAccept=request.getParameter("loginAccept");
String iChnSource="01" ; /*��������*/
String iOpCode =request.getParameter("opCode"); /*��������*/
String iLoginNo=(String)session.getAttribute("workNo") ;/*��������*/ 
String iLoginPwd=(String)session.getAttribute("password"); /*��������*/
String iPhoneNo ="";/*�ֻ�����*/
String iUserPwd ="";/*�ֻ�����*/

String sInContractNo=request.getParameter("contract_no");/*���Ų�Ʒ�ʻ����� */
String sInOpNote=request.getParameter("force_reason");/*ǿ�ƿ����ԭ��*/
String sLinkMan=request.getParameter("contact_name");/*  ��ϵ������*/
String sLinkPhone=request.getParameter("contact_phone");/*  ��ϵ�˵绰*/
String sBeginTime=request.getParameter("vBeginTime");/*ǿ�ƿ���ؿ�ʼʱ��*/
String sEndTime=request.getParameter("vEndTime");/*  ǿ�ƿ���ؽ���ʱ��*/

%>
<wtc:service name="sg176Cfm" 
	routerKey="region" routerValue="<%=regCode%>" 
	retmsg="rmE787Cfm" retcode="rcE787Cfm" outnum="1">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
		
	<wtc:param value="<%=sInContractNo%>"/>
	<wtc:param value="<%=sInOpNote%>"/>
	<wtc:param value="<%=sLinkMan%>"/>
	<wtc:param value="<%=sLinkPhone%>"/>
	<wtc:param value="<%=sBeginTime%>"/>
	<wtc:param value="<%=sEndTime%>"/>
</wtc:service>
<wtc:array id="rstE787Cfm" scope="end" />	
<%
if (rcE787Cfm.equals("000000"))
{
%>
<script>
	rdShowMessageDialog("<%=rmE787Cfm%>" , 2);
	removeCurrentTab();
</script>
<%
}
else
{
%>
<script>
	rdShowMessageDialog("<%=rcE787Cfm%>:<%=rmE787Cfm%>" , 1);
	removeCurrentTab();
</script>
<%
}
%>


