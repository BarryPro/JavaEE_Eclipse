<%
/********************
 
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	
	String iOfferIdStr    = WtcUtil.repNull(request.getParameter("iOfferIdStr"));
	String iOfferStateStr = WtcUtil.repNull(request.getParameter("iOfferStateStr"));
	String iFlagStr       = WtcUtil.repNull(request.getParameter("iFlagStr"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String newofferidss        = WtcUtil.repNull(request.getParameter("newofferidss"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "";
	String retMsg     = "";
	
	
	//7����׼�����
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = iOfferIdStr;
	paraAray[8] = iOfferStateStr;
	paraAray[9] = iFlagStr;
	

	String serverName = "sWLWOffCheck";
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
			<wtc:param value="<%=newofferidss%>" />
										
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
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
