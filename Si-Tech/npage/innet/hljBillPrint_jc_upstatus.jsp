<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNo= (String)session.getAttribute("workNo");
	String login_accept= WtcUtil.repStr(request.getParameter("login_accept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String password = (String)session.getAttribute("password");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String billType = WtcUtil.repStr(request.getParameter("billType"), "");
	String opflag = WtcUtil.repStr(request.getParameter("opflag"), "");
	String opNote = WtcUtil.repStr(request.getParameter("opNote"), "");
	String begin_month = WtcUtil.repStr(request.getParameter("begin_month"), "");
	

%>
	<wtc:service name="sPrt_JprintCfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:param value="0"/>
		<wtc:param value="01"/>	
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/> 
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=billType%>"/>
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=opflag%>"/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=begin_month%>"/>

				
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
if("000000".equals(retCode)) {
		session.removeAttribute("loginacceptJT"); 
}
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    