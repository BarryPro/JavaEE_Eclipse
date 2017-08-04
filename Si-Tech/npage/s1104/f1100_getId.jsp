<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  	String retType = request.getParameter("retType");
    String region_code = request.getParameter("region_code"); 
    String idType = request.getParameter("idType");
    String oldId = request.getParameter("oldId"); 
    String newId = "";
    
    
    System.out.println("--------------------------------------f1100_getId.jsp----------------------------------------");
    System.out.println("----------------------idType------------------------"+idType);
    System.out.println("----------------------oldId-------------------------"+oldId);
    //retArray = callView.view_sPubgetId(region_code,idType,oldId);
%>
	<wtc:service name="spubGetId" routerKey="region" routerValue="<%=region_code%>" retCode="retCode1" retMsg="retMsg1" outnum="3" >
	<wtc:param value="<%=region_code%>"/>
	<wtc:param value="<%=idType%>"/>
	<wtc:param value="<%=oldId%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
  	String retCode = "999999";      
    String retMessage = "取客户ID服务未能成功";
    String retnewId = "";

		if(result!=null&&result.length>0){
	    retCode = result[0][0];      
	    retMessage = result[0][1];
	    retnewId = result[0][2];			
		} 
    System.out.println("# from f1100_getId.jsp -> id = " + retnewId);
		
		
%>
		var response = new AJAXPacket();
		var retType = "";
		var retCode = "";
		var retMessage = ""
		var retnewId = "";
		retType = "<%=retType%>";
		retCode = "<%=retCode%>";
		retMessage = "<%=retMessage%>";
		retnewId = "<%=retnewId%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		response.data.add("retnewId",retnewId);
		core.ajax.receivePacket(response);
