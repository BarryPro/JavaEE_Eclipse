<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 ����11�·ݼ��ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-7-��ҵӦ��������BOSSϵͳ����
 * ������: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		/**
		sKBMainOffCfm
		###          0  ��ӡ��ˮ                iLognAccept
		###          1  ��������                iChnSource
		###          2  ��������                iOpCode
		###          3  ��������                iLoginNo
		###          4  ��������                iLoginPwd
		###          5  �û�����                iPhoneNo
		###          6  �û�����                iUserPwd
		
		###          7  ��ǰ����Ʒ����          iOldMode
		###          8  ������Ʒ����            iNewMode
		###          9  ϵͳ��־                iSysNote
		###          10 ������־                iOpNote
		###          11 ��¼IP                  iIpAddr
		###          12 ���ֵֿ۱�ʾ            iDealType 
		###          13 ���ֵֿۺ���            iPhoneChgNo
		###          14 ���ֵֿ�����            iMarkScore


		*/
		System.out.println("===gaopengSeeLog========= fm225Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");//ÿ���ύ��Ϊһ������ˮ hejwa and haoyy 2015��6��10��10:32:09
		
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String ipAddr = request.getRemoteAddr();
		
		String oldFeeCode =  request.getParameter("oldFeeCode");
		String newFeeCode =  request.getParameter("newFeeCode");
		String iSysNote =  "����"+iLoginNo+"ִ��"+iOpCode+"����,�ֻ��ţ�"+iPhoneNo;
		String iOpNote =  "����"+iLoginNo+"ִ��"+iOpCode+"����,�ֻ��ţ�"+iPhoneNo;
		
		String jfdkFlag =  request.getParameter("jfdkFlag");
		String jfdkPhone =  request.getParameter("jfdkPhone");
		String jdfkNum =  request.getParameter("jdfkNum");
		
		
		
		String  inputParsm [] = new String[17];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = oldFeeCode;
		inputParsm[8] = newFeeCode;
		inputParsm[9] = iSysNote;
		inputParsm[10] = iOpNote;
		inputParsm[11] = ipAddr;
		inputParsm[12] = jfdkFlag;
		inputParsm[13] = jfdkPhone;
		inputParsm[14] = jdfkNum;
		
		String retCode11 = "";
		String retMsg11 = "";
		
		String oActualNum="";
		String oActualTotal="";
		
try{		
%>
		<wtc:service name="sKBMainOffCfm" routerKey="region" routerValue="<%=regionCode%>"
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
				
		</wtc:service>
		
			
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
response.data.add("retMsg","<%=retMsg11 %>");;
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         