<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-22 ҳ�����,�޸���ʽ
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String groupId = (String)session.getAttribute("groupId");	 
String regionCode = (String)session.getAttribute("regCode");

String iLoginAccept=""; /*������ˮ*/
String iChnSource=""; /*������ʶ*/
String iOpCode="6998"; /*��������*/
String iLoginNo=(String)session.getAttribute("workNo"); /*��������*/
String iLoginPwd=(String)session.getAttribute("password"); /*��������*/
String iPhoneNo=""; /*�ֻ�����*/
String iUserPwd=""; /*�û�����*/
String iOpType = request.getParameter("opType");/*�������� I,U,D*/
String iSystemFlag = request.getParameter("kfFlag"); /*ϵͳ��ʶ*/
String iRoleCode  = request.getParameter("roleCode");/*��ɫ����*/
String iRoleName = request.getParameter("roleName"); /*��ɫ����*/
String iFunctionCode = request.getParameter("opCodej"); /*��������*/
String iPwdFlag = request.getParameter("passFlag"); /*����У���־ */
System.out.println("zhangyan@page=[ajaxAdd.jsp]iPwdFlag=["+iPwdFlag+"]");
%>		
<wtc:service name="s6998Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" 
	retcode="errCode" retmsg="errMsg"  outnum="8">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iOpType%>"/>
	<wtc:param value="<%=iSystemFlag%>"/>
	<wtc:param value="<%=iRoleCode%>"/>
	<wtc:param value="<%=iRoleName%>"/>
	<wtc:param value="<%=iFunctionCode%>"/>
	<wtc:param value="<%=iPwdFlag%>"/>
</wtc:service>
<wtc:array id="arrS6998Cfm" scope="end" />
var vArrS6998Qry = new Array();
<%
System.out.println("zhangyan@page=[ajaxAdd.jsp]errCode=["+errCode+"]");
System.out.println("zhangyan@page=[ajaxAdd.jsp]errMsg=["+errMsg+"]");
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);