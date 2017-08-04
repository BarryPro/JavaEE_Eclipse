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
String phoneNo = request.getParameter("phoneNo");

String loginAccept = request.getParameter("loginAccept");
String totalDate = request.getParameter("totalDate");

//ArrayList arr = F1244Wrapper.s1244Cfm(phoneNo,loginAccept,totalDate);
%>
<wtc:service name="s1244Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1244CfmCode" retmsg="s1244CfmMsg" outnum="23">
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="<%=loginAccept%>"/>
    <wtc:param value="<%=totalDate%>"/>
</wtc:service>
<wtc:array id="userInfo" scope="end" />
<%
String[][] errInfo = new String[][]{{s1244CfmCode,s1244CfmMsg}};

//String[][] userInfo = (String[][])arr.get(0);
//String[][] errInfo = (String[][])arr.get(1);


if(errInfo[0][1].equals("")){
errInfo[0][1] = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errInfo[0][0]));
if( errInfo[0][1].equals("null")){
errInfo[0][1] ="未知错误信息";
}
} 
//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//System.out.println(userInfo.length);
if(userInfo.length==0){


%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';


response.data.add("backString","");


response.data.add("flag","9");
response.data.add("errCode","<%=errInfo[0][0]%>");
response.data.add("errMsg","<%=errInfo[0][1]%>");


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
response.data.add("flag","0");



core.ajax.receivePacket(response);
<%}%>