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
String iChnSource="01" ; /*渠道类型*/
String iOpCode =request.getParameter("opCode"); /*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo") ;/*操作工号*/ 
String iLoginPwd=(String)session.getAttribute("password"); /*工号密码*/
String iPhoneNo ="";/*手机号码*/
String iUserPwd ="";/*手机密码*/

String sInContractNo=request.getParameter("contract_no");/*集团产品帐户号码 */
String sInOpNote=request.getParameter("force_reason");/*强制开或关原因*/
String sLinkMan=request.getParameter("contact_name");/*  联系人姓名*/
String sLinkPhone=request.getParameter("contact_phone");/*  联系人电话*/
String sBeginTime=request.getParameter("vBeginTime");/*强制开或关开始时间*/
String sEndTime=request.getParameter("vEndTime");/*  强制开或关结束时间*/

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


