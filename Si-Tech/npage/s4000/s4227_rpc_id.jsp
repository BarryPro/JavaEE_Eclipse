<%
/********************
     version v2.0
     ������: si-tech
     4240��ص���д����֤AJAXҳ�棬����s4150Snd(s4150��ؿͻ����ϲ�ѯ�ӿ�)
     gaopeng 20130105 ��Ϊ�°���棬���Ʒ��qucc����
     ********************/
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
	
	String loginNo 		 = request.getParameter("loginNo"); 	/* ��������   */ 
	System.out.println(loginNo);
	String orgCode 		 = request.getParameter("orgCode");	  /* ��������   */	
	System.out.println(orgCode);
	String opCode 		 = request.getParameter("opCode");		/* ��������   */
	System.out.println(opCode);
	String totalDate 	 = request.getParameter("totalDate");		
	String idType 		 = request.getParameter("IDType");	 
	String phoneNo 		 = request.getParameter("phoneNo");	/*�ֻ�����*/
	System.out.println(opCode);
	String custPWD 		 = request.getParameter("custPWD");	/*�ͷ�����*/
	String cardType 	 = request.getParameter("cardType");/*֤������*/
	String cardID 		 = request.getParameter("cardID");/*֤��ID*/
	String servLevel 		 = request.getParameter("servLevel");/*���񼶱�*/
	String attendant 		 = request.getParameter("attendant");/*��Ա����*/
	String qryType		 = request.getParameter("qryType");
	String beginTime	 = request.getParameter("beginTime");
	String endTime		 = request.getParameter("endTime");
	String testFlag=request.getParameter("test_flag");
	String opNote="���������Ȩ,�ֻ���:"+phoneNo;
	String loginNoPass 		 = request.getParameter("loginNoPass"); 	/* ��������   */ 
	
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println(regionCode+"----gaopeng");
	String PrintAccept = request.getParameter("PrintAccept");
	String  inputParsm [] = new String[12];
		inputParsm[0] = PrintAccept;	//��ˮ    
		inputParsm[1] = "01";       //������ʶ  
		inputParsm[2] = opCode;     //��������  
		inputParsm[3] = loginNo;    // �������� 
		inputParsm[4] = loginNoPass;    //��������  
		inputParsm[5] = phoneNo;    //�ֻ�����  
		inputParsm[6] = custPWD;   //��������  
		inputParsm[7] = orgCode;     //���Ź���  
		inputParsm[8] = cardType;    //֤������  
		inputParsm[9] = cardID;  //֤������  
		inputParsm[10] = servLevel;   //���񼶱�  
		inputParsm[11] = attendant;		//��Ա���� 
		
	
 
		String retCode="";
		String retMsg="";
		String endcardcode="";
		String cardcodesql="select a.card_code from dbvipadm.dGrpBigUserMsg a,dgrpmanagermsg b where a.service_no=b.service_no	and a.phone_no='"+phoneNo+"'";
	try{
	%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode21" retmsg="retMsg21">
			<wtc:param value="<%=cardcodesql%>"/>
		</wtc:service>
		<wtc:array id="result21" scope="end"/>
	<wtc:service name="s4228Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode1" retmsg="retMsg1" outnum="25">
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
		</wtc:service>
		<wtc:array id="result12" scope="end"/>
var resultmsg = new Array();	
<%	
retCode=retCode1;
retMsg=retMsg1;
if(result21.length>0){
	endcardcode=result21[0][0];
}
	if(result12.length>0 && "000000".equals(retCode))
	{
	String resultmsgs="var resultmsg = new Array(); ";
	for(int i=0;i<result12.length;i++){
	%>
	resultmsg[<%=i%>]=new Array();
	<%
		for(int j=0;j<11;j++){
%>

resultmsg[<%=i%>][<%=j%>] = "<%=result12[i][j].trim()%>";
<%		
}	
	}
	}
else{
	System.out.println("����s4150Snd----in-----s4226_prc_id.jsp---ʧ�ܣ�");
	System.out.println(retCode);
	System.out.println(retMsg);
}
}
catch(Exception e){
System.out.println("cuocuowa111133");
			retCode= "444444";
			retMsg= "ϵͳ�쳣";
			System.out.println("retMsg="+retMsg);
		}
%>


var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= retCode %>");
response.data.add("errorMsg","<%= retMsg %>");
response.data.add("endcardcode","<%= endcardcode %>");

<%
if("000000".equals(retCode.trim())){
%>
response.data.add("backArrMsg",resultmsg );
<%
}
else{
%>
response.data.add("backArrMsg","" );
<%
}
%>
core.ajax.receivePacket(response);


