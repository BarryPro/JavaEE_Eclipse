<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%	
	String opr_source="01";  //"01��ʾboss�࣬11��ʾƽ̨��"
	String login_no = request.getParameter("work_no");  //����
	String id_type="01";   //"01"��ʾͨ���ֻ�
	String id_value = request.getParameter("phone_no");							   //�绰����
	String opr_numb = "";   //������ˮ�ţ�boss�ഫ��
	String opr_code = request.getParameter("Td_code");  //��������
	String biz_type = "30";		//ҵ�����ʹ���
	//String effeti_time = request.getParameter("effetiTime");  //��Чʱ��
	String newPwd = request.getParameter("newPwd");  //������
	//String spId = request.getParameter("spId");  //SP��ҵ����
	String packNumb = request.getParameter("packNumb");  //�ײͱ���
	//String bizCode = request.getParameter("bizCode");  //SPҵ�����
	String login_accept=request.getParameter("login_accept");

%>
<wtc:service name="s1850Cfm" outnum="2" routerKey="phone" routerValue="<%=id_value%>">
	<wtc:param value="<%=opr_source%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=id_type%>"/>
	<wtc:param value="<%=id_value%>"/>
	<wtc:param value="<%=opr_numb%>"/>
	<wtc:param value="<%=opr_code%>"/>
	<wtc:param value="<%=biz_type%>"/>
	<wtc:param value="<%=newPwd%>"/>
	<wtc:param value="<%=packNumb%>"/>
	<wtc:param value="<%=login_accept%>"/>
	</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />
	<%
		String code = result[0][0];
		String msg = result[0][1];		
		if(code.equals("000000") && opr_code.equals("02"))
		{
			code="000009";
		}
	%>
<%
    System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String retCodeForCntt = code ;
		String loginAccept = login_accept; 
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1850&retCodeForCntt="+code+"&opName=��Ƶ����&workNo="+login_no+"&loginAccept="+login_accept+"&pageActivePhone="+id_value+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
%>
<jsp:include page="<%=url%>" flush="true" />
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);
