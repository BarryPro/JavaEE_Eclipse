<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-9-20 20:29:11-------------------
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
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
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = "10073"; 
	paraAray[8] = "52205,55086"; 

	String serverName = "sm404Check";
	String result_flag = "";
	String offer_flag = "";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-----sm404Check--------paraAray["+i+"]-------------------->"+paraAray[i]);
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
	
	System.out.println("--hejwa--------code--------sm404Check------"+code);
	System.out.println("--hejwa--------msg---------sm404Check------"+msg);
	
	if("000000".equals(code)){
		if(serverResult.length>0){
			String oSimType = serverResult[0][0];
			String oOfferId = serverResult[0][1];
			
			System.out.println("--hejwa--------oOfferId---------------"+oOfferId);
			System.out.println("--hejwa--------oSimType---------------"+oSimType);
			
			/**
				��ͬ������
				
				���SIM�������ǡ�10073--NFC����ͨ���� 	����		û�г���ͨ����ѡ�ʷ�(����ԤԼ��Ч��ԤԼʧЧ)��
				
				�����������ʾ
				52205,55086
			*/
			if("10073".equals(oSimType)&&!"52205,55086".equals(oOfferId)){
				result_flag = "1"; 
			}
			
			if("52205,55086".equals(oOfferId)){
				offer_flag = "1"; 
			}
			
		}
	}
	
	System.out.println("--hejwa--------result_flag---------------"+result_flag);
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_flag","<%=result_flag%>");
response.data.add("offer_flag","<%=offer_flag%>");
core.ajax.receivePacket(response);
