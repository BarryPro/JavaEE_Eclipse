<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 

 
<%
 String inChnSource = WtcUtil.repNull(request.getParameter("inChnSource"));
 String inLoginNo = WtcUtil.repNull(request.getParameter("inLoginNo"));
 String inLoginPwd = WtcUtil.repNull(request.getParameter("inLoginPwd"));
 String inPhoneNo = WtcUtil.repNull(request.getParameter("inPhoneNo"));
 String inUserPwd = WtcUtil.repNull(request.getParameter("inUserPwd"));
 String vOrgCode = WtcUtil.repNull(request.getParameter("vOrgCode"));
 String opCode = WtcUtil.repNull(request.getParameter("opCode"));
 
 String orgCode = (String)session.getAttribute("orgCode");
 String regionCode = orgCode.substring(0,2);
 
 String resultCode="";
 String resultMsg="";
 
 String[] inParams = new String[6];
 
 inParams[0] = inChnSource;
 inParams[1] = inLoginNo;
 inParams[2] = inLoginPwd;
 inParams[3] = inPhoneNo;
 inParams[4] = inUserPwd;
 inParams[5] = vOrgCode;
 
 
 //hejwa upd 2013��12��30��16:57:41 �޸ķ��� 
 String paraAray[] = new String[7];
	paraAray[0] = inChnSource;                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = inPhoneNo;                                  //�û�����
	paraAray[6] = inUserPwd;                                       //�û�����
System.out.println("------sWLANOrderCfm------------------");
		for(int jjj=0;jjj<paraAray.length;jjj++){
			System.out.println("---------------------paraAray["+jjj+"]=-----------------"+paraAray[jjj]);
		}
%>

	<wtc:service name="sWLANOrderCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">			
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>

<wtc:array id="result" scope="end" />

<%
	if("000000".equals(retCode) && result.length > 0){
		resultCode = retCode;
		resultMsg = retMsg;
		System.out.println("���÷���s9113Cfm in s9113Cfm_Wlan.jsp �ɹ�!--"+resultCode+"--"+resultMsg);
	}
	else{
		System.out.println("���÷���s9113Cfm in s9113Cfm_Wlan.jsp ʧ��!--"+resultCode+"--"+resultMsg);
		resultCode = retCode;
		resultMsg = retMsg;
	}
%>
 
var response = new AJAXPacket();
response.data.add("resultCode","<%=resultCode %>");
response.data.add("resultMsg","<%=resultMsg %>");
core.ajax.receivePacket(response);