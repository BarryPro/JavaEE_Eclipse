<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<% 
  
  String workNo = (String)session.getAttribute("workNo");
  
  String PRE_TIME=request.getParameter("PRE_TIME")==null?"":request.getParameter("PRE_TIME");
  String MSG_CONTENT=request.getParameter("MSG_CONTENT")==null?"":request.getParameter("MSG_CONTENT");
  String TARGET_PHONE_NO=request.getParameter("TARGET_PHONE_NO")==null?"":request.getParameter("TARGET_PHONE_NO");
  String INTERV_TIME=request.getParameter("INTERV_TIME")==null?"":request.getParameter("INTERV_TIME");

  String TIMES_FLAG=request.getParameter("TIMES_FLAG")==null?"":request.getParameter("TIMES_FLAG");
  String TIMES=request.getParameter("TIMES")==null?"":request.getParameter("TIMES");
  String SERIAL_NO=request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  String strUpSql = "update DPRESERVICE set PRE_TIME ='"+PRE_TIME+"',MSG_CONTENT = '"+MSG_CONTENT+"',TARGET_PHONE_NO = '"+TARGET_PHONE_NO+"',TIMES_FLAG = '"+TIMES_FLAG+"',TIMES = '"+TIMES+"' where SERIAL_NO = '"+SERIAL_NO+"'";	
%>
<wtc:service name="sKFModify"  outnum="2">
<wtc:param value="<%=strUpSql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
<%
	
	String selectTsql = "";
	String[] sqlArr = new String[]{};
	if(retRows[0][0].equals("000001")){
	  retCode = "1";
	  retMsg = "更新预约服务失败!";	     
	}else{
		selectTsql = " select SMS_PUSH_REC_SN from DPRESERVICETIME where SERIAL_NO = '"+SERIAL_NO+"'";
%>
<wtc:service name="s151Select"  outnum="2">
<wtc:param value="<%=selectTsql %>"/>
<wtc:param value="dbcall"/>
</wtc:service>
<wtc:array id="selRows"  scope="end"/>
<%
		List strList = new ArrayList();
		
		if(selRows.length > 0){
			for(int i = 0; i < selRows.length; i++){
				String sql = "update SMS_PUSH_REC_12580 set SEND_CONTENT = '"+MSG_CONTENT+"' where SERIAL_NO = '"+selRows[i][0]+"'";
				strList.add(sql);
			}
			sqlArr = (String[])strList.toArray(new String[strList.size()]);
		}
	}
%> 
<wtc:service name="sKFModify" outnum="2">
<wtc:params value="<%=sqlArr %>"/>
</wtc:service>
<wtc:array id="uptimeRows"  scope="end"/>
	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
