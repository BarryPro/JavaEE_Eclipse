<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode="g237";
	String opName="������ϢͶ�߽��";	
	String workNo=(String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	
	String phoneNo=(String)request.getParameter("phoneNo");
	String s_datesource=(String)request.getParameter("s_datesource"); //������Դ
	String s_message_flag=(String)request.getParameter("s_message_flag"); //�Ӻ�����
	String s_note=(String)request.getParameter("s_note");
	String return_msg="";
	String v_s_datesource = "";
	String v_s_message_flag = "";
	if("ȫ�����ƽ̨".equals(s_datesource)){
		v_s_datesource = "01";
	}else if("ʡ�ڼ��".equals(s_datesource)){
		v_s_datesource = "02";
	}else if("�ٱ�����".equals(s_datesource)){
		v_s_datesource = "03";
	}else{ //�û�Ͷ��
		v_s_datesource = "04";
	}
	
	if("��������".equals(s_message_flag)){
		v_s_message_flag = "01";
	}else if("ɧ�ŵ绰".equals(s_message_flag)){
		v_s_message_flag = "02";
	}else{ //��������
		v_s_message_flag = "03";
	}
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
	String paraStr[] = new String[11];
	paraStr[0] = printAccept;
	paraStr[1] = "01";
  paraStr[2] = opCode;
  paraStr[3] = workNo;
  paraStr[4] = loginPwd;
  paraStr[5] = phoneNo;
  paraStr[6] = "";
  paraStr[7] = v_s_datesource;
  paraStr[8] = v_s_message_flag;
  paraStr[9] = "06";
  paraStr[10] = s_note;
%>
	<wtc:service name="szg57Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode" retMsg="retMsg"  outnum="3">
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if("000000".equals(retCode)){
		return_msg="��ڲ����ɹ�����" ;
	}else{
		return_msg="��ڲ���ʧ�ܣ���������룺"+retCode+"��������Ϣ��"+retMsg ;
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("return_msg","<%=return_msg%>");
response.data.add("phoneNo","<%=phoneNo%>");
core.ajax.receivePacket(response);
