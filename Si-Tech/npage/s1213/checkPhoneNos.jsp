<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

	
	
	String yewuphoneno = WtcUtil.repNull((String)request.getParameter("yewuphoneno"));
	String zhuanfeiphoneno = WtcUtil.repNull((String)request.getParameter("zhuanfeiphoneno"));
	String lianxiphonno = WtcUtil.repNull((String)request.getParameter("lianxiphonno"));
	
	String beizhu=yewuphoneno+"进行授权销户校验";


  String  inputParsm [] = new String[18];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = "1216";
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = yewuphoneno;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = "Y";
	inputParsm[9] = zhuanfeiphoneno;
	inputParsm[10] = lianxiphonno;


	
%>
	<wtc:service name="s1216Chk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
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