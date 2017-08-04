<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.f1236.ejb.*"%>
<%@ page import="com.sitech.boss.f1236.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%

String inputPass = request.getParameter("inputPass");
String customPass = request.getParameter("customPass");
//System.out.println(inputPass);
//System.out.println(customPass);
String newPass = Encrypt.encrypt(inputPass);
System.out.println(newPass);
String info = "0";
if(1==Encrypt.checkpwd1(customPass,newPass.trim())){
		info="1";
}

%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("backString","<%=info%>");
response.data.add("errCode","0");
response.data.add("errMsg","0");
response.data.add("flag","99");
core.ajax.receivePacket(response);
