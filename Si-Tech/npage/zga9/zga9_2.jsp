<%
/********************
 -------------------------����-----------����(zhangleij) 2015/9/6 10:45:50-------------------
 c��ѯҳ��
 -------------------------��̨��Ա��chenhu--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String year_month    = WtcUtil.repNull(request.getParameter("year_month"));
	
	String regionCode = (String)session.getAttribute("regCode");
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  
  
	String retCode    = "";
	String retMsg     = "";
	
	//3����׼�����
	String paraAray[] = new String[4];
	
	paraAray[0] = phoneNo;                                  //�ֻ�����
	paraAray[1] = (String)session.getAttribute("workNo");   //����
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = year_month;							//����
	String serverName = "s_jtzzqry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />	
			<wtc:param value="<%=paraAray[3]%>" />				
		</wtc:service>
		<wtc:array id="serverResult" scope="end" start="0"  length="2" />	//��ʡ�Բ�ȡ
		<wtc:array id="listResult" scope="end" start="2"  length="9" />		//�ֶ�ȡ�����start-�ӵڼ�����ʼ��length-ȡ����
<%
	retCode = code;
	retMsg = msg;
	
	//ƴװ��������
	for(int i=0;i<listResult.length;i++){
%>
		retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<listResult[i].length;j++){
%>
		retArray[<%=i%>][<%=j%>] = "<%=listResult[i][j]%>";
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
