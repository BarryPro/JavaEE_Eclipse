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
	
  String sqlStr = "select SEQ_12580.nextval from dual"; 
  
  String sqlSEQ = "select lpad(SEQ_SMS_PUSH_REC.nextval,18,'0') from dual";//关联预约服务与短信表
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>

<% 
  
  String workNo = (String)session.getAttribute("workNo");
  
  String PRE_TIME=request.getParameter("PRE_TIME")==null?"":request.getParameter("PRE_TIME");
  
  String MSG_CONTENT=request.getParameter("MSG_CONTENT")==null?"":request.getParameter("MSG_CONTENT");
  
  String TARGET_PHONE_NO=request.getParameter("TARGET_PHONE_NO")==null?"":request.getParameter("TARGET_PHONE_NO");
  
  String INTERV_TIME=request.getParameter("INTERV_TIME")==null?"":request.getParameter("INTERV_TIME");
  
  String TIMES_FLAG=request.getParameter("TIMES_FLAG")==null?"":request.getParameter("TIMES_FLAG");
  
  String TIMES=request.getParameter("TIMES")==null?"":request.getParameter("TIMES");
  
  String ACCEPT_NO=request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
    
  String SERIAL_NO = queryList[0][0];
  
  String CREATE_TIME = getCurrDateStr();
  
  String strInSql = "insert into DPRESERVICE (SERIAL_NO,ACCEPT_NO,CREATE_TIME,MSG_CONTENT,PRE_TIME,TIMES,INTERV_TIME,TIMES_FLAG,TARGET_PHONE_NO,PRE_TYPE,CREATE_LOGIN_NO) "
  								+"values ('"+SERIAL_NO+"','"+ACCEPT_NO+"','"+CREATE_TIME+"','"+MSG_CONTENT+"','"+PRE_TIME+"','"+TIMES+"','','"+TIMES_FLAG+"','"+TARGET_PHONE_NO+"','1','"+workNo+"')";
%>


<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strInSql%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
	<%
		String[] sqlArr = new String[]{};
		String inserttime = "";
	  if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "保存预约服务失败!";	     
	  }else{
	  	String[] taNm = new String[20];
			List strList = new ArrayList();
			taNm = INTERV_TIME.split(";");
			int timeTaNm = 0;//每次时间间隔递加
			for(int i = 0; i < taNm.length; i++){
				
				if(!"".equals(taNm[i])){
				timeTaNm = timeTaNm + Integer.parseInt(taNm[i]);
		%>
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlSEQ%>"/>
					</wtc:service>
					<wtc:array id="querySEQ"  scope="end"/>
		<%
					
					inserttime = "insert into DPRESERVICETIME (set_serial_no,serial_no,order_no,interval,SMS_PUSH_REC_SN)"+
								" select SEQ_12580.nextval,'"+SERIAL_NO+"','"+(i+1)+"','"+taNm[i]+"','"+querySEQ[0][0]+"' from dual";
					strList.add(inserttime);
					
					//插入短信表SMS_PUSH_REC_12580
					inserttime = "INSERT INTO SMS_PUSH_REC_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
							"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE)" +
							" values ('"+querySEQ[0][0]+"','"+TARGET_PHONE_NO+"','99999995','10658088','KFZH','SX04'," +
							"sysdate,to_date('"+PRE_TIME+"','yyyy-MM-dd hh24:mi:ss')+"+timeTaNm+"/(60*24),'','"+MSG_CONTENT+"','','01','0','','0','01')";
					
					strList.add(inserttime);
					
					//记录短信日志SMS_PUSH_REC_LOG_12580
					inserttime = "INSERT INTO SMS_PUSH_REC_LOG_12580(SERIAL_NO,USER_PHONE,SERV_NO,LONG_SERV_NO,SERV_CODE,OUT_GATEWAY_ID," +
							"INSERT_TIME,VALID_TIME,SEND_TIME,SEND_CONTENT,SEND_URL,FEE_TYPE_ID,FEE,LINKID,SEND_FLAG,SERV_TYPE,SUCCESS_FLAG,SEND_LOGIN_NO,caller_phone)" +
							"select lpad(SEQ_WLOGINOPR.nextval,36,'0'),'"+TARGET_PHONE_NO+"','99999995','10658088','KFZH','SX04'," +
							"sysdate,to_date('"+PRE_TIME+"','yyyy-MM-dd hh24:mi:ss')+"+timeTaNm+"/(60*24),'','"+MSG_CONTENT+"','','01','0','','0','01','Y','"+workNo+"','"+ACCEPT_NO+"' from dual";
		
					strList.add(inserttime);
				}
			}
			
			sqlArr = (String[])strList.toArray(new String[strList.size()]);
	 	}
	 %>
<wtc:service name="sKFModify" outnum="2">
<wtc:params value="<%=sqlArr %>"/>
</wtc:service>
<wtc:array id="Rrows" scope="end"/>	

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
