
<%
	 /*
	 * 功能: 12580群组-新建编辑-delete群组中联系人
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
  
  String opCode = "K505";
  String opName = "群组维护";
  
  String SERIAL_NO = "";
  SERIAL_NO = request.getParameter("PERSON_ID")==null?"":request.getParameter("PERSON_ID");
  String GRP_ID = request.getParameter("GRP_ID")==null?"":request.getParameter("GRP_ID");
  
  String strDelSql = "delete from DMSGGRPPHONLIST where GRP_SERIAL_NO = '"+GRP_ID+"' and LIST_SERIAL_NO ='"+SERIAL_NO+"'"; 
%>  

<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=strDelSql%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />
	var response = new AJAXPacket(); 
	response.data.add("retCode",<%=retCode%>); 
	response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
	core.ajax.receivePacket(response);
