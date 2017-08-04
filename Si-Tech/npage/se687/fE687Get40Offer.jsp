<%
/*
 * 功能: 携号转网 查可选资费,特服等
 * 版本: 1.0
 * 日期: 2012/3/14 14:13:50
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
String iChnSource 	= 	"01";/*1*/
String iOpCode 		= 	"e687";/*2*/
String iLoginNo 	= 	(String)session.getAttribute("workNo");/*3*/
String iLoginPwd 	=	(String)session.getAttribute("password");/*4*/
String iPhoneNo 	=  	request.getParameter("phoneNo");/*5*/
String iUserPwd 	= 	"";/*6*/

String iQryType = "1";/*7*/
String iGroupId	= request.getParameter("groupId");/*8*/
String iOfferId	= request.getParameter("curOfferId");/*9*/
String iSmCode	= request.getParameter("smCode");/*10*/
String iNewOfferId	=request.getParameter("offerId");/*11*/

%>
<wtc:service name="sCityInOfferQry" routerKey="regCode" routerValue="<%=regCode%>" 
	retcode="errCodeGetOffer" retmsg="errMsgGetOffer"  outnum="9">
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
<wtc:array id="arr40Offer" scope="end" />

var offers=new Array(); 
<%
System.out.println("zhangyan~~~~~~arr40Offer.length~~~~~~~~"+arr40Offer.length);

System.out.println("zhangyan~~~~errCodeGetOffer"+errCodeGetOffer);
System.out.println("zhangyan~~~~errMsgGetOffer"+errMsgGetOffer);

for (int i=0; i<arr40Offer.length ; i++)
{
%>
	offers["<%=i%>"]=new Array(); 
	<%
	for (int j=0 ; j<arr40Offer[i].length ; j++)
	{
			System.out.println("zhangyan~~~~~~~~arr40Offer["+i+"]["+j+"]~~~~~~"+arr40Offer[i][j]);

	%>
		offers["<%=i%>"]["<%=j%>"]="<%=arr40Offer[i][j]%>"; 
	<%
	}
}%>    


var response = new AJAXPacket();
response.data.add("errorCode","<%=errCodeGetOffer%>");
response.data.add("errorMsg","<%=errMsgGetOffer%>");
response.data.add("offers" , offers);
core.ajax.receivePacket(response);