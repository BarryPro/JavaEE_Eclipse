<%
    /********************
     version v2.0
     开发商: si-tech
     *作者:sunzhe@2003-10-15  
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regionCode");
  	String retType = request.getParameter("retType");
    String region_code = WtcUtil.repNull(request.getParameter("region_code")); 
    String idType = request.getParameter("idType");
    String oldId = request.getParameter("oldId"); 
    String newId = "";
    //retArray = callView.view_sPubgetId(region_code,idType,oldId);
%>
		<wtc:service name="spubGetId" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
		<wtc:param value="<%=region_code%>"/>
		<wtc:param value="<%=idType%>"/> 
		<wtc:param value="<%=oldId%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
    String retCode = result.length>0?result[0][0]:"";      
    String retMessage = result.length>0?result[0][1]:"";
		String retnewId = result.length>0?result[0][2]:"";
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