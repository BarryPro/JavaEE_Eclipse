<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016/11/3 16:22:42-------------------
 
 -------------------------��̨��Ա��zhangzhea--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String business_code  = WtcUtil.repNull(request.getParameter("business_code"));
	String old_workNo     = WtcUtil.repNull(request.getParameter("old_workNo"));
	String new_workNo     = WtcUtil.repNull(request.getParameter("new_workNo"));

        	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7����׼�����
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = business_code;
	paraAray[8] = old_workNo;
	paraAray[9] = new_workNo;

	String serverName = "sChangeLogin";
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
