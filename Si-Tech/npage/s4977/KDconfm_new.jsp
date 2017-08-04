  <%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	
%>
<%

  String standardCode = WtcUtil.repNull(request.getParameter("standardCode"));
	String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	String offerType = WtcUtil.repNull(request.getParameter("offerType"));
  String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
  String paramValue_zhaz="N";
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //当前时间
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String objectId = (String)session.getAttribute("objectId");
	String groupId = (String)session.getAttribute("groupId");
	String siteId = (String)session.getAttribute("siteId");
	if(objectId ==null) objectId = orgCode;
	if(siteId==null) siteId = orgCode;
  System.out.println("当前时间=="+currentTime);
  System.out.println("groupId========"+groupId);
  String partnerCode=request.getParameter("partnerCode");
  /*2014/06/24 15:38:32 gaopeng 自有农村无线宽带（WBS）业务系统支撑需求 小区编码/小区建设性质/小区接入状况 */
  String distKdCode=request.getParameter("distKdCode");
  String nearInfo=request.getParameter("nearInfo");
  String propertyUnit=(String)request.getParameter("propertyUnit");
  System.out.println("gaopengSeeLog4977=====propertyUnit=="+propertyUnit);
  String kdZd = request.getParameter("kdZd");
  String kdZdFee = request.getParameter("kdZdFee");
  
  String fysqfs = request.getParameter("fysqfs");
  
  String snNumber = WtcUtil.repStr(request.getParameter("snNumber"),"");
  String isBaoNian = WtcUtil.repStr(request.getParameter("isBaoNian"),"0");
  
  /*2015/12/7 14:38:42 gaopeng 关于在宽带装机工单中增加“魔百和”安装选项的需求*/
  String ifMBH = WtcUtil.repNull(request.getParameter("ifMBH"));
  
  String yxds = WtcUtil.repNull(request.getParameter("yxds"));
  String jdhId = WtcUtil.repNull(request.getParameter("jdhId"));
  /*开户方式*/
  String openkdFlag = WtcUtil.repNull(request.getParameter("openkdFlag"));
  String yuankuandaiNum = WtcUtil.repNull(request.getParameter("yuankuandaiNum"));
  
  String anzhuangFangshi = WtcUtil.repNull(request.getParameter("anzhuangFangshi"));
	if("".equals(anzhuangFangshi)){
		anzhuangFangshi = "NULL";
	}
  
  if(openkdFlag==null || "".equals(openkdFlag)){
  	openkdFlag = "NULL";
  }
  if(yxds==null || "".equals(yxds)){
  	yxds = "产品未定制";
  }
  if(jdhId==null || "".equals(jdhId)){
  	jdhId = "产品未定制";
  }
  /*如果不安装魔百盒*/
  if("0".equals(ifMBH)){
    yxds = "产品未定制";
    jdhId = "产品未定制";
  }
   
	String phoneNo = "0";
	String serviceNo = WtcUtil.repNull(request.getParameter("phoneNo_h"));;
	String sysAcceptl	=  WtcUtil.repNull(request.getParameter("sysAcceptl"));
	System.out.println("---------------------gaopengSeeLog------sysAcceptl------------------------"+sysAcceptl);
	String printinfo   	=  WtcUtil.repNull(request.getParameter("path"));  //打印使用内容串
	System.out.println("---------------------------printinfo------------------------"+printinfo);
	String work_flow_no = WtcUtil.repNull(request.getParameter("work_flow_no"));//4603  工单号 4100 原手机号
	String phoneNo_h   = WtcUtil.repNull((String)request.getParameter("phoneNo_h"));  //用户号码 	 
	if(work_flow_no==null) work_flow_no = "";
	String mastServerType = WtcUtil.repNull(request.getParameter("mastServerType")); 
	String retnCode = "";
		phoneNo = phoneNo_h;
	
	String userpwd = WtcUtil.repNull(request.getParameter("userpwd"));	//密码加密
	String new_custPwd = (String)Encrypt.encrypt(userpwd);
	//System.out.println("---------------------------new_custPwd-------------------------"+new_custPwd);
	String serviceGroupId = WtcUtil.repNull(request.getParameter("serviceGroupId"));	
	if(serviceGroupId.equals("")){
		serviceGroupId = groupId;
	}
	String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	//客户订单号
	String custOrderNo = WtcUtil.repNull(request.getParameter("custOrderNo"));	
	String prtFlag = WtcUtil.repNull(request.getParameter("prtFlag"));//Y 合打，N 分打
	String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));		//客户订单子项ID
	String custId = WtcUtil.repNull(request.getParameter("gCustId"));
	String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//客户服务定单号
	if(servOrderId.equals("")){
		servOrderId = "0";
	}
	String offeridkd = WtcUtil.repNull(request.getParameter("offeridkd"));
	/* 有无端口   1无端口    0有端口 */
	String noPort = WtcUtil.repNull(request.getParameter("noPort"));
	/** 品牌 
	 *	是否内线施工，铁通无端口传Y，有端口传N。广电始终传N。
	*/
	String smCode = WtcUtil.repNull(request.getParameter("newSmCode"));
	String constructionFlag = "N";
	if("ke".equals(smCode)){
		constructionFlag = "N";
	}else{
		if("1".equals(noPort)){
			constructionFlag = "Y";
		}
	}
	/*是否使用营销案*/
	
	String joinMarket = WtcUtil.repNull(request.getParameter("joinMarket"));
	/*2015/05/06 9:09:31 gaopeng 获取抵扣金额 关于在CRM增加手机积分兑换宽带产品功能的需求*/
	String intePrice = WtcUtil.repNull(request.getParameter("intePrice"));
	
	
	String joinType = WtcUtil.repNull(request.getParameter("joinType"));
	System.out.println("joinType===="+joinType);
	/*营销案流水*/
	String marketAccept = WtcUtil.repNull(request.getParameter("marketAccept"));
	String marketAccept58_88 = WtcUtil.repNull(request.getParameter("marketAccept58_88"));
	
	String marketPhoneNo = WtcUtil.repNull(request.getParameter("marketPhoneNo"));
	String marketPhoneNo_58_88 = WtcUtil.repNull(request.getParameter("marketPhoneNo_58_88"));
	
	if("".equals(joinMarket)){
		marketAccept = "NULL";
		marketPhoneNo = "NULL";
	}
	System.out.println("KDconfm_new ningtn market [" + joinMarket + "," + marketAccept + "]");
	//---------------------选择的销售品--------------------
	HashMap son_Parent_Map = new HashMap();
	String[] sonParentArr = new String[]{};
	if(!WtcUtil.repNull(request.getParameter("sonParentArr")).equals("")){ //销售品标识~元素实例标识
		sonParentArr = WtcUtil.repNull(request.getParameter("sonParentArr")).split(",");
	}	
	for(int i=0;i<sonParentArr.length;i++){
			String[] temp = sonParentArr[i].split("~");
			son_Parent_Map.put(temp[0],temp[1]);
	}
	//------------------获取销售品实例化id----------------------------
	HashMap instanceMap = new HashMap();
	System.out.println("------------offerIdArr--------------"+WtcUtil.repNull(request.getParameter("offerIdArr")));
	String[] offerIdArr = WtcUtil.repNull(request.getParameter("offerIdArr")).split(",");//基本销售品和附加销售品
	String[] offerEffectTime = WtcUtil.repNull(request.getParameter("offerEffectTime")).split(",");
	String[] offerExpireTime = WtcUtil.repNull(request.getParameter("offerExpireTime")).split(",");
	String[] discountPlanInstId = new String[offerIdArr.length]; //销售品实例化ID
	for(int i=0;i<offerIdArr.length;i++){
	%>
	<wtc:service name="sDynSqlCfm" outnum="1">
		<wtc:param value="13"/>
	</wtc:service>	
	<wtc:array id="rows" scope="end" />
	<%
		if(retCode.equals("000000")&&rows.length > 0){	//生成销售品实例化ID并与相应的销售品放入hashmap中
			discountPlanInstId[i] = rows[0][0];
			instanceMap.put(offerIdArr[i],discountPlanInstId[i]);
		}	
	}	
 //-------------------销售品群组---------------------------
	HashMap groupInfoMap = new HashMap();
	String[] allGroupInfo = new String[]{};	//取所有销售品群组信息
	if(!WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).equals("")){
		allGroupInfo = WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).split("\\^");
	}
	for(int i=0;i<allGroupInfo.length;i++){
		String[] offerGroupInfo = allGroupInfo[i].split("\\|");
		groupInfoMap.put(offerGroupInfo[0],offerGroupInfo[1]);//销售品id，属性信息
	}
 //--------------产品群组-------------------------------
	String[] addGroupIdArrry = new String[]{};	//组合产品过来的可选群组信息
	if(!WtcUtil.repNull(request.getParameter("addGroupIdArr")).equals("")){
		addGroupIdArrry = WtcUtil.repNull(request.getParameter("addGroupIdArr")).split(",");
	}
	//--------------------------选择的产品---------------------
	String[] prodIdArr = WtcUtil.repNull(request.getParameter("productIdArr")).split(",");
	String[] prodEffectDate = WtcUtil.repNull(request.getParameter("prodEffectDate")).split(",");
	String[] prodExpireDate = WtcUtil.repNull(request.getParameter("prodExpireDate")).split(",");
	String[] isMainProduct = WtcUtil.repNull(request.getParameter("isMainProduct")).split(",");

	//--------------------销售品,产品属性信息------------
	HashMap offer_productAttrMap = new HashMap();
	String[] offer_productAttrInfoArr = new String[]{};	//取所有销售品,产品属性信息
	if(!WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).equals("")){
		offer_productAttrInfoArr = WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).split("\\^");
	}
	for(int i=0;i<offer_productAttrInfoArr.length;i++){
		String[] offer_productAttrArr = offer_productAttrInfoArr[i].split("\\|");
		if(offer_productAttrArr.length > 1)
			offer_productAttrMap.put(offer_productAttrArr[0],offer_productAttrArr[1]);//销售品id或产品id，属性信息
	}

	//--------------------------担保人信息-----------------------
	int hasVouchInfo = 1;			//是否有担保人信息标记
	String vouch_idType = WtcUtil.repNull(request.getParameter("vouch_idType"));
	String vouch_idNo = WtcUtil.repNull(request.getParameter("vouch_idNo"));
	if(vouch_idType.equals("") && vouch_idNo.equals("")){
		hasVouchInfo = 0;
	}

	//--------------------------SLA信息-----------------------
	String[] servslaArr = new String[]{};	//取所有产品属性信息
	if(!WtcUtil.repNull(request.getParameter("sla_info")).equals("")){
		servslaArr = WtcUtil.repNull(request.getParameter("sla_info")).split("\\|");
	}
	String addressId = "";	
	%>
	<wtc:service name="sDynSqlCfm" outnum="1">
		<wtc:param value="28"/>
	</wtc:service>	
	<wtc:array id="result" scope="end" />
	<%
		if(retCode.equals("000000") && result.length > 0){	//产生addressId
			addressId = result[0][0];
	}

	String userType = WtcUtil.repNull(request.getParameter("userType")); 	//用户级别
	if(userType.equals("")){
	  userType = "00";
	}
	String attrCode = userType+"000Y";
	String batchFlag = "0";	//批量标志  0,单个，1 批量
	String openType = WtcUtil.repNull(request.getParameter("openType")); //入网方式,如普通入网，分销商返单
	String innetType = WtcUtil.repNull(request.getParameter("innetType")); //入网类型，普通入网，靓号入网
	String is_not_adward = WtcUtil.repNull(request.getParameter("is_not_adward")); 	//入网有礼活动
	String largess_card = WtcUtil.repNull(request.getParameter("largess_card")); 	//赠送充值卡
	String yzID = WtcUtil.repNull(request.getParameter("yzID")); 	 
	String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));
	
	String userName=WtcUtil.repNull(request.getParameter("userName"));//用户名
	String userName11=WtcUtil.repNull(request.getParameter("userName11"));
	String userName22=WtcUtil.repNull(request.getParameter("userName22"));
	if(userName11.equals(userName22)) {
  }else {
  	userName=userName11;
	}
	
	String contactCustName=WtcUtil.repNull((String)request.getParameter("contactCustName"));//联系人
	String contactPhone  = WtcUtil.repNull((String)request.getParameter("contactPhone")); //联系人手机号
	String area_codeh  = WtcUtil.repNull((String)request.getParameter("area_codeh")); //宽带小区
	String area_nameh  = WtcUtil.repNull((String)request.getParameter("areaAddr")); //小区名称 
	/*2014/04/03 11:21:09 gaopeng 获取 归属类别 承载方式*/
	String belongCategory = WtcUtil.repNull((String)request.getParameter("belongCategory")); //归属类别
	String bearType = WtcUtil.repNull((String)request.getParameter("bearType")); //承载方式 
 	/*String area_codeh="1111";
	String area_nameh="七台河";*/
	String cfm_login   = WtcUtil.repNull((String)request.getParameter("cfm_login"));  //宽带登录账号
	String cfmPwd = WtcUtil.repNull((String)request.getParameter("cfmPwdEncrypt"));//宽带账号密码 
	
	/* 密码加密暂时封闭
	cfmPwd = Encrypt.encrypt(cfmPwd);
	*/
	String contract_no="0";//合同号
	String enter_num="1";//接入数量
	String enter_type  = WtcUtil.repNull((String)request.getParameter("enter_type")); //接入方式
	System.out.println("gaopengSeeLog4977====enter_type="+enter_type);
	
	String bandWidth   = WtcUtil.repNull((String)request.getParameter("bandWidth")); //宽带带宽 
	String bandWidthMsg   = WtcUtil.repNull((String)request.getParameter("bandWidthMsg")); //宽带带宽 
	/*String enter_type="GPON";
	String bandWidth="2M";*/
	String enter_addr  = WtcUtil.repNull((String)request.getParameter("enter_addr")); //安装地址
	//String cust_attr  = WtcUtil.repNull((String)request.getParameter("cust_attr")); //客户属性 
	String appointvTime=WtcUtil.repNull((String)request.getParameter("appointvTime"));//预约时间
	String deviceCode=WtcUtil.repNull((String)request.getParameter("deviceCode"));//设备编号
	if(deviceCode.length() == 0){
		deviceCode = "NULL";
	}
	String unitId  = WtcUtil.repNull((String)request.getParameter("unitId")); //集团编号
	if(unitId.length() == 0){
		unitId = "null";
	}
	System.out.println("====== ningtn unitId unitId [" + unitId + "]");
	String deviceType=WtcUtil.repNull((String)request.getParameter("deviceType"));//设备类型 
	/*String deviceCode="abcedjijeikoe3089";*/
	/*String ipAddress = request.getParameter("ipAddress")==""?"没有":request.getParameter("ipAddress");ip地址*/
	String ipAddress="0";//宽带的ip地址是自动获取的，给固定值0
	String deviceInAddress=WtcUtil.repNull((String)request.getParameter("deviceInAddress"));//设备安装地址
	String portCode=WtcUtil.repNull((String)request.getParameter("portCode"));//端口号
	if(deviceInAddress.length() == 0){
		deviceInAddress = "NULL";
	}
	if(portCode.length() == 0){
		portCode = "NULL";
	}
	String portType=WtcUtil.repNull((String)request.getParameter("portType"));//端口类型  
	/*String deviceInAddress="七台河移动公司";
	String portCode="408982";*/
	String constructRequest=WtcUtil.repNull((String)request.getParameter("construct_request"));//施工要求
	String cctId=WtcUtil.repNull((String)request.getParameter("cctId"));//电信局编码
	if(cctId.length() == 0){
		cctId = "NULL";
	}
	String userType1=WtcUtil.repNull((String)request.getParameter("userType1"));//用户类型
	String offerName=WtcUtil.repNull((String)request.getParameter("dOfferName"));//主资费名称
	String userRegionName=WtcUtil.repNull((String)request.getParameter("userRegionName"));//用户所属地市
	String isDoNoResource=WtcUtil.repNull((String)request.getParameter("isNeedHold"));//是否预占资源标识
	String standardContent=WtcUtil.repNull((String)request.getParameter("standardContent"));//标准地址名称
	String ipAddType=WtcUtil.repNull((String)request.getParameter("ipAddType"));//标准地址名称
	/*2016/3/7 15:33:01 gaopeng 实际使用人信息*/
	String realUserName = WtcUtil.repNull(request.getParameter("realUserName"));
	String realUserAddr = WtcUtil.repNull(request.getParameter("realUserAddr"));
	String realUserIccId = WtcUtil.repNull(request.getParameter("realUserIccId"));
	String realUserIdType = WtcUtil.repNull(request.getParameter("realUserIdType"));
	
	if(realUserName == null || "".equals(realUserName)){
		realUserName = "NULL";
	}
	if(realUserAddr == null || "".equals(realUserAddr)){
		realUserAddr = "NULL";
	}
	if(realUserIccId == null || "".equals(realUserIccId)){
		realUserIccId = "NULL";
	}
	if(realUserIdType == null || "".equals(realUserIdType)){
		realUserIdType = "NULL";
	}
	
	System.out.println("--------gaopengSeeLog4977====------------宽带用户新增扩展信息begin---------------------");
	System.out.println("----gaopengSeeLog4977====-----服务号码---------"+phoneNo);
	System.out.println("----gaopengSeeLog4977====-----小区代码---------"+area_codeh);
	System.out.println("----gaopengSeeLog4977====-----联系人---------"+contactCustName);
	System.out.println("----gaopengSeeLog4977====-----联系电话---------"+contactPhone);
	System.out.println("----gaopengSeeLog4977====-----宽带账号---------"+cfm_login);
	System.out.println("----gaopengSeeLog4977====-----账号密码---------"+cfmPwd);
	System.out.println("----gaopengSeeLog4977====-----合同号---------"+contract_no);
	System.out.println("----gaopengSeeLog4977====-----小区名称---------"+area_nameh);
	System.out.println("-----gaopengSeeLog4977====----详细安装地址---------"+enter_addr);
	System.out.println("----gaopengSeeLog4977====-----预约时间---------"+appointvTime);
	System.out.println("-----gaopengSeeLog4977====----宽带带宽---------"+bandWidth);
	System.out.println("-----gaopengSeeLog4977====----接入数量---------"+enter_num);
	//System.out.println("---gaopengSeeLog4977====------客户属性---------"+cust_attr);
	System.out.println("-----gaopengSeeLog4977====----接入方式---------"+enter_type);
	System.out.println("-------gaopengSeeLog4977====--设备编号---------"+deviceCode);
	System.out.println("------gaopengSeeLog4977====---端口编号---------"+portCode);
	System.out.println("------gaopengSeeLog4977====---ip地址---------"+ipAddress);
	System.out.println("------gaopengSeeLog4977====---设备安装地址---------"+deviceInAddress);
	System.out.println("------gaopengSeeLog4977====---施工要求---------"+constructRequest);
	System.out.println("------gaopengSeeLog4977====---是否施工---------"+"1");
	System.out.println("------gaopengSeeLog4977====---是否预占资源---------"+isDoNoResource);
	System.out.println("------gaopengSeeLog4977====---标准地址名称---------"+standardContent);
	System.out.println("------gaopengSeeLog4977====---ip地址类型---------"+ipAddType);
	/*System.out.println("----------电信局编码--------"+cctId);*/
	System.out.println("---------gaopengSeeLog4977====-----------宽带用户新增扩展信息end---------------------");
	%>
	<%
	UType ctrlInfoUtype = new UType();
	ctrlInfoUtype.setUe("STRING",batchFlag);
	UType batchDataListUtype = new UType();
	UType msgBodyTypeUtype = new UType();
	
	  UType oprInfoUtype = new UType();
	  	oprInfoUtype.setUe("LONG",sysAcceptl);
	    oprInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("opCode")));
	    oprInfoUtype.setUe("STRING",workNo);
	    oprInfoUtype.setUe("STRING",password);
	    oprInfoUtype.setUe("STRING",ipAddr);
	    oprInfoUtype.setUe("STRING",groupId);
	    oprInfoUtype.setUe("STRING","0");
	    oprInfoUtype.setUe("STRING",regionCode);
	    oprInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("op_note")));
	    oprInfoUtype.setUe("STRING",siteId);
	    oprInfoUtype.setUe("STRING",objectId);
			msgBodyTypeUtype.setUe(oprInfoUtype);
	
	
	    
		UType custOrderUtype = new UType();
			UType custOrderMsgUtype = new UType();
				custOrderMsgUtype.setUe("STRING",custOrderId);
				//System.out.println("1----------------------------------------"+custOrderId);
				custOrderUtype.setUe(custOrderMsgUtype);
				
			UType orderArrayListUtype = new UType();
      	UType orderArrayListContainerUtype = new UType();
        	UType orderArrayMsgUtype = new UType();
          	orderArrayMsgUtype.setUe("STRING",orderArrayId);
            //System.out.println("2----------------------------------------"+orderArrayId);
        		orderArrayListContainerUtype.setUe(orderArrayMsgUtype);
        	
        	UType servOrderListUtype = new UType();
              UType servOrderListContainerUtype = new UType();
                UType servOrderMsgUtype = new UType();
                  servOrderMsgUtype.setUe("STRING",servOrderId);
                  //System.out.println("3----------------------------------------"+servOrderId);
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("LONG","0");
                  servOrderMsgUtype.setUe("STRING",serviceNo);
                  //System.out.println("4----------------------------------------"+serviceNo);
                  servOrderMsgUtype.setUe("INT","0");
                  servOrderMsgUtype.setUe("INT","0");
                  servOrderMsgUtype.setUe("LONG",addressId);
                  //System.out.println("5----------------------------------------"+addressId);
                  servOrderMsgUtype.setUe("INT","110");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("INT","0");
                  //System.out.println("---------------------request.getParameter(servBusiId)------------------------"+request.getParameter("servBusiId"));
                  servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("servBusiId")));
                  //System.out.println("6----------------------------------------"+WtcUtil.repNull(request.getParameter("servBusiId")));
                  servOrderMsgUtype.setUe("STRING","N");
                  servOrderMsgUtype.setUe("STRING","0");
                  //servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("finishLimitTime")));
                  servOrderMsgUtype.setUe("STRING","");
                   servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("INT",WtcUtil.repNull(request.getParameter("dealLevel")));
                  System.out.println("8----------------------------------------"+WtcUtil.repNull(request.getParameter("dealLevel")));
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("INT","0");
                  servOrderMsgUtype.setUe("INT","1");
                  servOrderMsgUtype.setUe("STRING","Y");
                  servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("contactCustName")));
                  //System.out.println("9----------------------------------------"+WtcUtil.repNull(request.getParameter("contactCustName")));
                  servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("contactPhone")));
                  //System.out.println("10----------------------------------------"+WtcUtil.repNull(request.getParameter("contactPhone")));
                  servOrderListContainerUtype.setUe(servOrderMsgUtype);
                UType servOrderDataListUtype = new UType();
                  UType servOrderDataUtype = new UType();
                    servOrderDataUtype.setUe("LONG","1001");
                    servOrderDataUtype.setUe("INT","0");
                    //servOrderDataUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceOrderGroupId")));
                    servOrderDataUtype.setUe("STRING","0");//工单城区标志
                    //System.out.println("11----------------------------------------"+WtcUtil.repNull(request.getParameter("serviceOrderGroupId")));
                    servOrderDataListUtype.setUe(servOrderDataUtype);
                  servOrderListContainerUtype.setUe(servOrderDataListUtype);
                UType servOrderSlaListUtype = new UType();				
									if(servslaArr.length > 0){
										for(int i=0;i<servslaArr.length;i++){
											String[] slaTemp = servslaArr[i].split("~");
									
		                  UType servOrderSlaInfoUtype = new UType();
		                    servOrderSlaInfoUtype.setUe("STRING","0");
		                    servOrderSlaInfoUtype.setUe("INT","1");
		                    servOrderSlaInfoUtype.setUe("INT",slaTemp[2]);
		                    //System.out.println(i+"12----------------------------------------"+slaTemp[2]);
		                    servOrderSlaInfoUtype.setUe("DOUBLE",slaTemp[1]);
		                    //System.out.println(i+"13----------------------------------------"+slaTemp[1]);
		                    servOrderSlaListUtype.setUe(servOrderSlaInfoUtype);	
										}
									}								
                  servOrderListContainerUtype.setUe(servOrderSlaListUtype);
                UType servOrderBookingMsgUtype = new UType();
                  servOrderListContainerUtype.setUe(servOrderBookingMsgUtype);
                UType servOrderExcpInfoUtype = new UType();
                  servOrderExcpInfoUtype.setUe("STRING","0");
                  servOrderExcpInfoUtype.setUe("INT","0");
                  servOrderExcpInfoUtype.setUe("STRING","k");
                  servOrderExcpInfoUtype.setUe("STRING","OK");
                  servOrderExcpInfoUtype.setUe("STRING",workNo);
                  servOrderListContainerUtype.setUe(servOrderExcpInfoUtype);
                servOrderListUtype.setUe(servOrderListContainerUtype);
              orderArrayListContainerUtype.setUe(servOrderListUtype);
            orderArrayListUtype.setUe(orderArrayListContainerUtype);
          custOrderUtype.setUe(orderArrayListUtype);
        msgBodyTypeUtype.setUe(custOrderUtype);
        
        
      UType customerUtype = new UType();
        UType custDocUtype = new UType();
          UType custDocBaseInfoUtype = new UType();
            custDocBaseInfoUtype.setUe("LONG",custId);
            custDocUtype.setUe(custDocBaseInfoUtype);
         customerUtype.setUe(custDocUtype);
        UType userInfoListUtype = new UType();
          UType userInfoUtype = new UType();
            UType userBaseInfoUtype = new UType();
              userBaseInfoUtype.setUe("LONG",custId);
              //System.out.println("16----------------------------------------"+custId);
              userBaseInfoUtype.setUe("STRING",serviceNo);
              //System.out.println("17----------------------------------------"+serviceNo);
              userBaseInfoUtype.setUe("LONG","0");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("brandId")));
              //System.out.println("18----------------------------------------"+WtcUtil.repNull(request.getParameter("brandId")));
              userBaseInfoUtype.setUe("STRING","I");
              userBaseInfoUtype.setUe("DOUBLE",WtcUtil.repNull(request.getParameter("limitOwe")));
              //System.out.println("19----------------------------------------"+WtcUtil.repNull(request.getParameter("limitOwe")));
              /*lijy changeed @20110602 original is userBaseInfoUtype.setUe("LONG",WtcUtil.repNull(request.getParameter("contractNo")));*/
              userBaseInfoUtype.setUe("LONG","0");
              //System.out.println("20----------------------------------------"+WtcUtil.repNull(request.getParameter("contractNo")));
              userBaseInfoUtype.setUe("LONG",custId);
              //System.out.println("21----------------------------------------"+custId);
              userBaseInfoUtype.setUe("STRING",phoneNo_h);
              System.out.println("22----------------------------------------"+phoneNo+" "+phoneNo_h);
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceType")));
              userBaseInfoUtype.setUe("STRING",attrCode);
              userBaseInfoUtype.setUe("STRING","1");
              userBaseInfoUtype.setUe("STRING",new_custPwd);
              userBaseInfoUtype.setUe("STRING","0");
              userBaseInfoUtype.setUe("STRING","0");
              userBaseInfoUtype.setUe("INT","1");
              userBaseInfoUtype.setUe("STRING","1");
              userBaseInfoUtype.setUe("LONG","0");
              userBaseInfoUtype.setUe("STRING","21");
              userBaseInfoUtype.setUe("STRING",groupId);
              userBaseInfoUtype.setUe("STRING","000");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("userGroupName")));
              System.out.println("23-----------------------------------------------"+WtcUtil.repNull(request.getParameter("userGroupName")));
              userBaseInfoUtype.setUe("STRING","N");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("billModeCd")));
              userBaseInfoUtype.setUe("STRING",userName);
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("areaId")));
              userBaseInfoUtype.setUe("STRING","");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("openType")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("addCmgr")));/*是否短信关注*/
              userBaseInfoUtype.setUe("STRING","01");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceManagerId")));
              userBaseInfoUtype.setUe("STRING","");/*营销支撑经理*/
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("innetScheme")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("saleMode")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("imeiNo")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("goodType")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("chargeGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("installGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("maintGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("sellGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("devGroupId")));
              userBaseInfoUtype.setUe("STRING","");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("innetType")));
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("portInReason")));
              userBaseInfoUtype.setUe("STRING","");
              userInfoUtype.setUe(userBaseInfoUtype);
            UType userAddrMsgUtype = new UType();
              userAddrMsgUtype.setUe("STRING","0");
              userAddrMsgUtype.setUe("LONG","0");
              userAddrMsgUtype.setUe("INT","0");
              userAddrMsgUtype.setUe("INT","0");
              userAddrMsgUtype.setUe("INT","0");
              userAddrMsgUtype.setUe("STRING","0");
              userAddrMsgUtype.setUe("STRING","0");
              UType addrMsgUtype = new UType();
                addrMsgUtype.setUe("LONG","0");
                addrMsgUtype.setUe("INT","0");
                addrMsgUtype.setUe("STRING","0");
                addrMsgUtype.setUe("STRING","0");
                addrMsgUtype.setUe("STRING","0");
                addrMsgUtype.setUe("STRING","0");
                addrMsgUtype.setUe("STRING","0");
                userAddrMsgUtype.setUe(addrMsgUtype);
					
              userInfoUtype.setUe(userAddrMsgUtype);
            UType discountInfoListUtype = new UType();
					
							for(int i=0;i<offerIdArr.length;i++){
								String parentId = (String)son_Parent_Map.get(offerIdArr[i]);
								String parentInstId = (String)instanceMap.get(parentId);
								if(parentInstId == null){
									parentInstId = "0";
							}
					
					
              UType discountInfoListContainerUtype = new UType();
                UType discountInfoUtype = new UType();
                  discountInfoUtype.setUe("STRING","1");
                  discountInfoUtype.setUe("STRING",discountPlanInstId[i]);
                  discountInfoUtype.setUe("STRING","0");
                  discountInfoUtype.setUe("STRING","0");
                  discountInfoUtype.setUe("STRING","A");
                  discountInfoUtype.setUe("STRING",workNo);
                  discountInfoUtype.setUe("STRING",groupId);
                  discountInfoUtype.setUe("STRING",offerIdArr[i]);
                  discountInfoUtype.setUe("STRING",offerEffectTime[i]);
                  discountInfoUtype.setUe("STRING",offerExpireTime[i]);
                  discountInfoUtype.setUe("STRING",parentInstId);
                  discountInfoUtype.setUe("STRING","0");
                  discountInfoListContainerUtype.setUe(discountInfoUtype);
                UType discountAttrListUtype = new UType();
						
							if(offer_productAttrMap.get(offerIdArr[i]) != null){
								String[] discountAttrArr = ((String)offer_productAttrMap.get(offerIdArr[i])).split("\\$");
								for(int j=0;j<discountAttrArr.length;j++){
								String[] offerAttrTemp = discountAttrArr[j].split("~");
							
                  UType discountAttrUtype = new UType();
                    discountAttrUtype.setUe("STRING","1");
                    discountAttrUtype.setUe("STRING","");
                    discountAttrUtype.setUe("STRING",offerAttrTemp[0]);
                    discountAttrUtype.setUe("STRING",offerAttrTemp[1].trim());
                    discountAttrUtype.setUe("STRING","");
                    discountAttrUtype.setUe("STRING","A");
                    discountAttrUtype.setUe("STRING",currentTime);
                    discountAttrUtype.setUe("STRING","20500101 00:00:00");
                    discountAttrListUtype.setUe(discountAttrUtype);
						
								}
							}	
							
                  discountInfoListContainerUtype.setUe(discountAttrListUtype);
                UType groupInstInfoUtype = new UType();
							
									if(groupInfoMap.get(offerIdArr[i]) != null){
										String[] groupBaseInfoArr = ((String)groupInfoMap.get(offerIdArr[i])).split("/");
										String[] groupInstBaseInfo = groupBaseInfoArr[0].split("\\$");
										/*
										System.out.println("----------------------------groupInstBaseInfo[0]------------------"+groupInstBaseInfo[0]);
										System.out.println("----------------------------groupInstBaseInfo[1]------------------"+groupInstBaseInfo[1]);
										System.out.println("----------------------------groupInstBaseInfo[2]------------------"+groupInstBaseInfo[2]);
										System.out.println("----------------------------groupInstBaseInfo[3]------------------"+groupInstBaseInfo[3]);
										System.out.println("----------------------------groupInstBaseInfo[4]------------------"+groupInstBaseInfo[4]);
										*/
	                  UType groupInstBaseInfoUtype = new UType();
	                    groupInstBaseInfoUtype.setUe("STRING","1");
	                    groupInstBaseInfoUtype.setUe("STRING",groupInstBaseInfo[0]);
	                    groupInstBaseInfoUtype.setUe("STRING",groupInstBaseInfo[1]);
	                    groupInstBaseInfoUtype.setUe("STRING",groupInstBaseInfo[2]);
	                    groupInstBaseInfoUtype.setUe("STRING","A");
	                    groupInstBaseInfoUtype.setUe("STRING",currentTime);
	                    groupInstBaseInfoUtype.setUe("STRING",groupInstBaseInfo[3]);
	                    groupInstBaseInfoUtype.setUe("STRING",groupInstBaseInfo[4]);
	                    groupInstBaseInfoUtype.setUe("STRING","0");
	                    groupInstBaseInfoUtype.setUe("STRING","1");
	                    groupInstInfoUtype.setUe(groupInstBaseInfoUtype);
	                  UType groupInstMemberListUtype = new UType();
								
										if(groupBaseInfoArr.length == 2){
											String[] groupMemberArr = groupBaseInfoArr[1].split("_");
											for(int k=0;k<groupMemberArr.length;k++){
												String[] memberInfo = groupMemberArr[k].split("\\$");
												String[] groupInstMember = groupMemberArr[k].split("\\$");
												for(int m=0;m<groupInstMember.length;m++){
													//System.out.println("----------------------------groupInstMember["+m+"]----------------------------"+groupInstMember[m]);
												}
											
			                    UType groupInstMemberUtype = new UType();
			                      groupInstMemberUtype.setUe("STRING","1");
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[0]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[1]);
			                      groupInstMemberUtype.setUe("STRING","0");
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[2]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[3]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[4]);
			                      groupInstMemberUtype.setUe("STRING","0");
			                      groupInstMemberUtype.setUe("STRING","A");
			                      groupInstMemberUtype.setUe("STRING",currentTime);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[5]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[6]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[7]);
			                      groupInstMemberUtype.setUe("STRING",groupInstMember[8]);
			                      groupInstMemberListUtype.setUe(groupInstMemberUtype);
										
											}
									  }
										
                    groupInstInfoUtype.setUe(groupInstMemberListUtype);
                  	UType groupAttrListUtype = new UType();
								
										if(groupInstBaseInfo.length > 6){
											for(int j=6;j<groupInstBaseInfo.length;j++){		//第6个开始才为属性信息
											//System.out.println(j+"------------群组的属性信息===="+groupInstBaseInfo[j]);	
											String[] groupAttr = groupInstBaseInfo[j].split("~");
											//System.out.println("----------------------------------groupAttr[0]----------------------------"+groupAttr[0]);
											//System.out.println("----------------------------------groupAttr[1]----------------------------"+groupAttr[1]);
										
		                    UType groupAttrUtype = new UType();
		                      groupAttrUtype.setUe("STRING","1");
		                      groupAttrUtype.setUe("STRING",groupInstBaseInfo[0]);
		                      groupAttrUtype.setUe("STRING","");
		                      groupAttrUtype.setUe("STRING",groupAttr[0]);
		                      groupAttrUtype.setUe("STRING",groupAttr[1].trim());
		                      groupAttrUtype.setUe("STRING","");
		                      groupAttrListUtype.setUe(groupAttrUtype);
										
											}
										}	
								
		                groupInstInfoUtype.setUe(groupAttrListUtype);
		                UType groupInstAttrListUtype = new UType();
										
										if(groupBaseInfoArr.length == 2){
											String[] groupMemberArr = groupBaseInfoArr[1].split("_");
											for(int k=0;k<groupMemberArr.length;k++){
												String[] memberAttrInfoArr = groupMemberArr[k].split("\\$");
												if(memberAttrInfoArr.length > 10){
													for(int j=10;j<memberAttrInfoArr.length;j++){		//第10个开始才为属性信息
													//System.out.println(j+"------------成员的属性信息===="+memberAttrInfoArr[j]);	
													String[] groupAttrInfo = memberAttrInfoArr[j].split("~");
													
													//System.out.println("----------------------------------memberAttrInfoArr[1]----------------------------"+memberAttrInfoArr[1]);
													//System.out.println("----------------------------------groupAttrInfo[0]----------------------------"+groupAttrInfo[0]);
													//System.out.println("----------------------------------groupAttrInfo[1]----------------------------"+groupAttrInfo[1]);
										
		                    UType groupInstAttrUtype = new UType();
		                      groupInstAttrUtype.setUe("STRING","1");
		                      groupInstAttrUtype.setUe("STRING",memberAttrInfoArr[1]);
		                      groupInstAttrUtype.setUe("STRING","0");
		                      groupInstAttrUtype.setUe("STRING",groupAttrInfo[0]);
		                      groupInstAttrUtype.setUe("STRING",groupAttrInfo[1].trim());
		                      groupInstAttrUtype.setUe("STRING","0");
		                      groupInstAttrListUtype.setUe(groupInstAttrUtype);
										
													}
												}
											}	
										}	
								
                    groupInstInfoUtype.setUe(groupInstAttrListUtype);
						
						      }
							
                  discountInfoListContainerUtype.setUe(groupInstInfoUtype);
                UType discountParamListUtype = new UType();
                  discountInfoListContainerUtype.setUe(discountParamListUtype);
                discountInfoListUtype.setUe(discountInfoListContainerUtype);
					}
              userInfoUtype.setUe(discountInfoListUtype);
            UType userCreditListUtype = new UType();
              //userCreditListUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("controlType")));
              userCreditListUtype.setUe("STRING","");
              userCreditListUtype.setUe("STRING","E");
              userCreditListUtype.setUe("DOUBLE","0");
              userInfoUtype.setUe(userCreditListUtype);
            UType assuInfoUtype = new UType();
					
					if(hasVouchInfo == 1){
					
              assuInfoUtype.setUe("LONG",WtcUtil.repNull(request.getParameter("assureId")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("vouch_name")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("id_type")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("vouch_idNo")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("vouch_phone")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("vouch_post")));
              assuInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("vouch_addr")));
              assuInfoUtype.setUe("INT",WtcUtil.repNull(request.getParameter("assureNum")));
					}	
              userInfoUtype.setUe(assuInfoUtype);
            UType userContactInfoListUtype = new UType();
              userInfoUtype.setUe(userContactInfoListUtype);
            UType userRelaInfoListUtype = new UType();

              userInfoUtype.setUe(userRelaInfoListUtype);
            UType productListUtype = new UType();
				
					for(int i=0;i<prodIdArr.length;i++){
						String parentProdInstId = "0";
						String parentId = (String)son_Parent_Map.get(prodIdArr[i]);
						if(parentId.equals(offerIdArr[0])){	//如果是附加产品,将它的上级产品实例ID置为1
							parentProdInstId = "1";
					}
				//System.out.println(prodIdArr[i]+"---->parentId-->"+parentId+"-------------------->"+parentProdInstId);	
					String parentInstId = (String)instanceMap.get(parentId);
					if(parentInstId == null){
						parentInstId = "0";
					}
					String isCompFlag = "0";
					if(isMainProduct[i].equals("1")){	//将主产品的复合标识置为1
						isCompFlag = "1";
					}
					
					String productId = "";
					if(prodIdArr[i].indexOf("A") != -1){
						productId = prodIdArr[i].split("A")[1];
					}else{
						productId = prodIdArr[i];
					}
				
              UType productUtype = new UType();
                UType productBaseInfoUtype = new UType();
                  productBaseInfoUtype.setUe("STRING","1");
                  productBaseInfoUtype.setUe("STRING",parentInstId);
                  productBaseInfoUtype.setUe("STRING","0");
                  productBaseInfoUtype.setUe("STRING",productId);
                  productBaseInfoUtype.setUe("STRING","0");
                  productBaseInfoUtype.setUe("STRING",currentTime);
                  productBaseInfoUtype.setUe("STRING",prodEffectDate[i]);
                  productBaseInfoUtype.setUe("STRING",prodExpireDate[i]);
                  productBaseInfoUtype.setUe("STRING","A");
                  productBaseInfoUtype.setUe("STRING",prodExpireDate[i]);
                  productBaseInfoUtype.setUe("STRING",prodEffectDate[i]);
                  productBaseInfoUtype.setUe("STRING",isMainProduct[i]);
                  productBaseInfoUtype.setUe("STRING",parentProdInstId);
                  productBaseInfoUtype.setUe("STRING",isCompFlag);
                  productUtype.setUe(productBaseInfoUtype);
                UType productAttrListUtype = new UType();
						
							if(offer_productAttrMap.get(prodIdArr[i]) != null){
								String[] productAttrArr = ((String)offer_productAttrMap.get(prodIdArr[i])).split("\\$");
								for(int j=0;j<productAttrArr.length;j++){
								String[] prodAttrTemp = productAttrArr[j].split("~");
									//System.out.println("产品ID"+prodIdArr[i]+"--->产品属性ID="+prodAttrTemp[0]+"------>属性VALE="+prodAttrTemp[1].trim()+"-");	
							
                  UType productAttrUtype = new UType();
                    productAttrUtype.setUe("STRING","1");
                    productAttrUtype.setUe("STRING",prodAttrTemp[0]);
                    productAttrUtype.setUe("STRING",prodAttrTemp[1].trim());
                    productAttrUtype.setUe("STRING",currentTime);
                    productAttrUtype.setUe("STRING","20500101 00:00:00");
                    productAttrListUtype.setUe(productAttrUtype);
						
								}
							}	
							
                  productUtype.setUe(productAttrListUtype);
                UType productGroupListUtype = new UType();
							
								for(int j=0;j<addGroupIdArrry.length;j++){
                  UType productGroupUtype = new UType();
                    productGroupUtype.setUe("STRING",addGroupIdArrry[j]);
                    productGroupListUtype.setUe(productGroupUtype);
							
								}
							
                  productUtype.setUe(productGroupListUtype);
                productListUtype.setUe(productUtype);
					}
              userInfoUtype.setUe(productListUtype);
            UType userAcctRelListUtype = new UType();
              UType acctRelaUtype = new UType();
                UType acctRelaBaseUtype = new UType();
                  acctRelaBaseUtype.setUe("STRING","ADD");
                  /*lijy changed @20110602 original is  acctRelaBaseUtype.setUe("LONG",WtcUtil.repNull(request.getParameter("contractNo")));*/
                  acctRelaBaseUtype.setUe("LONG","0");
                  acctRelaBaseUtype.setUe("LONG","99999999");
                  acctRelaBaseUtype.setUe("LONG","0");
                  acctRelaBaseUtype.setUe("DOUBLE","0");
                  acctRelaBaseUtype.setUe("STRING","N");
                  acctRelaBaseUtype.setUe("STRING","Y");
                  acctRelaBaseUtype.setUe("STRING","20081005 00:00:00");
                  acctRelaBaseUtype.setUe("STRING","20081005 00:00:00");
                  acctRelaUtype.setUe(acctRelaBaseUtype);
                UType acctRateListUtype = new UType();
                  acctRelaUtype.setUe(acctRateListUtype);
                userAcctRelListUtype.setUe(acctRelaUtype);
              userInfoUtype.setUe(userAcctRelListUtype);
            UType userResListUtype = new UType();
              UType userResUtype = new UType();
                userResUtype.setUe("STRING","1");
                userResUtype.setUe("STRING","0");
                userResUtype.setUe("STRING","0");
                userResUtype.setUe("STRING",serviceNo);
                userResListUtype.setUe(userResUtype);
              userInfoUtype.setUe(userResListUtype);
            UType busiFeeFactorListUtype = new UType();
             /* UType busiFeeFactorUtype = new UType();
                busiFeeFactorUtype.setUe("STRING","C");
                busiFeeFactorUtype.setUe("STRING","C1");
						
                busiFeeFactorUtype.setUe("STRING",serviceNo);
                busiFeeFactorUtype.setUe("STRING","1");
                busiFeeFactorUtype.setUe("STRING","1");
                busiFeeFactorUtype.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype);
					
              UType busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","F");
                busiFeeFactorUtype1.setUe("STRING","F1");
                busiFeeFactorUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("openType")));
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
              */
              UType busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","A");
                busiFeeFactorUtype1.setUe("STRING","A0");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
                
                /* ningtn 2011-8-24 15:38:09 start 
                busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","K");
                busiFeeFactorUtype1.setUe("STRIN              
              UType busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","A");
                busiFeeFactorUtype1.setUe("STRING","A0");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);*/
                
                /* ningtn 2011-8-24 15:38:09 start */
                busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","K");
                busiFeeFactorUtype1.setUe("STRING","K0");
                busiFeeFactorUtype1.setUe("STRING",regionCode);
                busiFeeFactorUtype1.setUe("STRING",opCode);
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
                /* ningtn 2011-8-24 15:38:09 end */
                
                /* wanghyd 2011-10-14  start */
               String offeridKD =offerIdArr[0];
               int offeridKDINT =Integer.parseInt(offeridKD);
							 String sqlstrKD ="SELECT count(*) FROM product_offer where offer_type = 10 and sysdate between eff_date and exp_date and offer_attr_type = 'YnKB' and offer_id = "+offeridKDINT;
							 %>
                    <wtc:pubselect name="sPubSelect"  outnum="2" retcode="retCodeKD" retmsg="retMsgKD">
                    <wtc:sql>
    	              <%=sqlstrKD%>
                    </wtc:sql>  
                    </wtc:pubselect>        
                    <wtc:array id="retKD"  scope="end"/> 
                                                
                <%
                if("000000".equals(retCodeKD)&&retKD.length>0){   
                        if(retKD[0][0].equals("1") || retKD[0][0]=="1" )    {
	                busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","Y");
	                busiFeeFactorUtype1.setUe("STRING","Y0");
	                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
                        } 	 
                }
                /* wanghyd 2011-10-14  end */
                
              userInfoUtype.setUe(busiFeeFactorListUtype);
			         
            UType UserExtMsgListUtype = new UType();
            
            System.out.println("---------------------is_not_adward-----------------"+is_not_adward);
            if(is_not_adward.equals("Y")){ //入网有礼
              UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20010");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","1");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            }         
            else{
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20010");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","0");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	}
            	
            if(largess_card.equals("Y")){ //赠送充值卡
              UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20011");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","1");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            }      
            else{
							UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20011");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","0");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	} 
            	if(!yzID.equals("")&&yzID!=null){
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20013");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING",yzID);
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	}  
         		 System.out.println("mylog--------------p拼过户的节点--------------innetType--------"+innetType); 
          
		        /*
		        宽带过户限制屏蔽 
		         if(isGPhoneFlag.equals("1")){  
		          	System.out.println("mylog--------------p拼过户的节点--------------GoodPhoneDate-------"+request.getParameter("GoodPhoneDate"));
		           	UType UserExtMsgUtypeh = new UType();
		                	UserExtMsgUtypeh.setUe("LONG","20015");
		                	UserExtMsgUtypeh.setUe("INT","1");
		               	  UserExtMsgUtypeh.setUe("STRING",WtcUtil.repNull(request.getParameter("GoodPhoneDate")));
		                	UserExtMsgListUtype.setUe(UserExtMsgUtypeh);
		          } */
                    	
							UType UserExtMsgUtype01 = new UType();  /*服务号码*/
								UserExtMsgUtype01.setUe("LONG","20102");
								UserExtMsgUtype01.setUe("INT","0");
								UserExtMsgUtype01.setUe("STRING",phoneNo_h);
								UserExtMsgListUtype.setUe(UserExtMsgUtype01);
							
							UType UserExtMsgUtype02 = new UType(); /*小区代码*/
								UserExtMsgUtype02.setUe("LONG","20103");
								UserExtMsgUtype02.setUe("INT","0");
								UserExtMsgUtype02.setUe("STRING",area_codeh);
								UserExtMsgListUtype.setUe(UserExtMsgUtype02);
							
							UType UserExtMsgUtype03 = new UType(); /*联系人*/
							  UserExtMsgUtype03.setUe("LONG","20105");
								UserExtMsgUtype03.setUe("INT","0");
								UserExtMsgUtype03.setUe("STRING",contactCustName);
								UserExtMsgListUtype.setUe(UserExtMsgUtype03);
							
							UType UserExtMsgUtype04 = new UType(); /*联系电话*/
								UserExtMsgUtype04.setUe("LONG","20106");
								UserExtMsgUtype04.setUe("INT","0");
								UserExtMsgUtype04.setUe("STRING",contactPhone);
								UserExtMsgListUtype.setUe(UserExtMsgUtype04);
							
							UType UserExtMsgUtype05 = new UType(); /*宽带账号*/
								UserExtMsgUtype05.setUe("LONG","20107");
								UserExtMsgUtype05.setUe("INT","0");
								UserExtMsgUtype05.setUe("STRING",cfm_login);
								UserExtMsgListUtype.setUe(UserExtMsgUtype05);
							
							UType UserExtMsgUtype06 = new UType(); /*宽带账号密码*/
							UserExtMsgUtype06.setUe("LONG","20108");
								UserExtMsgUtype06.setUe("INT","0");
								UserExtMsgUtype06.setUe("STRING",cfmPwd);
								UserExtMsgListUtype.setUe(UserExtMsgUtype06);
							
							UType UserExtMsgUtype07 = new UType(); /*合同号*/
								UserExtMsgUtype07.setUe("LONG","20109");
								UserExtMsgUtype07.setUe("INT","0");
								UserExtMsgUtype07.setUe("STRING",contract_no);
								UserExtMsgListUtype.setUe(UserExtMsgUtype07);
							    	
							UType UserExtMsgUtype08 = new UType(); /*小区名称*/
								UserExtMsgUtype08.setUe("LONG","20117");
								UserExtMsgUtype08.setUe("INT","0");   
							  UserExtMsgUtype08.setUe("STRING",area_nameh);      
							  UserExtMsgListUtype.setUe(UserExtMsgUtype08); 
							/*2014/04/03 11:17:27 gaopeng utype 拼装  归属类别 belongCategory 承载方式 bearType start**/  
							UType UserExtMsgUtype36 = new UType(); /*归属类别*/
								UserExtMsgUtype36.setUe("LONG","20220");
								UserExtMsgUtype36.setUe("INT","0");   
							  UserExtMsgUtype36.setUe("STRING",belongCategory);      
							  UserExtMsgListUtype.setUe(UserExtMsgUtype36); 
							  
							UType UserExtMsgUtype37 = new UType(); /*承载方式*/
								UserExtMsgUtype37.setUe("LONG","20221");
								UserExtMsgUtype37.setUe("INT","0");   
							  UserExtMsgUtype37.setUe("STRING",bearType);      
							  UserExtMsgListUtype.setUe(UserExtMsgUtype37); 
							/*2014/04/03 11:17:27 gaopeng utype 拼装  归属类别 belongCategory 承载方式 bearType end**/      
							UType UserExtMsgUtype09 = new UType(); /*详细安装地址*/
								UserExtMsgUtype09.setUe("LONG","20119");
								UserExtMsgUtype09.setUe("INT","0");  
							  UserExtMsgUtype09.setUe("STRING",enter_addr);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype09);  
							    
							UType UserExtMsgUtype10 = new UType(); /*预约时间*/
								UserExtMsgUtype10.setUe("LONG","20120");
								UserExtMsgUtype10.setUe("INT","0");  
								UserExtMsgUtype10.setUe("STRING",appointvTime);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype10);
							    
							UType UserExtMsgUtype11 = new UType(); /*宽带带宽*/
								UserExtMsgUtype11.setUe("LONG","20121");
								UserExtMsgUtype11.setUe("INT","0");  
							  UserExtMsgUtype11.setUe("STRING",bandWidthMsg);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype11);
							            
							UType UserExtMsgUtype12 = new UType(); /*接入数量*/
								UserExtMsgUtype12.setUe("LONG","20122");
								UserExtMsgUtype12.setUe("INT","0");  
							  UserExtMsgUtype12.setUe("STRING",enter_num);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype12);  
							       
							UType UserExtMsgUtype13= new UType(); /*用户类型*/
								UserExtMsgUtype13.setUe("LONG","20123");
								UserExtMsgUtype13.setUe("INT","0");  
							  UserExtMsgUtype13.setUe("STRING","0");       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype13);    
							    
							UType UserExtMsgUtype14 = new UType(); /*接入方式*/
								UserExtMsgUtype14.setUe("LONG","20124");
								UserExtMsgUtype14.setUe("INT","0");  
							  UserExtMsgUtype14.setUe("STRING",enter_type);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype14); 
							    
							UType UserExtMsgUtype15 = new UType(); /*设备编号*/
								UserExtMsgUtype15.setUe("LONG","20125");
								UserExtMsgUtype15.setUe("INT","0");  
							  UserExtMsgUtype15.setUe("STRING",deviceCode);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype15); 
							      
							UType UserExtMsgUtype16= new UType(); /*端口编号*/
								UserExtMsgUtype16.setUe("LONG","20126");
								UserExtMsgUtype16.setUe("INT","0");  
							  UserExtMsgUtype16.setUe("STRING",portCode);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype16);
							    
							UType UserExtMsgUtype17= new UType(); /*ip地址*/
								UserExtMsgUtype17.setUe("LONG","20127");
								UserExtMsgUtype17.setUe("INT","0");  
							  UserExtMsgUtype17.setUe("STRING",ipAddress);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype17);
							    
							UType UserExtMsgUtype18= new UType(); /*设备安装地址*/
								UserExtMsgUtype18.setUe("LONG","20128");
								UserExtMsgUtype18.setUe("INT","0");
							  UserExtMsgUtype18.setUe("STRING",deviceInAddress);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype18);
							    
							UType UserExtMsgUtype19= new UType(); /*施工要求*/
								UserExtMsgUtype19.setUe("LONG","20129");
								UserExtMsgUtype19.setUe("INT","0");  
								UserExtMsgUtype19.setUe("STRING",constructRequest);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype19); 
							
							UType UserExtMsgUtype20= new UType(); /*是否施工*/
									UserExtMsgUtype20.setUe("LONG","20160");
									UserExtMsgUtype20.setUe("INT","0");  
									UserExtMsgUtype20.setUe("STRING","Y");       
									UserExtMsgListUtype.setUe(UserExtMsgUtype20); 
							
							UType UserExtMsgUtype21= new UType();  
								UserExtMsgUtype21.setUe("LONG","20161");/*电信局编码*/
								UserExtMsgUtype21.setUe("INT","0");  
								UserExtMsgUtype21.setUe("STRING",cctId);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype21); 
							
							UType UserExtMsgUtype22= new UType();  /*付费方式*/
								 UserExtMsgUtype22.setUe("LONG","20163");
								 UserExtMsgUtype22.setUe("INT","0");  
								 UserExtMsgUtype22.setUe("STRING","预付费");       
								 UserExtMsgListUtype.setUe(UserExtMsgUtype22);
								
							UType UserExtMsgUtype23= new UType();  /*用户类型*/
									UserExtMsgUtype23.setUe("LONG","20164");
									UserExtMsgUtype23.setUe("INT","0");  
									UserExtMsgUtype23.setUe("STRING",userType1);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype23);
									
							UType UserExtMsgUtype24= new UType();  /*ip地址类型*/
									UserExtMsgUtype24.setUe("LONG","20172");
									UserExtMsgUtype24.setUe("INT","0");  
									UserExtMsgUtype24.setUe("STRING",ipAddType);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype24);
									
							UType UserExtMsgUtype25= new UType();  /*标准地址名称*/
									UserExtMsgUtype25.setUe("LONG","20174");
									UserExtMsgUtype25.setUe("INT","0");  
									UserExtMsgUtype25.setUe("STRING",standardContent);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype25);
									
							UType UserExtMsgUtype26= new UType();  /*是否需要资源配置*/
									UserExtMsgUtype26.setUe("LONG","20175");
									UserExtMsgUtype26.setUe("INT","0");  
									UserExtMsgUtype26.setUe("STRING",constructionFlag);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype26);
							
							UType UserExtMsgUtype27= new UType();  /*品牌*/
									UserExtMsgUtype27.setUe("LONG","20181");
									UserExtMsgUtype27.setUe("INT","0");  
									UserExtMsgUtype27.setUe("STRING",brandId);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype27);
									
							UType UserExtMsgUtype28= new UType();  /*品牌类型*/
									UserExtMsgUtype28.setUe("LONG","20182");
									UserExtMsgUtype28.setUe("INT","0");  
									UserExtMsgUtype28.setUe("STRING",offerType);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype28);
									
							UType UserExtMsgUtype29= new UType();  /*集团编号*/
									UserExtMsgUtype29.setUe("LONG","20170");
									UserExtMsgUtype29.setUe("INT","0");  
									UserExtMsgUtype29.setUe("STRING",unitId);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype29);


							UType UserExtMsgUtype30= new UType();  /*营销案流水*/
									UserExtMsgUtype30.setUe("LONG","20196");
									UserExtMsgUtype30.setUe("INT","0");  
									UserExtMsgUtype30.setUe("STRING",marketAccept);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype30);
							
								
							UType UserExtMsgUtype31= new UType();  /*营销案手机号码*/
									UserExtMsgUtype31.setUe("LONG","20197");
									UserExtMsgUtype31.setUe("INT","0");  
									UserExtMsgUtype31.setUe("STRING",marketPhoneNo);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype31);


if(!"".equals(marketPhoneNo_58_88)){
							UType UserExtMsgUtype30000= new UType();  /*营销案手机号码*/
									UserExtMsgUtype30000.setUe("LONG","30000");
									UserExtMsgUtype30000.setUe("INT","0");  
									UserExtMsgUtype30000.setUe("STRING",marketPhoneNo_58_88);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype30000);
}									
																		
							UType UserExtMsgUtype32= new UType();  /*营销案流水*/
									UserExtMsgUtype32.setUe("LONG","20195");
									UserExtMsgUtype32.setUe("INT","0");  
									UserExtMsgUtype32.setUe("STRING",partnerCode);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype32);
						/*2014/06/24 15:35:28 gaopeng 小区编码/小区接入情况/小区建设性质	 自有农村无线宽带（WBS）业务系统支撑需求*/			
							UType UserExtMsgUtype33= new UType();  /*小区编码*/
									UserExtMsgUtype33.setUe("LONG","20222");
									UserExtMsgUtype33.setUe("INT","0");  
									UserExtMsgUtype33.setUe("STRING",distKdCode);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype33);
							UType UserExtMsgUtype34= new UType();  /*小区接入情况*/
									UserExtMsgUtype34.setUe("LONG","20223");
									UserExtMsgUtype34.setUe("INT","0");  
									UserExtMsgUtype34.setUe("STRING",nearInfo);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype34);
							UType UserExtMsgUtype35= new UType();  /*小区建设性质*/
									UserExtMsgUtype35.setUe("LONG","20224");
									UserExtMsgUtype35.setUe("INT","0");  
									UserExtMsgUtype35.setUe("STRING",propertyUnit+"");       
									UserExtMsgListUtype.setUe(UserExtMsgUtype35);
						if("kf".equals(smCode) || "ki".equals(smCode)){			
							UType UserExtMsgUtype38= new UType();  /*宽带终端*/
									UserExtMsgUtype38.setUe("LONG","20225");
									UserExtMsgUtype38.setUe("INT","0");  
									UserExtMsgUtype38.setUe("STRING",kdZd);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype38);
									
							UType UserExtMsgUtype39= new UType();  /*宽带终端费用*/
									UserExtMsgUtype39.setUe("LONG","20226");
									UserExtMsgUtype39.setUe("INT","0");  
									UserExtMsgUtype39.setUe("STRING",kdZdFee);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype39);
					
					 if("ONT".equals(kdZd))	{			
							UType UserExtMsgUtype42= new UType();  /*费用收取方式*/
									UserExtMsgUtype42.setUe("LONG","20234");
									UserExtMsgUtype42.setUe("INT","0");
									UserExtMsgUtype42.setUe("STRING",fysqfs);
									UserExtMsgListUtype.setUe(UserExtMsgUtype42);
									if(!"2".equals(fysqfs)&&!"".equals(snNumber)&&("kf".equals(smCode)||"ki".equals(smCode))){
										System.out.println("liangyl------------------------------------------------------------------------------"+snNumber);
										UType UserExtMsgUtype48= new UType();  /*SN码*/
										UserExtMsgUtype48.setUe("LONG","20135");
										UserExtMsgUtype48.setUe("INT","0");
										UserExtMsgUtype48.setUe("STRING",snNumber);
										UserExtMsgListUtype.setUe(UserExtMsgUtype48);
									}
									
									
							}else {
									UType UserExtMsgUtype44= new UType();  /*费用收取方式*/
									UserExtMsgUtype44.setUe("LONG","20234");
									UserExtMsgUtype44.setUe("INT","0");  
									UserExtMsgUtype44.setUe("STRING","1");       
									UserExtMsgListUtype.setUe(UserExtMsgUtype44);	
								
								}
						}
						
						UType UserExtMsgUtype40= new UType();  /*有线电视*/
									UserExtMsgUtype40.setUe("LONG","20231");
									UserExtMsgUtype40.setUe("INT","0");  
									UserExtMsgUtype40.setUe("STRING",yxds);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype40);
								
						UType UserExtMsgUtype41= new UType();  /*机顶盒ID*/
								UserExtMsgUtype41.setUe("LONG","20232");
								UserExtMsgUtype41.setUe("INT","0");  
								UserExtMsgUtype41.setUe("STRING",jdhId);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype41);
						
						UType UserExtMsgUtype43= new UType();  /*实际使用人证件类型*/
								UserExtMsgUtype43.setUe("LONG","20227");
								UserExtMsgUtype43.setUe("INT","0");  
								UserExtMsgUtype43.setUe("STRING",realUserIdType);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype43);
								
						UType UserExtMsgUtype44= new UType();  /*实际使用人证件号码*/
								UserExtMsgUtype44.setUe("LONG","20228");
								UserExtMsgUtype44.setUe("INT","0");  
								UserExtMsgUtype44.setUe("STRING",realUserIccId);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype44);
								
						UType UserExtMsgUtype45= new UType();  /*实际使用人姓名*/
								UserExtMsgUtype45.setUe("LONG","20229");
								UserExtMsgUtype45.setUe("INT","0");  
								UserExtMsgUtype45.setUe("STRING",realUserName);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype45);
								
						UType UserExtMsgUtype46= new UType();  /*实际使用人证件地址*/
								UserExtMsgUtype46.setUe("LONG","20230");
								UserExtMsgUtype46.setUe("INT","0");  
								UserExtMsgUtype46.setUe("STRING",realUserAddr);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype46);
						/*2016/5/31 10:34:42 gaopeng 关于铁通宽带客户迁移支撑系统改造补充需求的函 
							增加开户方式 openkdFlag
						*/
						UType UserExtMsgUtype47= new UType();  /*开户方式*/
								UserExtMsgUtype47.setUe("LONG","20235");
								UserExtMsgUtype47.setUe("INT","0");  
								UserExtMsgUtype47.setUe("STRING",openkdFlag);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype47);
						if("1".equals(openkdFlag)||"2".equals(openkdFlag)||"4".equals(openkdFlag)||"5".equals(openkdFlag)){
							UType UserExtMsgUtype49= new UType();  /*开户方式*/
							UserExtMsgUtype49.setUe("LONG","20236");
							UserExtMsgUtype49.setUe("INT","0");  
							UserExtMsgUtype49.setUe("STRING",yuankuandaiNum);       
							UserExtMsgListUtype.setUe(UserExtMsgUtype49);
						}
						
						
						UType UserExtMsgUtype53= new UType();  
						UserExtMsgUtype53.setUe("LONG","20300");
						UserExtMsgUtype53.setUe("INT","0");  
						UserExtMsgUtype53.setUe("STRING",anzhuangFangshi);
						UserExtMsgListUtype.setUe(UserExtMsgUtype53);
						
						System.out.println("-------hejwa------------20300------------->");
						System.out.println("-------hejwa------------20300------0------->");
						System.out.println("-------hejwa------------20300------anzhuangFangshi------->"+anzhuangFangshi);
								
    userInfoUtype.setUe(UserExtMsgListUtype);
        UType UserAgreementMsgUtype = new UType();
          userInfoUtype.setUe(UserAgreementMsgUtype);
        UType UserPostUtype = new UType();
              userInfoUtype.setUe(UserPostUtype);
            userInfoListUtype.setUe(userInfoUtype);
          customerUtype.setUe(userInfoListUtype);
        msgBodyTypeUtype.setUe(customerUtype);
        
        
        
        
         
	%>
	
<%String regionCode_sCBatMultiUser = (String)session.getAttribute("regCode");%>
<wtc:utype name="sCBatMultiUser" id="retVal"  routerKey="region" routerValue="<%=regionCode_sCBatMultiUser%>">
	<wtc:uparam value="<%=ctrlInfoUtype%>" type="UTYPE"/> 
	<wtc:uparam value="<%=batchDataListUtype%>" type="UTYPE"/>
	<wtc:uparam value="<%=msgBodyTypeUtype%>" type="UTYPE"/>
</wtc:utype>

<%
	String retrunCode=String.valueOf(retVal.getValue(0));//返回的retCode为LONG类型；
	String returnMsg=retVal.getValue(1);
	System.out.println("#hejwa from KDconfm_new.jsp -> retCode = "+retrunCode + ",retMsg = "+returnMsg);
	
	
if(retrunCode.equals("0"))
{
%>
<script language='JavaScript'>
function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet);
	packet =null;
	if("<%=tabcloseId%>"!="")
	{
			parent.removeTab("<%=tabcloseId%>");
	}
}
  /***其他函数中要用到的过滤函数**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function dnyCreatDiv(login_accept,printinfo,joinMarket){
	if(parent.document.getElementById("<%=gCustId%>")==null||
		 parent.document.getElementById("<%=gCustId%>")=="null"){
				var newE = parent.document.createElement("DIV");
			    newE.id = login_accept;
			    newE.printinfo=printinfo;
			    newE.joinMarket=joinMarket;
			    //newE.style.display = "none";
			    parent.document.appendChild(newE);
		 }else{
		 			parent.document.getElementById("<%=gCustId%>").printinfo = "";
					parent.document.getElementById("<%=gCustId%>").printinfo = printinfo;
		 }
}
function doProcess(packet)
{
	  var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  if(retCode=="0")
	  {
	  	var sData = packet.data.findValueByName("sData"); 
	  	parent.parent.$("#carNavigate").html(sData);
	  	var custOrderId = packet.data.findValueByName("custOrderId"); 
	  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
	  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
	  	var servOrderId = packet.data.findValueByName("servOrderId"); 
	  	var status = packet.data.findValueByName("status"); 
	  	var funciton_code = packet.data.findValueByName("funciton_code"); 
	  	var funciton_name = packet.data.findValueByName("funciton_name"); 
	  	var pageUrl = packet.data.findValueByName("pageUrl"); 
	  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
	  	var num = packet.data.findValueByName("num"); 
	  	var offerId = packet.data.findValueByName("offerId"); 
	  	var offerName = packet.data.findValueByName("offerName"); 
	  	var phoneNo = packet.data.findValueByName("phoneNo"); 
	  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
	  	var prtFlag = packet.data.findValueByName("prtFlag"); 
	  	var servBusiId = packet.data.findValueByName("servBusiId"); 
	    var validVal = packet.data.findValueByName("validVal"); 
	  	var openWay = packet.data.findValueByName("openWay"); 
	  	var closeId=orderArrayId+servOrderId;
	  	if("<%=paramValue_zhaz%>" == "Y"){
		  	parent.parent.checkHasBill(funciton_code);
		  	if(parent.parent.hasBill == "N"){
			   		rdShowMessageDialog("您昨天未进行轧帐,不能进行业务操作!",0);
			   		parent.parent.addTab(true,"r615","营业员操作统计报表","../rpt_new/f1615.jsp");
			   		return false;
			   }
			   if(parent.parent.todayHasBill == "Y"){
			   		rdShowMessageDialog("您今天已经轧帐完成,不能进行业务操作!",0);
			   		return false;
			   }
	  	}
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	var tpageUrln = pageUrl;
	  	if(pageUrl.indexOf("sq046/fq046.jsp")!=-1){//没有与营销业务一起做,原逻辑不变
	  		tpageUrln = "/npage/s4977/fq046.jsp?gCustId=<%=gCustId%>"; /*diling update for 将ADSL宽带和手机用户 统一缴费页面个性化@2012/9/19 */ 
	  	}else{
	  		tpageUrln = pageUrl+"?gCustId=<%=gCustId%>";
	  	}
	  	var path=   tpageUrln //宽带营销业务一起做的情况
	  							+"&opCode="+funciton_code
	  						  +"&opName="+funciton_name
	  							+"&offerSrvId="+offerSrvId
	  							+"&num="+num
	  							+"&offerId="+offerId
	  							+"&offerName="+offerName
	  							+"&phoneNo="+phoneNo
	  							+"&sitechPhoneNo="+sitechPhoneNo
	  							+"&orderArrayId="+orderArrayId
	  							+"&custOrderId="+custOrderId
	  							+"&custOrderNo="+custOrderNo
	  							+"&servOrderId="+servOrderId
	  							+"&closeId="+closeId
	  							+"&servBusiId="+servBusiId
	  							+"&prtFlag="+prtFlag
	  							+"&opcodeadd=<%=opCode%>"
	  							+"&offeridkd=<%=offeridkd%>"
	  							+"&oldMSISDN=<%=work_flow_no%>"
	  							+"&cfm_login=<%=cfm_login%>"
	  							+"&v_smCode=<%=smCode%>"
	  							+"&intePrice=<%=intePrice%>"
	  							+"&joinType=<%=joinType%>"
	  							+"&isBaoNian=<%=isBaoNian%>"
	  							+"&anzhuangFangshi=<%=anzhuangFangshi%>";
	  							
	 		dnyCreatDiv("<%=gCustId%>","<%=printinfo%>","<%=joinMarket%>");
	 		if(pageUrl.indexOf("sq046/fq046.jsp")!=-1){//没有与营销业务一起做,原逻辑不变 
		  	parent.addTab(false,closeId,funciton_name,path);
			}else{
				  try{
						parent.parent.L(openWay,funciton_code,funciton_name,path,validVal);
					}catch(e){
						parent.L(openWay,funciton_code,funciton_name,path,validVal);
					}
			}
	 			
	  }else{
	  		alert("操作导航失败!");
	  }
}
		
		//rdShowMessageDialog("开户成功！",2);
		goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
</script>            
<%}else
  {
%>
<script language='JavaScript'>
function realeaseResource()
{	
				var myPacket = new AJAXPacket("/npage/se276/ajax_yzResource.jsp", "正在校验，请稍候......");
				  	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
						myPacket.data.add("customerCode","<%=cfm_login%>");/*用户编号*/
						myPacket.data.add("productType","12");/*产品类型*/
						myPacket.data.add("opCode", "<%=opCode%>");
						myPacket.data.add("yzFlag", "2");
						/*2013/3/1 星期五 9:09:16 gaopeng FTTH需求，增加参数 addressCode 地址编码*/
						myPacket.data.add("addressCode", "<%=standardCode%>");
				   core.ajax.sendPacket(myPacket,doRealeaseResource);
		       myPacket = null;			 	
} 
function doRealeaseResource(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
     if(retCode=="000000"){
      		rdShowMessageDialog("资源释放成功");
     }
     else{ 
         	rdShowMessageDialog("资源释放失败"); 
     }
}
		
		if('<%=retrunCode%>' == '497701'){
			rdShowMessageDialog("开户失败！错误代码：<%=retrunCode%>,错误信息：<%=returnMsg%>",0);
		}else{
			rdShowMessageDialog("开户失败！错误代码：<%=retrunCode%>",0);
		}
		if("<%=isDoNoResource%>" =="1"){
    	realeaseResource();//释放已预占的资源
    }
    window.history.go(-1);
</script>
<%        
  }
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+retrunCode+
							"&opName="+opName+
							"&workNo="+workNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+returnMsg+
							"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
