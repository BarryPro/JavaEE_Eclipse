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
		
	if("add".equals(opType.trim())){//0Ϊδ��
		String receive_no = request.getParameter("receive_no")==null?"":request.getParameter("receive_no");
		String msg_type = request.getParameter("msg_type")==null?"":request.getParameter("msg_type");
		String msgContent = request.getParameter("msgContent")==null?"":request.getParameter("msgContent");
		
		//��Ҫ���ú�̨����������Ӳ���
		%>

		<wtc:service name="sDmessageOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="a" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=receive_no%>"/>
			<wtc:param value="<%=msg_type%>" />
			<wtc:param value="<%=msgContent%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e488" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="��Ϣ��������" />
		</wtc:service>
		
				
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("read".equals(opType.trim())){//���������޸�,�Ƿ��Ѷ����Ա�Ϊ1��0Ϊδ��
		String msg_seq = request.getParameter("msg_seq")==null?"":request.getParameter("msg_seq");
		
		String retCode = "000000";
		String retMsg ="success";
		//��Ҫ���ú�̨��������޸Ĳ���
		%>
		<%--
		<wtc:service name="" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=msg_seq%>" />
		</wtc:service>--%>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){//ɾ��
		String msg_seq = request.getParameter("msg_seq")==null?"":request.getParameter("msg_seq");
		//��Ҫ���ú�̨�������ɾ������
		System.out.println("msg_seq------>"+msg_seq);
		%>

		<wtc:service name="sDmessageOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="d" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=msg_seq.trim()%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e488" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="��Ϣ����ɾ��" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
	<%
	}
%>


