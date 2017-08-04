<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K501";
	String opName = "短信发送";
	
	String loginNo = (String) session.getAttribute("workNo");
	
	String user_phone = (String) request.getParameter("user_phone");
	String[] userphones = new String[100];
	userphones = user_phone.split(" ");
	
	List upList = new ArrayList();
	
	String contactid = (String) request.getParameter("contactid")==null?"":request.getParameter("contactid");//流水
	
	String callerphone = (String) request.getParameter("callerphone")==null?"":request.getParameter("callerphone");//主叫号码
	
	String sendno = (String) request.getParameter("sendno")==null?"":request.getParameter("sendno");//指定的发送短信人的号码
	
	String msg_content = (String) request.getParameter("msg_content")==null?"":request.getParameter("msg_content");//短信内容
	
	String VALID_TIME = ((String) request.getParameter("VALID_TIME")).equals("notime")?"":request.getParameter("VALID_TIME");//短信发送时间
	
	String user_name = (String) request.getParameter("user_name")==null?"":request.getParameter("user_name");//短信内容中的客户名称
	
	String send_login_no = (String) session.getAttribute("kfWorkNo")==null?"":request.getParameter("kfWorkNo");//发送短信工号
	
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
	     retMsg = "保存短信内容失败!";
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
	     retMsg = "保存发送短信日志失败!";
	%>
	rdShowMessageDialog("保存短信日志失败！错误代码:<%=rows[0][0] %>");
	<%
	  	}
	 
		}
	  
	%>
	
	
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
