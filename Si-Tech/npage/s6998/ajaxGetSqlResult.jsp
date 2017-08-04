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

String iFunctionCode=(String)request.getParameter("opCode"); /*操作代码*/
String iSystemFlag=(String)request.getParameter("kfFlag"); /*系统标识*/
String iPwdFlag=(String)request.getParameter("pasFlag"); /*密码校验标志*/

%>		
<wtc:service name="s6998Qry" routerKey="regionCode" routerValue="<%=regionCode%>" 
	retcode="errCode" retmsg="errMsg"  outnum="8">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iFunctionCode%>"/>
	<wtc:param value="<%=iSystemFlag%>"/>
	<wtc:param value="<%=iPwdFlag%>"/>
</wtc:service>
<wtc:array id="arrS6998Qry" scope="end" />
var vArrS6998Qry = new Array();
<%
System.out.println("zhangyan@page=[ajaxGetSqlResult.jsp]arrS6998Qry.length=["+arrS6998Qry.length+"]");
/*把tux服务返回的二维数组查询结果导入到js二维数组中*/
for (int i=0; i<arrS6998Qry.length; i++)
{
%>

	vArrS6998Qry[<%=i%>]=new Array();
	<%
	for ( int j=0; j<arrS6998Qry[i].length; j++ )
	{
		if ( arrS6998Qry[i][j]!=null )
		{
		%>
			vArrS6998Qry[<%=i%>][<%=j%>]="<%=arrS6998Qry[i][j]%>";
		<%
		}
	}
}
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("vArrS6998Qry",vArrS6998Qry);
core.ajax.receivePacket(response);