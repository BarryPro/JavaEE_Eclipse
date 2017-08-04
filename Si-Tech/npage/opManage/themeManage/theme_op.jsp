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
		String tCode = request.getParameter("tCode")==null?"":request.getParameter("tCode");
		String tName = request.getParameter("tName")==null?"":request.getParameter("tName");
		String tShow = request.getParameter("tShow")==null?"":request.getParameter("tShow");	
	
		//���ú�̨����������Ӳ���
		%>
		<wtc:service name="sInDthemeMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=tCode%>" />
			<wtc:param value="<%=tName%>" />
			<wtc:param value="<%=tShow%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e485" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="�������������" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String tCode = request.getParameter("tCode")==null?"":request.getParameter("tCode");
		String tName = request.getParameter("tName")==null?"":request.getParameter("tName");
		String tShow = request.getParameter("tShow")==null?"":request.getParameter("tShow");
		
		//���ú�̨��������޸Ĳ���
		
		%>
		<wtc:service name="sUpDthemeMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=tCode%>" />
			<wtc:param value="<%=tName%>" />
			<wtc:param value="<%=tShow%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e485" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="����������޸�" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String tCode = request.getParameter("tCode")==null?"":request.getParameter("tCode");
		String mRole   = request.getParameter("mRole")==null?"":request.getParameter("mRole");
		//���ú�̨�������ɾ������
		%>
		<wtc:service name="sDelDthemeMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=tCode%>" />
			<wtc:param value="<%=mRole%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e485" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="���������ɾ��" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//У��tCode�Ƿ����
		String tCode = request.getParameter("tCode")==null?"":request.getParameter("tCode");
		String sql = "select theme_css,theme_name,is_effect from dthememsg where theme_css=:theme_css";
		String param = "theme_css="+tCode;
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
	}else if("setRole".equals(opType.trim())){//У��tCode�Ƿ����
		
		String treeValue = request.getParameter("treeValue")==null?"":request.getParameter("treeValue");
		String defaulttheme = request.getParameter("defaulttheme")==null?"":request.getParameter("defaulttheme");
		String selectValue = request.getParameter("selectValue")==null?"":request.getParameter("selectValue");
		String setLayout = (String)session.getAttribute("layout")==null?"default":(String)session.getAttribute("layout");
		String deTheme   = request.getParameter("moduleHide1")==null?"":request.getParameter("moduleHide1");
		
		%>
		
		<wtc:service name="sDthemeMsgSet" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=treeValue%>" />
			<wtc:param value="<%=defaulttheme%>"/>
			<wtc:param value="<%=selectValue%>"/>
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e485" />
		    <wtc:param value="<%=ip_Addr%>" />
		    <wtc:param value="<%=powerCode%>" />
		    <wtc:param value="����������ɫ����" />
		    <wtc:param value="<%=setLayout%>" />
      		<wtc:param value="<%=deTheme%>" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);
	
	<%
	}
	%>

