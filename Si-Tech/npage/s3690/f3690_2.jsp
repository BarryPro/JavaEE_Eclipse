<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-03-19
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String opName=(String)request.getParameter("opName");
    String[] retStr = null;
    ArrayList retArray = null;
    String error_code="";
    String error_msg="";
    Logger logger = Logger.getLogger("f3690_2.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String smName="";
	String custName="";
    String [] paraIn = new String[2];
	
	ArrayList retList = new ArrayList();//���ؽ��
	double d_totalPay=0.00, d_cashPay=0.00, d_handPay=0.00 ;

    String iIpAddr = (String)session.getAttribute("ipAddr");
    System.out.println("ipAddr ====  "+iIpAddr);
    String iWorkNo = (String)session.getAttribute("workNo");
    String iWorkPwd = (String)session.getAttribute("password");
    String workname = (String)session.getAttribute("workName");
    String iOrgCode = (String)session.getAttribute("orgCode");
    String iRegion_Code = iOrgCode.substring(0,2);
    String iLogin_Pass  = (String)session.getAttribute("password");
    String Department = iOrgCode;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);
    String townCode = Department.substring(4,7);
    String inOpenFlag=request.getParameter("inOpenFlag");
    String hdF10671 = request.getParameter("hdF10671");
    System.out.println("hdF10671hdF10671hdF10671hdF10671~~~~~"+hdF10671);
    String sql_str = "";
    //ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
	String[][] result2  = null;
	sql_str = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sql_str).get(0);
	String ProvinceRun = "";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="1">
    	<wtc:sql><%=sql_str%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr1" scope="end" />
<%
	if (retArr1.length > 0 && retCode1.equals("000000")) 
	{
		ProvinceRun = retArr1[0][0];
	}
	
    //ȡ���������GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //����
    {
		String[][] result1  = null;
		sql_str = "select group_id,'unknown' FROM dLoginMsg where login_no=:iWorkNo";
		//result1 = (String[][])callView.sPubSelect("2",sql_str).get(0);
		
		paraIn[0] = sql_str;    
        paraIn[1]="iWorkNo="+iWorkNo;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
        	<wtc:param value="<%=paraIn[0]%>"/>
        	<wtc:param value="<%=paraIn[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%
        if(retCode2.equals("000000")){
            result1 = retArr2;
        }
		if (result1 != null && result1.length != 0) 
		{
			GroupId = result1[0][0];
			OrgId = result1[0][1];
		}
	}
	else
	{
		GroupId = (String)session.getAttribute("groupId");
		OrgId = (String)session.getAttribute("orgId");
	}
/************/
    String iLoginAccept = (String)request.getParameter("login_accept");  // ������ˮ
        System.out.println("----------------iLoginAccept==="+iLoginAccept);
    String iChildAccept = (String)request.getParameter("child_accept");  // ����ˮ
        System.out.println("----------------iChildAccept==="+iChildAccept);
    String iOpCode = (String)request.getParameter("op_code");  	// ��������
    String iSys_Note = (String)request.getParameter("sysnote");   // ϵͳ��ע
    String iOp_Note = (String)request.getParameter("tonote");   // ������ע
    String iCust_Id = (String)request.getParameter("cust_id");   // ���ſͻ�ID
    //String id_no = (String)request.getParameter("unit_id");   // ����ID
    
    String notestr="����cust_id==["+iCust_Id+"]���в�ѯ";
    
    String managerId = (String)request.getParameter("F10303");   // CL����Ա��Ϣ�� managerId
    String managerPasswd = (String)request.getParameter("F10304");   // CL����Ա��Ϣ�� managerPasswd
    //String CL_Msg = managerId+"~"+managerPasswd+"~";    // CL����Ա��Ϣ��
    
		String iProvince = (String)request.getParameter("province");   // ʡ����
		String catalog_item_id=(String)request.getParameter("catalog_item_id"); //Ҷ�ӽڵ�ID
		String vServArea = (String)request.getParameter("F10310");   // VPMN ҵ������
		String vScp_Code = (String)request.getParameter("F10312");   // VPMN SCP��
		String vGroup_type = (String)request.getParameter("F10313");   // ��������
		String ZNVW_Msg = vServArea+"~"+vScp_Code+"~"+vGroup_type+"~";   //  ����v��������Ϣ��
		
    String iBelong_Code = ((String)request.getParameter("belong_code")).substring(0,7);   // ��������
    
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+catalog_item_id);
    String iOrg_Id = (String)request.getParameter("org_id");   // orgId
    //String iGroup_Id = WtcUtil.repNull((String)session.getAttribute("groupId"));   // grpId �����û�ID
    String iGroup_Id = WtcUtil.repNull((String)request.getParameter("group_id"));
    String iOpenLabel = WtcUtil.repNull((String)request.getParameter("open_label"));
    String oMLFlag = WtcUtil.repNull((String)request.getParameter("oMLFlag"));
    String iBtnId = WtcUtil.repNull((String)request.getParameter("btn_id"));
    String iCount = WtcUtil.repNull((String)request.getParameter("count"));
    
    String channel_id = "";   // �����ӵ�
        String town_code = (String)request.getParameter("town_code1");
        if(town_code.equals("101")){
            channel_id = OrgId;
        }else{
            channel_id = request.getParameter("channel_id");     
        }
    
    String iGrp_Name = (String)request.getParameter("grp_name");   // �����û�����
    String iSm_Code = (String)request.getParameter("userType");   // ���Ų�Ʒ����
    String iBizTypeLHidden = (String)request.getParameter("bizTypeLHiddenSub"); //ҵ�����
    String iAProd_grpIdNoHidden = (String)request.getParameter("AProd_grpIdNoHidden"); //A�˲�Ʒ���ű��
    
    String iProduct_Code = "";
        //if ("AD".equals(iSm_Code) || "ML".equals(iSm_Code) || "MA".equals(iSm_Code)) {
            iProduct_Code = (String)request.getParameter("F00017");   // ��������Ʒ���� product_code    //ADC,MASʱ�� F00017
        //}else{
            //iProduct_Code = (String)request.getParameter("product_code");   // ��������Ʒ���� product_code    //ADCʱ�� F00017
        //}
    System.out.println("# iProduct_Code = "+iProduct_Code);
    iProduct_Code = iProduct_Code.substring(0, iProduct_Code.indexOf("|"));
    
    String iProductName = WtcUtil.repNull((String)request.getParameter("product_name"));
    String bizCode = (String)request.getParameter("bizCode");//ҵ�����
    String gongnengfee = (String)request.getParameter("F00019");//���ܷѸ��ѷ�ʽ
    String iProduct_Append = (String)request.getParameter("product_append");   // ���Ÿ��Ӳ�Ʒ����
    String iProduct_Prices = (String)request.getParameter("product_prices");   // ��Ʒ�۸����  ��Ʒ�۸����ִ�
    //String iProduct_Attr = (String)request.getParameter("product_attr");   //��Ʒ���Դ���  ��Ʒ���Դ�
    //String iProduct_Type = (String)request.getParameter("product_type");   // ��Ʒ����
    
    //String iService_Code = (String)request.getParameter("service_code");   // �������
    //String iService_Attr = (String)request.getParameter("service_attr");   // �������� ��Ʒ�۸����Դ�
    String iGrp_UserNo = (String)request.getParameter("grp_userno");   // �û����
    
        //String iBelong_Code = (String)request.getParameter("belong_code");   //�ͻ���������
        //String cust_code = ""; 		   //IDC�û����� null
        String mainModeCode = "";   //���ʷ�
        String subModeCode ="";   //�����ʷ�
    //String EC_CL_Prod = iBelong_Code+"~"+cust_code+"~"+iSm_Code+"~"+mainModeCode+"~"+subModeCode+"~";   // �ײ���Ϣ��
    String EC_CL_Prod = iBelong_Code+"~"+iSm_Code+"~"+mainModeCode+"~"+subModeCode+"~";   // �ײ���Ϣ��
    System.out.println("-----------qidp-------------EC_CL_Prod------------"+EC_CL_Prod);
        String ipkg_type       = request.getParameter("F10329");//�����ʷ��ײ�����
        String ipkg_day        = request.getParameter("F10330");//�ʷ��ײ���Ч����
        String idiscount       = request.getParameter("F10331");//���ۿ�
        String ilmt_fee        = request.getParameter("F10332");//�����·����޶�
        String ifee_rate       = request.getParameter("fee_rate");
        String ilock_flag      = request.getParameter("lock_flag");
        String ibusi_type      = request.getParameter("busi_type");
        String ibill_type      = request.getParameter("bill_type");
        String iuse_status     = request.getParameter("use_status");
        String icover_region   = request.getParameter("cover_region");
        String ichg_flag       = request.getParameter("chg_flag");
        String iPayCode        = request.getParameter("F10311");         //�����ʻ����ʽ
        String iflags_no_2 = (String)request.getParameter("FZHWW0");   // �ۺ�v�����
    String vtemp_field = "";    //VPMN������Ϣ��
        if("vp".equals(iSm_Code)){
           vtemp_field = iflags_no_2   + "~" +
                         ipkg_type     + "~" +
                         ipkg_day      + "~" +        
                         idiscount     + "~" + 
                         ilmt_fee      + "~" +
                         ifee_rate     + "~" +
                         ilock_flag    + "~" +
                         ibusi_type    + "~" +
                         ibill_type    + "~" +
                         iuse_status   + "~" +
                         icover_region + "~" +
                         ichg_flag     + "~" +
                         iOrg_Id       + "~" +
                         iGroup_Id     + "~" + 
                         iPayCode      + "~" ;
         }               
    
        String vInterFee = (String)request.getParameter("F10317");    //���ڷ�������
        String vOutFee = (String)request.getParameter("F10318");    //�����������
        String vOutGrpFee = (String)request.getParameter("F10319");   //����������������
        String vNormalFee = (String)request.getParameter("F10320");  //���Żݷ�������
        String vAdmin_No = (String)request.getParameter("F10321");  //���Ź������̵Ľ�����
        String vInside_GroupNum = (String)request.getParameter("F10324");  //�ڲ���������  �������պ�Ⱥ��
        String vInside_UserNum = (String)request.getParameter("F10325");  //�ڲ��û�����  ���պ�Ⱥ����û���
        String vMax_Close = (String)request.getParameter("F10326");  //�����û����ɼ���ıպ�Ⱥ��  ���û�������պ�Ⱥ��
        String vOutside_GroupNum = (String)request.getParameter("F10327");  //�ⲿ��������   ����������������
        String vOutside_UserNum = (String)request.getParameter("max_outnumcl");  //�ڲ���������
        String vMax_Users = (String)request.getParameter("F10328");   //��������û���
        String vFunFlags = (String)request.getParameter("F10315");   //�û����ܼ�
        String vTrans_No = (String)request.getParameter("F10322");   //���л���Աת�Ӻ�
        String vShort_Flag = (String)request.getParameter("F10323");   //���к�����ʾ��ʽ
    String ZNVW_Prod = vInterFee+"~"+vOutFee+"~"+vOutGrpFee+"~"+vNormalFee+"~"+vAdmin_No+"~"+vInside_GroupNum+"~"
                        +vInside_UserNum+"~"+vMax_Close+"~"+vOutside_GroupNum+"~"+vOutside_UserNum+"~"+vMax_Users+"~"+vFunFlags+"~"
                        +vTrans_No+"~"+vShort_Flag+"~";    // �ײ���Ϣ��
    
    String iContract_No = (String)request.getParameter("account_id");   // �����˻�ID �����û��˺�
    String iUser_Passwd = (String)request.getParameter("user_passwd");   // �˻�����
        iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //�����û�����
    String iBill_Type = (String)request.getParameter("bill_type");   // ��������
    String iBill_Date = (String)request.getParameter("srv_stop");   // �Ʒ�����
    
        String iPay_Type	   = (String)request.getParameter("payType");     //���ʽ
        String iCheck_No	   = (String)request.getParameter("checkNo");     //֧Ʊ����
        String iBank_Code	   = (String)request.getParameter("bankCode");     //���д���
        String iCheck_Pay	   = (String)request.getParameter("checkPay");     //֧Ʊ����
        String iCashPay	   = (String)request.getParameter("cashPay");     //�ֽ𽻿�
        String iShouldHandFee  = (String)request.getParameter("should_handfee");   //Ӧ��������
        String iHandFee        = (String)request.getParameter("real_handfee");     //ʵ��������    

        if (iCashPay == null || iCashPay.equals(""))
        {
            iCashPay = "0.00";
        }
        if (iHandFee == null || iHandFee.equals(""))
        {
            iHandFee = "0.00";
        }
    String feeList="";                                                 //������Ϣ
        feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCashPay+"~"+iShouldHandFee+"~"+iHandFee+"~";  
        
        System.out.println("-----------qidp-------------feeList------------"+feeList);
        String vSubState = (String)request.getParameter("F10314");     //ҵ�񼤻��־    
        String vStart_Time = (String)request.getParameter("srv_start");     //ҵ����ʼ����    
        String vEnd_Time = (String)request.getParameter("srv_stop");     //ҵ���������    
    String ZNVW_Account = vSubState+"~"+vStart_Time+"~"+vEnd_Time+"~";   // �˻���Ϣ��
    
    //String IP_Account = iShouldHandFee+"~"+iHandFee+"~"+iPayCode+"~";   // �˻���Ϣ��
    String F10500 = WtcUtil.repNull((String)request.getParameter("F10500"))==null?"":WtcUtil.repNull((String)request.getParameter("F10500"));    //DL:���������
    
	String name_list=request.getParameter("nameList");
	String grp_list=request.getParameter("nameGroupList");
	String open_flag_list = request.getParameter("openFlagList");

	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	StringTokenizer token_flag=new StringTokenizer(open_flag_list,"|");
	StringTokenizer token_flag2=new StringTokenizer(open_flag_list,"|");
	StringTokenizer token_flag3=new StringTokenizer(open_flag_list,"|");
	
      System.out.println("-----------hejwa-------------name_list------------"+name_list);	
      System.out.println("-----------hejwa-------------grp_list--------------"+grp_list);	
      System.out.println("-----------hejwa-------------open_flag_list--------"+open_flag_list);	
      
	
	int length=token.countTokens();
	//if (iSm_Code.equals("AD") || iSm_Code.equals("ML") || iSm_Code.equals("MA")){
	    int cnt = 0;
	    while (token_flag3.hasMoreElements()){
    	    if("Y".equals(token_flag3.nextElement())){
    	        cnt++;
    	    }
	    }
	    length = cnt;
	//}
	
    String[] vMonAdd = request.getParameterValues("F10001"); //vaʱ �����ʷ�
    if(vMonAdd != null){
        if (vMonAdd.length > 1){
            length = length + vMonAdd.length - 1;
        }
    }
    int i=0,j=0,k=0;
    
    System.out.println("# iProduct_Append = "+iProduct_Append);
    StringTokenizer productToken=new StringTokenizer(iProduct_Append,",");
    StringTokenizer productToken1=new StringTokenizer(iProduct_Append,",");
    j = 0;
    while (productToken.hasMoreElements()){
        System.out.println("---4444---"+productToken.nextElement());
	    j++;
    }
    
    String[] ProdAppend = new String[j]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
    String[] ProdPrice = new String[j];
    String[] ProdAttr = new String[j];
    /*
    for(i=0; i<j; i++) {
        k = iProduct_Append.indexOf(',');
        if (k > 0)
            ProdAppend[i] = iProduct_Append.substring(0, k);
        else
            ProdAppend[i] = iProduct_Append;
        ProdPrice[i] = "";
        ProdAttr[i] = "";
        //iProduct_Append = iProduct_Append.substring(k+1);
    }
    */
    i = 0;
    while (productToken1.hasMoreElements()){
        ProdAppend[i] = (String)productToken1.nextElement();
        i++;
    }
    /*ningtn*/
    if(ProdAppend.length==0){
			ProdAppend = new String[1];
		}
		/*ningtn*/
    int appendLen = ProdAppend.length;
    if("DL".equals(iSm_Code) && !"".equals(F10500)){
        appendLen++ ;
    }
    
    String fieldCodes[] = new String [length];   // �����ֶδ���
    String fieldValues[]= new String [length];   // �����ֶ�ֵ
    String fieldRowNo[]= new String [length];   // �����û����
    	
    	String parm1[];
    	String parm2[];
    	String parm3[];

	    parm1 = new String[length];
        parm2 = new String[length];
        parm3 = new String[length];
        
    	ArrayList fieldValueAry = new ArrayList();
    	Vector vec = new Vector();
    	
    	//��������ַ���
    	k=0;
        while (token_grp.hasMoreElements()){
            if("Y".equals(token_flag.nextElement())){
        		fieldRowNo[k]=(String)token_grp.nextElement();
        		    System.out.println("---fieldRowNo["+k+"]---"+fieldRowNo[k]);
        		k++;
        	}else{
        	    token_grp.nextElement();
    	    }
    	}
    	
    	i=0;
    	int p=0;
    	//�������ֺ�ֵ�ַ���
    	while (token.hasMoreElements()){
            if("Y".equals(token_flag2.nextElement())){
        		fieldCodes[i]=(String)token.nextElement();
            		System.out.println("---fieldCodes["+i+"]---"+fieldCodes[i]);
            		System.out.println("---fieldRowNo["+i+"]---"+fieldRowNo[i]);
        		
        		if(!vec.contains(fieldCodes[i]))
        		{
        			if(!fieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
        			{
        				String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
        				for(p=0;p<tempValues.length;p++)
        				{
        					fieldValueAry.add(tempValues[p]);
        					    System.out.println("---tempValues["+p+"]---"+tempValues[p]);
        				}
        			}
        			else
        			{
        				fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
        				    System.out.println("---tempValues["+p+"]---"+request.getParameter("F"+fieldCodes[i]));
        			}
        			vec.add(fieldCodes[i]);
        		}
        		i++;
        	}else{
        	    token.nextElement();    
        	}
    	}
    	
    	fieldValues=(String[])fieldValueAry.toArray(new String[length]);
        
        if(vMonAdd != null){
            if (vMonAdd.length > 1){
                for(int ii=1;ii<vMonAdd.length;ii++){
                    fieldCodes[ii+1]="10001";
                    fieldRowNo[ii+1]="0";
                    fieldValues[ii+1]=vMonAdd[ii];
                }
            }
        }
        
        if(length>0)
        {       
            parm1 = fieldCodes;
            parm2 = fieldValues;
            parm3 = fieldRowNo;
        }
        
    int fieldCodesLen = parm1.length;
    
    String parm4[];
	String parm5[];
	String parm6[];
	
    if (fieldCodesLen+appendLen == 0){
	    parm4 = new String[1];
	    parm5 = new String[1];
	    parm6 = new String[1];
	    parm5[0] = "*";
	}else{
        parm4 = new String[fieldCodesLen+appendLen];
        parm5 = new String[fieldCodesLen+appendLen];
        parm6 = new String[fieldCodesLen+appendLen];
    }
    
    if(fieldCodesLen+appendLen>0){
        for(int kk=0;kk<fieldCodesLen;kk++){
        	if (iSm_Code.equals("hl") ){
        		if (parm1[kk].equals("10671"))
        		{
        			if ( hdF10671.equals("1") )
        			{
        				continue;
        			}
        		}
        	}
        
            parm4[kk] = parm1[kk];
            parm5[kk] = parm2[kk];
            parm6[kk] = parm3[kk];
        }

        for(int kk=0;kk<ProdAppend.length;kk++){
            if("DL".equals(iSm_Code)){
                parm4[fieldCodesLen+kk] = "10000";
            }else{
                parm4[fieldCodesLen+kk] = "10086";
            }
            parm5[fieldCodesLen+kk] = ProdAppend[kk];
            parm6[fieldCodesLen+kk] = "0";
        }
        if("DL".equals(iSm_Code) && !"".equals(F10500)){
            parm4[fieldCodesLen+appendLen-1] = "10500";
            parm5[fieldCodesLen+appendLen-1] = F10500;
            parm6[fieldCodesLen+appendLen-1] = "0";
        }
        if("hl".equals(iSm_Code) && "02".equals(iBizTypeLHidden)){ //Ʒ��Ϊ����ר�ߣ�ҵ�����Ϊ����ר��
           parm4[fieldCodesLen+appendLen-1] = "10635";
           parm5[fieldCodesLen+appendLen-1] = iAProd_grpIdNoHidden;
           parm6[fieldCodesLen+appendLen-1] = "0";
        }
    }
    
    for(int ii=0;ii<parm4.length;ii++){
        System.out.println("-hejwa------parm4 ["+ii+"]-------"+parm4[ii]);
        System.out.println("-hejwa------parm5 ["+ii+"]-------"+parm5[ii]);
        System.out.println("-hejwa------parm6 ["+ii+"]-------"+parm6[ii]);
    }
        //(String)request.getParameter("userFieldCode");   // �û��ֶδ���
        //(String)request.getParameter("userFieldValue");   // �û��ֶ�ֵ
        //(String)request.getParameter("userFieldOrder");   // �û��ֶ����
    
    String vPay_Si = request.getParameter("FPAYSI");     // ����SI
    System.out.println("-----------------------asdfafdf*****************--"+vPay_Si);
    //String iPayNo = (String)request.getParameter("F10333");   // Ԥ���ֶ�   //���Ÿ��Ѻ���
    
    String cust_price=request.getParameter("cust_price");     // Ӧ�տ���
		
		String vGroup_Name = (String)request.getParameter("cust_name"); // ��������
		String vGroup_Type = (String)request.getParameter("F10313");  //  ��������
		String vAddress = (String)request.getParameter("F10307");  //  ������ϵ��ַ
		String vContact_Phone = (String)request.getParameter("F10306");  //  ������ϵ�绰
		String vPincipal_Name = (String)request.getParameter("F10305");  //  ��ϵ������
		String vCust_doc = vGroup_Name+"~"+vGroup_Type+"~"+vAddress+"~"+vContact_Phone+"~"+vPincipal_Name+"~";
        //String iBizType = (String)request.getParameter("bizType");//ҵ������  
    String iGrp_Id = request.getParameter("grp_id");           //�����û�ID
    String id_no = iGrp_Id;
    
    String apn_code = request.getParameter("F10033");   //APNҵ���� APN����
    String terminal_num = request.getParameter("F10034");   //APNҵ���� �ն�����
    
    String server_no = request.getParameter("F00006");   //ADC/MASҵ���� ���ŷ������
/***************/
    String iccid    = request.getParameter("iccid");     
 
	String grpFieldCode    ="10200";
	/////////////////////String grpFieldValue   =request.getParameter("userNum");
	
	String iPay_Type_Value="";

	if(iPay_Type != null && iPay_Type.equals("0"))
	{
		iPay_Type_Value="�ֽ�";
	}
	else
	{
		iPay_Type_Value="֧Ʊ";
	}
	
	
	
	
  String iCash_Pay	   = request.getParameter("cashNum");     //֧�����
	String systemNote        = request.getParameter("sysnote");     //ϵͳ��ע
	String opNote        = request.getParameter("tonote");     //�û���ע
	
	
	String cust_Address = request.getParameter("cust_address");
	
	String StartTime       = request.getParameter("StartTime"); 
  String EndTime       = request.getParameter("EndTime");  
  String MOCode       = request.getParameter("MOCode");  
  String CodeMathMode       = request.getParameter("CodeMathMode");  
  String MOType       = request.getParameter("MOType");  
  String DestServCode       = request.getParameter("DestServCode");  
  String ServCodeMathMode       = request.getParameter("ServCodeMathMode");  
  String stimestr     = request.getParameter("F00020");  
  String szMOstr      = request.getParameter("F00021");  
	
	String timeMOStr = gongnengfee+"~"+stimestr+"~"+StartTime+"~"+EndTime+"~"+szMOstr+"~"+MOCode+"~"+CodeMathMode+"~"+MOType+"~"+DestServCode+"~"+ServCodeMathMode+"~";
	System.out.println("---------------timeMOStr------------"+timeMOStr);
	
	String in_ChanceId = request.getParameter("in_ChanceId2"); //�̻����룺�˵���ʱ�����۷��洫�룻����ʱ�����մ�������
	String inBatchNo = request.getParameter("batch_no");
	System.out.println("### inBatchNo = "+inBatchNo);
	String wa_no = request.getParameter("waNo");
	String input_accept = request.getParameter("input_accept");
	
	if("ML".equals(iSm_Code)){
	    in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId3"));
	    wa_no = WtcUtil.repNull((String)request.getParameter("waNo3"));
	}
	
	System.out.println("####### in_ChanceId = "+in_ChanceId);
	System.out.println("####### wa_no = "+wa_no);
	
	String vpmn_str = vtemp_field + ZNVW_Account + ZNVW_Msg + ZNVW_Prod + vCust_doc ;
	String apnCode = request.getParameter("F10033");//APNʱ��APN����
	String termNum = request.getParameter("F10034");//APNʱ���ն�����
	String billPayType = request.getParameter("F10035");//APNʱ���Ʒѷ�ʽ
	String limitAmount = request.getParameter("F00013");//ADC��MASʱ�������·�����
	String sECBaseServCode = (String)request.getParameter("F00016");//EC��������� wangzn add 2012/2/19 15:42:43
	String deal_str =catalog_item_id+"|"+ vPay_Si+"~"+"|"
	                + apnCode+"~"+termNum+"~"+billPayType+"~"+"|"
	                + bizCode+"~"+limitAmount+"~"+"|"
	                + managerId+"~"+managerPasswd+"~"+"|"
	                + vpmn_str+"|"
	                + bizCode+"~"+"|";
    String smAttrLimit_str = bizCode+"~"+server_no+"~"+managerId+"~"+apnCode+"~"+catalog_item_id+"~"+sECBaseServCode+"~";//wangzn modify 2012/2/19 15:42:51 ����ec���������
    
    String serviceName = "";
    String iAccept = "";
    String DLFlag = "";
    /* ֱ�ӽ����˵���(ֻ��һ������)ʱ������s3690CfmE���񣻶���100��˵���(�ж�������)ʱ������s3690DLCfm���� */
    if("opcode".equals(iOpenLabel) || ("link".equals(iOpenLabel) && "1".equals(iCount)) || "ML".equals(oMLFlag)){
        serviceName = "s3690CfmE";
        DLFlag = "";
    }else{
        serviceName = "s3690DLCfm";
        DLFlag = "1";
    }
    System.out.println("# From f3690_2.jsp -> serviceName = "+serviceName);
    /* ֱ������opcode����ʱ��ҳ��ȡ��ˮ�Ŵ�����񣻶˵��˻���100����ʱ��ȡ��4091��7421ģ���ֳ�������ˮ��������� */
    if("opcode".equals(iOpenLabel)){
        iAccept = iLoginAccept;
    }else{
        iAccept = iChildAccept;
    }
	try
    {
    String cnttId=request.getParameter("cnttId");
    String cptId=request.getParameter("cptId");
    
    System.out.println("3690~~~~cnttId="+cnttId);
    System.out.println("3690~~~~cptId="+cptId);

    
            %>
            <wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="TlsLogicSerCode" retmsg="TlsLogicSerMsg" outnum="2" >
                <wtc:param value="<%=in_ChanceId%>"/>
                
                <wtc:param value="<%=id_no%>"/><!--�����û����-->
                <wtc:param value="<%=iWorkNo%>"/><!--����-->
                <wtc:param value="<%=iSm_Code%>"/><!--����Ʒ��-->
                <wtc:param value="<%=iCust_Id%>"/><!--���ſͻ�ID-->
                <wtc:param value="<%=iWorkPwd%>"/><!--��������-->
                
                <wtc:param value="<%=iProvince%>"/><!--��������ʡ����-->
                <wtc:param value="<%=iAccept%>"/><!--��ˮ��-->
                <wtc:param value="3690"/>
                <wtc:param value="<%=iOrgCode%>"/>
                <wtc:param value="<%=iOp_Note%>"/>
                
                <wtc:param value="<%=iIpAddr%>"/>
                <wtc:param value="<%=iOrg_Id%>"/>
                <wtc:param value="<%=iBelong_Code%>"/><!--��������-->
                <wtc:param value="<%=iGroup_Id%>"/>
                <wtc:param value="<%=iSys_Note%>"/>
                
                <wtc:param value="<%=iGrp_Name%>"/><!--�û�����-->
                <wtc:param value="<%=iGrp_UserNo%>"/><!--VPMNҵ���У����Ų�Ʒ���-->
                <wtc:param value="<%=channel_id%>"/><!--�����ӵ�-->
                <wtc:param value="<%=iBill_Type%>"/><!--�������� 0-->
                <wtc:param value="<%=iUser_Passwd%>"/><!--�����û����ʻ�������-->
                
                <wtc:param value="<%=iBill_Date%>"/><!--ҵ���������-->
                <wtc:param value="<%=iContract_No%>"/><!--��Ʒ�ʻ�ID-->
                <wtc:param value="<%=deal_str%>"/>
                <wtc:param value="<%=smAttrLimit_str%>"/>
                <wtc:param value="<%=feeList%>"/><!--������Ϣ-->
                    
                <wtc:param value="0"/><!--requestType-->
                <wtc:param value="u01"/><!--op_type-->
                <wtc:param value="<%=wa_no%>"/><!--�̻�����-->
                <wtc:param value="<%=timeMOStr%>"/>
                <wtc:param value="<%=iProduct_Prices%>"/><!--�����Ϣ��-->
                	
                <wtc:param value="<%=iProduct_Code%>"/><!--���Ų�Ʒ-->
                <wtc:param value="<%=DLFlag%>"/>
                <wtc:param value="<%=inBatchNo%>"/>
                <wtc:params value="<%=parm4%>"/><!--�����ֶδ���-->
                <wtc:params value="<%=parm6%>"/><!--�����û����-->
                	
                <wtc:params value="<%=parm5%>"/><!--�����ֶ�ֵ-->
                <wtc:params value="<%=ProdAppend%>"/><!--���Ÿ��Ӳ�Ʒ����-->
                <wtc:param value=""/><!--Ԥ������-->
                <wtc:param value=""/><!--Ԥ������-->
                <wtc:param value=""/><!--Ԥ������-->
                	
                <wtc:param value=""/><!--Ԥ������-->
                <wtc:param value=""/><!--Ԥ������-->
                <wtc:param value="<%=cptId%>"/><!--Ԥ������-->
                <wtc:param value="<%=cnttId%>"/><!--Ԥ������-->
                 <wtc:param value="<%=input_accept%>"/><!--��Ʒ����ˮ-->
            </wtc:service>
            <wtc:array id="TlsLogicSerArr" scope="end"/>
            <%
            error_code = TlsLogicSerCode;
            error_msg = TlsLogicSerMsg;
   System.out.println("||||||||||||||&&&&&&&&&&&&&&&&&&&###################|||||||||||||||||");
   System.out.println("......error_code......."+error_code+"......error_msg...."+error_msg);



		
		//----------------------Ϊ��ӡ��Ʊ��֯����add
		//double d_totalPay=0.00, d_cashPay=0.00, d_checkPay=0.00 ;
		d_cashPay = Double.parseDouble(iCash_Pay);
		d_handPay = Double.parseDouble(iHandFee);
		d_totalPay = d_cashPay + d_handPay ;
		//String totalPay = (new Double(d_totalPay2)).toString();
		//System.out.println("*******iSm_Code****"+iSm_Code+"....iRegion_Code.."+iRegion_Code+"++iCust_Id "+iCust_Id);

			  String sqlStr="select sm_name from sSmCode where sm_code=:iSm_Code and region_code=:iRegion_Code";
							
			  
			  //retList = callView.sPubSelect("1",sqlStr); 
			  
              paraIn[0] = sqlStr;    
              paraIn[1]="iSm_Code="+iSm_Code+",iRegion_Code="+iRegion_Code;
    %>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="1" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr4" scope="end"/>
    <%
              if(retArr4.length>0 && retCode4.equals("000000")){
                    smName = retArr4[0][0];
              }
                         
			  //smName = ((String[][])retList.get(0))[0][0];
			  
    %>
            <wtc:service name="sUserCustInfo" outnum="100" retmsg="retMsg5" retcode="retCode5" routerKey="region" routerValue="<%=regionCode%>">
            	<wtc:param value="0" />
            	<wtc:param value="01" />	
            	<wtc:param value="<%=iOpCode%>" />	
            	<wtc:param value="<%=iWorkNo%>" />
            	<wtc:param value="<%=iWorkPwd%>" />
            	<wtc:param value="" />
            	<wtc:param value="" />
            	<wtc:param value="<%=iIpAddr%>" />
            	<wtc:param value="<%=notestr%>" />
            	<wtc:param value="<%=iCust_Id%>" />
            	<wtc:param value="" />
            	<wtc:param value="" />
            	<wtc:param value="" />
            </wtc:service>
            <wtc:array id="returnFlag" start="0" length="1" scope="end"/>
            <wtc:array id="retArr5" start="1" length="5" scope="end"/>

    <%
            if("000000".equals(retCode5)){
              if(retArr5.length>0){
                if("01".equals(returnFlag[0][0])){
                  custName = retArr5[0][4];
                }
              }
            }
              
			  //custName = ((String[][])retList.get(0))[0][0];

    }catch(Exception e){
		e.printStackTrace();
		e.getMessage();
        System.out.println("Call TlsLogicSer is Failed!-----");
    }
 
    if(error_code.equals("000000"))
    {
    
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	ArrayList retList0 = new ArrayList();  
 		String grp_user_no="";
    %>
        <wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6" outnum="1" >
          <wtc:param value="0"/>
          <wtc:param value="01"/>
          <wtc:param value="<%=iOpCode%>"/>
          <wtc:param value="<%=iWorkNo%>"/>	
          <wtc:param value="<%=iWorkPwd%>"/>		
          <wtc:param value=""/>	
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value="<%=iOpCode%>"/>
          <wtc:param value=""/>	
          <wtc:param value="<%=iGrp_Id%>"/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value="2"/>
          <wtc:param value=""/>
          <wtc:param value="1"/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value=""/>
        </wtc:service>
        <wtc:array id="retArr6" scope="end"/>   
    <%
        if(retArr6.length>0 && retCode6.equals("000000")){
            grp_user_no = retArr6[0][0];
        }
 		//String[][] retListString0 = (String[][])retList0.get(0);
		//grp_user_no=retListString0[0][0];
%>
<script language="javascript">

<%if(d_totalPay>0){

java.text.DecimalFormat df = new java.text.DecimalFormat(".00"); 
 String strTotal = df.format(d_totalPay);

%>
	  //��ӡ��Ʊ
      rdShowMessageDialog("�����ɹ�,���潫��ӡ��Ʊ,����ֽ��!",2);

	  //--------------------print begin-----------------------------//
    var op_code = "<%=iOpCode%>";//op_code  ��������
	  var work_no = "<%=iWorkNo%>";//work_no ����
	  var maxAccept = "<%=iLoginAccept%>";//maxAccept ��ˮ
	  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo �ֻ�����////��Ա�û����� ok
	  var smName = "<%=smName%>";//smName Ʒ������
	  var custName = "<%=custName%>";//custName �ͻ�����  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
	  var cust_Address="<%=cust_Address%>";
	  var iHandFee = "<%=iHandFee%>";// ʵ��������
	  var iCash_Pay = "<%=iCash_Pay%>";// ������
	  var tmpMoney = Math.round(iHandFee)+Math.round(iCash_Pay);//tmpMoney ���Ѻϼ� =ʵ��������+������
	  //alert("tmpMoney"+tmpMoney);
	  var innetFee = "0.00";//innetFee ������ 0
	  var simFee = "0.00";//simFee SIM���� 0
	  var selectFee = "0.00"; //selectFee ѡ�ŷ� 0
	  var insuranceFee = "0.00";//insuranceFee ���շ� 0
	  var checkMachineFee = "0.00";//checkMachineFee ����� 0
	  var handFee = "<%=iHandFee%>"; //handFee ������ =ʵ��������
	  var machineFee = "0.00"; //machineFee ������ 0
	  var otherFee = "<%=iCash_Pay%>";//������ =������
	  var totalPrepay = "0.00"; //totalPrepay Ԥ��� 0
      var payType = "<%=iPay_Type%>";//��������
	  if(payType=='0'){
          var cashPay = tmpMoney; //cashPay �ֽ�ʽ tmpMoney ?0
	      var checkPay = "0.00"; //checkPay ֧Ʊ��ʽ tmpMoney?0
	  }else{
		  var cashPay = "0.00"; //cashPay �ֽ�ʽ tmpMoney ?0
	      var checkPay = tmpMoney; //checkPay ֧Ʊ��ʽ tmpMoney?0
	  }
	  var systemNote = "<%=systemNote%>"; //systemNote ϵͳ��ע
	  var opNote = "<%=opNote%>"; //opNote �û���ע

	  var printInfo = "op_code="+op_code+"&work_no="+work_no+"&maxAccept="+maxAccept+"&phoneNo="+phoneNo+"&smName="+smName+"&custName="+custName+"&tmpMoney="+tmpMoney+"&innetFee="+innetFee+"&simFee="+simFee+"&selectFee="+selectFee+"&insuranceFee="+insuranceFee+"&checkMachineFee="+checkMachineFee+"&handFee="+handFee+"&machineFee="+machineFee+"&otherFee="+otherFee+"&totalPrepay="+totalPrepay+"&cashPay="+cashPay+"&checkPay="+checkPay+"&systemNote="+systemNote+"&opNote="+opNote;

	 
	 
	 var ProFlag= "<%=ProvinceRun%>"; //�ж�ʡ��
	 if(ProFlag=="20")//����
	  {
	    var infoStr="";
	     infoStr+=" "+"|";
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+="<%=iGrp_Id%>"+"|";
	     infoStr+="<%=iContract_No%>"+"|";
	     infoStr+="<%=custName%>"+"|";
	     infoStr+="<%=cust_Address%>"+"|";
		   infoStr+="�ֽ�"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="*�����ѣ�"+"<%=iHandFee%>"+"*��ˮ�ţ�"+"<%=iAccept%>"+"|";
       infoStr+="<%=iWorkNo%>|";
     
	    var printPage="/npage/s3690/idc_print.jsp?retInfo="+infoStr;
	    var printPage = window.open(printPage);

	  }
	  else
	  {
		   var printPage="/npage/common/sPubPrintInvoice.jsp?";

	     var printPage = printPage + printInfo;


	    var h=150;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;     
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";

	    var retValue = window.showModalDialog(printPage,"",prop);
	  }
	  
	  
	  
	  
	  
	  
	  //------------------------print end---------------------------------------//

        <%if("DL100".equals(iOpenLabel)){%>
            window.opener.frm.<%=iBtnId%>.value="�ɹ�";
            window.opener.frm.<%=iBtnId%>.disabled=true;
            window.close();
        <%}else{%>
            removeCurrentTab();
        <%}%>
	 <%}else{%>
        rdShowMessageDialog("�����û����������ɹ���",2);
        <%if("DL100".equals(iOpenLabel)){%>
            window.opener.frm.<%=iBtnId%>.value="�ɹ�";
            window.opener.frm.<%=iBtnId%>.disabled=true;
            window.close();
        <%}else{%>
            removeCurrentTab();
        <%}%>
    <%}%>	 
  </script>
<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            //history.go(-1);
            <%if("DL100".equals(iOpenLabel)){%>
                window.close();
            <%}else{%>
                history.go(-1);
            <%}%>
        </script>
<%
    } 
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+iOpCode +"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg
		+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iAccept+"&pageActivePhone="+iGrp_Id
		+"&opBeginTime="+opBeginTime+"&contactId="+iGrp_Id+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
	
