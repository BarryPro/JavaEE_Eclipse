<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K507";
	String opName = "������־";
	
	String loginNo = (String) session.getAttribute("workNo");
	
	String USER_PHONE = (String)request.getParameter("aimphone")==null?"":request.getParameter("aimphone");//Ŀ�����

	String long_sevr_no = (String)request.getParameter("long_sevr_no")==null?"":request.getParameter("long_sevr_no");//���ŷ���Դ��ַ

	String caller_phone = (String)request.getParameter("callerphone")==null?"":request.getParameter("callerphone");//���к���
	String contactid = (String)request.getParameter("contactid")==null?"":request.getParameter("contactid");//��ˮ
	String contentMsg = (String)request.getParameter("contentMsg")==null?"":request.getParameter("contentMsg");//��������
	
	String VALID_TIME = (String)request.getParameter("VALID_TIME")==null?"":request.getParameter("VALID_TIME");//ָ���ķ���ʱ�� yyyy-MM-dd HH:mi:ss
		
	String scucc_flag = "Y";
	
	String insertSql = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
				"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
				"select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0'),'"+USER_PHONE+"','99999995','"+long_sevr_no+"','KFZH','SX04'," +
				"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+contentMsg+"','','01','0','','0','01' from dual";
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=insertSql %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "�����������ʧ��!";
	     scucc_flag = "N";
	  }else{
			String insertSqllog = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
				"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone,contact_id)" +
				"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+USER_PHONE+"','99999995','"+long_sevr_no+"','KFZH','SX04'," +
				"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+contentMsg+"','','01','0','','0','01','"+scucc_flag+"','"+loginNo+"','"+caller_phone+"','"+contactid+"' from dual";
	%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=insertSqllog %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
	<%
			if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "���淢�Ͷ�����־ʧ��!";
	%>
	rdShowMessageDialog("���������־ʧ�ܣ��������:<%=rows[0][0] %>");
	<%
	  	}  
		}
	  
	%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
