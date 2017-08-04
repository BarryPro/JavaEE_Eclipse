<%
/********************
 version v2.0
 ¿ª·¢ÉÌ: si-tech
 update hejw@2009-2-6
********************/
%>


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%


String inputPass = request.getParameter("inputPass");
String customPass = request.getParameter("customPass");
//System.out.println(inputPass);
//System.out.println(customPass);
String newPass =     Encrypt.encrypt(inputPass);
String info = "0";
if(Encrypt.checkpwd2(customPass,newPass.trim()) == 1){
info="1";
}




%>
var response = new AJAXPacket();
response.data.add("backString","<%=info%>");
response.data.add("errCode","0");
response.data.add("errMsg","0");
response.data.add("flag1","99");



core.ajax.receivePacket(response);
