<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016/12/1 9:33:35 -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String iOpType        = WtcUtil.repNull(request.getParameter("iOpType"));
	String iQryPhoneNo    = WtcUtil.repNull(request.getParameter("iQryPhoneNo"));
	String iIMSINo        = WtcUtil.repNull(request.getParameter("iIMSINo"));
	String iCfmLogin      = WtcUtil.repNull(request.getParameter("iCfmLogin"));
	String iIdIccid       = WtcUtil.repNull(request.getParameter("iIdIccid"));
	String iIMEINo        = WtcUtil.repNull(request.getParameter("iIMEINo"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7����׼�����
	String paraAray[] = new String[14];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = iOpType;  /*��ѯ����:�ֻ����룺0;IMSI:1;����˺�:2;֤������:3;IMEI:4(��֧��5ѡ1)*/
	paraAray[8] = iQryPhoneNo; /*�ֻ�����*/
	paraAray[9] = iIMSINo; /*IMSI*/
	paraAray[10] = iCfmLogin; /*����˺�*/
	paraAray[11] = iIdIccid; /*֤������*/
	paraAray[12] = iIMEINo;  	/*IMEI*/
	paraAray[13] = "��ע����ѯ������Ϣ"; /*��ע*/

	
	String serverName = "sm433Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="14" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
		
				System.out.println("--hejwa--------����------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
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
