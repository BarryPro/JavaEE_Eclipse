<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
		System.out.println("===gaopengSeeLog========= fGetIntegral.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		/*�������*/
		iUserPwd = Encrypt.encrypt(iUserPwd);
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String custName = "";
		String integralNum = "";
		String maxIntegralNum = "";
		
try{		
%>
		<wtc:service name="s4977Init" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="3">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fGetIntegral.jsp ==========" + infoRet1.length);
			custName = infoRet1[0][0];
			integralNum = infoRet1[0][1];
			maxIntegralNum = infoRet1[0][2];
				
				
			System.out.println("============ fGetIntegral.jsp ==========infoRet1[0][0]" + infoRet1[0][0]);
			System.out.println("============ fGetIntegral.jsp ==========infoRet1[0][1]" + infoRet1[0][1]);
			System.out.println("============ fGetIntegral.jsp ==========infoRet1[0][2]" + infoRet1[0][2]);
			
		}else{
			System.out.println("============ fGetIntegral.jsp ʧ��==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("custName","<%=custName %>");
response.data.add("integralNum","<%=integralNum %>");
response.data.add("maxIntegralNum","<%=maxIntegralNum %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         