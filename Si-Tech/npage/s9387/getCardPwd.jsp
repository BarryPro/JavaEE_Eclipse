<%
/********************
 version v1.0
开发商: si-tech
作者:jianglei
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%	    
	String CardPwd = "";
	String sq1="select 123456 from dual";     
%>
<wtc:pubselect name="sPubSelect" routerKey="region" retcode="retCode" retmsg="retMessage" outnum="1">
<wtc:sql><%=sq1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
System.out.println("retCode="+retCode);
if(retCode.equals("000000")&&result.length>0){
	retCode="000000";
	CardPwd=result[0][0];			
}
System.out.println("-----CardPwd---------"+CardPwd);
%>
var response = new AJAXPacket();
var retCode = "";
var retMessage = "";
var CardPwd="";

retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
CardPwd="<%=CardPwd%>";
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("CardPwd",CardPwd);
core.ajax.receivePacket(response);