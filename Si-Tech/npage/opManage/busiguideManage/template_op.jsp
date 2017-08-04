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
	System.out.println("--------opType---------------"+opType);
	if("add".equals(opType.trim())){
		String temp_id = request.getParameter("temp_id")==null?"":request.getParameter("temp_id");
		String temp_name = request.getParameter("temp_name")==null?"":request.getParameter("temp_name");
		String[] stepArr = request.getParameterValues("stepArr");
		System.out.println("stepArr-============================"+stepArr);
		
		//���ú�̨����������Ӳ���
		%>
		<wtc:service name="sGuideTempOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=temp_id%>" />
			<wtc:param value="<%=temp_name%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="ҵ�������ģ������" />
      	<wtc:params value="<%=stepArr%>" />
		</wtc:service>
		<%
		System.out.println("--hejwa--op------------retCode-----------"+retCode);
		System.out.println("--hejwa--op------------retMsg------------"+retMsg);
		%>
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		
		//��template_id
		String template_id = request.getParameter("template_id")==null?"":request.getParameter("template_id");
		
		//�޸ĺ����template_id
		String temp_id = request.getParameter("temp_id")==null?"":request.getParameter("temp_id");
		
		String temp_name = request.getParameter("temp_name")==null?"":request.getParameter("temp_name");
		String[] stepArr = request.getParameterValues("stepArr");
		System.out.println("stepArr-============================"+stepArr);
		
		
		//���ú�̨��������޸Ĳ���
		
		%>
		<wtc:service name="sGuideTempOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="u" />
			<wtc:param value="<%=temp_id%>" />
			<wtc:param value="<%=temp_name%>" />
			<wtc:param value="<%=template_id%>" />
			
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="ҵ�������ģ���޸�" />
      	<wtc:params value="<%=stepArr%>" />
		</wtc:service>
		<%
		
		System.out.println("--------temp_id---------------"+temp_id);
		System.out.println("--------temp_name-------------"+temp_name);
		System.out.println("--------template_id-----------"+template_id);
		
		
		System.out.println("--------opType----------------"+opType);
		System.out.println("--------retCode---------------"+retCode);
		System.out.println("--------retMsg----------------"+retMsg);
		%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){
		String template_id = request.getParameter("template_id")==null?"":request.getParameter("template_id");
		//���ú�̨�������ɾ������
		%>
		<wtc:service name="sGuideTempOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="<%=template_id%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e490" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="ҵ�������ģ��ɾ��" />
      	<wtc:param value="" />
		</wtc:service>
		
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//У��temp_id�Ƿ����
		String temp_id = request.getParameter("template_id")==null?"":request.getParameter("template_id");
		String sql = " select template_id from dbusiguidetemp where template_id=:temp_id";
		String param = "temp_id="+temp_id;
		String isAdd="1";
		%>
		<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode %>">
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

