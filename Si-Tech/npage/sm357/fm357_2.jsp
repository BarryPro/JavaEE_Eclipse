<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016-2-29 17:04:50-------------------
 
 -------------------------��̨��Ա��wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inQryType  = WtcUtil.repNull(request.getParameter("inQryType"));
	String inProdCode = WtcUtil.repNull(request.getParameter("inProdCode"));
	String inGearCode = WtcUtil.repNull(request.getParameter("inGearCode"));
	
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	String num="7";
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	if(inQryType.equals("2")){
		num="8";
	}
	//7����׼�����
	String paraAray[] = new String[11];
			paraAray[0] = "";                                       //��ˮ
			paraAray[1] = "01";                                     //��������
			paraAray[2] = opCode;                                   //��������
			paraAray[3] = (String)session.getAttribute("workNo");   //����
			paraAray[4] = (String)session.getAttribute("password"); //��������
			paraAray[5] = phoneNo;                              //�û�����
			paraAray[6] = "";  
			paraAray[7] = inQryType;  //��ѯ����,0:��ѯ��ͥ��Ʒ��1����Ʒ��λ; 2:��ͥ��ɫss 
			paraAray[8] = inProdCode;  //��Ʒ���룺JTRH,JTDX����ѯ����Ϊ1�Ǳش�
			paraAray[9] = inGearCode;  //��ͥ��Ʒ��λ����:D001,D002,D003,D004����ѯ����Ϊ2ʱ�ش�
			

			
	String serverName = "sm357Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="<%=num%>" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
			
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	System.out.println("--hejwa--------serverResult.length---------------"+serverResult.length);
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
			System.out.println("--hejwa--------serverResult["+i+"]["+j+"]---------------"+serverResult[i][j]);
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
response.data.add("inQryType","<%=inQryType%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
