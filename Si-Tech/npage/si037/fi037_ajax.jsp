<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 
<%
String accept = request.getParameter("accept");
String chnSrc = request.getParameter("chnSrc");
String opCode = request.getParameter("opCode");
String workNo = request.getParameter("workNo");
String passwd = request.getParameter("passwd");
           
String phoNo = request.getParameter("phoNo");
String usrPwd = request.getParameter("usrPwd");
String v_qryChn = request.getParameter("v_qryChn");
String v_iccid = request.getParameter("v_iccid");
String v_qryAcc = request.getParameter("v_qryAcc");
         
String appr_rst = request.getParameter("appr_rst");
String errMsg = request.getParameter("errMsg");
String vName = request.getParameter("vName");
String vIdAddr = request.getParameter("vIdAddr");
String vIdDate = request.getParameter("vIdDate");

String regCode = ( String )session.getAttribute( "regCode" );
%>
<wtc:service name = "sI037Cfm" outnum = "30"
	routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm1" retmsg = "rm_cfm1" >
	<wtc:param value = "<%=accept%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = "<%=phoNo%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = "<%=v_qryChn%>"/>
	<wtc:param value = "<%=v_iccid%>"/>
	<wtc:param value = "<%=v_qryAcc%>"/>
		
	<wtc:param value = "<%=appr_rst%>"/>
	<wtc:param value = "<%=errMsg%>"/>
	<wtc:param value = "<%=vName%>"/>
	<wtc:param value = "<%=vIdAddr%>"/>
	<wtc:param value = "<%=vIdDate%>"/>					
</wtc:service>
<wtc:array id="rst" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=rc_cfm1 %>");
response.data.add("retMsg","<%=rm_cfm1 %>");
core.ajax.receivePacket(response);