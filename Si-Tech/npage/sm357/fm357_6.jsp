<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-2-29 17:04:50-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String CFM_LOGIN    = WtcUtil.repNull(request.getParameter("CFM_LOGIN"));
	
	
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "";
	String retMsg     = "";
	
	System.out.println("---hejwa---------CFM_LOGIN-------------------"+CFM_LOGIN);
	
	String paramIn = "SELECT PHONE_NO FROM DBROADBANDMSG WHERE CFM_LOGIN =:CFM_LOGIN";
	String param = "CFM_LOGIN="+CFM_LOGIN;
	
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn%>" />
		<wtc:param value="<%=param%>" />	
	</wtc:service>
	<wtc:array id="serverResult" scope="end" />
			
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
			System.out.println("--hejwa--------serverResult["+i+"]["+j+"]---------------"+serverResult[i][j]);
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���TlsPubSelCrm��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
