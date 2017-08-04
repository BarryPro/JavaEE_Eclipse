<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regionCode = (String) session.getAttribute("regCode");
  String workNo = (String) session.getAttribute("workNo");
  String ip_Addr = (String) session.getAttribute("ipAddr");
  String password = (String) session.getAttribute("password");
  String opCode = "m351";
  String phoneNo = (String)request.getParameter("phoneNo");
  String opNote = workNo+"对用户"+phoneNo+"进行了固话信息查询操作";
  String qPhoneNo = "";
  String qCustName = "";

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
	<wtc:service name="sm351Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6"	>
		<wtc:param value = "<%=printAccept%>"/>
		<wtc:param value = "01"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>		
		<wtc:param value = "<%=password%>"/>
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = "<%=phoneNo%>"/>
		<wtc:param value = "<%=opNote%>"/>
		
	</wtc:service>
	<wtc:array id="ret" scope="end" />
<%
  if("000000".equals(retCode)){
		if(ret.length>0){
		
			qPhoneNo = ret[0][0];
		  qCustName = ret[0][1];
		System.out.println("qPhoneNo====="+qPhoneNo);
		System.out.println(qCustName);		  

		}
	}
%>
var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
response.data.add("phoneNo", "<%=phoneNo%>");
response.data.add("qPhoneNo", "<%=qPhoneNo%>");
response.data.add("qCustName", "<%=qCustName%>");

core.ajax.receivePacket(response);