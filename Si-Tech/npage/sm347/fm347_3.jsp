<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա��jingang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode       = WtcUtil.repNull(request.getParameter("opCode"));
	String iCategory    = WtcUtil.repNull(request.getParameter("iCategory"));
	String iSubPhoneNo  = WtcUtil.repNull(request.getParameter("iSubPhoneNo"));
	String iChrgType    = WtcUtil.repNull(request.getParameter("iChrgType"));
	String bizcode      = WtcUtil.repNull(request.getParameter("bizcode"));
	String iPhoneNo     = WtcUtil.repNull(request.getParameter("iPhoneNo"));
	String opnote       = WtcUtil.repNull(request.getParameter("opnote"));
	String loginAccept  = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	
	//7����׼�����
	String paraAray[] = new String[17];
	
	paraAray[0] = loginAccept;                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = iPhoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	
	paraAray[7]  = opnote;  //������ע                
	paraAray[8]  = "";  //ƽ̨��ˮ��              
	paraAray[9]  = iSubPhoneNo;  //����                    
	paraAray[10] = "74";  //ҵ�����ʹ���74          
	paraAray[11] = iChrgType;  //�Ʒ�����                
	paraAray[12] = iCategory;  //����������              
	paraAray[13] = "";  //���������к�            
	paraAray[14] = "";  //������������Ч���ں�ʱ��
	paraAray[15] = "698034";  //��ҵ����698034          
	paraAray[16] = bizcode;  //ҵ�����                


	for(int iii=0;iii<paraAray.length;iii++){
		System.out.println("--hejwa-----------paraAray["+iii+"]----------------->"+paraAray[iii]);
	}
	
	
	String serverName = "sm167Cfm";
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
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />
			<wtc:param value="<%=paraAray[15]%>" />
			<wtc:param value="<%=paraAray[16]%>" />
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
