<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- �������޸ġ�ɾ������  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
  String workNo = (String)session.getAttribute("workNo");
  
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String wkName = request.getParameter("wkName")==null?"":request.getParameter("wkName");
		String wkField = request.getParameter("wkField")==null?"":request.getParameter("wkField");
		String wkShow = request.getParameter("wkShow")==null?"":request.getParameter("wkShow");	
	
		//���ú�̨����������Ӳ���
		%>
		<wtc:service name="sDcommOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="" />
			<wtc:param value="<%=wkCode%>" />
			<wtc:param value="<%=wkName%>" />
			<wtc:param value="<%=wkField%>" />
			<wtc:param value="<%=wkShow%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e487" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="������ͨѶ����" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String wkSeq = request.getParameter("wkSeq")==null?"":request.getParameter("wkSeq");
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String wkName = request.getParameter("wkName")==null?"":request.getParameter("wkName");
		String wkField = request.getParameter("wkField")==null?"":request.getParameter("wkField");
		String wkShow = request.getParameter("wkShow")==null?"":request.getParameter("wkShow");
		
		//���ú�̨��������޸Ĳ���
		
		%>
		<wtc:service name="sDcommOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=wkSeq%>" />
			<wtc:param value="<%=wkCode%>" />
			<wtc:param value="<%=wkName%>" />
			<wtc:param value="<%=wkField%>" />
			<wtc:param value="<%=wkShow%>" />
		  <wtc:param value="<%=workNo%>" />
			<wtc:param value="e487" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="������ͨѶ�޸�" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String wkSeq = request.getParameter("wkSeq")==null?"":request.getParameter("wkSeq");
		//���ú�̨�������ɾ������
		%>
		<wtc:service name="sDcommOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="<%=wkSeq%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e487" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="������ͨѶɾ��" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//У��wkCode�Ƿ����
		String wkCode = request.getParameter("wkCode")==null?"":request.getParameter("wkCode");
		String sql = "select wkspace_code,wkspace_name,is_effect from dcommunicate where wkspace_code=:wkspace_code";
		String param = "wkspace_code="+wkCode;
		String isAdd="1";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="theme" scope="end"/>
		<%				
		if("000000".equals(retCode)){ 
			if(theme.length==0){
				isAdd = "0";//������
			}
		}
		
	%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("isAdd","<%=isAdd%>");
			core.ajax.receivePacket(response);	
	
	<%
	}
	%>

