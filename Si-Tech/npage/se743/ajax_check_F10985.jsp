<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------������(liangyl) 2016-07-11-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String F10985_val = WtcUtil.repNull(request.getParameter("F10985_val"));
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String result_count = "0";
	String paramIn =  " select count(1) from dJtprojectMsg where PROJ_ID = :F10985_val";
										
	String param	 = "F10985_val="+F10985_val;
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn%>" />
		<wtc:param value="<%=param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		result_count = result_t[0][0];
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���TlsPubSelCrm��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_count","<%=result_count%>");
core.ajax.receivePacket(response);
