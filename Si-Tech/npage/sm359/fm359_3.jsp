<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-3-28 13:37:56-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inGearCode = WtcUtil.repNull(request.getParameter("inGearCode"));
	
	
	
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
					paraAray3[7] = inGearCode;    	
			
			
	String serverName = "sm358Qry";
try{
%>
	 <wtc:service name="<%=serverName%>" outnum="14" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
