<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	String phoneNo = request.getParameter("phone_no");
	String resCode = "";
	String groupId = "";
	System.out.println(".............................phoneNo=="+phoneNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="2">
		<wtc:sql>select resource_code,group_id from dCustRes where phone_no='?'</wtc:sql> 
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:pubselect>	
	<wtc:array id="rows2" >
<%
	System.out.println(retCode + "==retCode.............................retMsg=="+retMsg);
	 if(retCode.equals("000000")){
	 	resCode = rows2[0][0];
	 	groupId = rows2[0][1];
	 }
%>
 	</wtc:array>	

var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("resCode","<%=resCode%>");
response.data.add("groupId","<%=groupId%>");
core.ajax.receivePacket(response);