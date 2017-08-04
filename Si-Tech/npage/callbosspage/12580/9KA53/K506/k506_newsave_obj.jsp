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
  
  String BEGIN_TIME=request.getParameter("BEGIN_TIME")==null?"":request.getParameter("BEGIN_TIME");
  String END_TIME=request.getParameter("END_TIME")==null?"":request.getParameter("END_TIME");
  String MSG_CONTENT=request.getParameter("MSG_CONTENT")==null?"":request.getParameter("MSG_CONTENT");
  String ACCEPT_NO=request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  
  String SERIAL_NO = queryList[0][0];
  String CREATE_TIME = getCurrDateStr();

  String delSql = "update DTAKEMSG set MSG_TYPE = '0' where ACCEPT_NO = '"+ACCEPT_NO+"' where begin_time > sysdate";
  
  String strInSql = "insert into DTAKEMSG (SERIAL_NO,ACCEPT_NO,CREATE_TIME,BEGIN_TIME,END_TIME,MSG_CONTENT,MSG_TYPE,CREATE_LOGIN_NO) "
                                +" values ('"+SERIAL_NO+"','"+ACCEPT_NO+"','"+CREATE_TIME+"','"+BEGIN_TIME+"','"+END_TIME+"','"+MSG_CONTENT+"','1','"+workNo+"')";

%>

<wtc:service name="sKFModify" outnum="2">
<wtc:param value="<%=delSql %>"/>
</wtc:service>

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strInSql %>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);  
 
  
  
