<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016/11/15 10:32:31-------------------
 
 -------------------------��̨��Ա��liyang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
  String iOfferId       = WtcUtil.repNull(request.getParameter("iOfferId"));
	String iEmeiCode      = WtcUtil.repNull(request.getParameter("iEmeiCode"));
	String iEmeiCodeOld   = WtcUtil.repNull(request.getParameter("iEmeiCodeOld"));
	String opNote         = WtcUtil.repNull(request.getParameter("opNote"));
			                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7����׼�����
	String paraAray[] = new String[11];
	
	paraAray[0] = loginAccept;                              //### 0	iLoginAccept	ҵ����ˮ               
	paraAray[1] = "01";                                     //### 1	iChnSource		������ʶ               
	paraAray[2] = opCode;                                   //### 2	iOpCode			��������                 
	paraAray[3] = (String)session.getAttribute("workNo");   //### 3	iLoginNo		����                     
	paraAray[4] = (String)session.getAttribute("password"); //### 4	iLoginPwd		��������                 
	paraAray[5] = phoneNo;                                  //### 5	iPhoneNo		����                     
	paraAray[6] = "";                                       //### 6	iUserPwd		��������                 
	paraAray[7] = iOfferId ;                                //### 7	iOfferId		�ʷѴ��� ���ʷ��Ǵ�0     
  paraAray[8] = iEmeiCode;                                //### 8	iEmeiCode		IMEI��	 �����͸���ʱ�ش�
  paraAray[9] = iEmeiCodeOld;                             //### 9	iEmeiCodeOld	ԭIMEI��         
  paraAray[10] = opNote;        
  
  
  
  
	String serverName = "sHeMuProdOffChg";
try{
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
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
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
