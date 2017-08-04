<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName = WtcUtil.repNull((String)request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
  String opTimehw  = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String beizhu=phoneNo+"进行银行主号码签约校验";
	String idType = WtcUtil.repNull((String)request.getParameter("idType"));
	String idIccid = WtcUtil.repNull((String)request.getParameter("idIccid"));
	String custname = WtcUtil.repNull((String)request.getParameter("custname"));
	String yhbm = WtcUtil.repNull((String)request.getParameter("yhbm"));
	String yhzh = WtcUtil.repNull((String)request.getParameter("yhzh"));
	String yhzhlx = WtcUtil.repNull((String)request.getParameter("yhzhlx"));
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<%  
  String  inputParsm [] = new String[18];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = loginAccept;
	inputParsm[9] = opTimehw;
	inputParsm[10] = "01";
	inputParsm[11] = phoneNo;
	inputParsm[12] = idType;
	inputParsm[13] = idIccid;
	inputParsm[14] = custname;
	inputParsm[15] = yhbm;
	inputParsm[16] = yhzh;
	inputParsm[17] = yhzhlx;
	
%>
	<wtc:service name="sG940Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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
			<wtc:param value="<%=inputParsm[11]%>"/>
			<wtc:param value="<%=inputParsm[12]%>"/>
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>
			<wtc:param value="<%=inputParsm[16]%>"/>
			<wtc:param value="<%=inputParsm[17]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");

	core.ajax.receivePacket(response);