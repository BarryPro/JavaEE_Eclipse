<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
	String sel_CountTotal = WtcUtil.repNull(request.getParameter("sel_CountTotal"));
	String sel_Count      = WtcUtil.repNull(request.getParameter("sel_Count"));
	String sel_Payment    = WtcUtil.repNull(request.getParameter("sel_Payment"));
	
	
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String ret_card_nos   = ""; //���ص��мۿ����ţ��ٺŷָ������10��
	
	//7����׼�����
	String paraAray[] = new String[15];
	
	paraAray[0] = loginAccept;                              //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	
	paraAray[7] = sel_CountTotal;/*�����мۿ���ֵ*/
	paraAray[8] = sel_Count;/*�����мۿ�����*/
	paraAray[9] = "";/*�����ַ*/
	paraAray[10] = sel_Payment;/*֧����ʽ*/	
	paraAray[11] = "";/*֤������*/
	paraAray[12] = "";/*֤������*/
	paraAray[13] = "";/*��Ʊ���λ*/
	paraAray[14] = "";/**/
	

	String serverName = "sm449Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
	 
	if(serverResult.length>0){
		ret_card_nos = serverResult[0][1];
		
		System.out.println("-------hejwa-----------serverResult[0][1]-------------->"+serverResult[0][1]);
		System.out.println("-------hejwa-----------serverResult[0][0]-------------->"+serverResult[0][0]);
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("ret_card_nos","<%=ret_card_nos%>");

core.ajax.receivePacket(response);
