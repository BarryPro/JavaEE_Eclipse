<%
  /*
   * 功能: m245·实际使用人信息修改 
   * 版本: 1.0
   * 日期: 2015/3/30 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regionCode = (String) session.getAttribute("regCode");
  String workNo = (String) session.getAttribute("workNo");
  String ip_Addr = (String) session.getAttribute("ipAddr");
  String password = (String) session.getAttribute("password");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String phoneNo = (String)request.getParameter("phoneNo");
  String opNote = "用户"+phoneNo+"进行了["+opName+"]操作";
  String qPhoneNo = "";
  String qCustName = "";
  String qRealUserName = "";
  String qRealUserAddr = "";
  String qRealUserIdType = "";
  String qRealUserIccId = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
	<wtc:service name="sm245Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6"	>
		<wtc:param value = "<%=printAccept%>"/>
		<wtc:param value = "01"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=password%>"/>
		<wtc:param value = "<%=phoneNo%>"/>
		<wtc:param value = ""/>
		<wtc:param value = "<%=opNote%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end" />
<%
  if("000000".equals(retCode)){
		if(ret.length>0){
			qPhoneNo = ret[0][0];
		  qCustName = ret[0][1];
		  qRealUserIdType = ret[0][2];
		  qRealUserIccId = ret[0][3];
		  qRealUserName = ret[0][4];
		  qRealUserAddr = ret[0][5];
		}
	}
%>
var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("qPhoneNo", "<%=qPhoneNo%>");
response.data.add("qCustName", "<%=qCustName%>");
response.data.add("qRealUserIdType", "<%=qRealUserIdType%>");
response.data.add("qRealUserIccId", "<%=qRealUserIccId%>");
response.data.add("qRealUserName", "<%=qRealUserName%>");
response.data.add("qRealUserAddr", "<%=qRealUserAddr%>");
core.ajax.receivePacket(response);