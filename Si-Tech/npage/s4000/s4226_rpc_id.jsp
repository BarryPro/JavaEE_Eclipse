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
	
	String curDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String op_code = request.getParameter("opCode");
	
	String loginNo 		 = request.getParameter("loginNo"); 	/* ��������   */ 
	String orgCode 		 = request.getParameter("orgCode");	  /* ��������   */	
	String opCode 		 = request.getParameter("opCode");		/* ��������   */
	String totalDate 	 = request.getParameter("totalDate");		
	String idType 		 = request.getParameter("IDType");	 
	String phoneNo 		 = request.getParameter("phoneNo");	
	String custPWD 		 = request.getParameter("custPWD");	
	String cardType 	 = request.getParameter("cardType");
	String cardID 		 = request.getParameter("cardID");
	String qryType		 = request.getParameter("qryType");
	String beginTime	 = request.getParameter("beginTime");
	String endTime		 = request.getParameter("endTime");
	String businessCode	 = request.getParameter("businessCode");
	String testFlag=request.getParameter("test_flag");
 
	String regionCode= (String)session.getAttribute("regCode");
	
	String  inputParsm [] = new String[11];
		inputParsm[0] = loginNo;
		inputParsm[1] = orgCode;
		inputParsm[2] = opCode;
		inputParsm[3] = idType;
		inputParsm[4] = phoneNo;
		inputParsm[5] = custPWD;
		inputParsm[6] = cardType;
		inputParsm[7] = cardID;
		inputParsm[8] = qryType;
		inputParsm[9] = beginTime;
		inputParsm[10] = endTime;
		//����ֵ����
		System.out.println("cardType-----------------------------="+cardType);
 
		String retCode="";
		String retMsg="";
	try{
	%>
	<wtc:service name="s4150Snd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="25">
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
		<wtc:array id="result12" scope="end"/>
var resultmsg = new Array();	
<%	
retCode=retCode1;
retMsg=retMsg1;

	if(result12.length>0 && "0000".equals(retCode))
	{
	String resultmsgs="var resultmsg = new Array(); ";
	for(int i=0;i<result12.length;i++){
	%>
	resultmsg[<%=i%>]=new Array();
	<%
		for(int j=0;j<25;j++){
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
<%
if("0000".equals(retCode.trim())){
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


