<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo   = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String oprIp    = (String)session.getAttribute("ipAddr");
		String regionCode = (String)session.getAttribute("regCode");
		
		String phonNo   = (String)request.getParameter("phone_no");  
		String opType   = (String)request.getParameter("opr_type");  
		String oprfunccode   = (String)request.getParameter("opr_funccode");  
		String oprRecode   = (String)request.getParameter("opr_recode");  
		String recodeIds   = (String)request.getParameter("recodeId");  
		
		
		System.out.println("--------------phonNo-------------ng35----------"+phonNo);
		System.out.println("--------------opType-------------ng35----------"+opType);
		System.out.println("--------------oprfunccode--------ng35----------"+oprfunccode);
		System.out.println("--------------oprRecode----------ng35----------"+oprRecode);
		System.out.println("--------------recodeIds----------ng35----------"+recodeIds);
		
%>
	<wtc:service name="sOprInfoReCode" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=workName%>" />
		<wtc:param value="<%=oprIp%>" />					
		<wtc:param value="<%=phonNo%>" />			
		<wtc:param value="<%=opType%>" />				
		<wtc:param value="<%=oprfunccode%>" />					
		<wtc:param value="<%=oprRecode%>" />					
		<wtc:param value="<%=recodeIds%>" />						
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>		
<%
	String recodeId = "";
	if(result_t.length>0){
		recodeId = result_t[0][0];
	}
	System.out.println("------------------recodeId-------ng35--------"+recodeId);
%>		
var response = new AJAXPacket();
response.data.add("recodeId","<%=recodeId%>");
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);
