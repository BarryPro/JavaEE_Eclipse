<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<%
String opCode="e687";
String opName="省内携号申请";
String iLoginAccept = 	"";/*0*/
String iChnSource 	= 	"01";/*1*/
String iOpCode 		= 	"e687";/*2*/
String iLoginNo 	= 	(String)session.getAttribute("workNo");/*3*/
String iLoginPwd 	=	(String)session.getAttribute("password");/*4*/
String iPhoneNo 	=  	request.getParameter("phoneNo");/*5*/
String iUserPwd 	= 	"";/*6*/

String iQryType = "2";/*7*/
String iGroupId	= "";/*8*/
String iOfferId	= "";/*9*/
String iSmCode	= "";/*10*/
String iNewOfferId	=request.getParameter("offerId");/*11*/
String regCode 	=	(String)session.getAttribute("regCode");/*4*/
System.out.println("zhangyan~~~~iPhoneNo~~~~~~~~~~~~~~~~~~~"+iPhoneNo);
%>
<wtc:service name="sCityInOfferQry" routerKey="regCode" routerValue="<%=regCode%>" 
	retcode="errCodeAttr" retmsg="errMsgAttr"  outnum="2">
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
<wtc:array id="arrAttrCode" scope="end" />

<%
System.out.println("zhangyan~~~~errCodeAttr~~~~~~~~~~~~~~~~~~~"+errCodeAttr);
System.out.println("zhangyan~~~~errMsgAttr~~~~~~~~~~~~~~~~~~~"+errMsgAttr);
System.out.println("zhangyan~~~~arrAttrCode.length~~~~~~~~~~~~~~~~~~~"+arrAttrCode.length);
if (!errCodeAttr.equals("000000"))
{
%>
<script>
	rdShowMessageDialog("<%=errCodeAttr%>"+":"+"<%=errMsgAttr%>",0);
	window.close();	
</script>
<%
}

if (arrAttrCode.length==0)
{
%>
<script>
	rdShowMessageDialog("该资费无小区代码",0);
	window.close();	
</script>
<%
}
%>	

<html>
<script>

function saveTo()
{
	window.returnValue = $("#attrCode").val();
	window.close();
}	
</script>
<body onkeydown="if(event.keyCode=='13')return false">
<div id="operation">
<FORM name="attrFm" action="" method=post>
<%@ include file="/npage/include/header_pop.jsp" %>	
<div id="operation_table">	
<DIV class="title"><div class="text">属性信息</div></DIV>	
<table>		
<tr>
	<td>属性信息</td>
	<td>
		<select id="attrCode" name="attrCode" style="width: 300px;" >
			<%
			for (int i=0; i<arrAttrCode.length; i++)
			{
			%>
				<option value="<%=arrAttrCode[i][0]%>">
					<%=arrAttrCode[i][0]%>--><%=arrAttrCode[i][1]%>
				</option>
			<%
			}
			%>
		</select>	
	</td>
</tr>	
<tr>
	<td colspan = "2" align = "center">
		<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
		&nbsp; 
		<input class="b_foot" name=back onClick="window.close()" type=button value="返回">		
	</td>
</tr>
</table>			
		
</div>
<%@ include file="/npage/include/footer_pop.jsp"%>
</FORM>
</DIV>
</BODY>
</HTML>
