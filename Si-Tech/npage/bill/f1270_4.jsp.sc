<% /******************** version v2.0 ������: si-tech * *update:zhanghonga@2008
          -08-19 ҳ�����,�޸���ʽ * ********************/ %> <%@page
              contentType="text/html;charset=GBK"%> <%@ include
 file="/npage/include/public_title_name.jsp" %> <%@ page import="java.text.*"%>
 <%@ page import="java.math.BigDecimal"%>
             <%@ page import="com.sitech.boss.pub.util.*" %> <%/* *
  ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
    ���ֱ������������ݶԴ˱���ʹ�õ����壬����;�� */ %> <% String opCode2 =
(String)request.getParameter("opCode"); if (opCode2 == null){ opCode2 = "1270";
    } %> <%! /**���������������ʽ�������Сд����**/ public static String
          formatNumber(String num, int zeroNum) { DecimalFormat form =
   (DecimalFormat)NumberFormat.getInstance(Locale.getDefault()); StringBuffer
patBuf = new StringBuffer("0"); if(zeroNum > 0) { patBuf.append("."); for(int i
                 = 0; i < zeroNum; i++) { patBuf.append("0"); }

        }
        form.applyPattern(patBuf.toString());
        return form.format(Double.parseDouble(num)).toString();
    }
%>

<!-- **** tianyang add for pos ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** tianyang add for pos ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String work_name = (String)session.getAttribute("workName");
	String serviceName="";
	String brand_code="";
	String type_code="";
	String prepay_fee="";
	String prepay_money="";
	String sp_money="";
	String chinaFee="";
	String xx_money="";
	String gift_name="";
	String gift_code="";
	String IMEINo="";
	String main_fee="";
	String second_fee="";
	String second_phone="";
	String free_fee="";
	String base_fee="";
%>
<HTML>
<head>
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%      
/*--------------------------------��֯s1270Cfm�Ĵ������-------------------------------*/
String thework_no = (String)session.getAttribute("workNo");                                   //��������                    0  �������� iLoginNo                          
String psw =(String)session.getAttribute("password");                                         //��������					1  �������� iLoginPwd                           
String theop_code = WtcUtil.repNull(request.getParameter("iOpCode"));                         //��������					2  iOpCode                                     
System.out.println("zhangyan~~~~~~~~theop_code~~~~~~"+theop_code);
String iadd_str =WtcUtil.repNull(request.getParameter("iAddStr"));                 						//���Ի���Ϣ
String link_count="0";
String themob = WtcUtil.repNull(request.getParameter("i1"));                        					//�ֻ�����					3  �ƶ����� iPhoneNo                           
String maincash = WtcUtil.repNull(request.getParameter("i16"))    ; 					//���ײʹ������				4  ��ǰ���ײʹ��� iOldMode                     
if(maincash.indexOf("-")!=-1){
	maincash = maincash.substring(0,maincash.indexOf("-")); 
}
String old_cash = WtcUtil.repNull(request.getParameter("ip"));       					//�����ײʹ���				5  �����ײʹ��� iNewMode                       
if(old_cash.indexOf(" ")!=-1){
	old_cash = old_cash.substring(0,old_cash.indexOf(" ")); 
}
String maincash_flag = WtcUtil.repNull(request.getParameter("tbselect")).substring(0,1);			//���ײ���Ч��־			6  ���ײͱ������Ч��ʽ iSendFlag    
String addcash_string = WtcUtil.repNull(request.getParameter("kx_habitus_bunch"));         	  //��ѡ�ײ͵Ĵ��봮			7  ��ѡ�ײ͵Ĵ��봮 iAddModeStr               
String do_string=WtcUtil.repNull(request.getParameter("kx_code_bunch"));           					//��ѡ�ײ͵�״̬��			8  ��ѡ�ײ͵ı���� iAddChgStr                 

String flag_string=WtcUtil.repNull(request.getParameter("kx_operation_bunch"));      					//��ѡ�ײ͵���Ч��ʽ��        9  ��ѡ�ײ͵ı���� iAddSendStr                                       
String favour = WtcUtil.repNull(request.getParameter("favorcode"));                    				//�Żݴ���					10 �Żݴ��� iFavourCde        				                 
String realcash = WtcUtil.repNull(request.getParameter("i19"));                     					//ʵ��������				 	11 ʵ�������� iRealFee                         
String fircash = WtcUtil.repNull(request.getParameter("i20"));                      					//�̶�������				 	12 Ӧ�������� iShouldFee                       
String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));                  					//ϵͳ��ע					13 ϵͳ��־ iSysNote                           
String donote = WtcUtil.repNull(request.getParameter("tonote"));                    					//������ע					14 ������־ iOpNote                            
String stream = WtcUtil.repNull(request.getParameter("stream"));       //ϵͳ��ˮ					15 ��ӡ��ˮ iLoginAccept                                                
String ip = WtcUtil.repNull(request.getParameter("ipAddr"));                                           //��½IP					    16 ��¼IP  iIpAddr                            										
String add_stream_str=WtcUtil.repNull(request.getParameter("kx_stream_bunch"));      					//ԭ��ѡ�ײ͵Ŀ�ͨ��ˮ��   		17 ��ѡ�ײ͵Ŀ�ͨ��ˮ  iOldAcceptStr          
String main_cash_stream = WtcUtil.repNull(request.getParameter("main_cash_stream"));					//��ǰ���ײͿ�ͨ��ˮ			18 ��ǰ���ײͿ�ͨ��ˮ  iCurModeAccept         
String next_main_cash = WtcUtil.repNull(request.getParameter("next_main_cash"));    					//�������ײ�        			19 �������ײ�          iNextMode              

System.out.println(" zhangyan~~~next_main_cash="+next_main_cash+"|");
if(next_main_cash.indexOf("-")!=-1){
	next_main_cash = next_main_cash.substring(0,next_main_cash.indexOf("-")); 
}
String next_main_stream = WtcUtil.repNull(request.getParameter("next_main_stream"));					//�������ײͿ�ͨ��ˮ			20 �������ײͿ�ͨ��ˮ  iNextModeAccept        
String iAddRateStr = WtcUtil.repNull(request.getParameter("iAddRateStr"));										//iAddRateStr˵��:  'A001^8032:'  A001�Ƕ������۴��룬8032�ǹ�����Ϣ��С�������
String beforeOpCode = WtcUtil.repNull(request.getParameter("beforeOpCode"));									//����ʱ���Ͷ�Ӧ����ҵ���opCode 
String returnPage = WtcUtil.repNull(request.getParameter("returnPage"));											//����ʱ���Ͷ�Ӧ����ҵ���opCode 
System.out.println("---------1270_4.jsp------returnPage="+returnPage);
String award_flag=""; //sunzx add at 20070906

String strHasEval = WtcUtil.repNull(request.getParameter("haseval"));													//�Ƿ����û���������� 
String strEvalCode = WtcUtil.repNull(request.getParameter("evalcode"));												//�û���������۴��� 

System.out.println(" zhangyan~~~strHasEval="+strHasEval);
System.out.println(" zhangyan~~~strEvalCode="+strEvalCode);
//���Ӳ���������վԤԼ��ǰ̨���� ningtn
String banlitype = WtcUtil.repNull(request.getParameter("banlitype"));
float  handcash = Float.parseFloat(realcash);                     														//�����ѵ�����

/*********liujian add �׶λ���� begin**********************/
//�׶λ����
String e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
String sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
System.out.println(" zhangyan~~~--------------------liujian-----------------" + e505_sale_name);
System.out.println(" zhangyan~~~--------------------liujian-----------------sale_name=" + sale_name);
//�µ���Ԥ��
String mon_prepay_limit = WtcUtil.repNull(request.getParameter("mon_prepay_limit"));
/*********liujian add �׶λ���� end**********************/

/********tianyang add at 20090928 for POS�ɷ�����****start*****/
String payType				 = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
String MerchantNameChs = request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
String MerchantId      = request.getParameter("MerchantId");
String TerminalId      = request.getParameter("TerminalId");
String IssCode         = request.getParameter("IssCode");
String AcqCode         = request.getParameter("AcqCode");
String CardNo          = request.getParameter("CardNo");
String BatchNo         = request.getParameter("BatchNo");
String Response_time   = request.getParameter("Response_time");
String Rrn             = request.getParameter("Rrn");
String AuthNo          = request.getParameter("AuthNo");
String TraceNo         = request.getParameter("TraceNo");
String Request_time    = request.getParameter("Request_time");
String CardNoPingBi    = request.getParameter("CardNoPingBi");
String ExpDate         = request.getParameter("ExpDate");
String Remak           = request.getParameter("Remak");
String TC              = request.getParameter("TC");
String transTotal			 = request.getParameter("transTotal");
/********tianyang add at 20090928 for POS�ɷ�����****end*******/
System.out.println(" zhangyan~~~payType : " + payType + "MerchantNameChs : " + MerchantNameChs + "Response_time : " + Response_time + " Request_time : " + Request_time);
String flag_code = WtcUtil.repNull(request.getParameter("flag_code"));
String rateCode = WtcUtil.repNull(request.getParameter("rateCode")); 
    
//String rateFlag = rateCode +"$"+flag_code+"$"+"&"; 
String rateFlag = flag_code;	
String sq1="select count(*) from sPrepayPhoneCfg where region_code='"+regionCode+"' "+
			" and op_code='"+theop_code+"' and to_char(sysdate,'yyyymmdd') between trim(sale_code) and mode_limit";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=themob%>" outnum="1">
		<wtc:sql><%=sq1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />	
<%
		if(result!=null&&result.length>0){
			link_count = result[0][0]; 
		}
%>
<%
	System.out.println(" zhangyan~~~wwwwwwwww === "+ rateFlag);

/*--------------------------------��ʼ����s1270Cfm--------------------------------*/
		String paraAray[] = new String[43];	
		paraAray[0] = stream; //15 ��ӡ��ˮ                iLoginAccept    stream
		paraAray[1] = ""; //������ʶ
		paraAray[2] = theop_code; //2                          iOpCode   theop_code
		paraAray[3] = thework_no; //0  ��������                iLoginNo  thework_no
		paraAray[4] = psw; //1  ��������                iLoginPwd psw
		paraAray[5] = themob; //3  �ƶ�����                iPhoneNo  themob
		paraAray[6] = "";    //�ƶ����� ����
		paraAray[7] = maincash; //4  ��ǰ����Ʒ����          iOldMode  maincash 
		paraAray[8] = old_cash; //5  ������Ʒ����            iNewMode  old_cash  
		paraAray[9] = maincash_flag; //6  ����Ʒ�������Ч��ʽ    iSendFlag  maincash_flag
		paraAray[10] = do_string; //7  ��ѡ��Ʒ�Ĵ��봮        iAddModeStr do_string
		paraAray[11] = addcash_string; //8  ��ѡ��Ʒ��״̬��        iAddStatusStr addcash_string
		paraAray[12] = flag_string; //9  ��ѡ��Ʒ����Ч��ʽ��    iAddSendStr   flag_string
		paraAray[13] = favour; //10 �Żݴ���                iFavourCode    favour
		paraAray[14] = realcash; //11 ʵ��������              iRealFee       realcash
		paraAray[15] = fircash; //12 Ӧ��������              iShouldFee     fircash
		paraAray[16] = iadd_str ; //13 ϵͳ��־                iSysNote       iadd_str
		if(donote.length()>60){
	  		paraAray[17] = donote.substring(0,60); //14 ������־                iOpNote        donote
		}else{
			paraAray[17] = donote; //14 ������־                iOpNote        donote
		}
		paraAray[18] = ip; //16 ��¼IP                  iIpAddr          ip
		paraAray[19] = add_stream_str; //17 ��ѡ��Ʒ�Ŀ�ͨ��ˮ      iOldAcceptStr    add_stream_str
		paraAray[20] = main_cash_stream; //18 ��ǰ����Ʒ��ͨ��ˮ      iCurModeAccept    main_cash_stream
		paraAray[21] = next_main_cash; //19 ��������Ʒ              iNextMode         next_main_cash
		paraAray[22] = next_main_stream; //20 ��������Ʒ��ͨ��ˮ      iNextModeAccept   next_main_stream
		paraAray[23] = rateFlag; //21 ����Ʒ�������۹�����Ϣ�� iAddRateStr       iAddRateStr
		paraAray[24] = beforeOpCode; //22   ����ʱ���Ͷ�Ӧ����ҵ���opCode 
		
		/********tianyang add at 20090928 for POS�ɷ�����****start*****/
		paraAray[25] = payType				 ;
		paraAray[26] = MerchantNameChs ;
		paraAray[27] = MerchantId      ;
		paraAray[28] = TerminalId      ;
		paraAray[29] = IssCode         ;
		paraAray[30] = AcqCode         ;
		paraAray[31] = CardNo          ;
		paraAray[32] = BatchNo         ;
		paraAray[33] = Response_time   ;
		paraAray[34] = Rrn             ;
		paraAray[35] = AuthNo          ;
		paraAray[36] = TraceNo         ;
		paraAray[37] = Request_time    ;
		paraAray[38] = CardNoPingBi    ;
		paraAray[39] = ExpDate         ;
		paraAray[40] = Remak           ;
		paraAray[41] = TC              ;
		/********tianyang add at 20090928 for POS�ɷ�����****end*******/
		/*ningtn ��վ���غ�Լ�ƻ�*/
		paraAray[42] = banlitype;
		/****liujian add begin****/
		String monitorValue = request.getParameter("monitorValue");
		
		for(int i=0; i<26; i++){
			System.out.println(" zhangyan~~~-----jsp paraAray["+i+"]="+paraAray[i]);
		}
		/****liujian add end****/
		for(int i=25; i<42; i++){
			System.out.println(" zhangyan~~~jsp paraAray["+i+"]="+paraAray[i]);
		}
		
		
		if(theop_code.equals("e721")||theop_code.equals("4265")||theop_code.equals("127b")||theop_code.equals("127a")||theop_code.equals("1206")||theop_code.equals("1198")||theop_code.equals("126c")||theop_code.equals("126i")||theop_code.equals("8035")||theop_code.equals("125c")||theop_code.equals("2282")||theop_code.equals("2265")||theop_code.equals("2284")||theop_code.equals("7118")||theop_code.equals("8071")||theop_code.equals("8043")||theop_code.equals("8045")||theop_code.equals("8028")||theop_code.equals("8024")||theop_code.equals("8091")||theop_code.equals("7964")||theop_code.equals("7966")||theop_code.equals("7374")||theop_code.equals("7382")||theop_code.equals("7976")||theop_code.equals("7982")||theop_code.equals("7899") ||theop_code.equals("7672") || theop_code.equals("8552")||theop_code.equals("7689")||theop_code.equals("e506")||theop_code.equals("e529")){
		  //����
		   serviceName = "s127bCfm";
		}else if(theop_code.equals("g122") || theop_code.equals("g124")){
			/*
				g122 ��TD����̻���ͨ�ŷ�
				g124 ��TD����̻���ͨ�ŷ�(��ͨ)
			*/
			serviceName = "sg122Cfm";
		}else if(theop_code.equals("g123") || theop_code.equals("g125")){
			/*
				g123 ��TD����̻���ͨ�ŷѳ���
				g125 ��TD����̻���ͨ�ŷ�(��ͨ)����
			*/
			serviceName = "sg123Cfm";
		}else{
			//����
		 	serviceName = "s127qCfmEx";
		}
	for(int i=0;i<paraAray.length;i++){
		System.out.println(" zhangyan~~~paraAray["+i+"]="+paraAray[i]);
	}		
		//ret = impl.callService(serviceName,paraAray,"2","phone",themob);
%>
		<wtc:service name="<%=serviceName%>" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
		<wtc:param value="<%=paraAray[25]%>"/>
		<wtc:param value="<%=paraAray[26]%>"/>
		<wtc:param value="<%=paraAray[27]%>"/>
		<wtc:param value="<%=paraAray[28]%>"/>
		<wtc:param value="<%=paraAray[29]%>"/>
		<wtc:param value="<%=paraAray[30]%>"/>
		<wtc:param value="<%=paraAray[31]%>"/>
		<wtc:param value="<%=paraAray[32]%>"/>
		<wtc:param value="<%=paraAray[33]%>"/>
		<wtc:param value="<%=paraAray[34]%>"/>
		<wtc:param value="<%=paraAray[35]%>"/>
		<wtc:param value="<%=paraAray[36]%>"/>
		<wtc:param value="<%=paraAray[37]%>"/>
		<wtc:param value="<%=paraAray[38]%>"/>
		<wtc:param value="<%=paraAray[39]%>"/>
		<wtc:param value="<%=paraAray[40]%>"/>
		<wtc:param value="<%=paraAray[41]%>"/>
		<wtc:param value="<%=paraAray[42]%>"/>
		<wtc:param value="<%=monitorValue%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%	
		System.out.println("zhouby:   " + monitorValue);
		int ret_code = 999999;
		if(retCode!=""){
			ret_code = Integer.parseInt(retCode);
		}		
		System.out.println(" zhangyan~~~#$#$#$#$#$#$#$#$#$#$#$#$#$#" + serviceName + " | " + ret_code + "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#");
%>

<!-- tianyang add for pos start *** boss���׳ɹ� ��������ȷ�Ϻ��� -->
<%
System.out.println("zhangyan~~~~~~~~~~~~~~ret_code~" +ret_code);
//ret_code=0;
if(ret_code==0){%>

<script language="jscript">
if("<%=payType%>"=="BX"){
	BankCtrl.TranOK();
}
if("<%=payType%>"=="BY"){
	var IfSuccess = KeeperClient.UpdateICBCControlNum();
}
</script>
<%}%>
<!-- tianyang add for pos end *** boss���׳ɹ� ��������ȷ�Ϻ��� -->

<%  
		String ret_msg = retMsg;
		System.out.println(" zhangyan~~~ret_code=====222=============="+ret_code);
		

		System.out.println(" zhangyan~~~%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");	
		String cnttLoginAccept = "";
		String opName2 = (String)request.getParameter("opName");
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+retCode+"&opName="+opName2+"&workNo="+thework_no+"&loginAccept="+stream+"&pageActivePhone="+themob+"&opBeginTime="+opBeginTime+"&contactId="+themob+"&contactType=user";
    System.out.println(url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%	
		System.out.println(" zhangyan~~~%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	//���� 2008��1��3�� �޸������û��������������
  if(0==ret_code && strHasEval.equals("1")){
		String strParaAray[] = new String[6];
	  strParaAray[0] = thework_no; 	//0  ��������                iLoginNo  thework_no
	  strParaAray[1] = theop_code; 	//1  ��������                iOpCode   theop_code
	  strParaAray[2] = themob; 			//2  �ƶ�����                iPhoneNo  themob                         
	  strParaAray[3] = strEvalCode; //3  ���۴���
	  strParaAray[4] = stream; 			//5  ������ˮ
	  strParaAray[5] = "0"; 
	  //ret = impl.callService("sCommEvalCfm",strParaAray,"2","phone",themob);
%>
		<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=themob%>" outnum="2" >
		<wtc:param value="<%=strParaAray[0]%>"/>
		<wtc:param value="<%=strParaAray[1]%>"/>
		<wtc:param value="<%=strParaAray[2]%>"/>
		<wtc:param value="<%=strParaAray[3]%>"/>
		<wtc:param value="<%=strParaAray[4]%>"/>
		<wtc:param value="<%=strParaAray[5]%>"/>
		</wtc:service>
		<wtc:array id="result4" scope="end"/>	
<%
		int iReturnCode = 999999;
		if(retCode!=""){
			iReturnCode = Integer.parseInt(retCode);
		}
    String strReturnMsg = retMsg;
    
    System.out.println(" zhangyan~~~iReturnCode="+iReturnCode);
    System.out.println(" zhangyan~~~strReturnMsg="+strReturnMsg);
	}

//�Է�����Ϣ�Ŀ���
  if(ret_msg.equals("")){
			ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg((new Integer(ret_code)).toString()));
			if( ret_msg.equals("null")){
				ret_msg ="δ֪������Ϣ";
			}
		}

/*------------------------------���ݵ��÷��񷵻ؽ������ҳ����ת------------------------------*/
/* ningtn ��վ���غ�Լ�ƻ�*/
if(0==ret_code && "1".equals(banlitype)){
	/*�ύ����ɹ� ��������վԤԼ����ģ�����sE385Cfm����*/
	if("e505".equals(theop_code)){
		/*
			�߹�����1270ҳ���opcode
			�Ժ���ܻ������µ�opcode������Ӿ�����
		*/
		String iOpCode		= 		request.getParameter("iOpCode");;
		String iLoginNo		= 		thework_no;
		String iLoginPwd	= 		psw;
		String iPhoneNo		= 		themob;	
		String iUserPwd 	= 		"";
		String inOpNote 	= 		donote;
		String iBookingId = 		"";
		String iLoginAccept=  	stream; 
		String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
				+"&iLoginNo="+iLoginNo
				+"&iLoginPwd="+iLoginPwd
				+"&iPhoneNo="+iPhoneNo
				+"&iUserPwd="+iUserPwd
				+"&inOpNote"+inOpNote
				+"&iLoginAccept="+iLoginAccept
				+"&iBookingId="+iBookingId;		
		System.out.println("booking_url="+booking_url);
		%>
		<jsp:include page="<%=booking_url%>" flush="true" />
		<%
		System.out.println("%%%%%%%����ԤԼ�������%%%%%%%%"); 
		System.out.println("7955����sE385Cfm�������");
	}
}
%>
<%
		/*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
		String cardno = WtcUtil.repNull(request.getParameter("i7"));                        //���֤����
		String name = WtcUtil.repNull(request.getParameter("i4"));                        //�û�����
		String address = WtcUtil.repNull(request.getParameter("i5"));					  //�û���ַ
		/***********************************************************************************************/
	System.out.println(" zhangyan~~~mylog  iadd_str ="+iadd_str);
	if(theop_code.equals("8042")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<15; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		//���������     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		//���������     END
		if(i==11){second_phone = iadd_str.substring(bb,aa);}
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;

	}
	
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8043")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<12; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==9){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==10){second_phone = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
		if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}

}
if(theop_code.equals("7671")){
	
	int aa=0;
	int bb=0;                    
	//Ӫ������|Ʒ������|Ӧ�ս��|����Ԥ��|�Ԥ��|��������|�̻�����|�̻��������·�|�ֻ�������������|IMEI��|�ֻ�������|�ֻ�����|�н���־|
 	for (int i=1; i<14; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}   //Ӧ�ս��
		if(i==4){main_fee=iadd_str.substring(bb,aa);}     //����
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}  //�
		if(i==6){type_code=iadd_str.substring(bb,aa);}    //��������
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==11){second_phone = iadd_str.substring(bb,aa);} //�ֻ�������
		if(i==12){second_fee=iadd_str.substring(bb,aa);}   //�ֻ�����
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;
	}
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7672")){
	//iAddStr��ʽ ԭ��ˮ|Ӫ������|Ӧ�ս��|����Ԥ��|�Ԥ��|�̻���|�����·�|���ֻ�����|��������|�ֻ�������|�ֻ�����������|�����ʷ�|
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){prepay_money=iadd_str.substring(bb,aa);} 
		if(i==8){second_fee=iadd_str.substring(bb,aa);}
		if(i==9){brand_code=iadd_str.substring(bb,aa);}
		if(i==10){second_phone = iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
		if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}

}
if(theop_code.equals("8044")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<15; i++)
	{ //Ӫ������|Ʒ������|Ӧ�ս��|���ͻ���|����Ԥ��|��������|�����·�|SIM����|�µ���|IMEI��|������|
		
		//00095975|ŵ����|520.00|150.00|18.00|N6030|13.00|89860068081504579634|25.00|358834008977126|0|520.00|10559|0|

		//00095915|ŵ����|520.00|150.00|18.00|N6030|13.00|89860068081504579634|25.00|358834008977126|0|520.00|10559|0|
		//76988402511|00095915|520|150|18|13|25|ŵ����N6030|352|520|358834008977126|14780 ���еش���С��������|
		
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==11){second_phone = iadd_str.substring(bb,aa);}
		if(i==14){award_flag = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	xx_money=formatNumber(main_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8045")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<12; i++)
	{ //����ˮ|Ӫ������|Ӧ��|����Ԥ��|����ר��|��������|�µ���|����|������|�ֻ�ԭ��|IMEI|
		aa=iadd_str.indexOf("|",aa+1);
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){main_fee=iadd_str.substring(bb,aa);}
		if(i==5){second_fee=iadd_str.substring(bb,aa);}
		if(i==9){second_phone = iadd_str.substring(bb,aa);}
		if(i==11){IMEINo = iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
		xx_money=formatNumber(main_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("126h") || theop_code.equals("8023")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==6){type_code=iadd_str.substring(bb,aa);}
		//���������     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		if(i==12){award_flag = iadd_str.substring(bb,aa);}
		//���������     END
		bb=aa+1;

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("126i") || theop_code.equals("8024")){
	
	int aa1=0;
	int bb1=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		
		if(i1==3){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==10){type_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8034")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){brand_code=iadd_str.substring(bb,aa);}
		if(i==6){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==3){prepay_money=iadd_str.substring(bb,aa);}
		if(i==4){sp_money=iadd_str.substring(bb,aa);}
		if(i==5){type_code=iadd_str.substring(bb,aa);}
		if(i==9){gift_name=iadd_str.substring(bb,aa);}
		if(i==8){gift_code=iadd_str.substring(bb,aa);}
		//���������     START
		if(i==10){IMEINo = iadd_str.substring(bb,aa);}
		//���������     END
		bb=aa+1;
		

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8035")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}
		if(i==6){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==4){prepay_money=iadd_str.substring(bb,aa);}
		if(i==5){sp_money=iadd_str.substring(bb,aa);}
		if(i==8){gift_name=iadd_str.substring(bb,aa);}
		
		bb=aa+1;
		

	} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8070")||theop_code.equals("8071")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<8; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==2){prepay_money=iadd_str.substring(bb,aa);}
		if(i==6){IMEINo=iadd_str.substring(bb,aa);}
		
		bb=aa+1;
		

	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("2281")||theop_code.equals("2283")||theop_code.equals("2264")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<9; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("2282")||theop_code.equals("2284")||theop_code.equals("2265")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==2){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==9){brand_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090410
if(theop_code.equals("7371")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<9; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
		if(i==2){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==8){brand_code=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7374")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<11; i1++)
	{ 
		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==2){prepay_fee=iadd_str.substring(bb1,aa1);}
		if(i1==9){brand_code=iadd_str.substring(bb1,aa1);}
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090414
if(theop_code.equals("7379")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<13; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}   	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}   
        if(i==5){second_fee=iadd_str.substring(bb,aa);} 
        if(i==7){sp_money=iadd_str.substring(bb,aa);} 
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} 
        if(i==12){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7382")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<14; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}   	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}   
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);} 
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);} 
        if(i1==11){prepay_money=iadd_str.substring(bb1,aa1);} 
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//add sunaj  20090516
if(theop_code.equals("7975")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}   	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}   
        if(i==5){second_fee=iadd_str.substring(bb,aa);} 
        if(i==7){sp_money=iadd_str.substring(bb,aa);} 
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} 
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7976")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}   	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}   
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);} 
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);} 
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//��TD�̻������� sunaj  20090828 start 20100427 ��ͨ
if(theop_code.equals("7981") || theop_code.equals("8551")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //�ͺ�  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //Ӧ�����
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //����
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //������
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //�г���
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7982") || theop_code.equals("8552")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //����
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //������
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//��TD�̻������� sunaj  20090828  end
//��TD����̻���ͨ�ŷ� sunaj  20090902 start
if(theop_code.equals("7898") || theop_code.equals("g122")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //�ͺ�  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //Ӧ�����
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //����
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //������
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //�г���
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7899") || theop_code.equals("g123")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //����
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //������
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//��TD����̻���ͨ�ŷ� sunaj  20090902  end

//��TD����̻�����ͨ�ŷ�(��ͨ) wangyua  20100512 start
if(theop_code.equals("7688") || theop_code.equals("g124")){
	int aa=0;
	int bb=0;
 	for (int i=1; i<12; i++)
	{ 
		iadd_str=iadd_str+"|";
		aa=iadd_str.indexOf("|",aa+1);
		if(i==3){brand_code=iadd_str.substring(bb,aa);}  //�ͺ�  	
        if(i==4){prepay_fee=iadd_str.substring(bb,aa);}  //Ӧ�����
        if(i==5){second_fee=iadd_str.substring(bb,aa);}  //����
        if(i==7){sp_money=iadd_str.substring(bb,aa);}    //������
        if(i==10){prepay_money=iadd_str.substring(bb,aa);} //�г���
        if(i==11){IMEINo=iadd_str.substring(bb,aa);}
		bb=aa+1;
	} 
       
    xx_money=formatNumber(prepay_fee,2);
    //xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("7689") || theop_code.equals("g125")){
	int aa1=0;
	int bb1=0;
 	for (int i1=1; i1<13; i1++)
	{ 

		aa1=iadd_str.indexOf("|",aa1+1);
		if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
        if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
        if(i1==6){second_fee=iadd_str.substring(bb1,aa1);}  //����
        if(i1==8){sp_money=iadd_str.substring(bb1,aa1);}    //������
        if(i1==10){prepay_money=iadd_str.substring(bb1,aa1);} 
        if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
        System.out.println(" zhangyan~~~=========================="+iadd_str);
 
		bb1=aa1+1;
	} 
	xx_money=formatNumber(prepay_fee,2);
	//xx_money=formatNumber(prepay_limit,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
//��TD����̻���ͨ�ŷ� wangyua  20100512  end
if(theop_code.equals("8027")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<7; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
	
		if(i==1){type_code=iadd_str.substring(bb,aa);} //sale_code
		if(i==2){brand_code=iadd_str.substring(bb,aa);}//agent_code
		if(i==3){prepay_fee=iadd_str.substring(bb,aa);}//Ԥ���
		if(i==4){type_code=iadd_str.substring(bb,aa);}//phone_type
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}//������
		if(i==6){IMEINo=iadd_str.substring(bb,aa);}//ImeiNo
		
		bb=aa+1;
	
	} 
	xx_money=formatNumber(prepay_money,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
if(theop_code.equals("8028")){
	
	int aa=0;
	int bb=0;
	//String aString ="0000000001|200.00|aaaaaa|";
 	for (int i=1; i<13; i++)
	{ 
		aa=iadd_str.indexOf("|",aa+1);
	 //iAddStr��ʽ ԭ��ˮ|Ӫ������|��������|���ͻ���|������|	
		//if(i==1){=iadd_str.substring(bb,aa);}
		if(i==2){type_code=iadd_str.substring(bb,aa);}
		if(i==3){brand_code=iadd_str.substring(bb,aa);}
		if(i==4){prepay_fee=iadd_str.substring(bb,aa);}
		if(i==5){prepay_money=iadd_str.substring(bb,aa);}
		bb=aa+1;

	} 
	xx_money=formatNumber(prepay_money,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
%>

<%
		/***************liujian  e505  e506��Լ�ƻ�������ʼ******************/
	if(theop_code.equals("e505")){
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
      if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
      if(i1==5){second_fee=iadd_str.substring(bb1,aa1);} //����Ԥ��
      if(i1==6){//��������
      	sp_money=iadd_str.substring(bb1,aa1);
      }    
      if(i1==7){prepay_money=iadd_str.substring(bb1,aa1); } //�Ԥ��
      if(i1==11){
      	IMEINo=iadd_str.substring(bb1,aa1);
      	System.out.println(" zhangyan~~~------liujian-----------IMEINo=" +IMEINo);
      }
      System.out.println(" zhangyan~~~========liujia=================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e506")){
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
      if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
      if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
/***************liujian  e528  e529��Լ�ƻ�������ʼ******************/
if(theop_code.equals("e528")){
//Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ����������0��imei��
//�ɷѺϼƣ�XXԪ  ����Ԥ�滰��XXԪ��ÿ�·�����XXԪ��һ���Է�����XXԪ��ÿ�����ͷ��ã�XXԪ��
		int aa1=0;
		int bb1=0;
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
      if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
      if(i1==5){second_fee=iadd_str.substring(bb1,aa1);}  //����Ԥ��
      if(i1==7){//�Ԥ��
      	prepay_money=iadd_str.substring(bb1,aa1); 
      	//Ԥ���=�Ԥ��+����Ԥ��
      	second_fee = Float.parseFloat(prepay_money) + Float.parseFloat(second_fee) + "";
      }
			if(i1==9){second_phone=iadd_str.substring(bb1,aa1);}//������Ԥ���
      if(i1==11){
      	IMEINo=iadd_str.substring(bb1,aa1);
      	System.out.println(" zhangyan~~~------liujian-----------IMEINo=" +IMEINo);
      }
      System.out.println(" zhangyan~~~========liujia=================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e529")){
		int aa1=0;
		int bb1=0;
		//������ˮ��Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ����������
		//				��������Ԥ������0��imei���
	 	for (int i1=1; i1<13; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==4){brand_code=iadd_str.substring(bb1,aa1);}  //�ͺ� 	
      if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
      if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
			bb1=aa1+1;
		} 
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
System.out.println("zhangyan ~~~~~~~~~~~~~~~~~~~~~athe opcode end");
/***************liujian  e528  e529��Լ�ƻ���������******************/

if(theop_code.equals("e720")){
		int aa1=0;
		int bb1=0;
		//������ˮ��Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ����������
		//				��������Ԥ������0��imei���
	 	for (int i1=1; i1<12; i1++)
		{ 
			aa1=iadd_str.indexOf("|",aa1+1);
			if(i1==3){brand_code=iadd_str.substring(bb1,aa1);
				System.out.println("zhangyan~~~~~~~~~~brand_code");
			}  //�ͺ� 	
			if(i1==7){free_fee=iadd_str.substring(bb1,aa1);}  //�Ż��ܽ�� 	
			if(i1==9){base_fee=iadd_str.substring(bb1,aa1);}  //�Żݱ��� 	
			if(i1==4){prepay_fee=iadd_str.substring(bb1,aa1);}  //Ӧ����� 
			if(i1==11){IMEINo=iadd_str.substring(bb1,aa1);}
      System.out.println(" zhangyan~~~=========================="+iadd_str);
      System.out.println(" zhangyan~~~===========IMEINo==============="+IMEINo);
			bb1=aa1+1;
		} 
		System.out.println("zhangyan~~~~~~~~~~~~~~~~`"+xx_money);
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}

if(theop_code.equals("e721")){
		int aa1=0;
		int bb1=0;

	 	for (int i1=1; i1<13; i1++)
		{ 
				
			aa1=iadd_str.indexOf("|",aa1+1);
			if (i1==4){brand_code=iadd_str.substring(bb1,aa1);}
			if(i1==5){prepay_fee=iadd_str.substring(bb1,aa1);}  //��д���
			if(i1==12){IMEINo=iadd_str.substring(bb1,aa1);}  //IMEI�룺
			if(i1==8){free_fee=iadd_str.substring(bb1,aa1);}  //�Ż��ܽ��
			if(i1==10){base_fee=iadd_str.substring(bb1,aa1);}  //�Ż��ܽ��
      System.out.println(" zhangyan~~~=========================="+iadd_str);
      System.out.println(" zhangyan~~~===========IMEINo==============="+IMEINo);
			bb1=aa1+1;
		} 
		System.out.println("zhangyan~~~~~~~~~~~~~~~~`"+xx_money);
		xx_money=formatNumber(prepay_fee,2);
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" >
		<wtc:param value="<%=xx_money%>"/>
		</wtc:service>
		<wtc:array id="chinaFeeArr" scope="end"/>	
<%
	 if(chinaFeeArr!=null&&chinaFeeArr.length>0){
			chinaFee = chinaFeeArr[0][2];
		}
}
%>
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+='<%=cardno%>'+"|";//���֤����                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=name%>'+"|";//�û�����                                                
	 infoStr+='<%=address%>'+"|";//�û���ַ
	 infoStr+="�ֽ�"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="���ʷѱ����*�����ѣ�"+'<%=realcash%>'+"*��ˮ�ţ�"+'<%=stream%>'+"|";
	 var dirtPage="";
	 <%if(theop_code.equals("1255")){%>
		 dirtPate = "/npage/bill/f1255_login.jsp";
	 <%}else{%>
         dirtPate = "/npage/bill/f1270_1.jsp";
	 <%}%>
	 location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8042(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      Ԥ�����ֻ������ѹ�����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�ɿ�ϼƣ�<%=prepay_fee%>"+ "Ԫ,������Ԥ�滰��<%=main_fee%>"+"Ԫ,����Ԥ�滰��<%=second_fee%>"+"Ԫ,�������룺<%=second_phone%>,IMEI�룺<%=IMEINo%>"+"|";
	  infoStr+="<%=work_name%>"+"|";//��Ʊ��

	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="�Ѳ���������Ʒ�"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	     infoStr+="  "+"|";
	     infoStr+="  "+"|";
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8042_login.jsp?activePhone=<%=themob%>&opCode=8042&opName=Ԥ�����ֻ������ѹ�����";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8042&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8043(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      Ԥ�����ֻ������ѹ��������"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�˿�ϼƣ�<%=prepay_fee%>"+ "Ԫ,������Ԥ�滰��<%=main_fee%>"+"Ԫ,����Ԥ�滰��<%=second_fee%>"+"Ԫ,�������룺<%=second_phone%>"+"|";
	  infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	  infoStr+=" "+"|";//�տ���
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
        infoStr+=" "+"|";
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8042_login.jsp?activePhone=<%=themob%>&opCode=8043&opName=Ԥ�����ֻ������ѹ��������";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8043&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill7671()
{		 
	 var infoStr="";  
	 var base_fee=parseFloat("<%=prepay_money%>")+parseFloat("<%=main_fee%>");   
	                                                                       
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      Ԥ�����̻������ѿɷ���"+"|";  //����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+=" "+"|";         
	 infoStr+="<%=chinaFee%>"+"|";       //�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";       //Сд
	 
	 infoStr+="TD�̻�Ʒ���ͺ�"+'<%=brand_code%>'+'<%=type_code%>'; 
	 infoStr+=",IMEI��<%=IMEINo%>"+",�����ֻ�������<%=second_phone%>"+",�ɿ�ϼ�<%=prepay_fee%>"+"Ԫ,"+"���̻�������"+base_fee+"Ԫ,�ֻ�������<%=second_fee%>"+"Ԫ��"+"|";

	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 if("<%=award_flag%>" == "1")
	 {
	 		infoStr+="�Ѳ���������Ʒ�"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";            
	 dirtPate = "/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ���";
	 //location = "/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ���";
	 location = "/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7671&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ���";
	 // location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill7672()
{

	 var infoStr=""; 
	 var base_fee=parseFloat("<%=prepay_money%>")+parseFloat("<%=main_fee%>");  	
	                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      Ԥ�����̻������ѿɷ������"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+=" "+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 
	 infoStr+="TD�̻�Ʒ���ͺ�"+"<%=brand_code%>"+",�˿�ϼ�<%=prepay_fee%>"+"Ԫ,���̻�������"+base_fee+
	 "Ԫ,�ֻ�������<%=second_fee%>"+"Ԫ,�����ֻ�������<%=second_phone%>"+"|"; 
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";          
	 dirtPate = "/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ������";  
	 //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ������";
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7672&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7671_login.jsp?activePhone=<%=themob%>%26opCode=7671%26opName=Ԥ�����̻������ѿɷ������";
	 // location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8044(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      ������ũ���������ֻ�Ӫ��"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 

	 
	 if ("0" == "<%=second_fee%>" ){
	 infoStr+="�ɿ�ϼƣ�<%=main_fee%>"+ "Ԫ���������� <%=second_phone%>"+"Ԫ,Ԥ�滰�� <%=prepay_fee%>"+"Ԫ��IMEI�룺<%=IMEINo%>"+"|";
	 	}else{
	 infoStr+="�ɿ�ϼƣ�<%=main_fee%>"+ "Ԫ���������� <%=second_phone%>"+"Ԫ,Ԥ�滰�� <%=prepay_fee%>"+"Ԫ������ר�� <%=second_fee%>"+"Ԫ��IMEI�룺<%=IMEINo%>"+"|";

		}	 
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="�Ѳ���������Ʒ�"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){

	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=������ũ���������ֻ�Ӫ��";
	if("<%=link_count%>"=="0"){
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=������ũ���������ֻ�Ӫ��";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8044&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8044%26opName=������ũ���������ֻ�Ӫ��";
	}else{
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=��ѡ�ײͰ���";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8044&loginAccept=<%=stream%>&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=��ѡ�ײͰ���";
	}
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill8045(){   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"      ������ũ���������ֻ�Ӫ������"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 

		//���� 2007��9��29�� �޸�
		
	 if ("0" == "<%=second_fee%>"){
	 infoStr+="�˿�ϼƣ�<%=main_fee%>"+"Ԫ���������� <%=second_phone%>"+"Ԫ��Ԥ�滰�� <%=prepay_fee%>"+"Ԫ��IMEI�룺<%=IMEINo%>"+"|";
		}else{
	 infoStr+="�˿�ϼƣ�<%=main_fee%>"+ "Ԫ���������� <%=second_phone%>"+"Ԫ��Ԥ�滰�� <%=prepay_fee%>"+"Ԫ������ר�� <%=second_fee%>"+"Ԫ��IMEI�룺<%=IMEINo%>"+"|";
		}
	
	  infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 
	 var dirtPage="";
	dirtPate = "/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=������ũ���������ֻ�Ӫ������";
	if("<%=link_count%>"=="0"){
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=������ũ���������ֻ�Ӫ������";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8045&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8044_login.jsp?activePhone=<%=themob%>%26opCode=8045%26opName=������ũ���������ֻ�Ӫ������";
	}else{
		//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=��ѡ�ײͰ���";
		location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8045&loginAccept=<%=stream%>&dirtPage=/npage/bill/f3250_login.jsp?activePhone=<%=themob%>%26opCode=3250%26opName=��ѡ�ײͰ���";
	}
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}
function printBill126h(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ǩԼ����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�ɿ�ϼƣ�  <%=prepay_fee%>"+
		 "Ԫ����:Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+="IMEI�룺<%=IMEINo%>"+"|";
	 if( "<%=award_flag%>" == "1")
	 {
	 		infoStr+="�Ѳ���������Ʒ�"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 
	 /**** tianyang add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** tianyang add for pos end ****/
	 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f126h_login.jsp?activePhone=<%=themob%>&opCode=126h&opName=ǩԼ����";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=126h&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	//location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f126h_login.jsp?activePhone=<%=themob%>";
}
function printBill126i(){

	   
	 var infoStr="";                                                                         
	// infoStr+='<%=thework_no%>  <%=stream%>'+"|";//���֤����   
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ǩԼ��������"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�˿�ϼƣ�  <%=prepay_fee%>"+
		 "Ԫ����:Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 
	 /**** tianyang add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** tianyang add for pos end ****/
	 
	 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f126h_login.jsp?activePhone=<%=themob%>&opCode=126i&opName=ǩԼ��������";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=126i&loginAccept=<%=stream%>&dirtPage="+codeChg(dirtPate);
	// location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPate;
}



function printBill8094(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��������ʷ�Ӫ����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=" "+"|";//�û���ַ
	 infoStr+=" "+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8094";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	
}


function printBill2282(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ǩԼ����Ʒ����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="��Ʒ����:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�˿�ϼƣ�  <%=prepay_fee%>"+
		 "Ԫ����:Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2281_login.jsp";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2281_login.jsp?activePhone=<%=themob%>%26opCode=2281%26opName=ǩԼ����Ʒ  ";
}
function printBill2283(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ȫ��ͨǩԼ����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="��Ʒ����:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�ɿ�ϼƣ�  <%=prepay_fee%>"+
		 "Ԫ����:Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2283%26opName=ȫ��ͨǩԼ����";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2283%26opName=ȫ��ͨǩԼ����";
}
function printBill2284(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ȫ��ͨǩԼ�������"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="��Ʒ����:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�˿�ϼƣ�  <%=prepay_fee%>"+
		 "Ԫ����:Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2284%26opName=ȫ��ͨǩԼ�������";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f2283_login.jsp?activePhone=<%=themob%>%26opCode=2284%26opName=ȫ��ͨǩԼ�������";
}
//add sunaj 20090410
function printBill7371(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ���Ż���������Ӫ����"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�û�����                                                       
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�ƶ�����                                           
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="Ԥ�滰�� <%=prepay_fee%>"+"Ԫ|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 /*
	dirtPate = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=Ԥ���Ż���������Ӫ����";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=Ԥ���Ż���������Ӫ����";
	*/
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=thework_no%>");
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=name%>");
	$(billArgsObj).attr("10006","Ԥ���Ż���������Ӫ����");
	$(billArgsObj).attr("10008","<%=themob%>");
	$(billArgsObj).attr("10015","<%=xx_money%>");//Сд
	$(billArgsObj).attr("10016","<%=xx_money%>");//�ϼƽ��(��д) ��Сд������ҳת��
	$(billArgsObj).attr("10017","*");//���νɷѣ��ֽ�
	$(billArgsObj).attr("10020","");//������
	$(billArgsObj).attr("10021","<%=handcash%>");//������
	$(billArgsObj).attr("10022","");//ѡ�ŷ�
	$(billArgsObj).attr("10023","");//Ѻ��
	$(billArgsObj).attr("10024","");//SIM����
	$(billArgsObj).attr("10025","<%=prepay_fee%>");//Ԥ����
	$(billArgsObj).attr("10026","");//������
	$(billArgsObj).attr("10027","");//������
	$(billArgsObj).attr("10028","");//�����Ӫ�������
	$(billArgsObj).attr("10047","");//�����
	$(billArgsObj).attr("10030","<%=stream%>");//ҵ����ˮ
	$(billArgsObj).attr("10036","7371");
	$(billArgsObj).attr("10031","<%=work_name%>");//��Ʊ��
	
	var printInfo = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
	var path = path + "&infoStr="+printInfo+"&loginAccept=<%=stream%>&opCode=7371&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop); 
	location = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7371%26opName=Ԥ���Ż���������Ӫ����";
}
function printBill7374(){
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ���Ż���������Ӫ��������"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�û�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�ƶ�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	/*
	dirtPate = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=Ԥ���Ż���������Ӫ��������";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=Ԥ���Ż���������Ӫ��������";
	*/
	var  billArgsObj = new Object();
	$(billArgsObj).attr("10001","<%=thework_no%>");
	$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
	$(billArgsObj).attr("10005","<%=name%>");
	$(billArgsObj).attr("10006","Ԥ���Ż���������Ӫ��������");
	$(billArgsObj).attr("10008","<%=themob%>");
	$(billArgsObj).attr("10015","-<%=xx_money%>");//Сд
	$(billArgsObj).attr("10016","-<%=xx_money%>");//�ϼƽ��(��д) ��Сд������ҳת��
	$(billArgsObj).attr("10017","*");//���νɷѣ��ֽ�
	$(billArgsObj).attr("10020","");//������
	if("<%=handcash%>">0.01){
		$(billArgsObj).attr("10021","-<%=handcash%>");//������
	}else{
		$(billArgsObj).attr("10021","<%=handcash%>");//������
	}
	$(billArgsObj).attr("10022","");//ѡ�ŷ�
	$(billArgsObj).attr("10023","");//Ѻ��
	$(billArgsObj).attr("10024","");//SIM����
	$(billArgsObj).attr("10025","-<%=prepay_fee%>");//Ԥ����
	$(billArgsObj).attr("10026","");//������
	$(billArgsObj).attr("10027","");//������
	$(billArgsObj).attr("10028","");//�����Ӫ�������
	$(billArgsObj).attr("10047","");//�����
	$(billArgsObj).attr("10030","<%=stream%>");//ҵ����ˮ
	$(billArgsObj).attr("10036","7374");
	$(billArgsObj).attr("10031","<%=work_name%>");//��Ʊ��
	$(billArgsObj).attr("10072","2"); //����2
	
	var printInfo = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
	var path = path + "&infoStr="+printInfo+"&loginAccept=<%=stream%>&opCode=7374&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop); 
	location = "/npage/bill/f7371_login.jsp?activePhone=<%=themob%>%26opCode=7374%26opName=Ԥ���Ż���������Ӫ��������";
}
//add sunaj 20090414
function printBill7379(){
     var prepayfee=parseFloat("<%=prepay_fee%>")-parseFloat("<%=prepay_money%>");
     //alert("prepayfee========"+prepayfee);
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ���Żݹ���"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ������������"+'<%=prepay_money%>'+"Ԫ��Ԥ�滰��"+prepayfee+"Ԫ  ";
	 infoStr+="�ն��ͺţ�"+'<%=brand_code%>'+"  IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���

	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7379%26opName=Ԥ���Żݹ���Ӫ����";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7379%26opName=Ԥ���Żݹ���Ӫ����";
}
function printBill7382(){
     var prepayfee=parseFloat("<%=prepay_fee%>")-parseFloat("<%=prepay_money%>");
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ���Żݹ�������"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�<%=prepay_fee%>Ԫ������������<%=prepay_money%>Ԫ��Ԥ�滰��"+prepayfee+"Ԫ  ";
	 infoStr+="�ն��ͺţ�<%=brand_code%>"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7382%26opName=Ԥ���Żݹ���Ӫ��������";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7379_login.jsp?activePhone=<%=themob%>%26opCode=7382%26opName=Ԥ���Żݹ���Ӫ��������";
}
function printBill7975(){
   var prepayfee=parseFloat("<%=second_fee%>")+parseFloat("<%=sp_money%>");
     //alert("prepayfee========"+prepayfee);
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ����"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ����Ԥ�滰��"+prepayfee+"Ԫ  ";
	 infoStr+="�����ͺţ�"+'<%=brand_code%>'+"  IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���

	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7975%26opName=����Ӫ����";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7975%26opName=����Ӫ����";
}
function printBill7976(){
     var prepayfee=parseFloat("<%=second_fee%>")+parseFloat("<%=sp_money%>");
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ���񱦳���"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�<%=prepay_fee%>Ԫ����Ԥ�滰��"+prepayfee+"Ԫ  ";
	 infoStr+="�����ͺţ�<%=brand_code%>"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 var dirtPage="";
	 
	dirtPate = "/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7976%26opName=����Ӫ��������";
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7975_login.jsp?activePhone=<%=themob%>%26opCode=7976%26opName=����Ӫ��������";
}
function printBill8027(){
	   
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     ���ֻ����ͻ���"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+'<%=type_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	
	
	  infoStr+="�ɿ�ϼƣ�  <%=prepay_money%>"+
		 "Ԫ������Ԥ�滰�� <%=prepay_fee%>"+"Ԫ"+"|";

	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+="IMEI�룺<%=IMEINo%>"+"|";
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=���ֻ����ͻ���";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=���ֻ����ͻ���";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8027&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=���ֻ����ͻ���";
}
function printBill7981(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD�̻�������"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD�̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=��TD�̻�������";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=��TD�̻�������";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7981&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=��TD�̻�������";
}
function printBill8551(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD�̻�������(��ͨ)"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD�̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=��TD�̻�������(��ͨ)";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=��TD�̻�������(��ͨ)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8551&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=��TD�̻�������(��ͨ)";
}
function printBill7982(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD�̻������ѳ���"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD�̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7981_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=��TD�̻�������";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7982&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7981_login.jsp?activePhone=<%=themob%>%26opCode=7981%26opName=��TD�̻�������";
}
function printBill8552(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       ��TD�̻�������(��ͨ)����"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�˿�ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD�̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f8551_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=��TD�̻�������(��ͨ)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8552&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8551_login.jsp?activePhone=<%=themob%>%26opCode=8551%26opName=��TD�̻�������(��ͨ)";
}
function printBill7898(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ�滰����TD����̻�"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";
	 dirtPate = "/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=Ԥ�滰����TD����̻�";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=Ԥ�滰����TD����̻�";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7898&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=Ԥ�滰����TD����̻�";
}
function printBill7899(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ�滰����TD����̻�����"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f7898_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=Ԥ�滰����TD����̻�";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7899&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7898_login.jsp?activePhone=<%=themob%>%26opCode=7898%26opName=Ԥ�滰����TD����̻�";
}
function printBill7688(){

	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ�滰����TD����̻�(��ͨ)"+"|";//����                                                 
	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' > 0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/ 
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=Ԥ�滰����TD����̻�(��ͨ)";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=Ԥ�滰����TD����̻�(��ͨ)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7688&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=Ԥ�滰����TD����̻�(��ͨ)";
}
function printBill7689(){ 
	 var infoStr="";                                                                        
	 infoStr+="<%=thework_no%>  <%=stream%>"+"       Ԥ�滰����TD����̻�(��ͨ)����"+"|";//����                                                 
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+=""+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="����ϼƣ�"+'<%=prepay_fee%>'+"Ԫ��������"+'<%=second_fee%>'+"Ԫ��";
	 if('<%=sp_money%>' >0)
	 {
	 	infoStr+="������"+'<%=sp_money%>'+"Ԫ��";
	 }
	 infoStr+="TD����̻��ͺţ�"+'<%=brand_code%>'+"��IMEI�ţ�"+'<%=IMEINo%>'+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start ****/
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*ռλ��15������*/
	 		infoStr+=" "+"|";/*ռλ��16������*/
		 	infoStr+="<%=payType%>"+"|";
			infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
	 }
	 /**** ningtn add for pos end ****/
	 var dirtPage="";	 
	dirtPate = "/npage/bill/f7688_login.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=Ԥ�滰����TD����̻�(��ͨ)";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7689&loginAccept=<%=stream%>&dirtPage=/npage/bill/f7688_login.jsp?activePhone=<%=themob%>%26opCode=7688%26opName=Ԥ�滰����TD����̻�(��ͨ)";
}
function printBill8028(){
	   
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     ���ֻ����ͻ��ѳ���"+"|";//����                                                 
     	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	
	 infoStr+="�ɿ�ϼƣ�  <%=prepay_money%>"+ "Ԫ�����ͻ��� <%=prepay_fee%>"+ "Ԫ"+"|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";
	 var dirtPage=""; 
	dirtPate = "/npage/bill/f8027.jsp";
	//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=���ֻ����ͻ���";
	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=8028&loginAccept=<%=stream%>&dirtPage=/npage/bill/f8027.jsp?activePhone=<%=themob%>%26opCode=8027%26opName=���ֻ����ͻ���";
}



function printBillE720(){

	 var infoStr="";                           
                                            
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//����      
                                         
   	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	
	infoStr+="<%=chinaFee%>"+"|";
	infoStr+="<%=xx_money%>"+"|";

	infoStr+="�ֻ��ͺţ�"+"<%=brand_code%>"+"     IMEI�룺"+"<%=IMEINo%>"+"~"
		+"��Լ������ͨ�ŷ����Ż��ܶ��Ϊ"+"<%=free_fee%>"+"Ԫ��"
		+"ͨ�ŷ����Żݱ���Ϊ�ͻ��ƶ��绰������ʵ�����Ѷ�ȵ�"+"<%=base_fee%>"+"%��"+"|";
	infoStr+="|";
	infoStr+="<%=xx_money%>"+"  Ԥ�滰��"+"<%=xx_money%>"+"Ԫ��"+"|";
	infoStr+="|";
 	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e720&loginAccept=<%=stream%>&dirtPage=/npage/se720/fE720Login.jsp?activePhone=<%=themob%>%26opCode=e720%26opName=��������-�����ƻ�";
}


function printBillE721(){

	 var infoStr="";                           
                                            
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//����      
                                         
   	 infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	
	infoStr+="<%=chinaFee%>"+"|";
	infoStr+="<%=xx_money%>"+"|";

	infoStr+="�ֻ��ͺţ�"+"<%=brand_code%>"
		+"~"
		+"��Լ������ͨ�ŷ����Ż��ܶ��Ϊ"+"<%=free_fee%>"+"Ԫ��"
		+"ͨ�ŷ����Żݱ���Ϊ�ͻ��ƶ��绰������ʵ�����Ѷ�ȵ�"+"<%=base_fee%>"+"%��"+"|";
	infoStr+="|";
	infoStr+="<%=xx_money%>"+"  Ԥ�滰��"+"<%=xx_money%>"+"Ԫ��"+"|";
	infoStr+="|";
 	location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e721&loginAccept=<%=stream%>&dirtPage=/npage/se720/fE720Login.jsp?activePhone=<%=themob%>%26opCode=e721%26opName=��������-�����ƻ�����";
}

function printBillE528() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//����                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"~";
	 infoStr+="IMEI�ţ�"+'<%=IMEINo%>'+"~";
	 infoStr+="�ɿ�ϼƣ�<%=prepay_fee%>" + "Ԫ  ����Ԥ�滰��" + '<%=second_fee%>' + "Ԫ��ÿ�·�����" + '<%=mon_prepay_limit%>' + "Ԫ��" + "~" ;
	 infoStr+="һ���Է�����" + '<%=prepay_money%>' + "Ԫ��ÿ�����ͷ��ã�" + '<%=second_phone%>' + "Ԫ��" + "|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";
	 
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e528&loginAccept=<%=stream%>&dirtPage=/npage/se528/se528_login.jsp?activePhone=<%=themob%>%26opCode=e528%26opName=�Ա�����Լ�ƻ�";
}
function printBillE529() {
	 var infoStr="";                                                                         
	 infoStr+="<%=thework_no%>  <%=stream%>"+"     <%=sale_name%><%=opName2%>"+"|";//����                                                 
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=name%>'+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+='<%=themob%>'+"|";//�û�����                                                
	 infoStr+=""+"|";//�û���ַ
	 infoStr+="|";
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=xx_money%>"+"|";//Сд 
	 infoStr+="�ֻ��ͺ�:"+'<%=brand_code%>'+"~";
	 //infoStr+="IMEI�ţ�"+'<%=IMEINo%>'+"~";
	 //����Ԥ�滰��" + '<%=second_fee%>' + "Ԫ��ÿ�·�����" + '<%=mon_prepay_limit%>' + "Ԫ��һ���Է�����" + '<%=prepay_money%>' + "Ԫ��ÿ�����ͷ��ã�" + '<%=second_phone%>' + "Ԫ��"
	 infoStr+="�˿�ϼƣ�<%=prepay_fee%>" + "Ԫ" + "|";
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";
	 
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=e528&loginAccept=<%=stream%>&dirtPage=/npage/se528/se528_login.jsp?activePhone=<%=themob%>%26opCode=e528%26opName=�Ա�����Լ�ƻ�";
}
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>

<jsp:include page="fe505_1270_4.jsp">
	<jsp:param name="prepay_money" value="<%=prepay_money%>"  />
	<jsp:param name="second_fee" value="<%=second_fee%>"  />
	<jsp:param name="thework_no" value="<%=thework_no%>"  />
	<jsp:param name="stream" value="<%=stream%>"  />
	<jsp:param name="e505_sale_name" value="<%=e505_sale_name%>"  />
	<jsp:param name="opName2" value="<%=opName2%>"  />
	<jsp:param name="name" value="<%=name%>"  />
	<jsp:param name="themob" value="<%=themob%>"  />
	<jsp:param name="chinaFee" value="<%=chinaFee%>"  />
	<jsp:param name="xx_money" value="<%=xx_money%>"  />
	<jsp:param name="brand_code" value="<%=brand_code%>"  />
	<jsp:param name="IMEINo" value="<%=IMEINo%>"  />
	<jsp:param name="prepay_fee" value="<%=prepay_fee%>"  />
	<jsp:param name="work_name" value="<%=work_name%>"  />
	<jsp:param name="payType" value="<%=payType%>"  />
	<jsp:param name="MerchantNameChs" value="<%=MerchantNameChs%>"  />
	<jsp:param name="CardNoPingBi" value="<%=CardNoPingBi%>"  />
	<jsp:param name="MerchantId" value="<%=MerchantId%>"  />
	<jsp:param name="BatchNo" value="<%=BatchNo%>"  />
	<jsp:param name="IssCode" value="<%=IssCode%>"  />
	<jsp:param name="TerminalId" value="<%=TerminalId%>"  />
	<jsp:param name="AuthNo" value="<%=AuthNo%>"  />
	<jsp:param name="Response_time" value="<%=Response_time%>"  />
	<jsp:param name="Rrn" value="<%=Rrn%>"  />
	<jsp:param name="TraceNo" value="<%=TraceNo%>"  />
	<jsp:param name="AcqCode" value="<%=AcqCode%>"  />
	<jsp:param name="transTotal" value="<%=transTotal%>"  />
	<jsp:param name="returnPage" value="<%=returnPage%>"  />
</jsp:include>

<jsp:include page="fg122_1270_4.jsp">
	<jsp:param name="prepay_money" value="<%=prepay_money%>"  />
	<jsp:param name="second_fee" value="<%=second_fee%>"  />
	<jsp:param name="thework_no" value="<%=thework_no%>"  />
	<jsp:param name="stream" value="<%=stream%>"  />
	<jsp:param name="e505_sale_name" value="<%=e505_sale_name%>"  />
	<jsp:param name="opName2" value="<%=opName2%>"  />
	<jsp:param name="name" value="<%=name%>"  />
	<jsp:param name="themob" value="<%=themob%>"  />
	<jsp:param name="chinaFee" value="<%=chinaFee%>"  />
	<jsp:param name="xx_money" value="<%=xx_money%>"  />
	<jsp:param name="brand_code" value="<%=brand_code%>"  />
	<jsp:param name="IMEINo" value="<%=IMEINo%>"  />
	<jsp:param name="prepay_fee" value="<%=prepay_fee%>"  />
	<jsp:param name="work_name" value="<%=work_name%>"  />
	<jsp:param name="payType" value="<%=payType%>"  />
	<jsp:param name="MerchantNameChs" value="<%=MerchantNameChs%>"  />
	<jsp:param name="CardNoPingBi" value="<%=CardNoPingBi%>"  />
	<jsp:param name="MerchantId" value="<%=MerchantId%>"  />
	<jsp:param name="BatchNo" value="<%=BatchNo%>"  />
	<jsp:param name="IssCode" value="<%=IssCode%>"  />
	<jsp:param name="TerminalId" value="<%=TerminalId%>"  />
	<jsp:param name="AuthNo" value="<%=AuthNo%>"  />
	<jsp:param name="Response_time" value="<%=Response_time%>"  />
	<jsp:param name="Rrn" value="<%=Rrn%>"  />
	<jsp:param name="TraceNo" value="<%=TraceNo%>"  />
	<jsp:param name="AcqCode" value="<%=AcqCode%>"  />
	<jsp:param name="returnPage" value="<%=returnPage%>"  />
	<jsp:param name="sp_money" value="<%=sp_money%>"  />
</jsp:include>


<%if(ret_code==0&&(handcash>0.0||theop_code.equals("1255")||theop_code.equals("1259"))){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8042")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8042();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8043")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8043();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8044")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8044();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8045")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8045();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("126h")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill126h();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("126i")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill126i();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8023")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8023();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8024")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8024();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8034")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8034();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8035")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8035();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8070")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8070();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8071")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8071();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2264")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2264();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("2265")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2265();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("2281")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2281();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2282")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2282();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2283")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2283();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("2284")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill2284();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7371")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7371();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7374")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7374();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7379")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7379();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7382")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7382();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7975")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7975();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7976")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7976();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7981")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7981();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7982")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7982();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8551")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8551();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8552")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8552();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7671")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7671();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7672")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7672();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7898")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7898();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7899")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7899();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8094")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ����뷵��.......');
location="/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8094&opName=��������ʷ�Ӫ����  ";
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8091")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ����뷵��.......');
location="/npage/bill/f8094_login.jsp?activePhone=<%=themob%>&opCode=8091&opName=��������ʷ�Ӫ����  ";
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("8027")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8027();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("8028")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill8028();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7688")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7688();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("7689")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBill7689();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e505")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillE505();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e506")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillE506();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("e720")){%>
<script language="jscript">
	rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
	printBillE720();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e721")){%>
<script language="jscript">
	rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
	printBillE721();
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("e528")){%>
<script language="jscript">
if('<%=prepay_fee%>' == '0' || '<%=prepay_fee%>' == '0.00') {
	rdShowMessageDialog('�����ɹ���');
	location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=e528&opName=�Ա�����Լ�ƻ�";
}else {
	rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
	printBillE528();
}
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("e529")){%>
<script language="jscript">
	if('<%=prepay_fee%>' == '0' || '<%=prepay_fee%>' == '0.00') {
		rdShowMessageDialog('�����ɹ���');
		location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=e529&opName=�Ա�����Լ�ƻ�����";
	}else {
		rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
		printBillE529();
	}
</script>
<%}%>

<%if(ret_code==0&& theop_code.equals("g122")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillG122();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g123")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillG123();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g124")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillG124();
</script>
<%}%>
<%if(ret_code==0&& theop_code.equals("g125")){%>
<script language="jscript">
rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......');
printBillG125();
</script>
<%}%>

<%if(ret_code==0){%>
<script language='jscript'>
rdShowMessageDialog('�����ɹ���',2);
if("<%=returnPage%>"!="")
{
  location="<%=returnPage%>";

}
else
{
  removeCurrentTab();
  
}
</script>
<%}%>
<%if(!(ret_code==0)){%>
<script language='jscript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
	
	<%
		if(theop_code.equals("e505") || theop_code.equals("e506")) {
	%>
			//location = "/npage/se505/se505_login.jsp?activePhone=<%=themob%>&opCode=<%=theop_code%>&opName=<%=opName2%>"
			if("<%=returnPage%>"!=""){
        location="<%=returnPage%>";
      }else{
        removeCurrentTab();
      }
	<%
		}else if(theop_code.equals("e528") || theop_code.equals("e529")) {
	%>
			location = "/npage/se528/se528_login.jsp?activePhone=<%=themob%>&opCode=<%=theop_code%>&opName=<%=opName2%>"
	<%		
		}else {
	%>
			history.go(-2);
	<%		
		} 
	%>
</script>
<%}%>

