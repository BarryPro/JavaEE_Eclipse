<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	
<%@ page import="java.text.SimpleDateFormat"%>

<%
	String retrunCode="";
	String returnMsg="";
	String sysAcceptl = "";
	System.out.println("<<--------------查询销售品构成明细开始--------------------->>"); 
	String workNo = (String)session.getAttribute("workNo");
	//String groupId = (String)session.getAttribute("siteId");
	String groupId = (String)session.getAttribute("groupId");
	String feeFactor=WtcUtil.repNull(request.getParameter("feeFactor"));	
	String oldOfferExpTime="";
	String errCode = "";
	String errMsg = "";
	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	int recordNum = 0; //查询结果记录数量
	
	StringBuffer discountInfoList_sb = new StringBuffer();//销售品信息
	StringBuffer ProductBaseInfo_sb = new StringBuffer();
	StringBuffer ProductBaseInfo_sb2 = new StringBuffer();
	String discountInfo=WtcUtil.repNull(request.getParameter("discountInfo"));	
	String UserOffers=WtcUtil.repNull(request.getParameter("UserOffers"))+"~";	//老销售品基本信息
  String newOfferEffectTime = WtcUtil.repNull(request.getParameter("newOfferEffectTime")).trim();//新购基本销售品生效完整时间
	newOfferEffectTime=newOfferEffectTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
System.out.println("新购销售品生效时间为："+newOfferEffectTime);	
	String[] majorProductArr=WtcUtil.repNull(request.getParameter("majorProductArr")).split(",");
	String discountInfo_bas[]=discountInfo.split(",");
	String discountInfo_bas_ins="";
	if(discountInfo_bas.length>1){
		discountInfo_bas_ins=discountInfo_bas[1];
	}
	String UserOffers_s[]=UserOffers.split("~");
	String UserOffers_ss[][]=new String[UserOffers_s.length][2];

	String[] oldRemained=WtcUtil.repNull(request.getParameter("oldRemained")).split(",");
	String systemTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());	// 	系统当前时间
	String offer_effectTime="";//销售品将要生成的时间
	String offer_expireTime=WtcUtil.repNull(request.getParameter("offer_expireTime"));	// 新购的销售品失效完整时间
	offer_expireTime=offer_expireTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
	String proType=WtcUtil.repNull(request.getParameter("proType")).trim();	// 
	String proDisNum=WtcUtil.repNull(request.getParameter("proDisNum")).trim();	// 
	String proDisType=WtcUtil.repNull(request.getParameter("proDisType")).trim();	// 
		offer_effectTime=newOfferEffectTime;	
		offer_effectTime=offer_effectTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
	
	if("".equals(offer_effectTime)){
		offer_effectTime=new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	}
System.out.println("新购销售品生效时间为："+newOfferEffectTime);	
	if("".equals(offer_expireTime)){
		offer_expireTime="20500101";
	}
	String offered=WtcUtil.repNull(request.getParameter("offId"));	//"100005329";	//  #销售品标识 100005610
	String opCode=WtcUtil.repNull(request.getParameter("opCode"));	//  #操作代码	//"1210";	
	String servId=WtcUtil.repNull(request.getParameter("servId"));	//servId//  #主产品实例ID "900000783066";	10099000990
	String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));//  #客户ID 900001942251	//900001942251 "900000782559";	
	String ruleValue="";	//   #业务规则
	String oldTempArr="";
  String attrCode="aa";		//     #属性代码
  String attrValue="bb";	//    #属性值
	String sale_mode=WtcUtil.repNull(request.getParameter("sale_mode"));
	String imeiNo=WtcUtil.repNull(request.getParameter("imeiNo"));
	String offerSrvId1 = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String phoneNo1 = WtcUtil.repNull(request.getParameter("phoneNo"));
	System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111111111===="+sale_mode+"||||");
	if(sale_mode!=null && !sale_mode.equals("")){
	System.out.println("*****************************************************调用sIProdMidMac服务**************");

%>
<wtc:utype name="sIProdMidMac" id="retVal" scope="end">
	<wtc:uparam value="<%=offerSrvId1%>" type="LONG"/> 
	<wtc:uparam value="<%=phoneNo1%>" type="STRING"/> 
	<wtc:uparam value="<%=sale_mode%>" type="STRING"/> 
	<wtc:uparam value="<%=imeiNo%>" type="STRING"/> 
	<wtc:uparam value="<%=workNo%>" type="STRING"/> 
	<wtc:uparam value="0" type="STRING"/> 
</wtc:utype>	
<%

	String retCode1=retVal.getValue(0);
	String retMsg1=retVal.getValue(1);
	
				if(!retCode1.equals("0"))
				{
						retrunCode=retCode1;
						returnMsg=retMsg1;
				}
		}
	String ProductBaseInfo_=WtcUtil.repNull(request.getParameter("ProductBaseInfo2"))+"~";		
	String discountInfoList_=WtcUtil.repNull(request.getParameter("discountInfoList"))+"~";
	int seqArrDiscountPlan_num=1+ProductBaseInfo_.split("~").length+discountInfoList_.split("~").length;
	int seqArrDiscountPlan_num2=0;
	String [] seqArrDiscountPlan = new String[seqArrDiscountPlan_num];	//销售品实例化ID
	for(int i=0;i<seqArrDiscountPlan_num;i++){
%>	
<wtc:service name="sDynSqlCfm" outnum="1">
	<wtc:param value="13"/>
</wtc:service>	
<wtc:array id="rows" scope="end" />
<%
		if(retCode.equals("000000")&&rows.length > 0)
			seqArrDiscountPlan[i] = rows[0][0];
	}	
	String offeredIns=seqArrDiscountPlan[seqArrDiscountPlan_num2++];	//seqArr[0];
	discountInfoList_sb.append("1,"+offeredIns+","+offered+","+offer_effectTime+","+offer_expireTime+",A~");	
	for(int i=0;i<UserOffers_ss.length;i++){
		String ss[]=UserOffers_s[i].split(",");
		UserOffers_ss[i][0]=ss[0];
		UserOffers_ss[i][1]=ss[1];
		java.util.Calendar cal2 = java.util.Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		Date desDate1 = sdf1.parse(newOfferEffectTime);  
		cal2.setTime(desDate1);
		cal2.add(Calendar.SECOND,-1);
		ss[3] = sdf1.format(cal2.getTime());
		oldOfferExpTime=sdf1.format(cal2.getTime());
		discountInfoList_sb.append("3,"+ss[0]+","+ss[1]+","+ss[2]+","+ss[3]+",A~");
	}																		
  String opName=WtcUtil.repNull(request.getParameter("opName"));	
	String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));	//如果是新装就是 //新装销售品实例ID;如果是客户服务就是 idNo
	String num=WtcUtil.repNull(request.getParameter("num"));	//1			数量
	String offerId=WtcUtil.repNull(request.getParameter("offerId"));	//0		销售品ID
	String offerName=WtcUtil.repNull(request.getParameter("offerName"));	//e8		销售品名称
	String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));	//13083154258	业务号码
	String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));	//A0209022000000180  客户订单子项ID
	String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));	//C0209022000000166  客户订单ID
	String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));	//C0209022000000166  客户订单编号
	String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));	//			    服务订单ID
	String closeId=WtcUtil.repNull(request.getParameter("closeId"));	//A0209022000000180		关闭tab的ID
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));	//Y                      打印标识  Y 合打 N分打
	String servBusiId=WtcUtil.repNull(request.getParameter("servBusiId"));	//620
	String offercode = WtcUtil.repNull(request.getParameter("offercode"));
	
	String loginAccept =WtcUtil.repNull(request.getParameter("loginAccept"));
	
	System.out.println("----------------------loginAccept------------------------"+loginAccept);
	int seqArr_num=0;
	int seqArr_num2=0;
	String [] seqArr = new String[seqArr_num];
	for(int i=0;i<seqArr_num;i++){
%>	

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="seq" />
<%
	seqArr[i] = seq;
	}	
	
	
	  
    String loginPwd =(String)session.getAttribute("password");
    String ipAddress =request.getRemoteAddr();	
    //String oprGroupId =(String)session.getAttribute("siteId");	//10032 
    String oprGroupId =(String)session.getAttribute("groupId");	//10032 
    String opTime =new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
    String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);//bureau_Id  区域ID  相当与咱们原来的regionCode 
    String opNote="工号:"+workNo+" 操作代码:"+opCode+" 业务:"+opName;
    //String bureauId =(String)session.getAttribute("siteId");	//site_id   处理点ID  相当于咱们原来的groupId
    //String objectId =(String)session.getAttribute("objectId");	//object_id 处理局ID	//bureau_id >  object_id > site_id
    
    String bureauId =(String)session.getAttribute("groupId");	//site_id   处理点ID  相当于咱们原来的groupId
    String objectId =(String)session.getAttribute("groupId");	//object_id 处理局ID	//bureau_id >  object_id > site_id
    
    String productI = (String)request.getParameter("productI");
		
		System.out.println("---------------productI-------------"+productI);
		
		
		String servOrderNo ="0";	//客户服务定单编号(为外系统预留)
		String servOrderChangeId ="0";	//服务定单变更编号
		String idNo = WtcUtil.repNull(request.getParameter("offerSrvId"));	//"200001868613"; //custInfo.getIdNo();//用户ID/主产品实例ID//
		String serviceNo =phoneNo;	//"0";//网络接入号码//-------------j	WtcUtil.repNull(request.getParameter("selNum"));
		String dispathRule ="0"; //替换0	工单派发规则标识
		String decomposeRule ="0"; //替换0	工单分解规则标识
		String addressId ="0"; //替换0	//地址ID//-------------j ----------------@@@@
		String orderStatus ="110"; //替换0 //0初始未调度状态	//待收费110
		String stateDate =opTime;;	//-------------j
		String stateReasonId ="3"; //替换0	//定单状态原因ID//-------------j
		String finishFlag ="N";	//未完成,已完成 N未竣工//-------------j
		String finishTime ="0";		//竣工时间//-------------j
		String finishLimitTime =opTime;	//完成期限//-------------j	//-------------------@@@@
		String warningTime =opTime;	//预警时间//-------------j	//-------------------@@@@
		String dealLevel ="1";		//1:普通优先级//-------------j  
		String payStatus ="0";		//缴费状态 char sPayState[1+1];//-------------j
		String backFlag ="0";		//退费标志//-------------j
		String exceptionTimes ="0";	//"int";	//异常出现次数//-------------j
		String servOrderSeq ="1";	//"int";	//服务定单调度顺序dOrderArrayOrder.serv_order_seq//-------------j//-------------------@@@@
		String isPreCreateStatus ="Y";	//"string";表示是否是预创建状态，dOrderArrayOrder.create_status，取值范围'Y','N'。对于组合业务服务定单是提前生成的	//表示是否是预创建状态，dOrderArrayOrder.create_status，取值范围'Y','N'。//-------------j
		String contactPerson ="0";	//服务定单级别的联系人。//-------------j
		String contactPhone =WtcUtil.repNull(request.getParameter("phoneNo"));	//"string"; //服务定单级别的联系电话。//-------------j	
		String classCode ="0";	//"long";	//对象类型  ----可空或默认
		String arraySeq ="0";	//"int";	//数组序号
		String classValue ="0";		//数组值
		String srvOrderSlaId ="0";	//定单SLA标识
		String slaIndexId ="0"; //替换0	//指标标识
		String salValueSeq ="0"; //替换0	//指标序号
		String slaValue ="0";	//指标序号
		String bookSrvId ="0";		//预约服务信息标识
		String modifyTime =opTime;	//最后修改时间
		String bookingTime =opTime;	//预约时间
		String srvOrderExcpId ="0";	//异常信息标识
		String excpType ="1"; //替换0				//异常类型
		String excpReason ="0";		//异常原因
		String handleResult ="OK";		//异常处理结果
		String handleLogin ="0";		//异常处理人
		String userId =idNo;		//"210001466327";	//"1010001242459"; //替换0			//用户标识//-------------j
		String brand ="0";			//用户的品牌信息，如：00 世界风 01 新势力 02 如意通。//-------------j
		String userNo ="0";		//用户的内部11位编码，用于出账//-------------j
		String UseCustId =gCustId;	//使用客户ID
		HashMap DiscountInfo_idMap=new HashMap();
		HashMap DiscountInfo_effectMap=new HashMap();
		HashMap DiscountInfo_expireMap=new HashMap();
		String discountInfoList="";
		int discountInfoList_sbs =discountInfoList_sb.toString().split("~").length;
		int contentNum=WtcUtil.repNull(request.getParameter("cutOfferList")).split("~").length;
		if(request.getParameter("cutOfferList").equals(""))
		{
				contentNum=0;
		}
		if(true){
		discountInfoList=discountInfoList_sb.toString()+WtcUtil.repNull(request.getParameter("cutOfferList"));
		}else{
		discountInfoList=discountInfo+WtcUtil.repNull(request.getParameter("discountInfoList"))+"~";
		}
		String discountInfoLists[]=discountInfoList.split("~");
		int discountInfoList_num=8;
		String DiscountInfos[][]=new String[discountInfoLists.length][discountInfoList_num];	
		String[] oldTempArray=oldTempArr.split("~");
		for(int i=0;i<discountInfoList_sbs+contentNum;i++){
			String ss[]=discountInfoLists[i].split(",");
			if(ss.length>4){
			DiscountInfos[i][0] =ss[0];//操作符号
			DiscountInfos[i][1] =ss[1];//销售品实力ID
			if(ss[1].equals(""))
			{
				DiscountInfos[i][1]=seqArrDiscountPlan[seqArrDiscountPlan_num2++];
			}
			DiscountInfos[i][2] =ss[2];//销售品ID
			DiscountInfos[i][3] =ss[3];//生效时间
			DiscountInfos[i][4] =ss[4];//失效时间
			DiscountInfos[i][7] = ss[5];//状态
			DiscountInfos[i][5] ="0";	//父实例节点-------------------------自己取父节点实例ID
			DiscountInfos[i][6] ="1";	//当前级别	//string-------------自己取,0,1,2........
			if(i<1||i==discountInfoList_sbs-1){
			DiscountInfos[i][5] ="0";	//父实例节点-------------------------自己取父节点实例ID
			DiscountInfos[i][6] ="0";	//当前级别	//string-------------自己取,0,1,2........
			} 
			boolean ch=false;

			DiscountInfo_idMap.put(DiscountInfos[i][2],DiscountInfos[i][1]);
			DiscountInfo_effectMap.put(DiscountInfos[i][1],DiscountInfos[i][3]);
			DiscountInfo_expireMap.put(DiscountInfos[i][1],DiscountInfos[i][4]);
			}
		}
		String order ="0";	//seqArr[0]; //序列号  0	
		String custAgreementId ="0";	//客户协议标识   0 取服务的返回
		String status ="A";				//状态  
		String developLoginNo =(String)session.getAttribute("workNo");
		//String channelId =(String)session.getAttribute("siteId");	//受理渠道  group_id (从用户信息读)//区域标识
		String channelId =(String)session.getAttribute("groupId");	//受理渠道  group_id (从用户信息读)//区域标识
HashMap offer_productAttrMap = new HashMap();
String[] offer_productAttrInfoArr = new String[]{};	//取所有产品属性信息
if(!WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).equals("")){
	offer_productAttrInfoArr = WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).split("\\^");
}
for(int i=0;i<offer_productAttrInfoArr.length;i++){
	String[] offer_productAttrArr = offer_productAttrInfoArr[i].split("\\|");
	if(offer_productAttrArr.length > 1)
		offer_productAttrMap.put(offer_productAttrArr[0],offer_productAttrArr[1]);
}
	String DiscountAttrList=WtcUtil.repNull(request.getParameter("DiscountAttrList"));	//-----------------------------------j2				
	if(DiscountAttrList.trim().length() > 1)
			offer_productAttrMap.put(offered,DiscountAttrList+"^");
		
		String DiscountAttr_effDate =opTime;	//生效时间
		String DiscountAttr_expDate ="20501231235959";	//失效时间
HashMap groupInfoMap = new HashMap();
String[] allGroupInfo = new String[]{};	//取所有销售品群组信息
if(!WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).equals("")){
	allGroupInfo = WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).split("\\@");
}
for(int i=0;i<allGroupInfo.length;i++){
	String[] offerGroupInfo = allGroupInfo[i].split("\\|");
	groupInfoMap.put(offerGroupInfo[0],offerGroupInfo[1]);
}			
		String operatorFlag ="1";	//操作类型：'ADD':增加；'DEL':删除；'UPD':更新
		String grpInstId ="0";		//群组实例ID
		String grpTypeId ="0";		//群组类型ID
		String groupDesc ="0";		//群组描述
		String groupState ="A";	//群组状态"A"
		String effectDate =opTime;	//生效时间
		String expireDate ="20501231235959";	//失效时间
		String grpAttr ="0";		//群组属性
		String upGroupId ="0";		//上级群组ID
		String memberId ="0";			//成员标识	群组实例成员标识
		String memberDesc ="0";	//群组成员描述
		String memberTypeId ="0";	//群组成员类型标识
		String memberRoleId ="0";	//群组成员角色标识
		String lifeCycleId ="0";	//生命周期标识
		String mebState ="A";		//成员状态
		String grpMebAttr ="0";	//群组成员属性
		String memberObjectId ="0";	//群组实例成员对象标识
		String attrType ="0";      //属性类型	AttrType  
		attrCode ="0";		//属性代码	AttrCode  
		attrValue ="0";		//属性值	AttrValue   
		String attrRemark ="0";	//属性备注	AttrRemark
		String operatorFlag0 ="0";	//操作类型：'ADD':增加；'DEL':删除；'UPD':更新 
		String paramInstanceId ="0";	//参数取值标识
		String paramId ="0";		//销售品参数标识
		String paramValue ="0";	//参数值
		String paramAttrId ="0";	//参数属性标识
		String agreementId ="0";	//识别客户协议的唯一标识号。
		String subUserId ="0";		//用户关系类型long
		String relationType ="0";	//用户关系类型long
		String resType ="0";		//资源类型
		String resSeq ="0";		//资源序列
		String resNo =phoneNo;			//资源编号
		String paramType ="C";			//参数信息------------营业自费类型
		String paramCode ="C2";			//参数代码
		String paramValueBegin =feeFactor;	//开始参数值
		String paramValueEnd ="0";	
		String paramObj ="0";			//参数扩展信息
		

		
%>	

<wtc:utype name="sProdChgCfm" id="retVal" scope="end" >
<wtc:uparams name="ctrlInfo" iMaxOccurs="1">
		<wtc:uparam value="0" type="string"/>
</wtc:uparams>	
<wtc:uparams name="batchDataList" iMaxOccurs="1">
		<wtc:uparams name="batchData" iMaxOccurs="-1">
			<wtc:uparam value="0" type="long"/>
			<wtc:uparam value="0" type="string"/>
			<wtc:uparam value="0" type="string"/>
		</wtc:uparams>	
</wtc:uparams>	
<wtc:uparams name="msgBodyType" iMaxOccurs="1">
<wtc:uparams name="oprInfo" iMaxOccurs="1">
        <wtc:uparam value="<%=loginAccept %>" type="long"/>
        <wtc:uparam value="<%=opCode %>" type="string"/>
        <wtc:uparam value="<%=workNo %>" type="string"/>
        <wtc:uparam value="<%=loginPwd %>" type="string"/>
        <wtc:uparam value="<%=ipAddress %>" type="string"/>
        <wtc:uparam value="<%=oprGroupId %>" type="string"/>
        <wtc:uparam value="<%=opTime %>" type="string"/>
        <wtc:uparam value="<%=regionCode %>" type="string"/>
        <wtc:uparam value="<%=opNote %>" type="string"/>
        <wtc:uparam value="<%=bureauId %>" type="string"/>
        <wtc:uparam value="<%=objectId %>" type="string"/>
</wtc:uparams>
<wtc:uparams name="custOrder" iMaxOccurs="1">
        <wtc:uparams name="custOrderMsg" iMaxOccurs="1">
                <wtc:uparam value="<%=custOrderId %>" type="string"/>
        </wtc:uparams>
        <wtc:uparams name="orderArrayList" iMaxOccurs="1">		
		<% for(int m=0;m<1;m++){ %>
                <wtc:uparams name="orderArrayListContainer" iMaxOccurs="1">				
                        <wtc:uparams name="orderArrayMsg" iMaxOccurs="1">						
                                <wtc:uparam value="<%=orderArrayId %>" type="string"/>
                        </wtc:uparams>
                        <wtc:uparams name="servOrderList" iMaxOccurs="1">	
						<% for(int n=0;n<1;n++){ %>
                                <wtc:uparams name="servOrderListContainer" iMaxOccurs="1">														
                                        <wtc:uparams name="servOrderMsg" iMaxOccurs="1">										
                                                <wtc:uparam value="<%=servOrderId %>" type="string"/>
                                                <wtc:uparam value="<%=servOrderNo %>" type="string"/>
                                                <wtc:uparam value="<%=servOrderChangeId %>" type="string"/>
                                                <wtc:uparam value="<%=idNo %>" type="long"/>
                                                <wtc:uparam value="<%=serviceNo %>" type="string"/>
                                                <wtc:uparam value="<%=dispathRule %>" type="int"/>
                                                <wtc:uparam value="<%=decomposeRule %>" type="int"/>
                                                <wtc:uparam value="<%=addressId %>" type="long"/>
                                                <wtc:uparam value="<%=orderStatus %>" type="int"/>
                                                <wtc:uparam value="<%=stateDate %>" type="string"/>
                                                <wtc:uparam value="<%=stateReasonId %>" type="int"/>
                                                <wtc:uparam value="<%=servBusiId %>" type="string"/>
                                                <wtc:uparam value="<%=finishFlag %>" type="string"/>
                                                <wtc:uparam value="<%=finishTime %>" type="string"/>
                                                <wtc:uparam value="<%=finishLimitTime %>" type="string"/>
                                                <wtc:uparam value="<%=warningTime %>" type="string"/>
                                                <wtc:uparam value="<%=dealLevel %>" type="int"/>
                                                <wtc:uparam value="<%=payStatus %>" type="string"/>
                                                <wtc:uparam value="<%=backFlag %>" type="string"/>
                                                <wtc:uparam value="<%=exceptionTimes %>" type="int"/>
                                                <wtc:uparam value="<%=servOrderSeq %>" type="int"/>
                                                <wtc:uparam value="<%=isPreCreateStatus %>" type="string"/>
                                                <wtc:uparam value="<%=contactPerson %>" type="string"/>
                                                <wtc:uparam value="<%=contactPhone %>" type="string"/>
                                        </wtc:uparams>
                                        <wtc:uparams name="servOrderDataList" iMaxOccurs="1">										
												<% for(int i=0;i<0;i++){ %>
                                                <wtc:uparams name="servOrderData" iMaxOccurs="1">								
                                                        <wtc:uparam value="<%=classCode %>" type="long"/>
                                                        <wtc:uparam value="<%=arraySeq %>" type="int"/>
                                                        <wtc:uparam value="<%=classValue %>" type="string"/>
                                                </wtc:uparams>
												<% } %>
                                        </wtc:uparams>
                                        <wtc:uparams name="servOrderSlaList" iMaxOccurs="1">										
												<% for(int i=0;i<0;i++){ %>										
                                                <wtc:uparams name="servOrderSlaInfo" iMaxOccurs="1">
                                                        <wtc:uparam value="<%=srvOrderSlaId %>" type="string"/>
                                                        <wtc:uparam value="<%=slaIndexId %>" type="int"/>
                                                        <wtc:uparam value="<%=salValueSeq %>" type="int"/>
                                                        <wtc:uparam value="<%=slaValue %>" type="double"/>
                                                </wtc:uparams>
												<% } %>
                                        </wtc:uparams>
                                        <wtc:uparams name="servOrderBookingMsg" iMaxOccurs="1">												<% for(int i=0;i<0;i++){ %>		
                                                <wtc:uparam value="<%=bookSrvId %>" type="string"/>
                                                <wtc:uparam value="<%=modifyTime %>" type="string"/>
                                                <wtc:uparam value="<%=bookingTime %>" type="string"/>
											<% } %>
                                        </wtc:uparams>
                                        <wtc:uparams name="servOrderExcpInfo" iMaxOccurs="1">											
                                                <wtc:uparam value="<%=srvOrderExcpId %>" type="string"/>
                                                <wtc:uparam value="<%=excpType %>" type="int"/>
                                                <wtc:uparam value="<%=excpReason %>" type="string"/>
                                                <wtc:uparam value="<%=handleResult %>" type="string"/>
                                                <wtc:uparam value="<%=handleLogin %>" type="string"/>
                                        </wtc:uparams>
                                </wtc:uparams>
						<% } %>
                        </wtc:uparams>
                </wtc:uparams>
		<% } %>
        </wtc:uparams>
</wtc:uparams>
<wtc:uparams name="customer" iMaxOccurs="1">								
        <wtc:uparams name="custDoc" iMaxOccurs="1">								
                <wtc:uparams name="custDocBaseInfo" iMaxOccurs="1">				
                        <wtc:uparam value="<%=gCustId %>" type="long"/>
                </wtc:uparams>
        </wtc:uparams>
        <wtc:uparams name="userInfoList" iMaxOccurs="1">
				<wtc:uparams name="userInfo" iMaxOccurs="1">
						<wtc:uparams name="userBaseInfo" iMaxOccurs="1">									
                                <wtc:uparam value="<%=serviceNo %>" type="string"/>
                                <wtc:uparam value="<%=userId %>" type="long"/>
                                <wtc:uparam value="<%=brand %>" type="string"/>
                                <wtc:uparam value="<%=userNo %>" type="string"/>
                                <wtc:uparam value="<%=groupId %>" type="string"/>
								<wtc:uparam value="<%=UseCustId %>" type="long"/>
                        </wtc:uparams>
                        <wtc:uparams name="discountInfoList" iMaxOccurs="1">
						<% 
							for(int j=0;j<DiscountInfos.length;j++){ 
							%>
                                <wtc:uparams name="discountInfoListContainer" iMaxOccurs="1">													
                                        <wtc:uparams name="discountInfo" iMaxOccurs="1">										
                                                <wtc:uparam value="<%=DiscountInfos[j][0] %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][1] %>" type="string"/>
                                                <wtc:uparam value="<%=order %>" type="string"/>
                                                <wtc:uparam value="<%=custAgreementId %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][7]%>" type="string"/>
                                                <wtc:uparam value="<%=developLoginNo %>" type="string"/>
                                                <wtc:uparam value="<%=channelId %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][2] %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][3] %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][4] %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][5] %>" type="string"/>
                                                <wtc:uparam value="<%=DiscountInfos[j][6] %>" type="string"/>												
                                        </wtc:uparams>																
                                        <wtc:uparams name="discountAttrList" iMaxOccurs="1">											
						<%
							if(offer_productAttrMap.get(DiscountInfos[j][2]) != null){
								String[] discountAttrArr = ((String)offer_productAttrMap.get(DiscountInfos[j][2])).split("\\$");
								int number=discountAttrArr.length;
								if(((String)offer_productAttrMap.get(DiscountInfos[j][2])).equals(""))
								{
									number=0;
								}
								for(int jj=0;jj<number&&(discountAttrArr[jj].indexOf("~")!=-1);jj++){
								String[] offerAttrTemp = discountAttrArr[jj].split("~",2);
						%>	
                                               <wtc:uparams name="discountAttr" iMaxOccurs="-1">
																										<wtc:uparam value="1" type="string"/>
																										<wtc:uparam value="" type="string"/>
																										<wtc:uparam value="<%=offerAttrTemp[0]%>" type="string"/>
																										<wtc:uparam value="<%=offerAttrTemp[1].trim()%>" type="string"/>
																										<wtc:uparam value="" type="string"/>
																										<wtc:uparam value="10A" type="string"/>
																										<wtc:uparam value="<%=opTime%>" type="string"/>
																										<wtc:uparam value="20500101 00:00:00" type="string"/>
																								</wtc:uparams>
										<% 
										      }
										   } 
										%>
                                        </wtc:uparams>
                                        <wtc:uparams name="groupInstInfo" iMaxOccurs="1">
                                        </wtc:uparams>
                                        <wtc:uparams name="discountParamList" iMaxOccurs="1">
										<% for(int i=0;i<1;i++){ %>												
                                                <wtc:uparams name="discountParamInfo" iMaxOccurs="1">												
                                                        <wtc:uparam value="<%=operatorFlag0 %>" type="string"/>
                                                        <wtc:uparam value="<%=paramInstanceId %>" type="string"/>
                                                        <wtc:uparam value="<%=lifeCycleId %>" type="string"/>
                                                        <wtc:uparam value="<%=paramId %>" type="string"/>
                                                        <wtc:uparam value="<%=paramValue %>" type="string"/>
                                                        <wtc:uparam value="<%=paramAttrId %>" type="string"/>
                                                </wtc:uparams>
										<% } %>
                                        </wtc:uparams>
                                </wtc:uparams>
						<% } %>
                        </wtc:uparams>
                        <wtc:uparams name="userRelaInfoList" iMaxOccurs="1">
						<% for(int i=0;i<1;i++){ %>
                                <wtc:uparams name="userRelaInfo" iMaxOccurs="1">									
                                        <wtc:uparam value="<%=operatorFlag0 %>" type="string"/>
                                        <wtc:uparam value="<%=agreementId %>" type="string"/>
                                        <wtc:uparam value="<%=subUserId %>" type="long"/>
                                        <wtc:uparam value="<%=relationType %>" type="string"/>
                                        <wtc:uparam value="<%=effectDate %>" type="string"/>
                                        <wtc:uparam value="<%=expireDate %>" type="string"/>
                                </wtc:uparams>
						<% } %>
                        </wtc:uparams>
                        <wtc:uparams name="productList" iMaxOccurs="1">
						<% for(int j=0;j<1;j++){ 
							if(majorProductArr.length==5){															
															%>								
                                <wtc:uparams name="product" iMaxOccurs="1">
                                        <wtc:uparams name="productBaseInfo" iMaxOccurs="1">													
                                                <wtc:uparam value="0" type="string"/>
                                                <wtc:uparam value="<%=offeredIns%>" type="string"/>
                                                <wtc:uparam value="<%=offerSrvId%>" type="string"/>
                                                <wtc:uparam value="<%=majorProductArr[0] %>" type="string"/>
                                                <wtc:uparam value="0" type="string"/>
                                                <wtc:uparam value="<%=systemTime%>" type="string"/>
                                                <wtc:uparam value="<%=majorProductArr[1] %>" type="string"/> 
                                                <wtc:uparam value="<%=majorProductArr[2] %>" type="string"/> 
                                                <wtc:uparam value="A" type="string"/>
                                                <wtc:uparam value="<%=majorProductArr[2] %>" type="string"/>
                                                <wtc:uparam value="<%=majorProductArr[1] %>" type="string"/>
                                                <wtc:uparam value="1" type="string"/>
                                                <wtc:uparam value="0" type="string"/>
                                                <wtc:uparam value="<%=majorProductArr[3] %>" type="string"/>
                                        </wtc:uparams>										
                                        <wtc:uparams name="productAttrList" iMaxOccurs="1">
                                        </wtc:uparams>
                                        <wtc:uparams name="productGroupList" iMaxOccurs="1">
                                        </wtc:uparams>
                                </wtc:uparams>
						<%
						   } 
						}
						%>
						<%
						
							String productIArr[] = productI.split("#");
							String rowtype[] = new String[]{};
							for(int hh=0;hh<productIArr.length;hh++){
								if(!productIArr[hh].equals("")){
								
								System.out.println("--------------------------productIArr["+hh+"] ---------------------------"+productIArr[hh] );                     
								
								System.out.println("productIArr["+hh+"]|"+productIArr[hh]);
									rowtype = productIArr[hh].split("§");
									 
									
																				System.out.println("--------------------------rowtype[0] ---------------------------"+rowtype[0] );                     
									                      System.out.println("--------------------------rowtype[1] ---------------------------"+rowtype[1] );                     
									                      System.out.println("--------------------------rowtype[2] ---------------------------"+rowtype[2] );                     
									                      System.out.println("--------------------------rowtype[3] ---------------------------"+rowtype[3] );   
									                      System.out.println("--------------------------rowtype[6] ---------------------------"+rowtype[6] );                     
									                      System.out.println("--------------------------rowtype[7] ---------------------------"+rowtype[7] );                     
									                      System.out.println("--------------------------rowtype[8] ---------------------------"+rowtype[8] );                    
									                      System.out.println("--------------------------rowtype[9] ---------------------------"+rowtype[9] );                    
									                      System.out.println("--------------------------rowtype[10]---------------------------"+rowtype[10]);                    
									                      System.out.println("--------------------------rowtype[9] ---------------------------"+rowtype[9] );                    
									                      System.out.println("--------------------------rowtype[8] ---------------------------"+rowtype[8] );                    
									                      System.out.println("--------------------------rowtype[12]---------------------------"+rowtype[12]);                    
									                      System.out.println("--------------------------rowtype[13]---------------------------"+rowtype[13]);                    
									                      System.out.println("--------------------------rowtype[14]---------------------------"+rowtype[14]);   
									                     
									                       				
									
									%>
															<wtc:uparams name="product" iMaxOccurs="1">
                                        <wtc:uparams name="productBaseInfo" iMaxOccurs="1">													
                                                <wtc:uparam value="<%=rowtype[0]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[1]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[2]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[3]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[6]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[7]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[8]%>" type="string"/> 
                                                <wtc:uparam value="<%=rowtype[9]%>" type="string"/> 
                                                <wtc:uparam value="<%=rowtype[10]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[9]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[8]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[12]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[13]%>" type="string"/>
                                                <wtc:uparam value="<%=rowtype[14]%>" type="string"/>
                                        </wtc:uparams>										
                                        <wtc:uparams name="productAttrList" iMaxOccurs="1">
                                        </wtc:uparams>
                                        <wtc:uparams name="productGroupList" iMaxOccurs="1">
                                        </wtc:uparams>
                                </wtc:uparams>
									<%
								}
							}
						
						%>
						
                        </wtc:uparams>
                        <wtc:uparams name="userResList" iMaxOccurs="1">	
						<% for(int i=0;i<0;i++){ %>
                                <wtc:uparams name="userRes" iMaxOccurs="1">																
                                        <wtc:uparam value="<%=operatorFlag0 %>" type="string"/>
                                        <wtc:uparam value="<%=resType %>" type="string"/>
                                        <wtc:uparam value="<%=resSeq %>" type="string"/>
                                        <wtc:uparam value="<%=resNo %>" type="string"/>
                                </wtc:uparams>
						<% } %>
                        </wtc:uparams>
                        <wtc:uparams name="busiFeeFactorList" iMaxOccurs="1">					
						<% if(paramValueBegin!=null&&!"".equals(paramValueBegin.trim())){ %>
                                <wtc:uparams name="busiFeeFactor" iMaxOccurs="1">							
                                        <wtc:uparam value="<%=paramType %>" type="string"/>
                                        <wtc:uparam value="<%=paramCode %>" type="string"/>
                                        <wtc:uparam value="<%=paramValueBegin %>" type="string"/>
                                        <wtc:uparam value="<%=paramValueEnd %>" type="string"/>
                                        <wtc:uparam value="<%=paramObj %>" type="string"/>
										                    <wtc:uparam value="<%=offered %>" type="string"/>										
                                </wtc:uparams>
						<% } %>
                        </wtc:uparams>
                </wtc:uparams>
        </wtc:uparams>
</wtc:uparams>
</wtc:uparams>
</wtc:utype>



<%
	retrunCode=retVal.getValue(0);//返回的retCode为LONG类型；
	returnMsg=retVal.getValue(1);
	if(returnMsg!=null&&returnMsg.length()>50){
		returnMsg=returnMsg.substring(0,50);
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
							
							<%
							System.out.println("url："+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
	

var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode %>");
response.data.add("errorMsg","<%=returnMsg %>");
core.ajax.receivePacket(response);

