<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	
	String billDate    = WtcUtil.repNull(request.getParameter("billDate"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	
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
	
	//7����׼�����
	String paraAray[] = new String[7];
	
	paraAray[0] = (String)session.getAttribute("workNo");   //����
	paraAray[1] = orgCode;
	paraAray[2] = password;
	paraAray[3] = opCode;                                       
	paraAray[4] = phoneNo; 
	paraAray[5] = billDate; 
	paraAray[6] = loginAccept; 

	String serverName = "sPubGetOprMsg";
try{
%>
    <wtc:service name="<%=serverName%>" routerKey="phone" routerValue="<%=phoneNo%>" retcode="code" retmsg="msg" outnum="25">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>		
		</wtc:service>
    <wtc:array id="serverResult" scope="end"/>
    	
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
				
				System.out.println("--hejwa--------serverResult["+i+"]["+j+"]--------------"+serverResult[i][j].trim());
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j].trim()%>";
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
