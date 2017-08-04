<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String oldno = WtcUtil.repNull((String)request.getParameter("oldno"));
	String newno = WtcUtil.repNull((String)request.getParameter("newno"));
	String opFlag = WtcUtil.repNull((String)request.getParameter("opFlag"));
	String moneys="";
	String numss="";
 
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<%  
  String  inputParsm [] = new String[18];
	inputParsm[0] = oldno;
	inputParsm[1] = newno;
	inputParsm[2] = "";
	inputParsm[3] = opFlag;

	
%>
	<wtc:service name="s3075InitBat" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if(retCode.equals("000000")) {
	if(ret.length>0) {
		 moneys=ret[0][2];
		 numss=ret[0][3];
	}
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	response.data.add("moneys","<%=moneys%>");
	response.data.add("numss","<%=numss%>");

	core.ajax.receivePacket(response);