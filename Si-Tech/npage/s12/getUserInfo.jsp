<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
String kuandaizhanghao = request.getParameter("phoneNo");

String loginAccept = request.getParameter("loginAccept");
String totalDate = request.getParameter("totalDate");
String workNo = (String)session.getAttribute("workNo");
String regionCode= (String)session.getAttribute("regCode");
String password = (String)session.getAttribute("password");
String beizhu=workNo+"进行宽带发票补打";

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAcceptss" />
<wtc:service name="sm123Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s1244CfmCode" retmsg="s1244CfmMsg" outnum="27">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="m123"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=beizhu%>"/>
		<wtc:param value="<%=kuandaizhanghao%>"/>
		<wtc:param value="<%=totalDate%>"/>
</wtc:service>
<wtc:array id="userInfo" scope="end" />
<%
String[][] errInfo = new String[][]{{s1244CfmCode,s1244CfmMsg}};



if(errInfo[0][1].equals("")){
errInfo[0][1] = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errInfo[0][0]));
if( errInfo[0][1].equals("null")){
errInfo[0][1] ="未知错误信息";
}
} 

if(userInfo.length==0){


%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';


response.data.add("backString","");


response.data.add("flag","9");
response.data.add("errCode","<%=errInfo[0][0]%>");
response.data.add("errMsg","<%=errInfo[0][1]%>");
response.data.add("loginAcceptss","<%=loginAcceptss%>");

core.ajax.receivePacket(response);



<%
	


	
}else{

%>
<%
String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);

%>
<%=strArray%>
<%

for(int i = 0 ; i < userInfo.length ; i ++){
      for(int j = 0 ; j < userInfo[i].length ; j ++){


%>

userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
<%
}
}
%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("backString",userInfo);
response.data.add("errCode","<%=errInfo[0][0]%>");
response.data.add("errMsg","<%=errInfo[0][1]%>");
response.data.add("loginAcceptss","<%=loginAcceptss%>");
response.data.add("flag","0");




core.ajax.receivePacket(response);
<%}%>