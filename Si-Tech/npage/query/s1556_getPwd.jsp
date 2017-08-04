<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.25
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
		 String retFlag="";
		 String retInfo = "";
	   String retType = request.getParameter("retType");
	   String passTrans=request.getParameter("passwd"); 
     String sqlStr = request.getParameter("sqlStr");
     String orgCode = (String)session.getAttribute("orgCode");
     String regionCode = orgCode.substring(0,2);
     //String regionCode=request.getParameter("regionCode");
     System.out.println("111111 GetPwd Begin+++++");
     System.out.println("++++++ sqlStr +++++"+sqlStr);     
%>

<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage" outnum="1">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
System.out.println(retCode+"   :   "+retMessage);
if(retCode.equals("000000") && result.length > 0)
{
  retInfo = result[0][0]; 
  System.out.println("222222"+retInfo);
}
else
{
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMessage = "查询密码信息失败!<br>retCode: " + retCode + "<br>retMessage: " + retMessage;
	}
}		
String passFromPage=Encrypt.encrypt(passTrans);
if(0==Encrypt.checkpwd2(retInfo.trim(),passFromPage)){
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	 	 retMessage = "密码错误!";
	}
} 
System.out.println("33333333 GetPwd End+++++");   
System.out.println("44444444 retFlag+++++"+retFlag);           
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var retInfo = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retFlag = "<%=retFlag%>";
retMessage = "<%=retMessage%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retFlag",retFlag);
core.ajax.receivePacket(response);

