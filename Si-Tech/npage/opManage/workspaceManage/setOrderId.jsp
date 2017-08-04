<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>

<%-- 新增、修改、删除工作区模块操作  --%>

<%
		String divid = request.getParameter("divid")==null?"":request.getParameter("divid");
		String roleid = request.getParameter("roleid")==null?"":request.getParameter("roleid");
		String orderid = request.getParameter("orderid")==null?"":request.getParameter("orderid");
		String regionCode = (String)session.getAttribute("regCode");
		System.out.println("------------divid-------------"+divid);
		System.out.println("------------roleid------------"+roleid);
		System.out.println("------------orderid-----------"+orderid);
		
%>			
			<wtc:service name="sSetwkOrderId" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
				<wtc:param value="<%=divid%>" />
				<wtc:param value="<%=roleid%>" />
				<wtc:param value="<%=orderid%>" />
			</wtc:service>
			
			var response = new AJAXPacket();
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	

