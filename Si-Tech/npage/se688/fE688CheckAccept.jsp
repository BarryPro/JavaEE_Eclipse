<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
String regCode=(String)session.getAttribute("regCode");

String iLoginAccept = 	"";/*0*/
String iChnSource 	= 	"02";/*1*/
String iOpCode 		= 	"e688";/*2*/
String iLoginNo 	= 	(String)session.getAttribute("workNo");/*3*/
String iLoginPwd 	=	(String)session.getAttribute("password");/*4*/
String iPhoneNo 	=  	request.getParameter("phoneNo");/*5*/
String iUserPwd 	= 	"";/*6*/

String iOldLoginAccept = request.getParameter("old_accept");
System.out.println("zhangyan~~~~~~~~~~~~iPhoneNo~~~~~~~~~~"+iPhoneNo);
%>

<wtc:service name="sCityChgInit" routerKey="regCode" routerValue="<%=regCode%>" 
	retcode="errCode" retmsg="errMsg"  outnum="7">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
		
	<wtc:param value="<%=iOldLoginAccept%>"/>
</wtc:service>
<wtc:array id="arrCityInOfferQry" scope="end" />
	
var arrE688=new Array;
<%
System.out.println("zhangyan arrE688 length="+arrCityInOfferQry.length);
if (arrCityInOfferQry.length!=0)
{
	for (int i=0;i<arrCityInOfferQry[0].length ; i++)
	{
	%>
	arrE688[<%=i%>]="<%=arrCityInOfferQry[0][i]%>";
	<%
	}
}
%>


var response = new AJAXPacket();
response.data.add("errorCode","<%=errCode%>");
response.data.add("errorMsg","<%=errMsg%>");
response.data.add("arrE688",arrE688);
core.ajax.receivePacket(response);