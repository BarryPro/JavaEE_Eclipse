<%
/********************

 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.13------------------
 �����¹̻���Ʒ���ڵ���������ִ����ⱨ���ĺ�  �������ڱ��
 
 
 -------------------------��̨��Ա��gudd--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String other_value   = WtcUtil.repNull(request.getParameter("other_value"));//��������
	String external_code   = WtcUtil.repNull(request.getParameter("external_code"));//Ʒ�Ʊ���
	
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	
	//��׼�����
	String paraAray[] = new String[9];
	
	paraAray[0] = "0";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] =  "";                                       //�û�����
	paraAray[7] =  external_code;                                   //Ʒ�Ʊ���
	paraAray[8] =  other_value;                                       //��������
	

	String serverName = "sm469Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming1-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
if(serverResult.length>0){
	retCode = serverResult[0][0];
	retMsg = serverResult[0][1];
}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}


	System.out.println("--duming1--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming1--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
