<%
/********************
 version v2.0
������: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		
		String input_group_id   = (String)request.getParameter("input_group_id");  
		String opCode   	      = (String)request.getParameter("opCode");  
		String imeiNo   				= (String)request.getParameter("imeiNo");  
		String phoneName 				= (String)request.getParameter("phoneName");  
		String phoneNo   				= (String)request.getParameter("phoneNo");  
		String allow_land_bTime = (String)request.getParameter("allow_land_bTime");  
		String allow_land_eTime = (String)request.getParameter("allow_land_eTime");  
		String allow_land_bDate = (String)request.getParameter("allow_land_bDate");  
		String allow_land_eDate = (String)request.getParameter("allow_land_eDate");  
		String status   				= "0";  //Ĭ��״̬����
		
		String paraAray[] = new String[14];
		
		paraAray[0]  = "";  																		 //��ˮ
		paraAray[1]  = "01";                                     //��������
		paraAray[2]  = opCode;                                   //��������
		paraAray[3]  = (String)session.getAttribute("workNo");   //����
		paraAray[4]  = (String)session.getAttribute("password"); //��������
		paraAray[5]  = phoneNo;      														 //�û�����
		paraAray[6]  = "";                                       //�û�����
		paraAray[7]  = imeiNo;                                   //�ն�imei
		paraAray[8]  = allow_land_bDate;                         //�����½��ʼ����
		paraAray[9]  = allow_land_eDate;                         //�����½��������
		paraAray[10] = allow_land_bTime;                         //�����½��ʼʱ��
		paraAray[11] = allow_land_eTime;                         //�����½����ʱ��
		paraAray[12] = input_group_id;                 				 //groupId
		paraAray[13] = phoneName;                         				 //groupId
		
		String retCode = "";
		String retMsg  = "";
		System.out.println("---------hejwa-------------paraAray[3]--------------------"+paraAray[3]);
if(paraAray[3]!=null&&!"".equals(paraAray[3])){
%>
	<wtc:service name="sm018Cfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />	
 		<wtc:param value="<%=paraAray[9]%>" />	
 		<wtc:param value="<%=paraAray[10]%>" />	
 		<wtc:param value="<%=paraAray[11]%>" />	
 		<wtc:param value="<%=paraAray[12]%>" />	
 		<wtc:param value="<%=paraAray[13]%>" />		
	</wtc:service>
<%
	retCode = code;
	retMsg  = msg;
}else{
	retCode = "WLNERR";
	retMsg  = "��ȡ��ǰ���Ŵ��������µ�¼ϵͳ";
}

%>		
		
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);