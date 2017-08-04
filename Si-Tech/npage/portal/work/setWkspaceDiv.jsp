<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%-- 工作区设置  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String wkspace_id = request.getParameter("wkspace_id")==null?"":request.getParameter("wkspace_id");
	
	//是否选中标识，1为选中，0为取消
	String checked = request.getParameter("checked")==null?"":request.getParameter("checked");	
	 %>
		<wtc:service name="sDwkSpaceSet" outnum="0" routerKey="region" routerValue="<%=regionCode%>">
		  <wtc:param value="0"/>
		  <wtc:param value="<%=workNo%>"/>
		  <wtc:param value="<%=wkspace_id%>"/>	
		  <wtc:param value="<%=checked%>"/>	
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e486" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="我的工作区设置" />
		</wtc:service>
		<%
			System.out.println("setWkspaceDiv.jsp---------retcode==="+retCode);
			System.out.println("setWkspaceDiv.jsp---------retMsg==="+retMsg);
		%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
	
