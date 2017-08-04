
<%
	 /*
	 * 功能: 12580群组-新建编辑-update群组
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
  String PERSON_NAME = request.getParameter("PERSON_NAME")==null?"":request.getParameter("PERSON_NAME");
  String PERSON_PHONE = request.getParameter("PERSON_PHONE")==null?"":request.getParameter("PERSON_PHONE");
  String PERSON_FAX = request.getParameter("PERSON_FAX")==null?"":request.getParameter("PERSON_FAX");
  String PERSON_EMAIL = request.getParameter("PERSON_EMAIL")==null?"":request.getParameter("PERSON_EMAIL");
  String PERSON_QQ = request.getParameter("PERSON_QQ")==null?"":request.getParameter("PERSON_QQ");
  String PERSON_UNIT = request.getParameter("PERSON_UNIT")==null?"":request.getParameter("PERSON_UNIT");
  String PERSON_BIRTH = request.getParameter("PERSON_BIRTH")==null?"":request.getParameter("PERSON_BIRTH");
  String PERSON_SEX = request.getParameter("PERSON_SEX")==null?"":request.getParameter("PERSON_SEX");
  String PERSON_DESCR = request.getParameter("PERSON_DESCR")==null?"":request.getParameter("PERSON_DESCR");
  
  String lSql = "select 'x' from DPHONLIST where PERSON_PHONE = '"+PERSON_PHONE+"' and SERIAL_NO = '"+SERIAL_NO+"' and PERSON_TYPE ='1'";
  
  System.out.println("====================="+lSql);
 
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=lSql%>" />
</wtc:service>
<wtc:array id="queryListl" scope="end" />

<% 
  System.out.println("====================="+queryListl.length);
  
  if(queryListl.length>0){
  	
  	String strUpSql = "update DPHONLIST set PERSON_NAME ='"+PERSON_NAME+"',PERSON_PHONE = '"+PERSON_PHONE+"',PERSON_FAX='"+PERSON_FAX+"'"
  					 					 +",PERSON_EMAIL = '"+PERSON_EMAIL+"',PERSON_QQ = '"+PERSON_QQ+"',PERSON_UNIT='"+PERSON_UNIT+"'"
  					 					 +",PERSON_BIRTH = '"+PERSON_BIRTH+"',PERSON_SEX = '"+PERSON_SEX+"',PERSON_DESCR='"+PERSON_DESCR+"' "
  					 	     +" where SERIAL_NO = '"+SERIAL_NO+"'";
  	%>
  	<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=strUpSql%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />
	var response = new AJAXPacket(); 
	response.data.add("retCode",<%=retCode%>); 
	response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
	core.ajax.receivePacket(response);
  	<%
  }else{
  	String gSql = "select 'x' from DPHONLIST where PERSON_PHONE = '"+PERSON_PHONE+"' and PERSON_TYPE ='1'";
  	%>
  	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=gSql%>" />
	</wtc:service>
	<wtc:array id="queryListg" scope="end" />
  	<%
  	if(queryListg.length>0){
  	%>
  	var response = new AJAXPacket(); 
	response.data.add("retCode","33333"); 
	response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
	core.ajax.receivePacket(response);
  	<%	
  	}else{
  		
  		String sSql = "update DPHONLIST set PERSON_NAME ='"+PERSON_NAME+"',PERSON_PHONE = '"+PERSON_PHONE+"',PERSON_FAX='"+PERSON_FAX+"'"
  					 					 +",PERSON_EMAIL = '"+PERSON_EMAIL+"',PERSON_QQ = '"+PERSON_QQ+"',PERSON_UNIT='"+PERSON_UNIT+"'"
  					 					 +",PERSON_BIRTH = '"+PERSON_BIRTH+"',PERSON_SEX = '"+PERSON_SEX+"',PERSON_DESCR='"+PERSON_DESCR+"' "
  					 	     +" where SERIAL_NO = '"+SERIAL_NO+"'";
  	%>
  	<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=sSql%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />
	var response = new AJAXPacket(); 
	response.data.add("retCode",<%=retCode%>); 
	response.data.add("SERIAL_NO","<%=GRP_ID%>"); 
	core.ajax.receivePacket(response);
  	
  	<%				 	     
  }
  }
%>
