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
String iOpCode 		= 	"e687";/*2*/
String iLoginNo 	= 	(String)session.getAttribute("workNo");/*3*/
String iLoginPwd 	=	(String)session.getAttribute("password");/*4*/
String iPhoneNo 	=  	request.getParameter("phoneNo");/*5*/
String iUserPwd 	= 	"";/*6*/

String iQryType = "0";/*7*/
String iGroupId	= request.getParameter("groupId");/*8*/
String iOfferId	= request.getParameter("curOfferId");/*9*/
String iSmCode	= request.getParameter("smCode");/*10*/
String iNewOfferId	="";/*11*/

System.out.println("@zhangyan~~~~iGroupId="+iGroupId);
%>

<wtc:service name="sCityInOfferQry" routerKey="regCode" routerValue="<%=regCode%>" 
	retcode="errCodeGetOffer" retmsg="errMsgGetOffer"  outnum="4">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
		
	<wtc:param value="<%=iQryType%>"/>
	<wtc:param value="<%=iGroupId%>"/>
	<wtc:param value="<%=iOfferId%>"/>
	<wtc:param value="<%=iSmCode%>"/>
	<wtc:param value="<%=iNewOfferId%>"/>
</wtc:service>
<wtc:array id="arrCityInOfferQry" scope="end" />

var offers=new Array(); 
<%

for (int i=0; i<arrCityInOfferQry.length ; i++)
{
%>
	offers["<%=i%>"]=new Array(); 
	<%
	for (int j=0 ; j<arrCityInOfferQry[i].length ; j++)
	{
	%>
		offers["<%=i%>"]["<%=j%>"]="<%=arrCityInOfferQry[i][j]%>"; 
	<%
	}
}%>    
var response = new AJAXPacket();
response.data.add("errorCode","<%=errCodeGetOffer%>");
response.data.add("errorMsg","<%=errMsgGetOffer%>");
response.data.add("offers",offers);
core.ajax.receivePacket(response);