<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 У�鸱������ 
 -------------------------��̨��Ա��xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	var retArray = new Array();//���巵������
<%

	String opCode            = WtcUtil.repNull(request.getParameter("opCode"));
	String iPhoneNoMaster    = WtcUtil.repNull(request.getParameter("iPhoneNoMaster"));
	String iPhoneNoMember    = WtcUtil.repNull(request.getParameter("iPhoneNoMember"));
	String iUserPwdMember    = WtcUtil.repNull(request.getParameter("iUserPwdMember"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
		String accept           = "";//��ˮ
	String num_can_phone_no = "";//����ʣ�����Ӹ�����
	
	
	//7����׼�����
	String paraAray[] = new String[13];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = iPhoneNoMaster;   
	paraAray[8] = iPhoneNoMember;   
	paraAray[9] = (String)Encrypt.encrypt(iUserPwdMember);   
	paraAray[10] = "a";   
	paraAray[11] = "";   
	paraAray[12] = "0";   

	String serverName = "sm324Check";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />						
			<wtc:param value="<%=paraAray[7]%>" />				
			<wtc:param value="<%=paraAray[8]%>" />				
			<wtc:param value="<%=paraAray[9]%>" />				
			<wtc:param value="<%=paraAray[10]%>" />				
			<wtc:param value="<%=paraAray[11]%>" />				
			<wtc:param value="<%=paraAray[12]%>" />				
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
	if(serverResult.length>0){
		accept = serverResult[0][0];
		num_can_phone_no = serverResult[0][1];
	}
	System.out.println("--hejwa--------num_can_phone_no---------------"+num_can_phone_no);
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");

response.data.add("accept","<%=accept%>");
response.data.add("num_can_phone_no","<%=num_can_phone_no%>");

core.ajax.receivePacket(response);
