<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------������(lingyl) 2016-8-15 14:24:38-------------------
 
 -------------------------��̨��Ա��zuolf--------------------------------------------
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String iLoginAccept = WtcUtil.repNull(request.getParameter("iLoginAccept"));
	String iChnSource = WtcUtil.repNull(request.getParameter("iChnSource"));
	String iOpCode = WtcUtil.repNull(request.getParameter("iOpCode"));
	String iLoginNo = WtcUtil.repNull(request.getParameter("iLoginNo"));
	String iLoginPwd = WtcUtil.repNull(request.getParameter("iLoginPwd"));
	String iPhoneNo = WtcUtil.repNull(request.getParameter("iPhoneNo"));
	String iUserPwd = WtcUtil.repNull(request.getParameter("iUserPwd"));
	
	String regionCode = (String)session.getAttribute("regCode");
	String promptPhoneNo="";
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginAccept);
	System.out.println("liangyl~~~~~~~~~~~~"+iChnSource);
	System.out.println("liangyl~~~~~~~~~~~~"+iOpCode);
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginNo);
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginPwd);
	System.out.println("liangyl~~~~~~~~~~~~"+iPhoneNo);
	System.out.println("liangyl~~~~~~~~~~~~"+iUserPwd);
	
	
	String retCode    = "";
	String retMsg     = "";
	
	//7����׼�����
	String paraAray[] = new String[8];
	
	paraAray[0] = iLoginAccept;                                       //��ˮ
	paraAray[1] = iChnSource;                                     //��������
	paraAray[2] = iOpCode;                                   //��������
	paraAray[3] = iLoginNo;   //����
	paraAray[4] = iLoginPwd; //��������
	paraAray[5] = iPhoneNo;                                  //�û�����
	paraAray[6] = iUserPwd;                                       //��ע
	paraAray[7] = ""; 

	String serverName = "sG072Qry";
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
			<wtc:param value="<%=paraAray[7]%>" />						
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	if("000000".equals(retCode)){//�����ɹ�
		promptPhoneNo=serverResult[0][1];
    }
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("promptPhoneNo","<%=promptPhoneNo%>");
core.ajax.receivePacket(response);
