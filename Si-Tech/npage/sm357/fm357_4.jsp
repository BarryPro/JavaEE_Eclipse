<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo       = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inCheckFlag   = WtcUtil.repNull(request.getParameter("inCheckFlag"));
	String sel_kd_flag   = WtcUtil.repNull(request.getParameter("sel_kd_flag"));
	String kd_phoneNo    = WtcUtil.repNull(request.getParameter("kd_phoneNo"));
	String activePhone_j = WtcUtil.repNull(request.getParameter("activePhone"));
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	System.out.println("---hejwa---------inCheckFlag-------------------"+inCheckFlag);
	
	
	//7����׼�����
	String paraAray[] = new String[11];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = inCheckFlag; 
	paraAray[8] = kd_phoneNo; 
	paraAray[9] = sel_kd_flag; 
	paraAray[10] = activePhone_j; 

for(int i=0;i<paraAray.length;i++){
	System.out.println("---hejwa---------paraAray["+i+"]------------------"+paraAray[i]);
}
	String serverName = "sm357RoleCheck";
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
