<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-3-28 13:37:56-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
 
	//7����׼�����
	 String paraAray3[] = new String[8];
					paraAray3[0] = "";                                       //��ˮ
					paraAray3[1] = "01";                                     //��������
					paraAray3[2] = opCode;                                   //��������
					paraAray3[3] = (String)session.getAttribute("workNo");   //����
					paraAray3[4] = (String)session.getAttribute("password"); //��������
					paraAray3[5] = phoneNo;                            //�û�����
					paraAray3[6] = "";       
					paraAray3[7] = loginAccept;    	
			
			
	String serverName = "sBackAcceptChk";
try{
%>
	 <wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="serverResult" scope="end"  />

			
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	System.out.println("--hejwa--------serverResult.length---------------"+serverResult.length);
	 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
