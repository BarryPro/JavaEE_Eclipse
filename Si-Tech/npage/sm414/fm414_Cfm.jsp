<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	String iImeiCode      = WtcUtil.repNull(request.getParameter("iImeiCode"));
	String iCfmLogin      = WtcUtil.repNull(request.getParameter("iCfmLogin"));
	String iAddress       = WtcUtil.repNull(request.getParameter("iAddress"));
	String iDepositFee    = WtcUtil.repNull(request.getParameter("iDepositFee"));
	String sm414Pwd       = WtcUtil.repNull(request.getParameter("sm414Pwd"));
	String iOpType       = WtcUtil.repNull(request.getParameter("iOpType"));
                       
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7����׼�����
	String paraAray[] = new String[14];
	
	paraAray[0] = loginAccept;                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	
	paraAray[7] = "��ע��ħ�ٺ϶���"+phoneNo; 
	paraAray[8] = iImeiCode;
	paraAray[9] = iCfmLogin;
	paraAray[10] = iAddress;
	paraAray[11] = iDepositFee;
	paraAray[12] = sm414Pwd;//����
	paraAray[13] = iOpType;//Ѻ��0������1
	String serverName = "sm414Cfm";
	
try{
	System.out.println("-----chenleikaishi-------------------------------->"+iOpType);
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code-----serverName=["+serverName+"]---------"+code);
	System.out.println("--hejwa--------msg------serverName=["+serverName+"]---------"+msg);
	
 
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
