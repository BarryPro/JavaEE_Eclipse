<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%!
public String getCurrDateStr(){
   
   Calendar c = Calendar.getInstance();
   Date date = c.getTime();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
   String  startTime = sdf.format(date);
   
   return startTime;   
}

%>

<% 
	String loginNo = (String)session.getAttribute("workNo");
	String scucc_flag = "Y";
	
	String callerphone = request.getParameter("callerphone")==null?"":request.getParameter("callerphone");//主叫号码
	String contactid = request.getParameter("contactid")==null?"":request.getParameter("contactid");
	String phone_number=request.getParameter("phone_number")==null?"":request.getParameter("phone_number");
	String ACCEPT_NO=request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
	String shortmessage=request.getParameter("shortmessage")==null?"":request.getParameter("shortmessage");
	String VALID_TIME = getCurrDateStr();
	
	String[] user_phone = phone_number.split("_");
	String[] arySql = new String[user_phone.length-1];
	
	for(int i =1;i<user_phone.length;i++){
		
		String insertSql = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
					"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
					"select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0'),'"+user_phone[i]+"','99999995','"+ACCEPT_NO+"','KFZH','SX04'," +
					"sysdate,sysdate,'','"+shortmessage+"','','01','0','','0','01' from dual";
		
		arySql[i-1]=insertSql;
		
	}
	
%>

<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=arySql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
	
<%
	  if(retRows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "保存短信内容失败!";
	     scucc_flag = "N";
	  }else{
	  	List logupList = new ArrayList();
	  	for(int i =1;i<user_phone.length;i++){
	  		String insertSql = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
								"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone,contact_id)" +
								"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+user_phone[i]+"','99999995','"+ACCEPT_NO+"','KFZH','SX04'," +
								"sysdate,sysdate,'','"+shortmessage+"','','01','0','','0','01','"+scucc_flag+"','"+loginNo+"','"+callerphone+"','"+contactid+"' from dual";
				logupList.add(insertSql);
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
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
