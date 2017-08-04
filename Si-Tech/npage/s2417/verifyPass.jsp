
<%
/********************
 version v2.0
 ¿ª·¢ÉÌ si-tech
 update hejw@2009-2-8
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.f1236.ejb.*"%>
<%@ page import="com.sitech.boss.f1236.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String inputPass = request.getParameter("inputPass");
	String customPass = request.getParameter("customPass");
	//System.out.println(inputPass);
	//System.out.println(customPass);
	String newPass =     Encrypt.encrypt(inputPass);
	String info = "0";
	if(1==Encrypt.checkpwd2(customPass,newPass.trim())){
		info="1";
	}
%>
var response = new AJAXPacket();

response.data.add("backString","<%=info%>");
response.data.add("errCode","0");
response.data.add("errMsg","0");
response.data.add("flag","99");

core.ajax.receivePacket(response);
