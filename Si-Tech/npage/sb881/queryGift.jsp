<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String orgCode = (String) session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0, 2);
  
  String op_code =  request.getParameter("op_code");
  String itemid =  request.getParameter("codes");//ÀñÆ·±àÂë
	String phone_no =  request.getParameter("phone_no");
	String user_pass =  request.getParameter("user_pass");
	String retType = request.getParameter("retType");
	String hs = request.getParameter("hs");
	
	
	String itemPoints="";
	String itemState="";
	String itemNumber="";
	String custRegCode = request.getParameter( "custRegCode" );
	String custDisCode = request.getParameter( "custDisCode" );
%>
<wtc:service name="sItemCheck" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value=" "/>
	<wtc:param value="01"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=workNo%>"/>	  	
	<wtc:param value="<%=password%>"/>	  	
	<wtc:param value="<%=phone_no%>"/>	  	
	<wtc:param value="<%=user_pass%>"/>		
	<wtc:param value="<%=itemid%>"/>		
	<wtc:param value = "<%=custRegCode%>" />		
	<wtc:param value = "<%=custDisCode%>" />		
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
 System.out.println("retCode======================"+retCode);
  System.out.println("retMsg======================"+retMsg);
	if(retCode.equals("000000"))
  {
		if(result.length>0)
		{
		itemPoints=result[0][0];
		itemState=result[0][1];
		itemNumber=result[0][2];
		
		System.out.println("_____________________________________________---"+itemNumber);
		}
  }
String cd=result.length+"";
%>	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("hs","<%=hs%>");
response.data.add("itemPoints","<%=itemPoints%>");
response.data.add("itemState","<%=itemState%>");
response.data.add("itemNumber","<%=itemNumber%>");
response.data.add("cd","<%=cd%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMsg%>");
core.ajax.receivePacket(response);


