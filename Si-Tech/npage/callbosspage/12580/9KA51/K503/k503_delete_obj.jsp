<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>


<% 
  
  String workNo = (String)session.getAttribute("workNo");
  
  String obj_id=request.getParameter("obj_id")==null?"":request.getParameter("obj_id");
  String arryID[] = obj_id.split("_");
  String arySql[] = new String[arryID.length];
  int n = 0;
  String serialSql[] = new String[arryID.length];;//ɾ��ԤԼ��������
  for(int i = 1;i<arryID.length;i++){
  	
	  arySql[n] = "update DPRESERVICE set PRE_TYPE = '0' where SERIAL_NO = '"+arryID[i]+"'";
	  serialSql[n] = "delete SMS_PUSH_REC_12580 where send_flag <> '1' and SERIAL_NO in (select SMS_PUSH_REC_SN from DPRESERVICETIME where SERIAL_NO = '"+arryID[i]+"')";
	  n++;
  }
%> 

<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=arySql %>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>

<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=serialSql %>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
 
