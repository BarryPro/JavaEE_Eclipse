<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/05/03 liangyl ����ȫ��ָ�ʡ�ʿ������������֪ͨ
* ����: liangyl
* ��Ȩ: si-tech
*/
%> 
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 

<%
	//String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	//String errorCode="444444";
	//String[][] errCodeMsg = null;

	//String[][] callData = null;
	//String[][] callData1 = null;

	//List al = null;
	//boolean showFlag=false;	//showFlag��ʾ�Ƿ������ݿɹ���ʾ
  //int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����

	//String strArray="var arrMsg = new Array(); ";  //must 
	//String strArray1="var arrMsg1 = new Array(); ";  //must

  String verifyType = request.getParameter("verifyType");
	//String[][] input_paras = new String[1][13];  
	//String[][] recv_num = new String[3][2];
	
	String curDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String op_code = request.getParameter("opCode");
	
	String bipCode       = "BIP1A010";//ҵ�����
	String transCode     = "T1000008";//���״���
	String loginNo 		 = WtcUtil.repStr(request.getParameter("loginNo"),"");/* ��������   */ 
	String orgCode 		 = WtcUtil.repStr(request.getParameter("orgCode"),"");/* ��������   */	
	String idType 		 = WtcUtil.repStr(request.getParameter("idType"),"");//�������� 
	String idValue 		 = WtcUtil.repStr(request.getParameter("idValue"),"");//����
	String CCPasswd 	 = WtcUtil.repStr(request.getParameter("CCPasswd"),"");//��������
	String cardType 	 = WtcUtil.repStr(request.getParameter("cardType"),"");//֤������
	String cardNum 		 = WtcUtil.repStr(request.getParameter("cardID"),"");//֤������
	String typeIDs		 = WtcUtil.repStr(request.getParameter("typeIDs"),"");//��ѯ����
	String opNote        = loginNo+"���ڽ�����ز�����Ȩ��ѯ!";//��ע
 
	String regionCode= (String)session.getAttribute("regCode");
	
	System.out.println("liangyl----0-----"+bipCode);
	System.out.println("liangyl----1-----"+transCode);
	System.out.println("liangyl----2-----"+loginNo);
	System.out.println("liangyl----3-----"+orgCode);
	System.out.println("liangyl----4-----"+idType);
	System.out.println("liangyl----5-----"+idValue);
	System.out.println("liangyl----6-----"+CCPasswd);
	System.out.println("liangyl----7-----"+cardType);
	System.out.println("liangyl----8-----"+cardNum);
	System.out.println("liangyl----9-----"+typeIDs);
	System.out.println("liangyl----10-----"+opNote);
	
	String  inputParsm [] = new String[11];
		inputParsm[0] = bipCode;
		inputParsm[1] = transCode;
		inputParsm[2] = loginNo;
		inputParsm[3] = orgCode;
		inputParsm[4] = idType;
		inputParsm[5] = idValue;
		inputParsm[6] = CCPasswd;
		inputParsm[7] = cardType;
		inputParsm[8] = cardNum;
		inputParsm[9] = typeIDs;
		inputParsm[10] = opNote;
		//����ֵ����
		System.out.println("cardType-----------------------------="+cardType);
 
		String retCode="";
		String retMsg="";
	try{
	%>
	<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="39">
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
	</wtc:service>
	<wtc:array id="resultSnd1" start="0" length="9" scope="end"/>
	<wtc:array id="resultSnd2" start="9" length="14" scope="end"/>
	<wtc:array id="resultSnd3" start="10" length="14" scope="end"/>
	<wtc:array id="resultSnd4" start="13" length="2" scope="end"/>
var resultmsg1 = new Array();
var resultmsg2 = new Array();
var resultmsg3 = new Array();
var resultmsg4 = new Array();	
<%	
retCode=retCode1;
retMsg=retMsg1;
	if(resultSnd1.length>0 && "000000".equals(retCode)){
		for(int i=0;i<resultSnd1.length;i++){
		%>
			resultmsg1[<%=i%>]=new Array();
		<%
			for(int j=0;j<resultSnd1[i].length;j++){
				System.out.println("liangyl---------------------"+resultSnd1[i][j]);
		%>
		
			resultmsg1[<%=i%>][<%=j%>] = "<%=resultSnd1[i][j]%>";
		<%		
			}	
		}
		System.out.println("liangyl--2----------------------------------------");
		for(int i=0;i<resultSnd2.length;i++){
			System.out.println("liangyl--2-------------------"+resultSnd2[i][0]);
			%>
			resultmsg2[<%=i%>] = "<%=resultSnd2[i][0]%>";
			resultmsg3[<%=i%>] = "<%=resultSnd3[i][0]%>";
			<%	
		}
		System.out.println("liangyl--3----------------------------------------");
		for(int i=0;i<resultSnd3.length;i++){
			System.out.println("liangyl--3-------------------"+resultSnd3[i][0]);
		}
		System.out.println("liangyl--4----------------------------------------");
		for(int i=0;i<resultSnd4.length;i++){
			%>
				resultmsg4[<%=i%>]=new Array();
			<%
			for(int j=0;j<resultSnd4[i].length;j++){
				System.out.println("liangyl--3-------------------"+resultSnd4[i][j]);
				%>
				resultmsg4[<%=i%>][<%=j%>] = "<%=resultSnd4[i][j]%>";
				<%	
			}
		}
	}
	else{
		System.out.println("����sTSNPubSnd----in-----s4226_prc_id.jsp---ʧ�ܣ�");
		System.out.println(retCode);
		System.out.println(retMsg);
	}
}
catch(Exception e){
	System.out.println(e);
	System.out.println("cuocuowa111133");
	retCode= "444444";
	retMsg= "ϵͳ�쳣";
	System.out.println("retMsg="+retMsg);
}
%>


var response = new AJAXPacket();
response.data.add("verifyType","<%=verifyType%>");
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("resultmsg1",resultmsg1);
response.data.add("resultmsg2",resultmsg2);
response.data.add("resultmsg3",resultmsg3);
response.data.add("resultmsg4",resultmsg4);
core.ajax.receivePacket(response);


