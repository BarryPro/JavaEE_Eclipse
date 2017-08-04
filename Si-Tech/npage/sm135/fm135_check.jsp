<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%


	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");

  String phoneNo = request.getParameter("phoneNo");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String loginAccept = request.getParameter("loginAccept");
  String groupId = (String)session.getAttribute("groupId");
	String workPwd = (String)session.getAttribute("password");
 String iofferid = WtcUtil.repNull((String)request.getParameter("iofferid"));

 String imeino = WtcUtil.repNull((String)request.getParameter("imeino"));
  
 String  inputParsm [] = new String[9];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = workPwd;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = imeino;
	inputParsm[8] = "0";
%>

	<wtc:service name="sOfferImeiCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=iofferid%>"/>

	</wtc:service>

	<wtc:array id="result22" scope="end"/>
	
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");

core.ajax.receivePacket(response);
