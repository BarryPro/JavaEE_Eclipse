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
		String guideCode = request.getParameter("guideCode")==null?"":request.getParameter("guideCode");
		String temp_id = request.getParameter("tempName")==null?"":request.getParameter("tempName");
		String detail = request.getParameter("detail")==null?"":request.getParameter("detail");
		String is_effect = request.getParameter("is_effect")==null?"":request.getParameter("is_effect");	
	
		//���ú�̨����������Ӳ���
		%>
		<wtc:service name="sBusiGuideOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=temp_id%>" />
			<wtc:param value="<%=guideCode%>" />
			<wtc:param value="<%=detail%>" />
			<wtc:param value="<%=is_effect%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
		      <wtc:param value="<%=ip_Addr%>" />
		      <wtc:param value="<%=powerCode%>" />
		      <wtc:param value="ҵ�����������" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String busiguide_seq = request.getParameter("busiguide_seq")==null?"":request.getParameter("busiguide_seq");
		String guideCode = request.getParameter("guideCode")==null?"":request.getParameter("guideCode");
		String temp_id = request.getParameter("tempName")==null?"":request.getParameter("tempName");
		String detail = request.getParameter("detail")==null?"":request.getParameter("detail");
		String is_effect = request.getParameter("is_effect")==null?"":request.getParameter("is_effect");
		
		//���ú�̨��������޸Ĳ���
		
		%>
		<wtc:service name="sBusiGuideOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=temp_id%>" />
			<wtc:param value="<%=guideCode%>" />
			<wtc:param value="<%=detail%>" />
			<wtc:param value="<%=is_effect%>" />
			<wtc:param value="<%=busiguide_seq%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="ҵ��������޸�" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String busiguide_seq = request.getParameter("busiguide_seq")==null?"":request.getParameter("busiguide_seq");
		//���ú�̨�������ɾ������
		%>
		<wtc:service name="sBusiGuideOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=busiguide_seq%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="ҵ�������ɾ��" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//У��guideCode�Ƿ����
		String guideCode = request.getParameter("guideCode")==null?"":request.getParameter("guideCode");
		String sql = " select template_id, op_code,is_effect from dbusiguidemsg where op_code=:guideCode";
		String param = "guideCode="+guideCode;
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

