<%
/********************

 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.24------------------
���ڲ�������ص�����ҵ��֧��ϵͳ�����֪ͨ
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String iOfferId       = WtcUtil.repNull(request.getParameter("iOfferId"));
	String iProductId     = WtcUtil.repNull(request.getParameter("iProductId"));
	String iServicId      = WtcUtil.repNull(request.getParameter("iServicId"));
	String iProdOffInsId  = WtcUtil.repNull(request.getParameter("iProdOffInsId"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String opr_type       = WtcUtil.repNull(request.getParameter("opr_type"));
	String new_iServicId  = WtcUtil.repNull(request.getParameter("new_iServicId"));	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	
	//��׼�����
	String paraAray[] = new String[12];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] =  "";                                       //�û�����
	paraAray[7] =  iOfferId;                              //�ʷѴ���    
	paraAray[8] =  iProductId;  														//��Ʒ����
	paraAray[9] =  iProdOffInsId; 														//�ʷ�ʵ��
	paraAray[10] =  new_iServicId; 														//ServiceID��
	paraAray[11] =  iServicId;                            //��APP��ServiceID��         
	

	String serverName = "sDXSPLLOfferChk";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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

	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("opr_type","<%=opr_type%>");
core.ajax.receivePacket(response);
