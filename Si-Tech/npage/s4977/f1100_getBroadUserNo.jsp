<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String retType = request.getParameter("retType");
    System.out.println("1111111111111111");
	  String loginAccept = request.getParameter("loginAccept");
	  String chnSource = request.getParameter("chnSource");
	  String opCode = request.getParameter("opCode");
	  String loginNo = request.getParameter("loginNo");
	  String loginPwd = request.getParameter("loginPwd");
	  String phoneNo = request.getParameter("phoneNo");
	  String userPwd = request.getParameter("userPwd");
	  String region_code=request.getParameter("region_code");
	  String bandId=request.getParameter("band_id");	  
    String phoneNo_h = "";
%>

<wtc:service name="sGetBroadUserNo" outnum="3" routerKey="region" routerValue="<%=region_code%>">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="<%=chnSource%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=userPwd%>"/>
	<wtc:param value="<%=bandId%>"/>		
	</wtc:service>
<wtc:array id="result" start="0" length="3" scope="end" />

<%if (result!=null && result.length > 0 ){
     phoneNo_h =  result[0][0]; 
}
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var phoneNo_h = "";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMsg%>";
phoneNo_h = "<%=phoneNo_h%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("phoneNo_h",phoneNo_h);
core.ajax.receivePacket(response);