<%
    /********************
     * @ OpCode    :  7983
     * @ OpName    :  集团成员增加
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2009-10-20
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
    <input type="hidden" id="unitId" name="unitId" value="" />
    <input type="hidden" id="loginAccept" name="loginAccept" value="" />
    <input type="hidden" id="grpName" name="grpName" value="" />
</form>
</body>
<%

    String RH_input_radio = WtcUtil.repNull((String)request.getParameter("RH_input_radio"));
    String opCode = "7983";
    String opName = "集团成员增加";
    String workNo               = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName             = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode           = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String orgCode              = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String ipAddr               = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String workPwd              = WtcUtil.repNull((String)session.getAttribute("password"));
    String groupId              = WtcUtil.repNull((String)session.getAttribute("groupId"));
    
	String iUnitId              = WtcUtil.repNull((String)request.getParameter("unit_id"));
	String iGrpName             = WtcUtil.repNull((String)request.getParameter("grp_name"));
    String iLoginAccept         = WtcUtil.repNull((String)request.getParameter("sysAccept"));
    String iSysNote             = WtcUtil.repNull((String)request.getParameter("op_note"));
    String iOpNote              = WtcUtil.repNull((String)request.getParameter("op_note"));
    String iIdNo                = WtcUtil.repNull((String)request.getParameter("id_no"));
    String iUserType            = WtcUtil.repNull((String)request.getParameter("user_type"));
    String iSmCode              = WtcUtil.repNull((String)request.getParameter("sm_code"));
    String iAddModeFlag         = WtcUtil.repNull((String)request.getParameter("add_mode_flag"));
    
    String product_name              = WtcUtil.repNull((String)request.getParameter("product_name"));
    String iccid              = WtcUtil.repNull((String)request.getParameter("iccid"));
    String phonNosLength              = WtcUtil.repNull((String)request.getParameter("phonNosLength"));
    String phoneFlag              = WtcUtil.repNull((String)request.getParameter("phoneFlag"));
    String extInputType = WtcUtil.repNull((String)request.getParameter("extInputType"));//liujian multi/file
    if("hy".equals(iSmCode)){
        iAddModeFlag = "3";
    }
    String iRequestType = "";
    if("AD".equals(iSmCode) || "ML".equals(iSmCode) || "MA".equals(iSmCode)){
        iRequestType = WtcUtil.repNull((String)request.getParameter("request_type"));
    }else{
        iRequestType = "";
    }
    String iInputType           = WtcUtil.repNull((String)request.getParameter("input_type"));
    String iVpmnInputType       = WtcUtil.repNull((String)request.getParameter("vpmn_input_type"));
    String iJ1InputType       = WtcUtil.repNull((String)request.getParameter("j1_input_type"));	//liujian7983a添加 2010-12-6 10:56 移动总机接入BOSS
    String iInputFlag = "";
    if("vp".equals(iSmCode)){
        iInputFlag = iVpmnInputType;
    }else if("j1".equals(iSmCode)){
        iInputFlag = iJ1InputType;
    }else{
        iInputFlag = iInputType;
    }

    if("file".equals(iInputFlag) || "vpmnFile".equals(iInputFlag) || "j1File".equals(iInputFlag)){
        iInputFlag = "file";
    }else{
        iInputFlag = "no";
    }
    if("hj".equals(iSmCode)) {
    	if(extInputType != null && extInputType.equals("multi")) {
    		iInputFlag = "no";
    	}else if(extInputType != null && extInputType.equals("file")) {
    		iInputFlag = "file";	
    	}
    }
    
    if (RH_input_radio != null && !RH_input_radio.equals("")){
        iInputFlag = RH_input_radio;
    }
    
    System.out.println("--liujian7983---iInputFlag=" + iInputFlag);
    String iInputFile           = WtcUtil.repNull((String)request.getParameter("inputFile"));
    String iServerIpAddr        = realip;   // 0.100主机隐藏ip用上面方法得到的是0.100非真实ip
    
    String iSinglePhone         = WtcUtil.repNull((String)request.getParameter("single_phoneno"));
    String iMultiPhone          = WtcUtil.repNull((String)request.getParameter("multi_phoneNo"));
    String iPhoneList = "";
    if("multi".equals(iInputType)){
        iPhoneList = iMultiPhone;
    }else{
        iPhoneList = iSinglePhone + "|";
    }
    String iBelongCode          = WtcUtil.repNull((String)request.getParameter("belong_code"));
    String iPayFlag             = "";
    String iPayListShow         = WtcUtil.repNull((String)request.getParameter("pay_list_show"));
    if("".equals(iPayListShow)){
        iPayFlag = WtcUtil.repNull((String)request.getParameter("pay_flag"));
    }else if("none".equals(iPayListShow)){
        iPayFlag = "";
    }
    String iOpType = "m01";
    String iGrpOutNo            = WtcUtil.repNull((String)request.getParameter("service_no"));
    String iAddProductCode      = "";
    if(!"CR".equals(iSmCode)){
        iAddProductCode = WtcUtil.repNull((String)request.getParameter("addProductId"));
    }else{
        iAddProductCode = WtcUtil.repNull((String)request.getParameter("addProductIdCR"));
    }
    
    
    String addProductIdYH = WtcUtil.repNull((String)request.getParameter("addProductIdYH"));
    
    String[] subModeCode = new String[1];
    subModeCode[0] = iAddProductCode;
    String iFeeList = "";
    String iApnNo               = WtcUtil.repNull((String)request.getParameter("apnNo"));
    String iBillTime            = WtcUtil.repNull((String)request.getParameter("billTime"));
    String iPhoneType = "";
    if("vp".equals(iSmCode)){
        iPhoneType = WtcUtil.repNull((String)request.getParameter("phone_type"));
    }else{
        iPhoneType = "";
    }
    String iMebMonthFlag = "";
    String iMatureProdCode = "";
    String iMatureFlag = "";
    if("CR".equals(iSmCode)){
        iMebMonthFlag   = WtcUtil.repNull((String)request.getParameter("mebMonthFlag"));
        iMatureProdCode = WtcUtil.repNull((String)request.getParameter("matureProdCode"));
        iMatureFlag     = WtcUtil.repNull((String)request.getParameter("matureFlag"));
    }else{
        iMebMonthFlag = "";
        iMatureProdCode = "";
        iMatureFlag = "";
    }
    
    
    
    
    
    
    String iApnIpAddr           = WtcUtil.repNull((String)request.getParameter("F81002"));  //APN成员IP地址
    String iGrpUnitId = new String();
    if ("j1".equals(iSmCode)) {	//liujian7983a修改 j1接入BOSS需求
	    iGrpUnitId = WtcUtil.repNull((String)request.getParameter("unit_id"));
	} else {
	    iGrpUnitId = WtcUtil.repNull((String)request.getParameter("grp_unit_id"));
	}
    String iDEPT                = WtcUtil.repNull((String)request.getParameter("F80002"));
    String iExpectTime          = WtcUtil.repNull((String)request.getParameter("expect_time"));
    String iAllPayFlag          = WtcUtil.repNull((String)request.getParameter("allPayFlag"));
    String iAllFlag             = WtcUtil.repNull((String)request.getParameter("allFlag"));
    String iCycleMoney          = WtcUtil.repNull((String)request.getParameter("cycleMoney"));
    String iBeginDate           = WtcUtil.repNull((String)request.getParameter("beginDate"));
    String iEndDate             = WtcUtil.repNull((String)request.getParameter("endDate"));
    String iNpList = iAllPayFlag + "~"
                   + iAllFlag    + "~"
                   + iCycleMoney + "~"
                   + iBeginDate  + "~"
                   + iEndDate    + "~";
                   
    String F80024 = WtcUtil.repNull((String)request.getParameter("F80024"));      // 个人付费放音标志
    String F80025 = WtcUtil.repNull((String)request.getParameter("F80025"));      // 语言种类
    String F80026 = WtcUtil.repNull((String)request.getParameter("F80026"));      // 主叫号码显示方式
    String iStatus = F80024 + F80025 + F80026 + "0000000";      // vp - 成员状态
    
    String F80027 = WtcUtil.repNull((String)request.getParameter("F80027"));        // 网内
    String F80028 = WtcUtil.repNull((String)request.getParameter("F80028"));        // 网间
    String F80029 = WtcUtil.repNull((String)request.getParameter("F80029"));        // 网外主叫
    String F80030 = WtcUtil.repNull((String)request.getParameter("F80030"));        // 网外号码组
    String iFeeFlag = F80027 + F80028 + F80029 + F80030;
    
    String opTime = "";
    String  insql = "select to_char(sysdate,'YYYYMMDD HH24:MI:SS')  from  dual";
    %>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg61" outnum="1">
        <wtc:sql><%=insql%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result6" scope="end" />
    <%
    if("000000".equals(retCode6) && result6.length>0){
        opTime = result6[0][0];
    }else{
        opTime = "";
    }
    
    /* vpmn时,取数据 */
    String tmpR1 = WtcUtil.repNull((String)request.getParameter("tmpR1"));
    String tmpR2 = WtcUtil.repNull((String)request.getParameter("tmpR2"));
    String tmpR3 = WtcUtil.repNull((String)request.getParameter("tmpR3"));
    String tmpR4 = WtcUtil.repNull((String)request.getParameter("tmpR4"));
    String tmpR5 = WtcUtil.repNull((String)request.getParameter("tmpR5"));
    
    /* RH时，融合通信取值*/
    String tmpR6 = WtcUtil.repNull((String)request.getParameter("tmpR6"));
    String busiFlag = WtcUtil.repNull((String)request.getParameter("busiFlag"));
    String tmpR7 = WtcUtil.repNull((String)request.getParameter("tmpR7"));//联系人姓名
    String tmpR8 = WtcUtil.repNull((String)request.getParameter("tmpR8"));//联系电话
    
    

    System.out.println("#   34短号     = "+tmpR1);
    System.out.println("#   35手机号码 = "+tmpR2);
    System.out.println("#   客户姓名 = "+tmpR3);
    System.out.println("#   证件号码 = "+tmpR4);
    System.out.println("#   备注信息 = "+tmpR5);
    System.out.println("#   固话对应的手机号码 = "+tmpR6);
    /* end of vpmn 取数据 */
    
    /* 获取动态展示数据 */
	String name_list = request.getParameter("nameList");
	String grp_list = request.getParameter("nameGroupList");
	StringTokenizer token = new StringTokenizer(name_list,"|");
	StringTokenizer token_grp = new StringTokenizer(grp_list,"|");
	int length = token.countTokens();
	System.out.println("---------------------------------liujian7983------name_list=" + name_list);
	System.out.println("---------------------------------liujian7983------select=" + request.getParameter("F81018"));
	System.out.println("---------------------------------liujian7983------select2=" + request.getParameter("F81019"));
	System.out.println("---------------------------------liujian7983------length=" + length);
	String fieldCodes[] = new String [length];
	String fieldValues[] = new String [length];
	String fieldRowNo[] = new String [length];
	
	ArrayList fieldValueAry = new ArrayList();
	Vector vec = new Vector();
	
	
	//解析组号字符串
	int k=0;
	while (token_grp.hasMoreElements()){
		fieldRowNo[k]=(String)token_grp.nextElement();
		System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
		k++;
	}
	
	int i=0;
	int pp=0;
	//解析名字和值字符串
	while (token.hasMoreElements()){
		fieldCodes[i]=(String)token.nextElement();
		System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
		System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
		
		if(!vec.contains(fieldCodes[i]))
		{
			if(!fieldRowNo[i].equals("0"))	//行号从1开始
			{
				String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
				System.out.println("@:***"+tempValues+"***") ;
				if(tempValues==null)
				{
					tempValues = new String[0];
				}
				for(pp=0;pp<tempValues.length;pp++)
				{
					fieldValueAry.add(tempValues[pp]);
					System.out.println("###########********tempValues["+pp+"]**********##########"+tempValues[pp]);
				}
			}
			else
			{
				fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
				System.out.println("###########********tempValues["+pp+"]**********##########"+request.getParameter("F"+fieldCodes[i]));
			}
			vec.add(fieldCodes[i]);
		}
		i++;
	}
	
	fieldValues=(String[])fieldValueAry.toArray(new String[length]);
	/* end of 获取动态展示数据 */
	
	/* 对取得的动态展示数据进行调整:增加、删除一些数据 */
	String fieldCodesArr[] = null;
    String fieldValueArr[] = null;
    String fieldRowNoArr[] = null;
    
	if("vp".equals(iSmCode)){
	    int addFlag = 14;
        int rmvFlag = 8;
        System.out.println("----liujian7983---length=" + length);
        System.out.println("----liujian7983---addFlag=" + addFlag);
        System.out.println("----liujian7983---rmvFlag=" + rmvFlag);
    	fieldCodesArr = new String [length+addFlag-rmvFlag];
        fieldValueArr = new String [length+addFlag-rmvFlag];
        fieldRowNoArr = new String [length+addFlag-rmvFlag];
        
        int tmp1 = 0;
        for(int x=0;x<fieldCodes.length;x++){
            if(!"80023".equals(fieldCodes[x]) && !"80024".equals(fieldCodes[x]) && !"80025".equals(fieldCodes[x]) && !"80026".equals(fieldCodes[x]) && !"80027".equals(fieldCodes[x]) && !"80028".equals(fieldCodes[x]) && !"80029".equals(fieldCodes[x]) && !"80030".equals(fieldCodes[x])){
                fieldCodesArr[tmp1] = fieldCodes[x];
                fieldValueArr[tmp1] = fieldValues[x];
                fieldRowNoArr[tmp1] = fieldRowNo[x];
                tmp1++;
            }
        }
        System.out.println("------------------haoyy---------------liujian7983------length=" + length);
        System.out.println("-------------------haoyy--------------liujian7983------rmvFlag=" + rmvFlag);
        /* 成员状态 */
        fieldCodesArr[length-rmvFlag] = "80001";
        fieldValueArr[length-rmvFlag] = iStatus;
        fieldRowNoArr[length-rmvFlag] = "0";
        /* 当月费用类型 */
        fieldCodesArr[length-rmvFlag+1] = "80021";
        fieldValueArr[length-rmvFlag+1] = "0";
        fieldRowNoArr[length-rmvFlag+1] = "0";
        /* 下月费用类型 */
        fieldCodesArr[length-rmvFlag+2] = "80005";
        fieldValueArr[length-rmvFlag+2] = "0";
        fieldRowNoArr[length-rmvFlag+2] = "0";
        /* 费用标志 */
        fieldCodesArr[length-rmvFlag+3] = "80007";
        fieldValueArr[length-rmvFlag+3] = iFeeFlag;
        fieldRowNoArr[length-rmvFlag+3] = "0";
        /* 变更标志 */
        fieldCodesArr[length-rmvFlag+4] = "80009";
        fieldValueArr[length-rmvFlag+4] = "N";
        fieldRowNoArr[length-rmvFlag+4] = "0";
        /* 变更时间 */
        fieldCodesArr[length-rmvFlag+5] = "80010";
        fieldValueArr[length-rmvFlag+5] = opTime;
        fieldRowNoArr[length-rmvFlag+5] = "0";
        /* 锁标志 */
        fieldCodesArr[length-rmvFlag+6] = "80011";
        fieldValueArr[length-rmvFlag+6] = "0";
        fieldRowNoArr[length-rmvFlag+6] = "0";
        /* USER_PIN */
        fieldCodesArr[length-rmvFlag+7] = "80012";
        fieldValueArr[length-rmvFlag+7] = "88888888";
        fieldRowNoArr[length-rmvFlag+7] = "0";
        /* 有效标志 */
        fieldCodesArr[length-rmvFlag+8] = "80013";
        fieldValueArr[length-rmvFlag+8] = "Y";
        fieldRowNoArr[length-rmvFlag+8] = "0";
        /* KEY_FLAG */
        fieldCodesArr[length-rmvFlag+9] = "80014";
        fieldValueArr[length-rmvFlag+9] = "0";
        fieldRowNoArr[length-rmvFlag+9] = "0";
        /* LAN_FLAG */
        fieldCodesArr[length-rmvFlag+10] = "80015";
        fieldValueArr[length-rmvFlag+10] = "Y";
        fieldRowNoArr[length-rmvFlag+10] = "0";
        /* OUTGRP */
        fieldCodesArr[length-rmvFlag+11] = "80018";
        fieldValueArr[length-rmvFlag+11] = "0";
        fieldRowNoArr[length-rmvFlag+11] = "0";
        /* 最大集团号码数量 */
        fieldCodesArr[length-rmvFlag+12] = "80019";
        fieldValueArr[length-rmvFlag+12] = "10";
        fieldRowNoArr[length-rmvFlag+12] = "0";
        /* 付费模式 */
        fieldCodesArr[length-rmvFlag+13] = "80020";
        fieldValueArr[length-rmvFlag+13] = "1";
        fieldRowNoArr[length-rmvFlag+13] = "0";
    /*diling update for 去掉智慧城管品牌@2012/10/11 
    }else if("ap".equals(iSmCode)||"ZH".equals(iSmCode)){//haoyy add 2012/7/23 15:23 添加智慧城管品牌
    */
    }else if("ap".equals(iSmCode)){
        int addFlag = 6;
        int rmvFlag = 1;
        fieldCodesArr = new String [length+addFlag-rmvFlag];
        fieldValueArr = new String [length+addFlag-rmvFlag];
        fieldRowNoArr = new String [length+addFlag-rmvFlag];
        
        int tmp2 = 0;
        for(int x=0;x<fieldCodes.length;x++){
            if(!"81008".equals(fieldCodes[x])){
            		System.out.println("====liujian7983a====f7983_2.jsp==== fieldCodesArr["+tmp2+"] = " + fieldCodesArr[tmp2]);
            		System.out.println("====liujian7983a====f7983_2.jsp==== fieldValueArr["+tmp2+"] = " + fieldValueArr[tmp2]);
            		System.out.println("====liujian7983a====f7983_2.jsp==== fieldRowNoArr["+tmp2+"] = " + fieldRowNoArr[tmp2]);
                fieldCodesArr[tmp2] = fieldCodes[x];
                fieldValueArr[tmp2] = fieldValues[x];
                fieldRowNoArr[tmp2] = fieldRowNo[x];
                tmp2++;
            }
        }
        /* 公网IP */
        fieldCodesArr[length-rmvFlag] = "81003";
        fieldValueArr[length-rmvFlag] = "";
        fieldRowNoArr[length-rmvFlag] = "0";
        /* 终端IP */
        fieldCodesArr[length-rmvFlag+1] = "81004";
        fieldValueArr[length-rmvFlag+1] = "";
        fieldRowNoArr[length-rmvFlag+1] = "0";
        /* 服务器IP */
        fieldCodesArr[length-rmvFlag+2] = "81005";
        fieldValueArr[length-rmvFlag+2] = "";
        fieldRowNoArr[length-rmvFlag+2] = "0";
        /* apn号码 */
        fieldCodesArr[length-rmvFlag+3] = "81006";
        fieldValueArr[length-rmvFlag+3] = iApnNo;
        fieldRowNoArr[length-rmvFlag+3] = "0";
        /* apn编号 */
        fieldCodesArr[length-rmvFlag+4] = "81007";
        fieldValueArr[length-rmvFlag+4] = iIdNo;
        fieldRowNoArr[length-rmvFlag+4] = "0";
        /* apn编号 */
        fieldCodesArr[length-rmvFlag+5] = "81008";
        fieldValueArr[length-rmvFlag+5] = WtcUtil.repNull((String)request.getParameter("F81008"));;
        fieldRowNoArr[length-rmvFlag+5] = "0";
    }else{
        fieldCodesArr = new String [length];
        fieldValueArr = new String [length];
        fieldRowNoArr = new String [length];
        
        for(int x=0;x<fieldCodes.length;x++){
					fieldCodesArr[x] = fieldCodes[x];
					fieldValueArr[x] = fieldValues[x];
					fieldRowNoArr[x] = fieldRowNo[x];
        }
    }
    
    System.out.println("===========================");
    System.out.println("# fieldCodesArr.length = "+fieldCodesArr.length);
    System.out.println("===========================");
    
    for(int x=0;x<fieldCodesArr.length;x++){
        System.out.println("# fieldCodesArr["+x+"] = "+fieldCodesArr[x]);
        System.out.println("# fieldValueArr["+x+"] = "+fieldValueArr[x]);
        System.out.println("# fieldRowNoArr["+x+"] = "+fieldRowNoArr[x]);
    }
	/* end of 对取得的动态展示数据进行调整 */
	
    String retCodeForCntt = "";
    String retMsgForCntt = "";
    
	try{
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====0==== " + iLoginAccept);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====1==== " + opCode);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====2==== " + workNo);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====3==== " + workPwd);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====4==== " + orgCode);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====5==== " + iSysNote);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====6==== " + iOpNote);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====7==== " + ipAddr);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====8==== " + iIdNo);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm=====9==== " + iPhoneList);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====10==== " + iUserType);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====11==== " + iRequestType);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====12==== 0");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====13==== " + iBillTime);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====14==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====15==== " + iBelongCode);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====16==== " + iPayFlag);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====17==== " + groupId);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====18==== " + iSmCode);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====19==== " + iOpType);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====20==== " + iNpList);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====21==== " + iApnNo);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====22==== " + iApnIpAddr);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====23==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====24==== " + iFeeList);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====25==== " + iExpectTime);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====26==== " + iGrpOutNo);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====27==== 0~0~0~0~0~");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====28==== " + iDEPT);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====29==== " + iGrpUnitId);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====30==== " + iPhoneType);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====31==== " + iMebMonthFlag);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====32==== " + iMatureProdCode);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====33==== " + iMatureFlag);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====34==== " + tmpR1);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====35==== " + tmpR2);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====36==== " + tmpR4);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====37==== " + tmpR3);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====38==== " + tmpR5);
		System.out.println("====zhoubyx====f7983_2.jsp====s7983Cfm====48==== " + tmpR6);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====39==== " + iAddModeFlag);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====40==== " + iInputFlag);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====41==== " + iInputFile);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====42==== " + iServerIpAddr);
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====43==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====44==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm========== 以上是固定的入参");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====45==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====46==== ");
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm====47==== ");
%>
        <wtc:service name="s7983Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
            <!--0-->
            <wtc:param value="<%=iLoginAccept%>"/>
            <wtc:param value="<%=opCode%>"/>
            <wtc:param value="<%=workNo%>"/>
            <wtc:param value="<%=workPwd%>"/>
            <wtc:param value="<%=orgCode%>"/>
            <!--5-->
            <wtc:param value="<%=iSysNote%>"/>
            <wtc:param value="<%=iOpNote%>"/>
            <wtc:param value="<%=ipAddr%>"/>
            <wtc:param value="<%=iIdNo%>"/>
            <wtc:param value="<%=iPhoneList%>"/>
            <!--10-->
            <wtc:param value="<%=iUserType%>"/>
            <wtc:param value="<%=iRequestType%>"/>
            <wtc:param value="0"/>
            <wtc:param value="<%=iBillTime%>"/>
            <wtc:param value=""/>
            <!--15-->
            <wtc:param value="<%=iBelongCode%>"/>
            <wtc:param value="<%=iPayFlag%>"/>
            <wtc:param value="<%=groupId%>"/>
            <wtc:param value="<%=iSmCode%>"/>
            <wtc:param value="<%=iOpType%>"/>
            <!--20-->
            <wtc:param value="<%=iNpList%>"/>
            <wtc:param value="<%=iApnNo%>"/>
            <wtc:param value="<%=iApnIpAddr%>"/>
            <wtc:param value=""/>
            <wtc:param value="<%=iFeeList%>"/>
            <!--25-->
            <wtc:param value="<%=iExpectTime%>"/>
            <wtc:param value="<%=iGrpOutNo%>"/>
            <wtc:param value="0~0~0~0~0~"/>
            <wtc:param value="<%=iDEPT%>"/>
            <wtc:param value="<%=iGrpUnitId%>"/>
            <!--30-->
            <wtc:param value="<%=iPhoneType%>"/>
            <wtc:param value="<%=iMebMonthFlag%>"/>
           
           <%if("RH".equals(iSmCode)&&"186".equals(busiFlag)){%>
           		<wtc:param value="<%=addProductIdYH%>"/>
           <%}else{%>
           		<wtc:param value="<%=iMatureProdCode%>"/>
	         <%}%>	
	        
            
            <wtc:param value="<%=iMatureFlag%>"/>
            <wtc:param value="<%=tmpR1%>"/>
            <!--35-->
            <wtc:param value="<%=tmpR2%>"/>
            <wtc:param value="<%=tmpR4%>"/>
            <wtc:param value="<%=tmpR3%>"/>
          <%if("186".equals(busiFlag)){%>
          	<wtc:param value="<%=tmpR6%>"/>
          <%}else{%>
          	<wtc:param value="<%=tmpR5%>"/>
          <%}%>
						<wtc:param value="<%=iAddModeFlag%>"/>
						<!--40-->
		    		<wtc:param value="<%=iInputFlag%>"/> <!-- 号码输入类型 -->
            <wtc:param value="<%=iInputFile%>"/>
            <wtc:param value="<%=iServerIpAddr%>"/>
       		<%if("186".equals(busiFlag)){%>
          	<wtc:param value="<%=tmpR7%>"/>
          	<wtc:param value="<%=tmpR8%>"/>
	        <%}else{%>
	          <wtc:param value=""/>
						<wtc:param value=""/>
	        <%}%>
						

            
            <%if(subModeCode.length>0){%>	
                <wtc:params value="<%=subModeCode%>"/>
            <%}else{%>
                <wtc:param value=""/>
            <%}%>
            <%if(fieldCodes.length>0){%>
                <wtc:params value="<%=fieldCodesArr%>"/>
                <wtc:params value="<%=fieldValueArr%>"/>
                <wtc:params value="<%=fieldRowNoArr%>"/>
            <%}else{%>
                <wtc:param value=""/>
                <wtc:param value=""/>
                <wtc:param value=""/>
            <%}%>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
<%
		System.out.println("====liujian7983a====f7983_2.jsp====s7983Cfm==== " + retCode + ", " + retMsg);
    	retCodeForCntt = retCode;
    	retMsgForCntt = retMsg;
        if("000000".equals(retCode)){
            String errPhoneList = retArr[0][0];
            String errMsgList   = retArr[0][1];
            String rphone = "";
            StringTokenizer stPhone = new StringTokenizer(errPhoneList,"|");
            String[] errPhoneArr = new String[stPhone.countTokens()];
   			 int h = 0;   
    		 while(stPhone.hasMoreTokens()){
              errPhoneArr[h] = stPhone.nextToken();
              h++;
            }
            if(phoneFlag.equals("more") && "vp".equals(iSmCode)){
             String[] phioneAttr = tmpR2.split("\\|");
             ArrayList list = new ArrayList();
             for(int y=0;y<phioneAttr.length;y++){
                list.add(phioneAttr[y]);
             }
             ArrayList list1 = new ArrayList();
             for(int u=0;u<errPhoneArr.length;u++){
                list1.add(errPhoneArr[u]);
             }
             
             list.removeAll(list1);
             
             for(int m=0;m<list.size();m++){
               rphone = rphone + (String)list.get(m) + ",";
             }
             System.out.println("=====================qqqqqq==========================================   "+rphone);
            }
            
       /* 读文件 --- -- */
       /* 0 失败    1成功*/
       String printFlag = "1";
    try{
       if(phoneFlag.equals("file") && "vp".equals(iSmCode)){
					File file=null; 
					file=new File(iInputFile);
					BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(file)));  		
					String str=br.readLine();
					
					while(str!=null)
					{   
						String strArr[] = str.trim().split(" ");
						rphone = rphone + strArr[1] + ",";
						str = br.readLine();
					}
					
					String[] phoneAttr1 = rphone.split(",");
					ArrayList list2 = new ArrayList();
					for(int y1=0;y1<phoneAttr1.length;y1++){
						list2.add(phoneAttr1[y1]);
					}
					ArrayList list3 = new ArrayList();
					for(int u1=0;u1<errPhoneArr.length;u1++){
						list3.add(errPhoneArr[u1]);
					}
					
					list2.removeAll(list3);
					rphone = "";
					for(int m1=0;m1<list2.size();m1++){
						rphone = rphone + (String)list2.get(m1) + ",";
					}
					
					System.out.println("=====================aaaaaa==========================================   "+rphone);
       }
       printFlag = "1";
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("免填单打印失败，请使用正确分隔符！",0);
        </script>
        <%
         printFlag = "0";
        System.out.println("# return from f7983_2.jsp -> Call Service s7983Cfm Failed!");
        e.printStackTrace();
    }
        
		
        /* 成功后转到错误展示页面 */
        %>
            <script language='jscript'>
            	window.onload=doJudge;
            	function doJudge(){
            		if("<%=iSmCode%>" == "vp" && "<%=phonNosLength%>" > 2 && "1" == "<%=printFlag%>"){
            		   doFile();
            	    }else{
            	    	submitForm();
            	    }
            	}
            	
            	// 在免填单中打印 成功的电话号码  // 文件录入方式 ， 需要 从wloginopryyyymm 这个表中取出成功的手机号码
            	function doFile(){
            		 printInfoFile("<%=rphone%>","Detail","确实要进行电子免填单打印吗？","Yes");
            	} 
                
                
                function printInfoFile(retResult,printType,DlgMessage,submitCfm){
                	var h=200;
            		var w=352;
            		var t=screen.availHeight/2-h/2;
            		var l=screen.availWidth/2-w/2;
            		var hljPrint="hljPrint_more.jsp";
                	var retInfo="";
                	var phoneNo = "";
                	
                	retInfo+="集团产品名称:"+'<%=product_name%>'+"|";
                	retInfo+="业务类型：集团成员增加"+"|";
                	retInfo+="集团名称："+'<%=iGrpName%>'+"|";
                	retInfo+="证件号码:"+"<%=iccid%>"+"|";
                    retInfo+="手机号："+retResult+"|";
                    
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	
                	retInfo+="流水："+"<%=iLoginAccept%>"+"|";
                	retInfo+="操作工号："+'<%=workNo%>'+"|";
                	retInfo+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
                	retInfo+=""+"|";
            		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
            		var path = "<%=request.getContextPath()%>/npage/innet/"+hljPrint+"?DlgMsg=" + DlgMessage;
            		var path = path + "&printInfo=" + retInfo + "&submitCfm=" + submitCfm;
            		var ret=window.showModalDialog(path,"",prop);
            		
            		submitForm();
                }
                
                //------------------------------------------------------
                function submitForm(){
                	$("#errPhoneList").val("<%=errPhoneList%>");
                    $("#errMsgList").val("<%=errMsgList%>");
                    //alert($("#errMsgList").val());
                    $("#unitId").val("<%=iUnitId%>");
                    $("#loginAccept").val("<%=iLoginAccept%>");
                    $("#grpName").val("<%=iGrpName%>");
                
                    frm.action="f7983_3.jsp";
            	    frm.method="post";
            	    frm.submit();
                }
                
            	
            	//用location批量时有可能URL超长。
                //window.location="f7983_3.jsp?errPhoneList=<%=errPhoneList%>&errMsgList=<%=errMsgList%>&unitId=<%=iUnitId%>&loginAccept=<%=iLoginAccept%>&grpName=<%=iGrpName%>";
            </script>
        <%
        }else{
            %>
            <script type=text/javascript>
                rdShowMessageDialog("操作失败！<br/>错误代码：<%=retCode%>，错误信息:<%=retMsg%>",0);
                window.location="f7983_1.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s7983Cfm失败！",0);
            window.location="f7983_1.jsp";
        </script>
        <%
        System.out.println("# return from f7983_2.jsp -> Call Service s7983Cfm Failed!");
        e.printStackTrace();
    }
    
System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
%>
<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+iUnitId+"&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />
<%
System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
</html>