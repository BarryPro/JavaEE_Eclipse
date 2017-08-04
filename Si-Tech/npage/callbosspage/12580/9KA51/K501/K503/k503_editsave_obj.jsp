<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

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
  String SERIAL_NO=request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  
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
	
  String strUpSql = "update DPRESERVICE set PRE_TIME ='"+PRE_TIME+"',MSG_CONTENT = '"+MSG_CONTENT+"',TARGET_PHONE_NO = '"+TARGET_PHONE_NO+"',INTERV_TIME = '"+INTERV_TIME+"',TIMES_FLAG = '"+TIMES_FLAG+"',TIMES = '"+TIMES+"' where SERIAL_NO = '"+SERIAL_NO+"'";	
%>  

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strUpSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
