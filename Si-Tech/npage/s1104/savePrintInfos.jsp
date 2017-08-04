<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      String regCode = (String)session.getAttribute("regCode");	
        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
        String path = request.getParameter("path");
        String sOrderArrayId = request.getParameter("sOrderArrayId");
        String opcode = request.getParameter("opcode");
        String optype = request.getParameter("optype");
        
        String printinfoquery="";
        
        System.out.println("hejwa1104---------------------->sOrderArrayId==="+sOrderArrayId+"===");
        System.out.println("hejwa1104---------------------->path==="+path+"===");

%>
<wtc:service name="sPrintInfoOpr" outnum="1"  routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opcode%>" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=path%>" />
			<wtc:param value="<%=sOrderArrayId%>" />
			<wtc:param value="<%=optype%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
		if("000000".equals(retCode)) {
			System.out.println("baseArr.length==="+baseArr.length);
			 if(baseArr.length>0) {
			 		printinfoquery=baseArr[0][0];
			 		System.out.println("printinfoquery==="+printinfoquery);
			 }
		}
		
		
		System.out.println("-------hejwa1104-------------printinfoquery------------>"+printinfoquery);
%>

var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("printinfoquery","<%=printinfoquery%>");

core.ajax.receivePacket(response);
