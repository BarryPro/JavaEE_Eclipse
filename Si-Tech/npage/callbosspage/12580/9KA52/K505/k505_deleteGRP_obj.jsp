
<%
	 /*
	 * ����: 12580Ⱥ��-�½��༭-deleteȺ��
	 * �汾: 1.0.0
	 * ����: 2009/01/12
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
  
  String opCode = "K505";
  String opName = "Ⱥ��ά��";
  
  String obj_id = request.getParameter("obj_id")==null?"":request.getParameter("obj_id");
  String arryID[] = obj_id.split("_");
  String arySql[] = new String[(arryID.length)*2];
  int n = 0;
  for(int i = 1;i<arryID.length;i++){
	  arySql[n] = "update DMSGGRP set GRP_TYPE = '0' where SERIAL_NO = '"+arryID[i]+"'";
	  n++;
	  arySql[n] = "delete from DMSGGRPPHONLIST where GRP_SERIAL_NO = '"+arryID[i]+"'";
	  n++;
  }
  
%>  

<wtc:service name="sKFModify" outnum="2">
	<wtc:params value="<%=arySql%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />
	var response = new AJAXPacket(); 
	response.data.add("retCode",<%=retCode%>); 
	core.ajax.receivePacket(response);
