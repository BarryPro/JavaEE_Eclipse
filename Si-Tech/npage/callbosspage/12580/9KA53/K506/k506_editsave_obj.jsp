<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<% 
  
  String workNo = (String)session.getAttribute("workNo");
  
  String BEGIN_TIME=request.getParameter("BEGIN_TIME")==null?"":request.getParameter("BEGIN_TIME");
  String END_TIME=request.getParameter("END_TIME")==null?"":request.getParameter("END_TIME");
  String MSG_CONTENT=request.getParameter("MSG_CONTENT")==null?"":request.getParameter("MSG_CONTENT");
  String SERIAL_NO=request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  
  String strUpSql = "update DTAKEMSG set BEGIN_TIME = '"+BEGIN_TIME+"',END_TIME = '"+END_TIME+"',MSG_CONTENT = '"+MSG_CONTENT+"' where SERIAL_NO = '"+SERIAL_NO+"'";
  
%>  

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strUpSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
  
