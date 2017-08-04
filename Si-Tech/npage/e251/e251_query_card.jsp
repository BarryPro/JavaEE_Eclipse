<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.lang.*"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%
String phoneNo1 = request.getParameter("phoneNo1");
String phoneNo2 = request.getParameter("phoneNo2");
String newFlag = request.getParameter("newFlag");
//String czkkh = request.getParameter("czkkh");
String sql_query = "select to_char(sum(nvl(add_pay_money,0))) from wChargeCardMsg where phone_no1='?' and phone_no2='?' and to_char(op_time,'YYYYMMDD')>'20121118' ";
//String sql_query = "select to_char(sum(add_pay_money)) from wChargeCardMsg where phone_no2='?'  ";
%>
<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sql_query%></wtc:sql>
		<wtc:param value="<%=phoneNo1%>"/>
		<wtc:param value="<%=phoneNo2%>"/> 
	</wtc:pubselect>
<wtc:array id="resultName" scope="end" /> 
var response = new AJAXPacket();
<%
	String o_money = "";
	if(resultName.length>0)
	{
		o_money=resultName[0][0];
		%>response.data.add("flagMoney","1");<%
	}
	else
	{
		o_money="0";
		%>response.data.add("flagMoney","0");<%
	}
%>
//alert("111o_money is "+"<%=o_money%>"+" and newFlag is "+"<%=newFlag%>");
response.data.add("o_money","<%=o_money%>");
response.data.add("newFlag","<%=newFlag%>");

core.ajax.receivePacket(response);
 
