<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String called_no_agent = WtcUtil.repNull(request.getParameter("called_no_agent"));
  String transagent = "";
  String staffstatus = "";
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String params = "called_no_agent="+called_no_agent;
  String sqlStr = "select login_no,staffstatus from dstaffstatus where ccsworkno=:called_no_agent";
  String[][] retData = new String[][] {};
%>
  <wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=params%>"/>
  </wtc:service>
  <wtc:array id="queryList">
<%
  	retData = queryList;
%>
  </wtc:array>
<%
	if(retData.length > 0){
		transagent = retData[0][0];
		staffstatus = retData[0][1];
	}
%>
  var response = new AJAXPacket();
	response.data.add("transagent","<%=transagent%>");
	response.data.add("called_no_agent","<%=called_no_agent%>");
	response.data.add("staffstatus","<%=staffstatus%>");
	core.ajax.receivePacket(response);
