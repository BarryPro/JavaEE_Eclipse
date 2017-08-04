<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

	String beizhu=workNo+"进行实际使用人证件数量校验";
	
	String g_CustId = WtcUtil.repNull((String)request.getParameter("g_CustId"));
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String sjsyzjhm = WtcUtil.repNull((String)request.getParameter("sjsyzjhm"));
	String sjsyzjlx = WtcUtil.repNull((String)request.getParameter("sjsyzjlx"));
	String phoness = WtcUtil.repNull((String)request.getParameter("phoness"));


  String  inputParsm [] = new String[18];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoness;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = g_CustId;
	inputParsm[9] = sjsyzjlx;
	inputParsm[10] = sjsyzjhm;


	
%>
	<wtc:service name="sActualUserChk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");

	core.ajax.receivePacket(response);