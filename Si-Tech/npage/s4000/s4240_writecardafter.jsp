<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/05/03 liangyl ����ȫ��ָ�ʡ�ʿ������������֪ͨ
* ����: liangyl
* ��Ȩ: si-tech
*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	
	String bipCode       = "BIP2B021";//ҵ�����
	String transCode     = "T2000022";//���״���
	String loginNo 		 = WtcUtil.repStr(request.getParameter("loginNo"),"");/* ��������   */ 
	String orgCode 		 = WtcUtil.repStr(request.getParameter("orgCode"),"");/* ��������   */
	String idValue 		 = WtcUtil.repStr(request.getParameter("idValue"),"");//����
	String seq 	 		 = WtcUtil.repStr(request.getParameter("seq"),"");//������ˮ��,�ɲ���
	String myseq 	 		 = WtcUtil.repStr(request.getParameter("myseq"),"");//������ˮ��,�ɲ���
	
	String IMSI 	 	 = WtcUtil.repStr(request.getParameter("IMSI"),"");//IMSI
	String writeresult   = WtcUtil.repStr(request.getParameter("writeresult"),"");///д����֤���
	String encK   = WtcUtil.repStr(request.getParameter("encK"),"");//�ù���ʡK2puk����K�������
	String encOpc   = WtcUtil.repStr(request.getParameter("encOpc"),"");//�ù���ʡK2puk����OPc�������
	String signature   = WtcUtil.repStr(request.getParameter("signature"),"");//ǩ��
	String localProvCode   = WtcUtil.repStr(request.getParameter("localProvCode"),"");//����ʡʡ����
	String bHomeProv   = WtcUtil.repStr(request.getParameter("bHomeProv"),"");//�Է�ʡ����
	
	String serviceFee   = WtcUtil.repStr(request.getParameter("serviceFee"),"");//�����
	String simFee   = WtcUtil.repStr(request.getParameter("simFee"),"0");//sim������
	String simCardNumber   = WtcUtil.repStr(request.getParameter("simCardNumber"),"");//sim�����к�
	String bICCID   = WtcUtil.repStr(request.getParameter("bICCID"),"");//��sim������
	
	System.out.println("liangyl-------"+loginNo);
	System.out.println("liangyl-------"+orgCode);
	System.out.println("liangyl-------"+idValue);
	System.out.println("liangyl-------"+seq);
	System.out.println("liangyl-------"+IMSI);
	System.out.println("liangyl-------"+writeresult);
	System.out.println("liangyl-------"+encK);
	System.out.println("liangyl-------"+encOpc);
	System.out.println("liangyl-------"+signature);
	
	System.out.println("liangyl-------"+localProvCode);
	System.out.println("liangyl-------"+serviceFee);
	System.out.println("liangyl-------"+simFee);
	System.out.println("liangyl-------"+simCardNumber);
	System.out.println("liangyl-------"+bICCID);
	
	
	
	String opNote = "��ص���д������,"+loginNo+"�������дUSIM������ش������뿪ͨ";//��ע
	
	String  inputParsm [] = new String[14];
	inputParsm[0] = bipCode;
	inputParsm[1] = transCode;
	inputParsm[2] = loginNo;
	inputParsm[3] = orgCode;
	inputParsm[4] = idValue;
	inputParsm[5] = seq;
	inputParsm[6] = IMSI;
	inputParsm[7] = writeresult;
	inputParsm[8] = encK;
	inputParsm[9] = encOpc;
	inputParsm[10] = signature;
	inputParsm[11] = localProvCode;
	inputParsm[12] = serviceFee;
	inputParsm[13] = opNote;
	String retCode1="";
	String retMsg1="";
%>
<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
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
</wtc:service>
<wtc:array id="result" scope="end"/>
var resultmsg = new Array();
<%
if(result.length>0 && "000000".equals(retCode)){
	for(int i=0;i<result.length;i++){
	%>
		resultmsg[<%=i%>]=new Array();
	<%
		for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl----------------"+result[i][j]);
	%>
		resultmsg[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
	<%		
		}	
	}
	String  inputParsm1 [] = new String[14];
	inputParsm1[0] = myseq;
	inputParsm1[1] = "01";
	inputParsm1[2] = "g412";
	inputParsm1[3] = loginNo;
	inputParsm1[4] = "";
	inputParsm1[5] = idValue;
	inputParsm1[6] = "";
	inputParsm1[7] = simFee;
	inputParsm1[8] = simCardNumber;
	inputParsm1[9] = "";
	inputParsm1[10] = bICCID;
	inputParsm1[11] = IMSI;
	inputParsm1[12] = seq;
	inputParsm1[13] = bHomeProv;
	%>
	<wtc:service name="sg412Chg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeChg" retmsg="retMsgChg" outnum="14">
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		<wtc:param value="<%=inputParsm1[5]%>"/>
		<wtc:param value="<%=inputParsm1[6]%>"/>
		<wtc:param value="<%=inputParsm1[7]%>"/>
		<wtc:param value="<%=inputParsm1[8]%>"/>
		<wtc:param value="<%=inputParsm1[9]%>"/>
		<wtc:param value="<%=inputParsm1[10]%>"/>
		<wtc:param value="<%=inputParsm1[11]%>"/>
		<wtc:param value="<%=inputParsm1[12]%>"/>
		<wtc:param value="<%=inputParsm1[13]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<%
	retCode1=retCodeChg;
	retMsg1=retMsgChg;
}else{
	retCode1=retCode;
	retMsg1=retMsg;
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("resultmsg",resultmsg);
core.ajax.receivePacket(response);