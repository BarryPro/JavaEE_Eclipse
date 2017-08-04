<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%

//SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();
//ArrayList  inputParam = new ArrayList();
//String     outList[][] = new String [][]{{"0","32"}};
//String  [][] userInfo = new String[][]{};

//String  errCode = "";
//String  errMsg = "";

String workNo = request.getParameter("workNo");
String phoneNo = request.getParameter("phoneNo");
String opCode = request.getParameter("opCode");
String orgCode = request.getParameter("orgCode");


//inputParam.add(workNo);
//inputParam.add(phoneNo);
//inputParam.add(opCode);
//inputParam.add(orgCode);

//ArrayList arr = callWrapper.callFXService("s1236Init",inputParam,"4",outList);

//String[][] errInfo = (String[][])arr.get(1);
//errCode = String.valueOf(callWrapper.getErrCode());
//errMsg = callWrapper.getErrMsg();
%>
<wtc:service name="s1236Init" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" outnum="32" retmsg="errMsg" retcode="errCode">
	<wtc:param value=" " />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>" />
	<wtc:param value=" " />	
	<wtc:param value="<%=phoneNo%>" />
    <wtc:param value=" " />	
	<wtc:param value="<%=orgCode%>"/>
</wtc:service>
<wtc:array id="userInfo" scope="end" />
<%
for(int i=0;i<userInfo.length;i++){
	for(int j=0;j<userInfo[i].length;j++){
		System.out.println("userInfo["+i+"]["+j+"]"+userInfo[i][j]);
	}
}
System.out.println(errCode);
System.out.println(errMsg);

if(!errCode.equals("000000")&&!errCode.equals("0") ){
	
%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("backString","");
response.data.add("flag","9");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");

core.ajax.receivePacket(response);

<%

}else{
//userInfo = (String[][])arr.get(0);
System.out.println("yyyyyyyyyyyyy");
%>
<%
String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);

%>
<%=strArray%>
<%
for(int i = 0 ; i < userInfo.length ; i ++){
      for(int j = 0 ; j < userInfo[i].length ; j ++){
		//System.out.println("["+i+"]["+j+"]: " + userInfo[i][j]);
%>

userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
<%
}
}
%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("backString",userInfo);
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("flag","0");

core.ajax.receivePacket(response);
<%}%>
