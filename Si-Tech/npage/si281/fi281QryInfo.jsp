<%
/********************
 * version v2.0
 * gaopeng 2013/12/11 14:28:26 R_CMI_HLJ_xueyz_2013_1148982@���ڴ��˰���ֹ�˾Эͬ������ٵ���ʾ
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		System.out.println("============ fi281QryInfo.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String opName =  request.getParameter("opName");
		String opCode = iOpCode;
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		String iKdNo =  request.getParameter("iKdNo");

		
		String  inputParsm [] = new String[8];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iKdNo;
		
		String retCode1 = "";
		String retMsg1 = "";
		/*��װ��ϵ������*/
		String constactName="";
		/*��װ��ϵ�˵绰*/
		String constactPhone="";
		/*��װ��ַ*/
		String constactAddr="";
		/*���ʷ�����*/
		String offerName = "";
		/*���ʷ�����*/
		String offerContent = "";
		
		
		
		/*���� sE474Init ���� ���� ��װ��ϵ����������װ��ϵ�˵绰����װ��ַ*/
%>
		<wtc:service name="sE474Init" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="7">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
		
		if("000000".equals(retCode)){
			
			System.out.println("============gaopengSeeLog fi281QryInfo.jsp ==========" + ret.length);
			if(ret.length > 0 ){
				
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][0]"+ret[0][0]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][1]"+ret[0][1]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][2]"+ret[0][2]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][3]"+ret[0][3]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][4]"+ret[0][4]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][5]"+ret[0][5]);
				System.out.println("============gaopengSeeLog fi281QryInfo.jsp ========== ret[0][6]"+ret[0][6]);
				retCode1 = retCode;
				retMsg1 = retMsg;
				/*��װ��ϵ������*/
				constactName=ret[0][2];
				/*��װ��ϵ�˵绰*/
				constactPhone=ret[0][3];
				/*��װ��ַ*/
				constactAddr=ret[0][5];
	%>
			<wtc:service name="sProductInfoQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode2" retmsg="retMsg2" outnum="6">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="1"/>
		</wtc:service>
		<wtc:array id="ret2" scope="end"/>
			
	<%
	System.out.println("gaopengSeeLog==========ret2.length:"+ret2.length);
				if("000000".equals(retCode2)){
					if(ret2.length > 0){
					System.out.println("gaopengSeeLog==========ret2.length:"+ret2.length);
						
						System.out.println("gaopengSeeLog==========ret2[0][0]:"+ret2[0][0]);
						System.out.println("gaopengSeeLog==========ret2[0][1]:"+ret2[0][1]);
						System.out.println("gaopengSeeLog==========ret2[0][2]:"+ret2[0][2]);
						System.out.println("gaopengSeeLog==========ret2[0][3]:"+ret2[0][3]);
						System.out.println("gaopengSeeLog==========ret2[0][4]:"+ret2[0][4]);
						System.out.println("gaopengSeeLog==========ret2[0][5]:"+ret2[0][5]);
						offerName = ret2[0][1];
						offerContent = ret2[0][2];
					}
				}else{
					
					retCode1 = retCode2;
					retMsg1 = retMsg2;
				}	
				
			}
		}else{
			System.out.println("============ fi281QryInfo.jsp ʧ��==========");
			retCode1 = retCode;
			retMsg1 = retMsg;
			
		}
%>

var response = new AJAXPacket();
	response.data.add("errCode","<%= retCode1 %>");
	response.data.add("errMsg","<%= retMsg1 %>");
	response.data.add("constactName","<%= constactName %>");
	response.data.add("constactPhone","<%= constactPhone %>");
	response.data.add("constactAddr","<%= constactAddr %>");
	response.data.add("offerName","<%= offerName %>");
	response.data.add("offerContent","<%= offerContent %>");
	
	
	core.ajax.receivePacket(response);