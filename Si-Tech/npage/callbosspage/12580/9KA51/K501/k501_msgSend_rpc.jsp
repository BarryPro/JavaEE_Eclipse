<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K501";
	String opName = "���ŷ���";
	
	String loginNo = (String) session.getAttribute("workNo");
	
	String user_phone = (String) request.getParameter("user_phone");
	String[] userphones = new String[100];
	userphones = user_phone.split(" ");
	
	List upList = new ArrayList();
	
	String contactid = (String) request.getParameter("contactid")==null?"":request.getParameter("contactid");//��ˮ
	
	String callerphone = (String) request.getParameter("callerphone")==null?"":request.getParameter("callerphone");//���к���
	
	String sendno = (String) request.getParameter("sendno")==null?"":request.getParameter("sendno");//ָ���ķ��Ͷ����˵ĺ���
	
	String msg_content = (String) request.getParameter("msg_content")==null?"":request.getParameter("msg_content");//��������
	
	String VALID_TIME = ((String) request.getParameter("VALID_TIME")).equals("notime")?"":request.getParameter("VALID_TIME");//���ŷ���ʱ��
	
	String user_name = (String) request.getParameter("user_name")==null?"":request.getParameter("user_name");//���������еĿͻ�����
	
	String send_login_no = (String) session.getAttribute("kfWorkNo")==null?"":request.getParameter("kfWorkNo");//���Ͷ��Ź���
	
	String scucc_flag = "Y";
	if(!"".equals(VALID_TIME)){
	  for(int i = 0; i < userphones.length; i++){
	
		  String insertSql = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
				"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
				"select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0'),'"+userphones[i]+"','99999995','"+sendno+"','KFZH','SX04'," +
				"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+msg_content+"','','01','0','','0','01' from dual";
		
		  upList.add(insertSql);
		
	  }
	}else{
		for(int i = 0; i < userphones.length; i++){
	
		  String insertSql = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
				"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
				"select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0'),'"+userphones[i]+"','99999995','"+sendno+"','KFZH','SX04'," +
				"sysdate,sysdate,'','"+msg_content+"','','01','0','','0','01' from dual";
		
		  upList.add(insertSql);
		}
	}
	String[] sqlArr = new String[]{};
	
	sqlArr = (String[])upList.toArray(new String[upList.size()]);
	
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:params value="<%=sqlArr %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "�����������ʧ��!";
	     scucc_flag = "N";
	  }else{
	List logupList = new ArrayList();
	if(!"".equals(VALID_TIME)){
		
		for(int i = 0; i < userphones.length; i++){
			
			String insertSql = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
					"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone,contact_id)" +
					"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+userphones[i]+"','99999995','"+sendno+"','KFZH','SX04'," +
					"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+msg_content+"','','01','0','','0','01','"+scucc_flag+"','"+loginNo+"','"+callerphone+"','"+contactid+"' from dual";
			
			logupList.add(insertSql);
	  }
	}else{
		for(int i = 0; i < userphones.length; i++){
		
			String insertSql = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
					"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone,contact_id)" +
					"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+userphones[i]+"','99999995','"+sendno+"','KFZH','SX04'," +
					"sysdate,sysdate,'','"+msg_content+"','','01','0','','0','01','"+scucc_flag+"','"+loginNo+"','"+callerphone+"','"+contactid+"' from dual";
			
			logupList.add(insertSql);
		}
	}
	String[] sqlArrLog = new String[]{};
	sqlArrLog = (String[])logupList.toArray(new String[logupList.size()]);
	%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:params value="<%=sqlArrLog %>"/>
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
