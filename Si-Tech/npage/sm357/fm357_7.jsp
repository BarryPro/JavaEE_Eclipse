<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-3-2 10:07:45-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
System.out.println("---hejwa------7777777777777777777--- ------7-----------");
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inProdCode  = WtcUtil.repNull(request.getParameter("inProdCode"));
	String inGearCode  = WtcUtil.repNull(request.getParameter("inGearCode"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7����׼�����
	String paraAray[] = new String[7];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
			
	String serverName = "sm358RemQry";
	
	String prt_cust_name = "";
	String prt_cust_bran = "";
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
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
 	if(serverResult.length>0){
 		prt_cust_name = serverResult[0][1];
 		prt_cust_bran = serverResult[0][0];
 	}
	
	System.out.println("---hejwa---------prt_cust_name------------------"+prt_cust_name);
	System.out.println("---hejwa---------prt_cust_bran------------------"+prt_cust_bran);
	
}catch(Exception ex){
	ex.printStackTrace();
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");

response.data.add("prt_cust_name","<%=prt_cust_name%>");
response.data.add("prt_cust_bran","<%=prt_cust_bran%>");

core.ajax.receivePacket(response);
