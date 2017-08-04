<%
  /*
   * 功能: 全国直管客户信息查询 1993
   * 版本: 1.0
   * 日期: 2014-10-28
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<% 
	String directManageCustNo = WtcUtil.repStr(request.getParameter("directManageCustNo"), "");
	String groupNo = WtcUtil.repStr(request.getParameter("groupNo"), "");
	String institutionName = WtcUtil.repStr(request.getParameter("institutionName"), "");
	String directManageCustName = WtcUtil.repStr(request.getParameter("directManageCustName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	
	String regCode = (String)session.getAttribute("regCode");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password = WtcUtil.repNull((String)session.getAttribute("password"));
	String v_directManageCustNo = "";
	String v_groupNo = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sDirCustMsgQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=directManageCustNo%>"/>
		<wtc:param value="<%=institutionName%>"/>
		<wtc:param value="<%=groupNo%>"/>
		<wtc:param value="<%=directManageCustName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
  if(retCode.equals("000000")) {
  	if(ret.length > 0){
  		for(int i=0;i<ret.length;i++){
  			v_directManageCustNo = ret[i][0];
  			v_groupNo = ret[i][5];
  		}
  	}
  }
%>

var response = new AJAXPacket();

response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("v_directManageCustNo","<%=v_directManageCustNo%>");
response.data.add("v_groupNo","<%=v_groupNo%>");
core.ajax.receivePacket(response);

