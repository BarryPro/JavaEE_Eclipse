
<%
	 /*
	 * 功能: 12580群组-新建编辑-select群组
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
  
  String opCode = "K505";
  String opName = "群组维护";

  String SERIAL_NO = "";
  String GRP_NAME = "";
  String GRP_DESCR = "";
  String ACCEPT_NO = "";
  String CREATE_TIME = getCurrDateStr();

  List sqlList=new ArrayList();
  String[] sqlArr = new String[]{};
  
  String sqlStr="select SEQ_12580.nextval from dual";
%>  

<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>

<% 
  String workNo = (String)session.getAttribute("workNo");
  SERIAL_NO = queryList[0][0];
  GRP_NAME = request.getParameter("GRP_NAME")==null?"":request.getParameter("GRP_NAME");
  GRP_DESCR = request.getParameter("GRP_DESCR")==null?"":request.getParameter("GRP_DESCR");
  ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  
  String aSql = "select nvl(count(SERIAL_NO),0) from DMSGGRP where ACCEPT_NO = '"+ACCEPT_NO+"' and GRP_TYPE = '1'";
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=aSql%>"/>
</wtc:service>
<wtc:array id="queryLista"  scope="end"/>
<%  
  if(Integer.parseInt(queryLista[0][0])>10){

%>
var response = new AJAXPacket();
response.data.add("retCode","44444");
response.data.add("SERIAL_NO","<%=SERIAL_NO %>");
core.ajax.receivePacket(response);
<% 
  
  }else{
  
  String lSql = "select 'x' from DMSGGRP where GRP_NAME = '"+GRP_NAME+"' and ACCEPT_NO = '"+ACCEPT_NO+"' and GRP_TYPE ='1'";
%>

<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=lSql%>"/>
</wtc:service>
<wtc:array id="queryListl"  scope="end"/>
<%
    if(queryListl.length>0){
%>
var response = new AJAXPacket();
response.data.add("retCode","11111");
response.data.add("SERIAL_NO","<%=SERIAL_NO %>");
core.ajax.receivePacket(response);
<%     	
    	
    }else{
 
  
  String strInGRPSql = "insert into DMSGGRP (SERIAL_NO,GRP_NAME,GRP_DESCR,ACCEPT_NO,CREATE_TIME,GRP_TYPE,CREATE_LOGIN_NO) "
                      +" values ('"+SERIAL_NO+"','"+GRP_NAME+"','"+GRP_DESCR+"','"+ACCEPT_NO+"','"+CREATE_TIME+"','1','"+workNo+"')" ; 
                      
  sqlList.add(strInGRPSql);                  
                    
  sqlArr = (String[])sqlList.toArray(new String[1]); 
  	
%>
<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
response.data.add("SERIAL_NO","<%=SERIAL_NO %>");
core.ajax.receivePacket(response);
<%
}
}
%>
