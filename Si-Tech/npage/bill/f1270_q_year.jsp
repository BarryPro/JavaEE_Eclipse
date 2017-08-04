<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-18 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.ReqUtil" %>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html; charset=GBK" %>
<%!
    //splitString()���ڽ�ȡ�ַ�������jdk�ϰ汾û��String.split()����
    public Vector splitString(String sign, String sourceString) {
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length() == 0) {
            return splitArrays;
        }
        while (i <= sourceString.length()) {
            j = sourceString.indexOf(sign, i);
            if (j < 0) {
                j = sourceString.length();
            }
            splitArrays.addElement(sourceString.substring(i, j));
            i = j + 1;
        }
        return splitArrays;
    }

    //��ʽ������
    public static String formatNumber(String num, int zeroNum) {
        DecimalFormat form = (DecimalFormat) NumberFormat.getInstance(Locale.getDefault());
        StringBuffer patBuf = new StringBuffer("0");
        if (zeroNum > 0) {
            patBuf.append(".");
            for (int i = 0; i < zeroNum; i++) {
                patBuf.append("0");
            }

        }
        form.applyPattern(patBuf.toString());
        return form.format(Double.parseDouble(num)).toString();
    }
%>
<%
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String work_no = (String) session.getAttribute("workNo");
    String work_name = (String) session.getAttribute("workName");
    String pass = (String) session.getAttribute("password");
    String ipAddr = (String)session.getAttribute("ipAddr");

/*--------------------------------������� �ο�f1270_4.jsp -------------------------------*/
    String theop_code = ReqUtil.get(request, "iOpCode");                    //��������	2  iOpCode                                     
    String iadd_str = ReqUtil.get(request, "iAddStr");                      //���Ի���Ϣ
    String themob = ReqUtil.get(request, "i1");                             //�ֻ�����	3  �ƶ����� iPhoneNo                           
    String maincash = ReqUtil.get(request, "i16").substring(0, ReqUtil.get(request, "i16").indexOf("-"));           //���ײʹ������ 4  ��ǰ���ײʹ��� iOldMode                     
    String old_cash = ReqUtil.get(request, "ip").substring(0,6);  
     System.out.println("-----------------------maincash[0] -------------------------"+maincash );
     System.out.println("-----------------------old_cash[0] -------------------------"+old_cash );
                                                                       //�����ײʹ���	 5  �����ײʹ��� iNewMode                       
    String maincash_flag = ReqUtil.get(request, "tbselect").substring(0, 1);//���ײ���Ч��־	6  ���ײͱ������Ч��ʽ iSendFlag              
    String addcash_string = ReqUtil.get(request, "kx_habitus_bunch");   //��ѡ�ײ͵Ĵ��봮	 7  ��ѡ�ײ͵Ĵ��봮 iAddModeStr               
    String do_string = ReqUtil.get(request, "kx_code_bunch");             //��ѡ�ײ͵�״̬��			8  ��ѡ�ײ͵ı���� iAddChgStr                 
    String flag_string = ReqUtil.get(request, "kx_operation_bunch");      //��ѡ�ײ͵���Ч��ʽ��        9 ��ѡ�ײ͵ı���� iAddSendStr                                       
    String favour = ReqUtil.get(request, "favorcode");               //�Żݴ���			10 �Żݴ��� iFavourCde                         
    String realcash = ReqUtil.get(request, "i19");                     //ʵ��������	 	11 ʵ�������� iRealFee                         
    String fircash = ReqUtil.get(request, "i20");                      //�̶�������	 	12 Ӧ�������� iShouldFee                       
    String sysnote = ReqUtil.get(request, "sysnote");                  //ϵͳ��ע		13 ϵͳ��־ iSysNote                           
    String donote = ReqUtil.get(request, "tonote");                    //������ע		14 ������־ iOpNote                            
    String stream = ReqUtil.get(request, "stream");                    //ϵͳ��ˮ		15 ��ӡ��ˮ iLoginAccept                                                
    String ip = WtcUtil.repNull((String) session.getAttribute("ipAddr"));                                           //��½IP		    16 ��¼IP  iIpAddr                            										
    String add_stream_str = ReqUtil.get(request, "kx_stream_bunch");      //ԭ��ѡ�ײ͵Ŀ�ͨ��ˮ��     17 ��ѡ�ײ͵Ŀ�ͨ��ˮ  iOldAcceptStr          
    String main_cash_stream = ReqUtil.get(request, "main_cash_stream");//��ǰ���ײͿ�ͨ��ˮ			18 ��ǰ���ײͿ�ͨ��ˮ  iCurModeAccept         
    String next_main_cash = ReqUtil.get(request, "next_main_cash");    //�������ײ�        			19         �������ײ�          iNextMode              
    String next_main_stream = ReqUtil.get(request, "next_main_stream");//�������ײͿ�ͨ��ˮ			20 �������ײͿ�ͨ��ˮ  iNextModeAccept 
    String iAddRateStr = ReqUtil.get(request, "iAddRateStr");//iAddRateStr˵��:  'A001^8032:'  A001�Ƕ������۴��룬8032�ǹ�����Ϣ��С�������
    float handcash = Float.parseFloat(realcash);                     //�����ѵ����� 
	  String cnttOpName = ReqUtil.get(request, "cnttOpName");
    String flag_code = ReqUtil.get(request, "flag_code");
    if(flag_code==null||(flag_code.toUpperCase()).equals("NULL")) flag_code = "";
    String rateCode = ReqUtil.get(request, "rateCode");
		String geftFlag = ReqUtil.get(request, "geftFlag"); 
    String rateFlag = rateCode + "$" + flag_code + "$" + "&";
    String thework_no = work_no;
%>
<%
		/*****     end     ******/
    String service_name = "";
    String pay_type = "", year_fee = "", prepay_fee = "", month_num = "", card_type = "", card_name = "", old_accept = "", contract_no = "", iOpType = "", bind_cust_name = "";
    Vector vec;
    /**���iAddStr**/
    vec = (Vector) splitString("|", iadd_str);
    if (theop_code.equals("1255") || theop_code.equals("1259")) {
        //iAddStr��ʽ pay_type|year_fee|prepay_fee|year_month|card_type|card_name ����card_type��card_name������E�а���
        pay_type = (String) vec.get(0);//���긶�Ѵ��� iPayType
        year_fee = (String) vec.get(1);//����Ӧ�ɽ�� iYearFee
        prepay_fee = (String) vec.get(2);//����ʵ�ɽ��            iPrepayFee
        month_num = (String) vec.get(3);//��������                iMonthNum
        card_type = (String) vec.get(4);//���ݿ�����              iCardType  
        card_name = (String) vec.get(5);//���ݿ�����              iCardName
    } else if (theop_code.equals("1201")) {
        //iAddStr��ʽ pay_type|year_fee|prepay_fee|year_month|card_type|card_name|bind_cust_name ����card_type��card_name������E�а���
        pay_type = (String) vec.get(0);//���긶�Ѵ��� iPayType
        year_fee = (String) vec.get(1);//����Ӧ�ɽ�� iYearFee
        prepay_fee = (String) vec.get(2);//����ʵ�ɽ��            iPrepayFee
        month_num = (String) vec.get(3);//��������                iMonthNum
        card_type = (String) vec.get(4);//���ݿ�����              iCardType  
        card_name = (String) vec.get(5);//���ݿ�����              iCardName
        bind_cust_name = (String) vec.get(6);//���󶨵��ֻ��û���              
    } else if (theop_code.equals("1257") || theop_code.equals("1258") || theop_code.equals("125a")) {
        //iAddStr��ʽ pay_type|year_fee|prepay_fee|iOldAccept|iContractNo|iOpType 
        pay_type = (String) vec.get(0);//���긶�Ѵ��� iPayType
        year_fee = (String) vec.get(1);//����Ӧ�ɽ�� iYearFee
        prepay_fee = (String) vec.get(2);//����ʵ�ɽ��            iPrepayFee
        old_accept = (String) vec.get(3);//������ˮ                iOldAccept
        contract_no = (String) vec.get(4);//����ר���˻�            iContractNo
        iOpType = (String) vec.get(5);//��������                iOpType     C:ȡ�� D:����
    }
    String errCode = "";
    String errMsg = "";
    String paraAray[] = new String[]{};
    /*
    
   							 0  ��������                iLoginNo
		###          1  ��������                iLoginPwd
		###          2  ��������                iOpCode
		###          3  �ƶ�����                iPhoneNo
		###          4  ��ǰ����Ʒ����          iOldMode
		###          5  ������Ʒ����            iNewMode
		###          6  ����Ʒ�������Ч��ʽ    iSendFlag        �ɴ���
		###          7  ��ѡ��Ʒ�Ĵ��봮        iAddModeStr      ��ʽ  200392#283472#
		###          8  ��ѡ��Ʒ��״̬��        iAddStatusStr    ��ʽ  Y#N#
		###          9  ��ѡ��Ʒ����Ч��ʽ��    iAddSendStr      �ɴ���
		###          10 �Żݴ���                iFavourCode     �ɴ���
		###          11 ʵ��������              iRealFee         �ɴ���
		###          12 Ӧ��������              iShouldFee       �ɴ���
		###          13 ϵͳ��־                iSysNote
		###          14 ������־                iOpNote
		###          15 ��ӡ��ˮ                iLoginAccept
		###          16 ��¼IP                  iIpAddr
		###          17 ��ѡ��Ʒ�Ŀ�ͨ��ˮ      iAddProdStr       //���ĺ���:�ط����봮            �ɴ���
		###          18 ��ǰ����Ʒ��ͨ��ˮ      iAddProdStatusStr //���ĺ���:�ط�״̬��            �ɴ���
		###          19 ��������Ʒ              iNextMode        �ɴ���
		###          20 ��������Ʒ��ͨ��ˮ      iNextModeAccept   �ɴ���
		###          21 ���긶�Ѵ���      		iPayType
		###          22 ����Ӧ�ɽ��      		iYearFee
		###          23 ����ʵ�ɽ��      		iPrepayFee     �ɴ���
		###          24 ��������      			iMonthNum
		###          25 ���ݿ�����      		iCardType  �����а���ʹ��   �ɴ���
		###          26 ���ݿ��ַ���      		iCardStr                   �ɴ���
		###				���ݿ�����|�ϻ���־|�ϻ����ֻ�����|���ʻ�����
		###          27 ����Ʒ�������۹�����Ϣ�� iAddRateStr
		###             iAddRateStr˵��: 'A001^8032:'  A001�Ƕ������۴��룬8032�ǹ�����Ϣ��С�������
		### ���������0 ���ش���
		###           1 ������Ϣ

    
    */
    
    if (theop_code.equals("1255") || theop_code.equals("1259") || theop_code.equals("1201")) {
        paraAray = new String[28];
        service_name = "s1255Cfm";
        paraAray[0] = work_no;                // 0  ��������                iLoginNo                                 		                                                                                                                                                                                                                                                                                                                                              
        paraAray[1] = pass;                // @wt          1  ��������                iLoginPwd                                                                                                                                                                                                                                                                                                                                                                       
        paraAray[2] = theop_code;                //@wt          2                          iOpCode                                                                                                                                                                                                                                                                                                                                                                    
        paraAray[3] = themob;                //@wt          3  �ƶ�����                iPhoneNo                                                                                                                                                                                                                                                                                                                                                                       
        paraAray[4] = maincash;//  @wt          4  ��ǰ���ײʹ���          iOldMode                                                                                                                                                                                                                                                                                                                                                                                   
        paraAray[5] = old_cash;//@wt          5  �����ײʹ���            iNewMode                                                                                                                                                                                                                                                                                                                                                                                     
        paraAray[6] = maincash_flag;//@wt          6  ���ײͱ������Ч��ʽ    iSendFlag                                                                                                                                                                                                                                                                                                                                                                               
        
        //paraAray[7] = addcash_string;//@wt          7  ��ѡ�ײ͵Ĵ��봮        iAddModeStr                                                                                                                                                                                                                                                                                                                                                                            
        //paraAray[8] = do_string;//@wt          8  ��ѡ�ײ͵�״̬��        iAddStatusStr                                                                                                                                                                                                                                                                                                                                                                               
        //paraAray[9] = flag_string;//@wt          9  ��ѡ�ײ͵���Ч��ʽ��    iAddSendStr                                                                                                                                                                                                                                                                                                                                                                               
        
        paraAray[7] = do_string;//@wt          7  ��ѡ�ײ͵Ĵ��봮        iAddModeStr                                                                                                                                                                                                                                                                                                                                                                            
        paraAray[8] = addcash_string;//@wt          8  ��ѡ�ײ͵�״̬��        iAddStatusStr                                                                                                                                                                                                                                                                                                                                                                               
        paraAray[9] = flag_string;//@wt          9  ��ѡ�ײ͵���Ч��ʽ��    iAddSendStr                                                                                                                                                                                                                                                                                                                                                                               


        
        
        paraAray[10] = favour;//@wt          10 �Żݴ���                iFavourCde                                                                                                                                                                                                                                                                                                                                                                                    
        paraAray[11] = realcash;//@wt          11 ʵ��������              iRealFee                                                                                                                                                                                                                                                                                                                                                                                    
        paraAray[12] = fircash;//@wt          12 Ӧ��������              iShouldFee                                                                                                                                                                                                                                                                                                                                                                                   
        paraAray[13] = sysnote;//@wt          13 ϵͳ��־                iSysNote                                                                                                                                                                                                                                                                                                                                                                                     
        paraAray[14] = donote;//@wt          14 ������־                iOpNote                                                                                                                                                                                                                                                                                                                                                                                       
        paraAray[15] = stream;//@wt          15 ��ӡ��ˮ                iLoginAccept                                                                                                                                                                                                                                                                                                                                                                                  
        paraAray[16] = ipAddr;//@wt          16 ��¼IP                  iIpAddr                                                                                                                                                                                                                                                                                                                                                                                       
        paraAray[17] = add_stream_str;//@wt          17 ��ѡ�ײ͵Ŀ�ͨ��ˮ      iOldAcceptStr                                                                                                                                                                                                                                                                                                                                                                         
        paraAray[18] = main_cash_stream;//@wt          18 ��ǰ���ײͿ�ͨ��ˮ      iCurModeAccept                                                                                                                                                                                                                                                                                                                                                                      
        paraAray[19] = next_main_cash.substring(0,next_main_cash.indexOf("--")); //@wt          19 �������ײ�              iNextMode                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
        paraAray[20] = next_main_stream;//@wt          20 �������ײͿ�ͨ��ˮ      iNextModeAccept                                                                                                                                                                                                                                                                                                                                                                     
        paraAray[21] = pay_type;//@wt          21 ���긶�Ѵ���            iPayType                                                                                                                                                                                                                                                                                                                                                                                    
        paraAray[22] = year_fee;//@wt          22 ����Ӧ�ɽ��            iYearFee                                                                                                                                                                                                                                                                                                                                                                                    
        paraAray[23] = prepay_fee;//@wt          23 ����ʵ�ɽ��            iPrepayFee                                                                                                                                                                                                                                                                                                                                                                                
        paraAray[24] = month_num;//@wt          24 ��������                iMonthNum                                                                                                                                                                                                                                                                                                                                                                                  
        paraAray[25] = card_type;//25 ���ݿ�����              iCardType    
        if(theop_code.equals("1259")){
        	paraAray[26] = geftFlag;//26  
        }else{
        	paraAray[26] = card_name;//26 
        }                                                                                                                                                                                                                                                                                                                                                                                           
        
        paraAray[27] = flag_code ;     //С������                                                                                                                                                                                                                                                                                                                                                                                      
        
        System.out.println("mylog-----------------------paraAray[0] -------------------------"+paraAray[0] );
				System.out.println("mylog-----------------------paraAray[1] -------------------------"+paraAray[1] );
				System.out.println("mylog-----------------------paraAray[2] -------------------------"+paraAray[2] );
				System.out.println("mylog-----------------------paraAray[3] -------------------------"+paraAray[3] );
				System.out.println("mylog-----------------------paraAray[4] -------------------------"+paraAray[4] );
				System.out.println("mylog-----------------------paraAray[5] -------------------------"+paraAray[5] );
				System.out.println("mylog-----------------------paraAray[6] -------------------------"+paraAray[6] );
				System.out.println("mylog-----------------------paraAray[7] -------------------------"+paraAray[7] );
				System.out.println("mylog-----------------------paraAray[8] -------------------------"+paraAray[8] );
				System.out.println("mylog-----------------------paraAray[9] -------------------------"+paraAray[9] );
				System.out.println("mylog-----------------------paraAray[10]-------------------------"+paraAray[10]);
				System.out.println("mylog-----------------------paraAray[11]-------------------------"+paraAray[11]);
				System.out.println("mylog-----------------------paraAray[12]-------------------------"+paraAray[12]);
				System.out.println("mylog-----------------------paraAray[13]-------------------------"+paraAray[13]);
				System.out.println("mylog-----------------------paraAray[14]-------------------------"+paraAray[14]);
				System.out.println("mylog-----------------------paraAray[15]-------------------------"+paraAray[15]);
				System.out.println("mylog-----------------------paraAray[16]-------------------------"+paraAray[16]);
				System.out.println("mylog-----------------------paraAray[17]-------------------------"+paraAray[17]);
				System.out.println("mylog-----------------------paraAray[18]-------------------------"+paraAray[18]);
				System.out.println("mylog-----------------------paraAray[19]-------------------------"+paraAray[19]);
				System.out.println("mylog-----------------------paraAray[20]-------------------------"+paraAray[20]);
				System.out.println("mylog-----------------------paraAray[21]-------------------------"+paraAray[21]);
				System.out.println("mylog-----------------------paraAray[22]-------------------------"+paraAray[22]);
				System.out.println("mylog-----------------------paraAray[23]-------------------------"+paraAray[23]);
				System.out.println("mylog-----------------------paraAray[24]-------------------------"+paraAray[24]);
				System.out.println("mylog-----------------------paraAray[25]-------------------------"+paraAray[25]);
				System.out.println("mylog-----------------------paraAray[26]-------------------------"+paraAray[26]);
				System.out.println("mylog-----------------------paraAray[27]-------------------------"+paraAray[27]);

        
 %>
			<wtc:service name="s1255Cfm" routerKey="phone" routerValue="<%=themob%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
				<wtc:param value="<%=paraAray[15]%>"/>
				<wtc:param value=" " />
				<wtc:param value="<%=paraAray[2]%>"/>
				<wtc:param value="<%=paraAray[0]%>"/>
				<wtc:param value="<%=paraAray[1]%>"/>
				<wtc:param value="<%=paraAray[3]%>"/>
			    <wtc:param value=" " />  						 
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
				 <wtc:param value=""/>	
			</wtc:service>
			<wtc:array id="s1255CfmArr" scope="end"/>
<%   
			errCode = retCode1!=""?retCode1:errCode;
			errMsg = retMsg1;    

    } 
    

    System.out.println("service_name==============" + service_name);
    System.out.println("errCode==========" + errCode);
    System.out.println("errMsg==========" + errMsg);
    
    /***********��¼ͳһ�Ӵ���ʼ************/
		//String cnttOpCode = "1255";
		
		String cnttLoginAccept =stream;//����û�з�����ˮ
		String cnttRetCode = String.valueOf(errCode);	
		String cnttWorkNo = work_no;
		String cnttActivePhone = themob;
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+theop_code+"&retCodeForCntt="+cnttRetCode+"&opName="+cnttOpName+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
    /*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
    String cardno = ReqUtil.get(request, "i7");                        //���֤����
    //themob = ReqUtil.get(request,"i1");						  //�ƶ�����
    String name = ReqUtil.get(request, "i4");                        //�û�����
    String address = ReqUtil.get(request, "i5");                      //�û���ַ
    //realcash = ReqUtil.get(request,"i19");   				  //������
    //stream = ReqUtil.get(request,"stream");                    //ϵͳ��ˮ 
    float fPrepayFee = Float.parseFloat(prepay_fee);//������
    //String chinaFee = ((String[][]) (callView.view_sToChinaFee(formatNumber(prepay_fee, 2)).get(0)))[0][2];//��д���
 %>
			<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
			<wtc:param value="<%=formatNumber(prepay_fee, 2)%>"/>
			</wtc:service>
			<wtc:array id="sToChinaFeeArr" scope="end"/>
<%    
		String chinaFee = "";
		if(sToChinaFeeArr.length>0){
			chinaFee = sToChinaFeeArr[0][2];
		}
    //�û�����  �ֻ��� ����
    String conf_flag = "", bind_phone_no = "", cust_name = "", phone_no = "", machine_name = "";
    if (theop_code.equals("1201")) {
        vec = (Vector) splitString("~", card_name);
        machine_name = (String) vec.get(0);
        conf_flag = (String) vec.get(1);
        bind_phone_no = (String) vec.get(2);
        if (conf_flag.equals("01")) {
            cust_name = bind_cust_name;
            phone_no = bind_phone_no;
        } else {
            cust_name = name;
            phone_no = themob;
        }
    }

/***********************************************************************************************/
%>
<script language="jscript">
    function printBill() {
        var infoStr = "";
        infoStr += "<%=work_no%>  <%=stream%>" + "  �����а���" + "|";//����                                          
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";//��
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";//��
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";//��

        infoStr += "<%=cust_name%>" + "|";//�û����� 
        infoStr += " " + "|";//����

        infoStr += "<%=phone_no%>" + "|";//�ƶ����� 
        infoStr += " " + "|";//Э�����                                                          
        infoStr += " " + "|";//֧Ʊ����  

        infoStr += "<%=chinaFee%>" + "|";//�ϼƽ��(��д)
        infoStr += "<%=formatNumber(prepay_fee,2)%>" + "|";//Сд

        infoStr += "���ɽ�  <%=formatNumber(prepay_fee,2)%>" +
                   "~~�ͺţ�<%=card_type%>  <%=machine_name%>" + "|";//��Ŀ

        infoStr += "<%=work_name%>" + "|";//��Ʊ��
        infoStr += " " + "|";//�տ���

        var dirtPage = "/npage/bill/f1201_login.jsp";

        location = "/npage/public/hljBillPrint.jsp?retInfo=" + infoStr + "&dirtPage=" + dirtPage;
    }
</script>
<%if(errCode.equals("000000") && theop_code.equals("1201")) {%>
<script language="javascript">
    rdShowMessageDialog("������������ɹ�����ӡ��Ʊ.......",2);
    printBill();
</script>
<%} else if(errCode.equals("000000")) {%>
<script language="javascript">
    rdShowMessageDialog("<%=cnttOpName%>�����ɹ���",2);
    parent.removeTab('<%=theop_code%>');
</script>
<%} else {%>
<script language="jscript">
    rdShowMessageDialog("�����������ʧ��!<br>errCode:<%=errCode%>" + "<br>������Ϣ��<%=errMsg%>",0);
    history.go(-1);
</script>
<%}%>

