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
		System.out.println("===gaopengSeeLog========= pubM032Cfm.jsp ==========");
		
		System.out.println("gaopengSeeLog===m032====");
		
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		String password = (String) session.getAttribute("password");
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
<%		
		String idIccid = request.getParameter("idIccid");
		String custName = request.getParameter("custName");
		String idAddr = request.getParameter("idAddrH");
		String birthDay = WtcUtil.repStr(request.getParameter("birthDayH")," "); //��������
		if(!birthDay.equals("")) {
	 		birthDay =	birthDay.replaceAll("-", "");
		}
		String custId = request.getParameter("custId");
		String zhengjianyxq = request.getParameter("zhengjianyxq");
		String custSex = request.getParameter("idSexH");  	//�ͻ��Ա�
		String IDSex_t = "";
    System.out.println("--------------custSex----------------"+custSex);
    if(custSex.equals("1")){
    	IDSex_t = "��";
    }
    else if(custSex.equals("2")){
    	IDSex_t = "Ů";
    }
    else{
    	IDSex_t = "δ֪";
		}
		String  inputParsm [] = new String[17];
		inputParsm[0] = sysAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		
		inputParsm[7] = idIccid;
		inputParsm[8] = "2��";
		inputParsm[9] = custName;
		inputParsm[10] = idAddr;
		inputParsm[11] = IDSex_t;
		inputParsm[12] = birthDay;
		inputParsm[13] = zhengjianyxq;
	
		inputParsm[14] = "";
		inputParsm[15] = custId;
		inputParsm[16] = "";
		
		String retCode11 = "";
		String retMsg11 = "";
		
		int errorNum = 0;
		
try{		
%>
		<wtc:service name="sM032Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				<wtc:param value="<%=inputParsm[16]%>"/>
				
		</wtc:service>
		<wtc:array id="infoRet1"   scope="end"/>

	
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
	
		
		}catch(Exception e){
			e.printStackTrace();
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


core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         