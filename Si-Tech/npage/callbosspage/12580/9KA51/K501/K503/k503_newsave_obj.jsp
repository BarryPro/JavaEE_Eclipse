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
  String Hours=request.getParameter("Hours")==null?"":request.getParameter("Hours");
  String Minutes=request.getParameter("Minutes")==null?"":request.getParameter("Minutes");
  String Seconds=request.getParameter("Seconds")==null?"":request.getParameter("Seconds");
  String TIMES_FLAG=request.getParameter("TIMES_FLAG")==null?"":request.getParameter("TIMES_FLAG");
  String TIMES=request.getParameter("TIMES")==null?"":request.getParameter("TIMES");
  String ACCEPT_NO=request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  
  int h;
  if("".equals(Hours)){
  	
  	h = 0;
  }else{
  	h = Integer.parseInt(Hours)*3600;
  }
  
  int m;
  if("".equals(Minutes)){
  	
  	m = 0;
  }else{
  	m = Integer.parseInt(Minutes)*60;
  }
  
  int s;
  if("".equals(Seconds)){
  	
  	s = 0;
  }else{
  	s = Integer.parseInt(Seconds);
  }
  
  String INTERV_TIME = ""+(h+m+s);
  String SERIAL_NO = queryList[0][0];
  String CREATE_TIME = getCurrDateStr();
  
  String strInSql = "insert into DPRESERVICE (SERIAL_NO,ACCEPT_NO,CREATE_TIME,MSG_CONTENT,PRE_TIME,TIMES,INTERV_TIME,TIMES_FLAG,TARGET_PHONE_NO,PRE_TYPE,CREATE_LOGIN_NO) "
  								+"values ('"+SERIAL_NO+"','"+ACCEPT_NO+"','"+CREATE_TIME+"','"+MSG_CONTENT+"','"+PRE_TIME+"','"+TIMES+"','"+INTERV_TIME+"','"+TIMES_FLAG+"','"+TARGET_PHONE_NO+"','1','"+workNo+"')";
%>

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strInSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
