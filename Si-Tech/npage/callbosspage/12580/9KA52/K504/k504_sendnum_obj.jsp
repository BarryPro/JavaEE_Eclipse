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
  String workNo = (String)session.getAttribute("workNo");
  
  String callerphone = (String)session.getAttribute("callerphone")==null?"":request.getParameter("callerphone");
  
  String SERIAL_NO=request.getParameter("obj_id")==null?"":request.getParameter("obj_id");
  String ACCEPT_NO=request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  String contactid = request.getParameter("contactid")==null?"":request.getParameter("contactid");
  String VALID_TIME = getCurrDateStr();
  
  String scucc_flag = "Y";
  
  String selectSql = "select PERSON_PHONE,PERSON_NAME from DPHONLIST where SERIAL_NO = '"+SERIAL_NO+"'";
%>
<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=selectSql%>"/>
</wtc:service>
<wtc:array id="queryLists"  scope="end"/>
<%  
  String shortmessage = "您好！您需要查询的号码是："+queryLists[0][0]+"，姓名："+queryLists[0][1]+"。";
  
  String insertSql = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
					"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
					"select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0'),'"+ACCEPT_NO+"','99999995','10658088','KFZH','SX04'," +
					"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+shortmessage+"','','01','0','','0','01' from dual";
%>

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=insertSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
<%
	  if(retRows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "保存短信内容失败!";
	     scucc_flag = "N";
	  }else{
	  	
	  		String insertSql1 = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
								"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone,contact_id)" +
								"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+ACCEPT_NO+"','99999995','10658088','KFZH','SX04'," +
								"sysdate,to_date('"+VALID_TIME+"','yyyy-MM-dd hh24:mi:ss'),'','"+shortmessage+"','','01','0','','0','01','"+scucc_flag+"','"+workNo+"','"+callerphone+"','"+contactid+"' from dual";
			
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=insertSql1 %>"/>
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
