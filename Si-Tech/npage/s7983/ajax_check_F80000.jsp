<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String InNewRate  = WtcUtil.repNull(request.getParameter("InNewRate"));
	String vSrvCode   = WtcUtil.repNull(request.getParameter("vSrvCode"));
	
  String regionCode = (String)session.getAttribute("regCode");
  
  
	String retCode    = "";
	String retMsg     = "";
	
	String result = "0";
	String serverName = "TlsPubSelCrm";
	
	String in_sql_str  =  " SELECT count(*) into :iTmpCount "+
												" FROM dbvipadm.scommoncode "+
												" WHERE common_code = '1045' "+
												" and field_code1 = :vSrvCode "+
												" and field_code3 = :InNewRate ";
	String in_sql_str_param = "vSrvCode="+vSrvCode+",InNewRate="+InNewRate;												
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=in_sql_str%>" />
		<wtc:param value="<%=in_sql_str_param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"   />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
 	
 	if(result_t.length>0){
 		result = result_t[0][0];
 	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result","<%=result%>");

core.ajax.receivePacket(response);
