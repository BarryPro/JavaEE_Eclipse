<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String groupId = (String)session.getAttribute("groupId");	 
String regionCode = (String)session.getAttribute("regCode");

String iLoginAccept=""; /*操作流水*/
String iChnSource=""; /*渠道标识*/
String iOpCode="6998"; /*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo"); /*操作工号*/
String iLoginPwd=(String)session.getAttribute("password"); /*工号密码*/
String iPhoneNo=""; /*手机号码*/
String iUserPwd=""; /*用户密码*/
String iOpType = request.getParameter("opType");/*操作代码 I,U,D*/
String iSystemFlag = request.getParameter("kfFlag"); /*系统标识*/
String iRoleCode  = request.getParameter("roleCode");/*角色代码*/
String iRoleName = request.getParameter("roleName"); /*角色名称*/
String iFunctionCode = request.getParameter("opCodej"); /*操作代码*/
String iPwdFlag = request.getParameter("passFlag"); /*密码校验标志 */
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