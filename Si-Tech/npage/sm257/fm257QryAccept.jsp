<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm257QryAccept.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String opAccept =  request.getParameter("opAccept");
		String iccid =  request.getParameter("iccid");
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = opAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iccid;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		/*
			�Ϳͻ��˽�����������Ĳ����ŵ�������
			strcpy(iLoginAccept	,	input_parms[0]);
			strcpy(iChnSource	,	input_parms[1]);
			strcpy(iOpCode		,	input_parms[2]);
			strcpy(iloginNo   	,	input_parms[3]);
			strcpy(iloginPwd  	,	input_parms[4]);
			strcpy(iPhoneNo		,	input_parms[5]);
			strcpy(iUserPwd		,	input_parms[6]);
			strcpy(iZhengJianNo,input_parms[7]);
		
		*/
		
try{		
%>
		<wtc:service name="sm256zjQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="6">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
			
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			System.out.println("============ fm257QryAccept.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					<%for(int j=0;j<infoRet1[i].length;j++){%>
					infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
					
					<%
					System.out.println("============ fm257QryAccept.jsp ==========infoRet1["+i+"]["+j+"]" + infoRet1[i][j]);
					}
					%>
				<%
				}
			
		}else{
			System.out.println("============ fm257QryAccept.jsp ʧ��==========");
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "����δ����������������ϵ����Ա��";
			%>
				var infoArray = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         