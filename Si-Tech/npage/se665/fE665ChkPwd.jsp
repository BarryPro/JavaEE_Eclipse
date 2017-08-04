<%
/*
 * 功能: 密码校验
 * 版本: 1.0
 * 日期: 2012/3/5 17:34:50
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%	
//得到输入参数
String custId 	= request.getParameter("custId");
String Pwd1 		= request.getParameter("unitCustPwd");
String regCode	=	request.getParameter("regCode");
String retResult= "false";

String sqlStr 	= "select cust_passwd from dCustDoc where cust_id = " 
	+ custId;
%>
<wtc:pubselect name="sPubSelect"	outnum="1"
	routerKey	="region" 			routerValue	="<%=regCode%>"
	retcode		="retCode1" 		retmsg			="retMsg1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
	String cust_passwd = "";
	if(result.length > 0 && retCode1.equals("000000"))
	{
		cust_passwd = (result[0][0]).trim();
	}
	Pwd1 = Encrypt.encrypt(Pwd1);
	Pwd1=Pwd1.trim();
	if (Encrypt.checkpwd2(cust_passwd,Pwd1) == 1)
	{
		retResult = "true";
	}
%>
var response = new AJAXPacket();
var retMessage1	="<%=retMsg1%>";
var retCode1		="<%=retCode1%>";
var retResult	 	="<%=retResult%>";

response.data.add("retResult",retResult);
response.data.add("retCode",retCode1);
response.data.add("retMessage",retMessage1);
core.ajax.receivePacket(response);
