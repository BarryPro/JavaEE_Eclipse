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
		System.out.println("===gaopengSeeLog========= fm257Qry.jsp ==========");
		
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
			Trim(oOLD_CARD_NO);          �ÿ��ſ�ʼ 0
			Trim(oOLD_CARD_NO_end);    �ÿ��Ž��� 1
			Trim(oNEW_CARD_NO);         �¿��ſ�ʼ2
			Trim(oNEW_CARD_NO_end);     �ºŽ���3
			Trim(oUSE_FLAG);             �Ƿ��ѹ�0-δ��1-�ѹ�4
			Trim(oCONTACT_NAME);        ��ϵ������/�ͻ�����5
			Trim(oCONTACT_PHONE);     ��ϵ�˵绰/�ͻ��绰6
			Trim(oID_ICCID);           ֤������7
			Trim(oCARD_STATIC);             �мۿ�״̬��0:δ�ʼ�,1:�ʼ���,2:�����8
			Trim(oREMOTE_ORDER_NUMBER);   '��ʡ�ʼĶ�����  /Ͷ�ߵ���9
			Trim(ocard_money);           ����ֵ 10
			Trim(oREMOTE_POSTAGE);       �ʷ�11

		
		*/
		
try{		
%>
		<wtc:service name="sm256Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="15">
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
			System.out.println("============ fm257Qry.jsp ==========" + infoRet1.length);
			
				for(int i=0;i<infoRet1.length;i++){
					
				%>
					infoArray[<%=i%>] = new Array();
					<%for(int j=0;j<infoRet1[i].length;j++){%>
					infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
					
					<%
					System.out.println("============ fm257Qry.jsp ==========infoRet1["+i+"]["+j+"]" + infoRet1[i][j]);
					}
					%>
				<%
				}
			
		}else{
			System.out.println("============ fm257Qry.jsp ʧ��==========");
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