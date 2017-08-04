<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<% 
  
  String workNo = (String)session.getAttribute("workNo");
  
  String SERIAL_NO=request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  
  String strDelSql = "update DPRESERVICE set PRE_TYPE = '0' where SERIAL_NO = '"+SERIAL_NO+"'";
%> 

<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strDelSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
 
