<%
/********************
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-3-19 9:24-------------------
 �в�
 -------------------------��̨��Ա��liyang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
	String iOpType    = WtcUtil.repNull(request.getParameter("iOpType"));
	String iScoreRule = WtcUtil.repNull(request.getParameter("iScoreRule"));
	String iScoreName = WtcUtil.repNull(request.getParameter("iScoreName"));
	String iPriority  = WtcUtil.repNull(request.getParameter("iPriority"));
	String iStatus    = WtcUtil.repNull(request.getParameter("iStatus"));
	String iEffDate   = WtcUtil.repNull(request.getParameter("iEffDate"));
	String iExpDate   = WtcUtil.repNull(request.getParameter("iExpDate"));
	String iScoreRuleOld = WtcUtil.repNull(request.getParameter("iScoreRuleOld"));
	
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
	String paraAray[] = new String[16];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = "";                                        
	paraAray[8] = iOpType;                                   
	paraAray[9] = iScoreRule;                                
	paraAray[10] = iScoreName;                               
	paraAray[11] = iPriority;                                
	paraAray[12] = iStatus;                                  
	paraAray[13] = iScoreRuleOld;  	                         
	paraAray[14] = iEffDate;  	    
	paraAray[15] = iExpDate;  	    


	String serverName = "sm247Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
			<wtc:param value="<%=paraAray[10]%>" />						
			<wtc:param value="<%=paraAray[11]%>" />						
			<wtc:param value="<%=paraAray[12]%>" />						
			<wtc:param value="<%=paraAray[13]%>" />						
			<wtc:param value="<%=paraAray[14]%>" />				
			<wtc:param value="<%=paraAray[15]%>" />					
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
