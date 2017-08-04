<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String org_code = (String)session.getAttribute("orgCode");
	
	String opCode     =  request.getParameter("opCode");
  String op_strong_pwd = (String) session.getAttribute("password");
  String iPhoneNo = request.getParameter("iPhoneNo");
  String pageSize = request.getParameter("pageSize");
  String groupNo = request.getParameter("groupNo");
  String beginNo = request.getParameter("beginNo");
  String endNo   = request.getParameter("endNo");
  
  System.out.println("---liujian--3-" + "---pageSize=" + pageSize);
%>

	<wtc:service name="se767UnitQry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeUnitQry" retmsg="retMsgUnitQry" outnum="4">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
	</wtc:service>
	<wtc:array id="qryRes"  scope="end"/>


	<wtc:service name="se767Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="2">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupNo%>"/>
		<wtc:param value="<%=beginNo%>"/>
		<wtc:param value="<%=endNo%>"/>
		<wtc:param value="1"/>	
		<wtc:param value="<%=pageSize%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

	
<%
   if(retCodeUnitQry.equals("000000") && retCodeQry.equals("000000")) {
   	%>
   		var response = new AJAXPacket();
		response.data.add("retcode","000000");
		response.data.add("retmsg","导出申请记录成功，请到g079模块查询导出结果!");
		core.ajax.receivePacket(response);	
	<%
	}else {
		if(!retCodeUnitQry.equals("000000")) {
	%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%=retCodeUnitQry%>");
			response.data.add("retmsg","<%=retMsgUnitQry%>");
			core.ajax.receivePacket(response);	
	<%		
		}else {
		%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%=retCodeQry%>");
			response.data.add("retmsg","<%=retMsgQry%>");
			core.ajax.receivePacket(response);	
		<%	
		}
	}
%>
