 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%

	String regionCode= (String)session.getAttribute("regCode");
	String workNo = request.getParameter("workNo");	
	String phoneNo = request.getParameter("phoneNo");	
	String opCode = request.getParameter("opCode");	
	String orgCode = request.getParameter("orgCode");	
	//ArrayList arr = F2300Wrapper.callF2300Init(workNo,phoneNo,opCode,orgCode);
	%>		
	<wtc:service name="s2300Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="26" >
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=orgCode%>"/>		
	</wtc:service>
	<wtc:array id="userInfo"  scope="end"/>	
	<%	
	String retCode2=retCode1;
	String retMsg2=retMsg1;
	System.out.println("retMsg2============"+retMsg2);
	
 	if(retMsg2.equals("")){ 		
		retMsg2 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode2));
		if( retMsg2.equals("null")){			
			retMsg2 ="未知错误信息";
		}
	} 
	System.out.println("retMsg2============"+retMsg2);
if(userInfo.length==0){
%>
var response = new AJAXPacket();
response.data.add("backString","");
response.data.add("flag","9");
response.data.add("errCode",'<%=retCode2%>');
response.data.add("errMsg",'<%=retMsg2%>');

core.ajax.receivePacket(response);



<%

	
}else{
%>
<%
String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);

%>
<%=strArray%>
var userInfo;
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
	response.data.add("backString",userInfo);
	response.data.add("errCode",'<%=retMsg2%>');
	response.data.add("errMsg",'<%=retMsg2%>');
	response.data.add("flag","0");
	core.ajax.receivePacket(response);
<%
System.out.println("===========================================================");


}%>
