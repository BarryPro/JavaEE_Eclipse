<%
/********************
 * version v2.0
 * 开发商: si-tech
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
	
	ArrayList retList = new ArrayList();//返回结果
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
    //取运行省份代码 -- 为吉林增加，山西可以使用session
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
	
    //取工号密码和GROUP_ID
    String GroupId = "";
    String OrgId = "";
    if(ProvinceRun.equals("20"))  //吉林
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
    String iLoginAccept = (String)request.getParameter("login_accept");  // 操作流水
        System.out.println("----------------iLoginAccept==="+iLoginAccept);
    String iChildAccept = (String)request.getParameter("child_accept");  // 子流水
        System.out.println("----------------iChildAccept==="+iChildAccept);
    String iOpCode = (String)request.getParameter("op_code");  	// 操作代码
    String iSys_Note = (String)request.getParameter("sysnote");   // 系统备注
    String iOp_Note = (String)request.getParameter("tonote");   // 操作备注
    String iCust_Id = (String)request.getParameter("cust_id");   // 集团客户ID
    //String id_no = (String)request.getParameter("unit_id");   // 集团ID
    
    String notestr="根据cust_id==["+iCust_Id+"]进行查询";
    
    String managerId = (String)request.getParameter("F10303");   // CL管理员信息串 managerId
    String managerPasswd = (String)request.getParameter("F10304");   // CL管理员信息串 managerPasswd
    //String CL_Msg = managerId+"~"+managerPasswd+"~";    // CL管理员信息串
    
		String iProvince = (String)request.getParameter("province");   // 省代码
		String catalog_item_id=(String)request.getParameter("catalog_item_id"); //叶子节点ID
		String vServArea = (String)request.getParameter("F10310");   // VPMN 业务区号
		String vScp_Code = (String)request.getParameter("F10312");   // VPMN SCP号
		String vGroup_type = (String)request.getParameter("F10313");   // 集团类型
		String ZNVW_Msg = vServArea+"~"+vScp_Code+"~"+vGroup_type+"~";   //  智能v网渠道信息串
		
    String iBelong_Code = ((String)request.getParameter("belong_code")).substring(0,7);   // 归属代码
    
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+catalog_item_id);
    String iOrg_Id = (String)request.getParameter("org_id");   // orgId
    //String iGroup_Id = WtcUtil.repNull((String)session.getAttribute("groupId"));   // grpId 集团用户ID
    String iGroup_Id = WtcUtil.repNull((String)request.getParameter("group_id"));
    String iOpenLabel = WtcUtil.repNull((String)request.getParameter("open_label"));
    String oMLFlag = WtcUtil.repNull((String)request.getParameter("oMLFlag"));
    String iBtnId = WtcUtil.repNull((String)request.getParameter("btn_id"));
    String iCount = WtcUtil.repNull((String)request.getParameter("count"));
    
    String channel_id = "";   // 渠道接点
        String town_code = (String)request.getParameter("town_code1");
        if(town_code.equals("101")){
            channel_id = OrgId;
        }else{
            channel_id = request.getParameter("channel_id");     
        }
    
    String iGrp_Name = (String)request.getParameter("grp_name");   // 集团用户名称
    String iSm_Code = (String)request.getParameter("userType");   // 集团产品类型
    String iBizTypeLHidden = (String)request.getParameter("bizTypeLHiddenSub"); //业务大类
    String iAProd_grpIdNoHidden = (String)request.getParameter("AProd_grpIdNoHidden"); //A端产品集团编号
    
    String iProduct_Code = "";
        //if ("AD".equals(iSm_Code) || "ML".equals(iSm_Code) || "MA".equals(iSm_Code)) {
            iProduct_Code = (String)request.getParameter("F00017");   // 集团主产品代码 product_code    //ADC,MAS时是 F00017
        //}else{
            //iProduct_Code = (String)request.getParameter("product_code");   // 集团主产品代码 product_code    //ADC时是 F00017
        //}
    System.out.println("# iProduct_Code = "+iProduct_Code);
    iProduct_Code = iProduct_Code.substring(0, iProduct_Code.indexOf("|"));
    
    String iProductName = WtcUtil.repNull((String)request.getParameter("product_name"));
    String bizCode = (String)request.getParameter("bizCode");//业务代码
    String gongnengfee = (String)request.getParameter("F00019");//功能费付费方式
    String iProduct_Append = (String)request.getParameter("product_append");   // 集团附加产品代码
    String iProduct_Prices = (String)request.getParameter("product_prices");   // 产品价格代码  产品价格因字串
    //String iProduct_Attr = (String)request.getParameter("product_attr");   //产品属性代码  产品属性串
    //String iProduct_Type = (String)request.getParameter("product_type");   // 产品类型
    
    //String iService_Code = (String)request.getParameter("service_code");   // 服务代码
    //String iService_Attr = (String)request.getParameter("service_attr");   // 服务属性 产品价格属性串
    String iGrp_UserNo = (String)request.getParameter("grp_userno");   // 用户编号
    
        //String iBelong_Code = (String)request.getParameter("belong_code");   //客户归属地区
        //String cust_code = ""; 		   //IDC用户编码 null
        String mainModeCode = "";   //主资费
        String subModeCode ="";   //附加资费
    //String EC_CL_Prod = iBelong_Code+"~"+cust_code+"~"+iSm_Code+"~"+mainModeCode+"~"+subModeCode+"~";   // 套餐信息串
    String EC_CL_Prod = iBelong_Code+"~"+iSm_Code+"~"+mainModeCode+"~"+subModeCode+"~";   // 套餐信息串
    System.out.println("-----------qidp-------------EC_CL_Prod------------"+EC_CL_Prod);
        String ipkg_type       = request.getParameter("F10329");//集团资费套餐类型
        String ipkg_day        = request.getParameter("F10330");//资费套餐生效日期
        String idiscount       = request.getParameter("F10331");//总折扣
        String ilmt_fee        = request.getParameter("F10332");//集团月费用限额
        String ifee_rate       = request.getParameter("fee_rate");
        String ilock_flag      = request.getParameter("lock_flag");
        String ibusi_type      = request.getParameter("busi_type");
        String ibill_type      = request.getParameter("bill_type");
        String iuse_status     = request.getParameter("use_status");
        String icover_region   = request.getParameter("cover_region");
        String ichg_flag       = request.getParameter("chg_flag");
        String iPayCode        = request.getParameter("F10311");         //集团帐户付款方式
        String iflags_no_2 = (String)request.getParameter("FZHWW0");   // 综合v网标记
    String vtemp_field = "";    //VPMN账务信息串
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
    
        String vInterFee = (String)request.getParameter("F10317");    //网内费率索引
        String vOutFee = (String)request.getParameter("F10318");    //网外费率索引
        String vOutGrpFee = (String)request.getParameter("F10319");   //网外号码组费率索引
        String vNormalFee = (String)request.getParameter("F10320");  //非优惠费率索引
        String vAdmin_No = (String)request.getParameter("F10321");  //集团管理流程的接入码
        String vInside_GroupNum = (String)request.getParameter("F10324");  //内部集团数量  集团最大闭合群数
        String vInside_UserNum = (String)request.getParameter("F10325");  //内部用户数量  单闭合群最大用户数
        String vMax_Close = (String)request.getParameter("F10326");  //单个用户最大可加入的闭合群数  单用户最大加入闭合群数
        String vOutside_GroupNum = (String)request.getParameter("F10327");  //外部集团数量   集团最大网外号码数
        String vOutside_UserNum = (String)request.getParameter("max_outnumcl");  //内部集团数量
        String vMax_Users = (String)request.getParameter("F10328");   //集团最大用户数
        String vFunFlags = (String)request.getParameter("F10315");   //用户功能集
        String vTrans_No = (String)request.getParameter("F10322");   //呼叫话务员转接号
        String vShort_Flag = (String)request.getParameter("F10323");   //主叫号码显示方式
    String ZNVW_Prod = vInterFee+"~"+vOutFee+"~"+vOutGrpFee+"~"+vNormalFee+"~"+vAdmin_No+"~"+vInside_GroupNum+"~"
                        +vInside_UserNum+"~"+vMax_Close+"~"+vOutside_GroupNum+"~"+vOutside_UserNum+"~"+vMax_Users+"~"+vFunFlags+"~"
                        +vTrans_No+"~"+vShort_Flag+"~";    // 套餐信息串
    
    String iContract_No = (String)request.getParameter("account_id");   // 集团账户ID 集团用户账号
    String iUser_Passwd = (String)request.getParameter("user_passwd");   // 账户密码
        iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //加密用户密码
    String iBill_Type = (String)request.getParameter("bill_type");   // 出账周期
    String iBill_Date = (String)request.getParameter("srv_stop");   // 计费日期
    
        String iPay_Type	   = (String)request.getParameter("payType");     //付款方式
        String iCheck_No	   = (String)request.getParameter("checkNo");     //支票号码
        String iBank_Code	   = (String)request.getParameter("bankCode");     //银行代码
        String iCheck_Pay	   = (String)request.getParameter("checkPay");     //支票交款
        String iCashPay	   = (String)request.getParameter("cashPay");     //现金交款
        String iShouldHandFee  = (String)request.getParameter("should_handfee");   //应收手续费
        String iHandFee        = (String)request.getParameter("real_handfee");     //实收手续费    

        if (iCashPay == null || iCashPay.equals(""))
        {
            iCashPay = "0.00";
        }
        if (iHandFee == null || iHandFee.equals(""))
        {
            iHandFee = "0.00";
        }
    String feeList="";                                                 //费用信息
        feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCashPay+"~"+iShouldHandFee+"~"+iHandFee+"~";  
        
        System.out.println("-----------qidp-------------feeList------------"+feeList);
        String vSubState = (String)request.getParameter("F10314");     //业务激活标志    
        String vStart_Time = (String)request.getParameter("srv_start");     //业务起始日期    
        String vEnd_Time = (String)request.getParameter("srv_stop");     //业务结束日期    
    String ZNVW_Account = vSubState+"~"+vStart_Time+"~"+vEnd_Time+"~";   // 账户信息串
    
    //String IP_Account = iShouldHandFee+"~"+iHandFee+"~"+iPayCode+"~";   // 账户信息串
    String F10500 = WtcUtil.repNull((String)request.getParameter("F10500"))==null?"":WtcUtil.repNull((String)request.getParameter("F10500"));    //DL:免费试用期
    
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
	
    String[] vMonAdd = request.getParameterValues("F10001"); //va时 附加资费
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
    
    String[] ProdAppend = new String[j]; //将附加产品、产品价格、产品属性分解到数组中
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
    
    String fieldCodes[] = new String [length];   // 集团字段代码
    String fieldValues[]= new String [length];   // 集团字段值
    String fieldRowNo[]= new String [length];   // 集团用户组号
    	
    	String parm1[];
    	String parm2[];
    	String parm3[];

	    parm1 = new String[length];
        parm2 = new String[length];
        parm3 = new String[length];
        
    	ArrayList fieldValueAry = new ArrayList();
    	Vector vec = new Vector();
    	
    	//解析组号字符串
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
    	//解析名字和值字符串
    	while (token.hasMoreElements()){
            if("Y".equals(token_flag2.nextElement())){
        		fieldCodes[i]=(String)token.nextElement();
            		System.out.println("---fieldCodes["+i+"]---"+fieldCodes[i]);
            		System.out.println("---fieldRowNo["+i+"]---"+fieldRowNo[i]);
        		
        		if(!vec.contains(fieldCodes[i]))
        		{
        			if(!fieldRowNo[i].equals("0"))	//行号从1开始
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
        if("hl".equals(iSm_Code) && "02".equals(iBizTypeLHidden)){ //品牌为集团专线，业务大类为数据专线
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
        //(String)request.getParameter("userFieldCode");   // 用户字段代码
        //(String)request.getParameter("userFieldValue");   // 用户字段值
        //(String)request.getParameter("userFieldOrder");   // 用户字段序号
    
    String vPay_Si = request.getParameter("FPAYSI");     // 结算SI
    System.out.println("-----------------------asdfafdf*****************--"+vPay_Si);
    //String iPayNo = (String)request.getParameter("F10333");   // 预留字段   //集团付费号码
    
    String cust_price=request.getParameter("cust_price");     // 应收款项
		
		String vGroup_Name = (String)request.getParameter("cust_name"); // 集团名称
		String vGroup_Type = (String)request.getParameter("F10313");  //  集团类型
		String vAddress = (String)request.getParameter("F10307");  //  集团联系地址
		String vContact_Phone = (String)request.getParameter("F10306");  //  集团联系电话
		String vPincipal_Name = (String)request.getParameter("F10305");  //  联系人姓名
		String vCust_doc = vGroup_Name+"~"+vGroup_Type+"~"+vAddress+"~"+vContact_Phone+"~"+vPincipal_Name+"~";
        //String iBizType = (String)request.getParameter("bizType");//业务类型  
    String iGrp_Id = request.getParameter("grp_id");           //集团用户ID
    String id_no = iGrp_Id;
    
    String apn_code = request.getParameter("F10033");   //APN业务中 APN号码
    String terminal_num = request.getParameter("F10034");   //APN业务中 终端数量
    
    String server_no = request.getParameter("F00006");   //ADC/MAS业务中 短信服务号码
/***************/
    String iccid    = request.getParameter("iccid");     
 
	String grpFieldCode    ="10200";
	/////////////////////String grpFieldValue   =request.getParameter("userNum");
	
	String iPay_Type_Value="";

	if(iPay_Type != null && iPay_Type.equals("0"))
	{
		iPay_Type_Value="现金";
	}
	else
	{
		iPay_Type_Value="支票";
	}
	
	
	
	
  String iCash_Pay	   = request.getParameter("cashNum");     //支付金额
	String systemNote        = request.getParameter("sysnote");     //系统备注
	String opNote        = request.getParameter("tonote");     //用户备注
	
	
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
	
	String in_ChanceId = request.getParameter("in_ChanceId2"); //商机编码：端到端时由销售方面传入；其他时，传空串“”。
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
	String apnCode = request.getParameter("F10033");//APN时，APN号码
	String termNum = request.getParameter("F10034");//APN时，终端数量
	String billPayType = request.getParameter("F10035");//APN时，计费方式
	String limitAmount = request.getParameter("F00013");//ADC、MAS时，限制下发次数
	String sECBaseServCode = (String)request.getParameter("F00016");//EC基本接入号 wangzn add 2012/2/19 15:42:43
	String deal_str =catalog_item_id+"|"+ vPay_Si+"~"+"|"
	                + apnCode+"~"+termNum+"~"+billPayType+"~"+"|"
	                + bizCode+"~"+limitAmount+"~"+"|"
	                + managerId+"~"+managerPasswd+"~"+"|"
	                + vpmn_str+"|"
	                + bizCode+"~"+"|";
    String smAttrLimit_str = bizCode+"~"+server_no+"~"+managerId+"~"+apnCode+"~"+catalog_item_id+"~"+sECBaseServCode+"~";//wangzn modify 2012/2/19 15:42:51 增加ec基本接入号
    
    String serviceName = "";
    String iAccept = "";
    String DLFlag = "";
    /* 直接进入或端到端(只有一条数据)时，调用s3690CfmE服务；动力100或端到端(有多条数据)时，调用s3690DLCfm服务。 */
    if("opcode".equals(iOpenLabel) || ("link".equals(iOpenLabel) && "1".equals(iCount)) || "ML".equals(oMLFlag)){
        serviceName = "s3690CfmE";
        DLFlag = "";
    }else{
        serviceName = "s3690DLCfm";
        DLFlag = "1";
    }
    System.out.println("# From f3690_2.jsp -> serviceName = "+serviceName);
    /* 直接输入opcode接入时，页面取流水号传入服务；端到端或动力100接入时，取由4091或7421模块拆分出的子流水，传入服务。 */
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
                
                <wtc:param value="<%=id_no%>"/><!--集团用户编号-->
                <wtc:param value="<%=iWorkNo%>"/><!--工号-->
                <wtc:param value="<%=iSm_Code%>"/><!--服务品牌-->
                <wtc:param value="<%=iCust_Id%>"/><!--集团客户ID-->
                <wtc:param value="<%=iWorkPwd%>"/><!--工号密码-->
                
                <wtc:param value="<%=iProvince%>"/><!--集团所在省区号-->
                <wtc:param value="<%=iAccept%>"/><!--流水号-->
                <wtc:param value="3690"/>
                <wtc:param value="<%=iOrgCode%>"/>
                <wtc:param value="<%=iOp_Note%>"/>
                
                <wtc:param value="<%=iIpAddr%>"/>
                <wtc:param value="<%=iOrg_Id%>"/>
                <wtc:param value="<%=iBelong_Code%>"/><!--归属代码-->
                <wtc:param value="<%=iGroup_Id%>"/>
                <wtc:param value="<%=iSys_Note%>"/>
                
                <wtc:param value="<%=iGrp_Name%>"/><!--用户名称-->
                <wtc:param value="<%=iGrp_UserNo%>"/><!--VPMN业务中，集团产品编号-->
                <wtc:param value="<%=channel_id%>"/><!--渠道接点-->
                <wtc:param value="<%=iBill_Type%>"/><!--出帐周期 0-->
                <wtc:param value="<%=iUser_Passwd%>"/><!--集团用户（帐户）密码-->
                
                <wtc:param value="<%=iBill_Date%>"/><!--业务结束日期-->
                <wtc:param value="<%=iContract_No%>"/><!--产品帐户ID-->
                <wtc:param value="<%=deal_str%>"/>
                <wtc:param value="<%=smAttrLimit_str%>"/>
                <wtc:param value="<%=feeList%>"/><!--费用信息-->
                    
                <wtc:param value="0"/><!--requestType-->
                <wtc:param value="u01"/><!--op_type-->
                <wtc:param value="<%=wa_no%>"/><!--商机编码-->
                <wtc:param value="<%=timeMOStr%>"/>
                <wtc:param value="<%=iProduct_Prices%>"/><!--议价信息串-->
                	
                <wtc:param value="<%=iProduct_Code%>"/><!--集团产品-->
                <wtc:param value="<%=DLFlag%>"/>
                <wtc:param value="<%=inBatchNo%>"/>
                <wtc:params value="<%=parm4%>"/><!--集团字段代码-->
                <wtc:params value="<%=parm6%>"/><!--集团用户组号-->
                	
                <wtc:params value="<%=parm5%>"/><!--集团字段值-->
                <wtc:params value="<%=ProdAppend%>"/><!--集团附加产品代码-->
                <wtc:param value=""/><!--预留参数-->
                <wtc:param value=""/><!--预留参数-->
                <wtc:param value=""/><!--预留参数-->
                	
                <wtc:param value=""/><!--预留参数-->
                <wtc:param value=""/><!--预留参数-->
                <wtc:param value="<%=cptId%>"/><!--预留参数-->
                <wtc:param value="<%=cnttId%>"/><!--预留参数-->
                 <wtc:param value="<%=input_accept%>"/><!--产品部流水-->
            </wtc:service>
            <wtc:array id="TlsLogicSerArr" scope="end"/>
            <%
            error_code = TlsLogicSerCode;
            error_msg = TlsLogicSerMsg;
   System.out.println("||||||||||||||&&&&&&&&&&&&&&&&&&&###################|||||||||||||||||");
   System.out.println("......error_code......."+error_code+"......error_msg...."+error_msg);



		
		//----------------------为打印发票组织参数add
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
	  //打印发票
      rdShowMessageDialog("开户成功,下面将打印发票,请检查纸张!",2);

	  //--------------------print begin-----------------------------//
    var op_code = "<%=iOpCode%>";//op_code  操作代码
	  var work_no = "<%=iWorkNo%>";//work_no 工号
	  var maxAccept = "<%=iLoginAccept%>";//maxAccept 流水
	  var phoneNo = "<%=iGrp_UserNo%>";//phoneNo 手机号码////成员用户编码 ok
	  var smName = "<%=smName%>";//smName 品牌名称
	  var custName = "<%=custName%>";//custName 客户姓名  ///// oksql select cust_name from dCustDoc where //cust_id = 8610277301;
	  var cust_Address="<%=cust_Address%>";
	  var iHandFee = "<%=iHandFee%>";// 实收手续费
	  var iCash_Pay = "<%=iCash_Pay%>";// 付款金额
	  var tmpMoney = Math.round(iHandFee)+Math.round(iCash_Pay);//tmpMoney 交费合计 =实收手续费+付款金额
	  //alert("tmpMoney"+tmpMoney);
	  var innetFee = "0.00";//innetFee 入网费 0
	  var simFee = "0.00";//simFee SIM卡费 0
	  var selectFee = "0.00"; //selectFee 选号费 0
	  var insuranceFee = "0.00";//insuranceFee 保险费 0
	  var checkMachineFee = "0.00";//checkMachineFee 验机费 0
	  var handFee = "<%=iHandFee%>"; //handFee 手续费 =实收手续费
	  var machineFee = "0.00"; //machineFee 机器费 0
	  var otherFee = "<%=iCash_Pay%>";//其他费 =付款金额
	  var totalPrepay = "0.00"; //totalPrepay 预存款 0
      var payType = "<%=iPay_Type%>";//付费类型
	  if(payType=='0'){
          var cashPay = tmpMoney; //cashPay 现金方式 tmpMoney ?0
	      var checkPay = "0.00"; //checkPay 支票方式 tmpMoney?0
	  }else{
		  var cashPay = "0.00"; //cashPay 现金方式 tmpMoney ?0
	      var checkPay = tmpMoney; //checkPay 支票方式 tmpMoney?0
	  }
	  var systemNote = "<%=systemNote%>"; //systemNote 系统备注
	  var opNote = "<%=opNote%>"; //opNote 用户备注

	  var printInfo = "op_code="+op_code+"&work_no="+work_no+"&maxAccept="+maxAccept+"&phoneNo="+phoneNo+"&smName="+smName+"&custName="+custName+"&tmpMoney="+tmpMoney+"&innetFee="+innetFee+"&simFee="+simFee+"&selectFee="+selectFee+"&insuranceFee="+insuranceFee+"&checkMachineFee="+checkMachineFee+"&handFee="+handFee+"&machineFee="+machineFee+"&otherFee="+otherFee+"&totalPrepay="+totalPrepay+"&cashPay="+cashPay+"&checkPay="+checkPay+"&systemNote="+systemNote+"&opNote="+opNote;

	 
	 
	 var ProFlag= "<%=ProvinceRun%>"; //判断省份
	 if(ProFlag=="20")//吉林
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
		   infoStr+="现金"+"|";	
		   infoStr+="<%=strTotal%>"+"|";
	     infoStr+="*手续费："+"<%=iHandFee%>"+"*流水号："+"<%=iAccept%>"+"|";
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
            window.opener.frm.<%=iBtnId%>.value="成功";
            window.opener.frm.<%=iBtnId%>.disabled=true;
            window.close();
        <%}else{%>
            removeCurrentTab();
        <%}%>
	 <%}else{%>
        rdShowMessageDialog("集团用户开户操作成功！",2);
        <%if("DL100".equals(iOpenLabel)){%>
            window.opener.frm.<%=iBtnId%>.value="成功";
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
	
