<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-4-11 16:17:08-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inGearCode = WtcUtil.repNull(request.getParameter("inGearCode"));
	String inGroupId  = WtcUtil.repNull(request.getParameter("inGroupId"));
	String oldGearCode  = WtcUtil.repNull(request.getParameter("oldGearCode")); //ԭ��λ
	
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
 
	//7����׼�����
	 String paraAray3[] = new String[10];
					paraAray3[0] = "";                                       //��ˮ
					paraAray3[1] = "01";                                     //��������
					paraAray3[2] = opCode;                                   //��������
					paraAray3[3] = (String)session.getAttribute("workNo");   //����
					paraAray3[4] = (String)session.getAttribute("password"); //��������
					paraAray3[5] = phoneNo;                            //�û�����
					paraAray3[6] = "";       
					paraAray3[7] = inGroupId;    	
					paraAray3[8] = inGearCode; 
					paraAray3[9] = oldGearCode; //ԭ��λ
			
for(int i=0;i<paraAray3.length;i++){
	System.out.println("----------------paraAray3["+i+"]--------------------->"+paraAray3[i]);
}
	String serverName = "sm359Check";
try{
%>
	 <wtc:service name="<%=serverName%>" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
		<wtc:param value="<%=paraAray3[8]%>" />		
		<wtc:param value="<%=paraAray3[9]%>" />		
	</wtc:service>
	<wtc:array id="serverResult" scope="end"  />

			
<%
	retCode = code;
	retMsg = msg;
	
 
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
