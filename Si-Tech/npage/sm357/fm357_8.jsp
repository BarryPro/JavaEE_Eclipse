<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/03/14 liangyl ��ʱ���󴴽���ͥ��Ϊ���÷��񴴽�
* ����: liangyl
* ��Ȩ: si-tech
*/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
System.out.println("---hejwa------7777777777777777777--- ------7-----------");
	String iLoginAccept      = WtcUtil.repNull(request.getParameter("iLoginAccept"));
	String iChnSource     = WtcUtil.repNull(request.getParameter("iChnSource"));
	String iOpCode  = WtcUtil.repNull(request.getParameter("iOpCode"));
	String iLoginNo  = WtcUtil.repNull(request.getParameter("iLoginNo"));
	String iLoginPwd  = WtcUtil.repNull(request.getParameter("iLoginPwd"));
	String iPhoneNo  = WtcUtil.repNull(request.getParameter("iPhoneNo"));
	String iUserPwd  = WtcUtil.repNull(request.getParameter("iUserPwd"));
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String retCode    = "";
	String retMsg     = "";
	String phone207 = "";
	//7����׼�����
	String paraAray[] = new String[7];
	
	paraAray[0] = iLoginAccept;//��ˮ
	paraAray[1] = iChnSource;//��������
	paraAray[2] = iOpCode;//��������
	paraAray[3] = iLoginNo;//����
	paraAray[4] = iLoginPwd;//��������
	paraAray[5] = iPhoneNo;//�û�����
	paraAray[6] = iUserPwd;//�û�����
			
	String serverName = "sFamPhoneCrtCfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />						
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	if("000000".equals(code)){
		phone207 = serverResult[0][0];
	}
	
}catch(Exception ex){
	ex.printStackTrace();
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("phone207","<%=phone207%>");
core.ajax.receivePacket(response);