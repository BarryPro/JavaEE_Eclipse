<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%-- ����������  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String wkspace_id = request.getParameter("wkspace_id")==null?"":request.getParameter("wkspace_id");
	
	//�Ƿ�ѡ�б�ʶ��1Ϊѡ�У�0Ϊȡ��
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
      <wtc:param value="�ҵĹ���������" />
		</wtc:service>
		<%
			System.out.println("setWkspaceDiv.jsp---------retcode==="+retCode);
			System.out.println("setWkspaceDiv.jsp---------retMsg==="+retMsg);
		%>
		var response = new AJAXPacket();
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
	
