<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String regionCode = (String)session.getAttribute("regCode");
String netcode=request.getParameter("netcode");
String phoneno=request.getParameter("phoneno");
String loginNo=request.getParameter("loginNo");
String[] paraArray = new String[8];
paraArray[0] = "";
paraArray[1] = "";
paraArray[2] = "";
paraArray[3] = loginNo;
paraArray[4] = "";
paraArray[5] = "";
paraArray[6] = "";
paraArray[7]= netcode;

int callDataNum = 0;
%>
<wtc:service  name="se916Qry"  routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode" retmsg="retMsg" outnum="21">
	<wtc:param  value="<%=paraArray[0]%>"/>	
    <wtc:param  value="<%=paraArray[1]%>"/>
    <wtc:param  value="<%=paraArray[2]%>"/>
    <wtc:param  value="<%=paraArray[3]%>"/>
    <wtc:param  value="<%=paraArray[4]%>"/>
    
    <wtc:param  value="<%=paraArray[5]%>"/>
    <wtc:param  value="<%=paraArray[6]%>"/>
    <wtc:param  value="<%=paraArray[7]%>"/>
</wtc:service>
<wtc:array  id="callData" scope="end"/>	
<%
	if(callData!=null&&callData.length>0){
			callDataNum = callData.length;	
	} 
	
	String stringArray = WtcUtil.createArray("arrMsg",callDataNum);
	
	System.out.println("test001=="+callData.length);

%> 
	<%=stringArray%>
<%

if(callDataNum>0){
	for(int i = 0 ; i < callData.length ; i ++){
	  for(int j = 0 ; j < callData[i].length ; j ++){

			if(callData[i][j] == null ||callData[i][j].trim().equals("") ){
			   callData[i][j] = "";
			}
%>
			arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
	  }
	}
	}
%>  
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","kdInfo");
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("backArrMsg",arrMsg );

core.ajax.receivePacket(response);
