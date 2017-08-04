<%
    /*************************************
    * 功  能: m282
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: gaopeng @ 2015/3/27 14:31:11
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("gaopengSeeLog===m282====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regCode = (String)session.getAttribute("regCode");
		
		String czLoginAccept = request.getParameter("czLoginAccept");
		String czStringCode = request.getParameter("czStringCode");
		
		
		String printAccept = request.getParameter("printAccept");
		
		String zddm = "0";
		String opNote = "工号："+workNo+"进行"+opCode+"操作";
		
		String retCode11 = "";
		String retMsg11 = "";
		
		
		
		try{
%>

<wtc:service name="sm336Cfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value=""/>
	  
	  
	  <wtc:param value="<%=czStringCode%>"/>
	  <wtc:param value="<%=czLoginAccept%>"/>
	  
	  
	</wtc:service>
	
<wtc:array id="result1"  scope="end"/>

	
var infoArray = new Array();


<%
	
	retCode11 = retCode;
	retMsg11 = retMsg;
	
	

}catch(Exception e){
	e.printStackTrace();
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
core.ajax.receivePacket(response);
