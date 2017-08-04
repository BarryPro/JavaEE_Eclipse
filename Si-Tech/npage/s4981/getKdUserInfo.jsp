<%@ page contentType="text/html; charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
String loginAccept = request.getParameter("loginAccept");
String chnSource="001";
String opCode = request.getParameter("opCode")==null?"":request.getParameter("opCode");
String workNo = request.getParameter("workNo");
String passWd = request.getParameter("password");
String phoneNo = request.getParameter("phoneNo")==null?"":request.getParameter("phoneNo");
String cfmLogin = request.getParameter("cfmLogin")==null?"":request.getParameter("cfmLogin");


%>

<wtc:service name="s4981Init"  outnum="25" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:param value="<%=loginAccept%>"/>  
	<wtc:param value="<%=chnSource%>"/>  
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>   
	<wtc:param value="<%=passWd%>"/>                                                                                             
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>  
	<wtc:param value="<%=cfmLogin%>"/>  
	                                                                                              
</wtc:service>                                                
<wtc:array id="result" scope="end" /> 
<%
 System.out.println("retCode======="+retCode);
 System.out.println("retMsg======="+retMsg);
	if(retCode.equals("000000")){
%>
var response = new AJAXPacket();
var returnCode= "<%=retCode%>";
var returnMsg="<%=retMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("id_no","<%=result[0][0]%>");
response.data.add("Sm_code","<%=result[0][1]%>");
response.data.add("Sm_name","<%=result[0][2]%>");
response.data.add("Cust_name","<%=result[0][3]%>");
response.data.add("Run_code","<%=result[0][4]%>");
response.data.add("Run_name","<%=result[0][5]%>");
response.data.add("Modecode","<%=result[0][6]%>");
response.data.add("Modename","<%=result[0][7]%>");
response.data.add("Belongcode","<%=result[0][8]%>");
response.data.add("Cust_address","<%=result[0][9]%>");
response.data.add("vOpenDate","<%=result[0][10]%>");
response.data.add("Attname","<%=result[0][11]%>");
response.data.add("Detailaddr","<%=result[0][12]%>");
response.data.add("Cfmlogin","<%=result[0][13]%>");
response.data.add("Cfmpwd","<%=result[0][14]%>");
response.data.add("Areacode","<%=result[0][15]%>");
response.data.add("Areaname","<%=result[0][16]%>");
response.data.add("Phoneno","<%=result[0][17]%>");
response.data.add("Contractno","<%=result[0][18]%>");
response.data.add("RegionCode","<%=result[0][19]%>");
response.data.add("RegionName","<%=result[0][20]%>");
response.data.add("BandWidth","<%=result[0][21]%>");
core.ajax.receivePacket(response);
<%}else{
%>
var response = new AJAXPacket();
var returnCode= "<%=retCode%>";
var returnMsg="<%=retMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%}%>

 