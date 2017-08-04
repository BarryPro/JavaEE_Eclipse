<%
    /*************************************
    * 功  能: sm263
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: gaopeng @ 2015/3/27 14:31:11
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===sm263====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		
		String cOpCode = request.getParameter("cOpCode");
		String regionNo = WtcUtil.repNull(request.getParameter("regionNo"));
		
		
		String retCode11 = "";
		String retMsg11 = "";
		String function_code = "";
		String function_name = "";
		
		try{
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name="sm263Qry" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=cOpCode%>"/>
	  <wtc:param value="<%=regionNo%>"/>
	  
	</wtc:service>
<wtc:array id="result0" start="0" length="2"  scope="end"/>	
<wtc:array id="result1" start="2" length="6" scope="end"/>
<wtc:array id="result3" start="8" length="2" scope="end"/>
	
var infoArray = new Array();


<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	if(result3.length > 0 && "000000".equals(retCode)){
		function_code = result3[0][0];
		function_name = result3[0][1];
	}
	if(result1.length > 0 && "000000".equals(retCode)){
		for(int i=0;i<result1.length;i++){
			%>
				infoArray[<%=i%>] = new Array();
				<%
					for(int j=0;j<result1[i].length;j++){
						%>
						infoArray[<%=i%>][<%=j%>] = "<%=result1[i][j]%>";
						<%
						System.out.println("gaopengSeeLog====sm263====infoArray["+i+"]["+j+"]====="+result1[i][j]);
					}
				%>
				
			<%
		}
	}
	

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
	%>
	var infoArray = new Array();
	<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("function_code","<%=function_code%>");
response.data.add("function_name","<%=function_name%>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);
