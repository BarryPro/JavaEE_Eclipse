 <%@ page contentType="text/html;charset=GB2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.regex.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String khType = WtcUtil.repNull(request.getParameter("khType"));
	String fszqVal = WtcUtil.repNull(request.getParameter("fszqVal"));
	System.out.println("1141~~~khType="+khType); 
	System.out.println("1104~~~fszqVal="+fszqVal); 
%>
<%
	/*
	���²�����addrTransIn newbranchnoȡ�Թ�����ַҳ���ֵ
	*/
	int hasservOrderSlaInfo = 0;
	int hasUserRelaInfo = 0;
	int hasDiscountParamInfo = 0;
	int hasUserRes = 0;
	int hasOrderBookingMsg = 0;
	int rateFlag =0;
	String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	String simCode = WtcUtil.repNull(request.getParameter("simCodeCfm"));
	//System.out.println("-------------------simCode------------------"+simCode);
	if(!simCode.equals("")){
		hasUserRes = 1;
	}

String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
String paramValue_zhaz="N";

	String selByWay = WtcUtil.repNull(request.getParameter("selByWay"));
	String bookingServTime = WtcUtil.repNull(request.getParameter("bookingServTime"));
	if(!bookingServTime.equals("")){
		hasOrderBookingMsg = 1;
	}
	String simType = WtcUtil.repNull(request.getParameter("simTypeCfm"));
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
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

	int hasAddressMsg = 1;
	String phoneNo = "0";

	String innerNoRule = WtcUtil.repNull(request.getParameter("inner_no_rule"));
	String innerNoSeq = WtcUtil.repNull(request.getParameter("inner_no_seq"));
	String serviceNo = WtcUtil.repNull(request.getParameter("selNum"));
	System.out.println("-----hejwa-------serviceNo-----selNum="+serviceNo);
	String sysAcceptl	=  WtcUtil.repNull(request.getParameter("sysAcceptl"));
	String printinfo   	=  WtcUtil.repNull(request.getParameter("path"));  //��ӡʹ�����ݴ�
	System.out.println("---------------------------printinfo------------------------"+printinfo);
	  String work_flow_no = WtcUtil.repNull(request.getParameter("work_flow_no"));
		String transJf      = WtcUtil.repNull(request.getParameter("transJf"));
    String transXyd     = WtcUtil.repNull(request.getParameter("transXyd"));
    String level4100    = WtcUtil.repNull(request.getParameter("level4100"));
    
    if(work_flow_no==null) work_flow_no = "";
    if(transJf==null) transJf = "";
    if(transXyd==null) transXyd = "";
    if(level4100==null) level4100 = "";
    
	System.out.println("---------------------------serviceNo------------------------"+printinfo);
	String mastServerType = WtcUtil.repNull(request.getParameter("mastServerType")); 
	String retnCode = "";
		System.out.println("-------------hejwa--------------innerNoRule------------------------"+innerNoRule);
		phoneNo = serviceNo;					//��serviceNo��ͬ
	 
	if(mastServerType.equals("0") || brandId.equals("3")){		//CDMAʱ,��ַ��0
		hasAddressMsg = 0;
	}
	
	String userpwd = WtcUtil.repNull(request.getParameter("userpwd"));	//�������
	//String new_custPwd1=WtcUtil.encrypt(userpwd);
	String new_custPwd = (String)Encrypt.encrypt(userpwd);
	//System.out.println("---------------------------new_custPwd-------------------------"+new_custPwd);
	String serviceGroupId = WtcUtil.repNull(request.getParameter("serviceGroupId"));	
	if(serviceGroupId.equals("")){
		serviceGroupId = groupId;
	}
	
	String printAccept = WtcUtil.repNull(request.getParameter("printAccept"));
		
	String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	//�ͻ�������
	String custOrderNo = WtcUtil.repNull(request.getParameter("custOrderNo"));	
	String prtFlag = WtcUtil.repNull(request.getParameter("prtFlag"));	
  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));		//�ͻ���������ID
  String custId = WtcUtil.repNull(request.getParameter("gCustId"));
  String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//�ͻ����񶨵���
	if(servOrderId.equals("")){
		servOrderId = "0";
	}
	
//---------------------ѡ�������Ʒ--------------------
HashMap son_Parent_Map = new HashMap();
String[] sonParentArr = new String[]{};
if(!WtcUtil.repNull(request.getParameter("sonParentArr")).equals("")){ //����Ʒ��ʶ~Ԫ��ʵ����ʶ
	sonParentArr = WtcUtil.repNull(request.getParameter("sonParentArr")).split(",");
}	
for(int i=0;i<sonParentArr.length;i++){
		String[] temp = sonParentArr[i].split("~");
		son_Parent_Map.put(temp[0],temp[1]);
}

HashMap instanceMap = new HashMap();
String[] offerAttrIdArr = new String[]{};
if(!WtcUtil.repNull(request.getParameter("offerAttrIdArr")).equals("")){
	offerAttrIdArr = WtcUtil.repNull(request.getParameter("offerAttrIdArr")).split(",");
}
String[] offerAttrValueArr = WtcUtil.repNull(request.getParameter("offerAttrValueArr")).split(",");
String offidArr1 = WtcUtil.repNull(request.getParameter("offerIdArr"));
/* ningtn ��������Ŀ*/
String newSmCode = WtcUtil.repNull(request.getParameter("newSmCode"));
if("PB".equals(newSmCode)){
	//if(serviceNo.subString(0,4).equals("147")){
	//	serviceNo = "206" + serviceNo.subString(3,serviceNo.length);
	//}else if(serviceNo.subString(0,6).equals("10648")){
	//	serviceNo = "205" + serviceNo.subString(3,serviceNo.length);
	//}
}

//System.out.println("---------------------------offidArr1------------------------"+offidArr1);

String[] offerIdArr = WtcUtil.repNull(request.getParameter("offerIdArr")).split(",");		
String[] offerEffectTime = WtcUtil.repNull(request.getParameter("offerEffectTime")).split(",");
String[] offerExpireTime = WtcUtil.repNull(request.getParameter("offerExpireTime")).split(",");
String[] discountPlanInstId = new String[offerIdArr.length]; //����Ʒʵ����ID
for(int i=0;i<offerIdArr.length;i++){
%>
<wtc:service name="sDynSqlCfm" outnum="1">
	<wtc:param value="13"/>
</wtc:service>	
<wtc:array id="rows" scope="end" />
<%
	if(retCode.equals("000000")&&rows.length > 0){	//��������Ʒʵ����ID������Ӧ������Ʒ����hashmap��
		discountPlanInstId[i] = rows[0][0];
		instanceMap.put(offerIdArr[i],discountPlanInstId[i]);
	}	
}
HashMap groupInfoMap = new HashMap();

String[] allGroupInfo = new String[]{};	//ȡ��������ƷȺ����Ϣ
if(!WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).equals("")){
	allGroupInfo = WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).split("\\^");
}
for(int i=0;i<allGroupInfo.length;i++){
	String[] offerGroupInfo = allGroupInfo[i].split("\\|");
	groupInfoMap.put(offerGroupInfo[0],offerGroupInfo[1]);
}

String[] addGroupIdArrry = new String[]{};	//��ϲ�Ʒ�����Ŀ�ѡȺ����Ϣ
if(!WtcUtil.repNull(request.getParameter("addGroupIdArr")).equals("")){
	addGroupIdArrry = WtcUtil.repNull(request.getParameter("addGroupIdArr")).split(",");
}
//--------------------------ѡ��Ĳ�Ʒ---------------------
String[] prodIdArr = WtcUtil.repNull(request.getParameter("productIdArr")).split(",");
String[] prodEffectDate = WtcUtil.repNull(request.getParameter("prodEffectDate")).split(",");
String[] prodExpireDate = WtcUtil.repNull(request.getParameter("prodExpireDate")).split(",");
String[] isMainProduct = WtcUtil.repNull(request.getParameter("isMainProduct")).split(",");
for(int i=0;i<isMainProduct.length;i++){
}

String[] prodAttrIdArr = new String[]{};
if(!WtcUtil.repNull(request.getParameter("prodAttrIdArr")).equals(""))
{
   prodAttrIdArr = WtcUtil.repNull(request.getParameter("prodAttrIdArr")).split(",");
}
String[] prodAttrValueArr = WtcUtil.repNull(request.getParameter("prodAttrValueArr")).split(",");

//--------------------����Ʒ,��Ʒ������Ϣ------------
HashMap offer_productAttrMap = new HashMap();
String[] offer_productAttrInfoArr = new String[]{};	//ȡ���в�Ʒ������Ϣ
if(!WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).equals("")){
	offer_productAttrInfoArr = WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).split("\\^");
}
for(int i=0;i<offer_productAttrInfoArr.length;i++){
	String[] offer_productAttrArr = offer_productAttrInfoArr[i].split("\\|");
	if(offer_productAttrArr.length > 1)
		offer_productAttrMap.put(offer_productAttrArr[0],offer_productAttrArr[1]);
}

//--------------------------��������Ϣ-----------------------
int hasVouchInfo = 1;			//�Ƿ��е�������Ϣ���
String vouch_idType = WtcUtil.repNull(request.getParameter("vouch_idType"));
String vouch_idNo = WtcUtil.repNull(request.getParameter("vouch_idNo"));
if(vouch_idType.equals("") && vouch_idNo.equals("")){
	hasVouchInfo = 0;
}

//--------------------------��������Ϣ-----------------------
int hasAgentInfo = 1;
String agent_idType = WtcUtil.repNull(request.getParameter("agent_idType"));
String agent_idNo = WtcUtil.repNull(request.getParameter("agent_idNo"));
if(agent_idType.equals("") && agent_idNo.equals("")){
	hasAgentInfo = 0;
}
//--------------------------��չ����Ϣ-----------------------
int hasDevelopInfo = 1; 
String develop_name = WtcUtil.repNull(request.getParameter("develop_name"));
String develop_idNo = WtcUtil.repNull(request.getParameter("develop_idNo"));
if(develop_name.equals("") && develop_idNo.equals("")){
	hasDevelopInfo = 0;
}

//--------------------------SLA��Ϣ-----------------------
String[] servslaArr = new String[]{};	//ȡ���в�Ʒ������Ϣ
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
	if(retCode.equals("000000") && result.length > 0){	//����addressId
		addressId = result[0][0];
}

String userType = WtcUtil.repNull(request.getParameter("userType")); 	//�û�����
if(userType.equals("")){
  userType = "00";
}
String stopId = WtcUtil.repNull(request.getParameter("stopId")); 	//��ͣ��־
String controlType = WtcUtil.repNull(request.getParameter("controlType")); 	//���ÿ���
String attrCode = userType+"000Y"+stopId;
//System.out.println("------------------------attrCode-------------------------"+attrCode);
int isBatch = 0;
String batchFlag = "0";	//������־
String enterType = WtcUtil.repNull(request.getParameter("enterType"));	//�������ͱ�ʶ,0:����;1:����
if(enterType.equals("1")){
	batchFlag = "1";
}
//-----------------��������-----------------------
String[] phoneNoArr = new String[]{};
if(!WtcUtil.repNull(request.getParameter("phoneNoStr")).equals("")){
	phoneNoArr = WtcUtil.repNull(request.getParameter("phoneNoStr")).split("~");
}
if(WtcUtil.repNull(request.getParameter("selNum")).indexOf("~") != -1){
	batchFlag = "1";
	enterType = "1";
	phoneNoArr = WtcUtil.repNull(request.getParameter("selNum")).split("~");
}
String[] simNoArr = new String[]{};
if(!WtcUtil.repNull(request.getParameter("simNoStr")).equals("")){
	simNoArr = WtcUtil.repNull(request.getParameter("simNoStr")).split("~");
}
String openType = WtcUtil.repNull(request.getParameter("openType")); //������ʽ
String innetType = WtcUtil.repNull(request.getParameter("innetType")); 

//System.out.println("-------------------------innetType---------------------------------"+innetType);
//----------------�ͷź����������-----------
	String branchNo = WtcUtil.repNull(request.getParameter("newbranchno"));
	String prodIdForRel = mastServerType;	//ѡ����,�����������
	String objectId1 = (String) session.getAttribute("objectId");//ѡ����
	String workFormId = orderArrayId;//ѡ����  ��������ID
	String svcInstId = "";//ѡ���� idNo ����Ϊ��
	
	String ispostFlag = WtcUtil.repNull(request.getParameter("isPost")); 
	
	String is_not_adward = WtcUtil.repNull(request.getParameter("is_not_adward")); 	//��������
	String largess_card = WtcUtil.repNull(request.getParameter("largess_card")); 	//���ͳ�ֵ��
	String cardTypeN = WtcUtil.repNull(request.getParameter("cardTypeN")); 	//�տ�����
	String cardstatus = WtcUtil.repNull(request.getParameter("cardstatus")); 	//�ظ��˱�־
	String yzID = WtcUtil.repNull(request.getParameter("yzID")); 	//�տ�����
	String firstId = WtcUtil.repNull(request.getParameter("firstId")); 	//2011/12/14	wanghfa���	¼�����֤	1��¼��	0��δ¼��
	String userName = WtcUtil.repNull(request.getParameter("userName")); 	//2011/12/14	wanghfa���	�û�����	��ʵ����֤��
	
	String isGPhoneFlag = WtcUtil.repNull(request.getParameter("isGPhoneFlag")); 	//������������
	String isGPhoneDate = WtcUtil.repNull(request.getParameter("isGPhoneDate")); 	//��������ʱ��
	
	System.out.println("---------mylog----------isGPhoneFlag-----------"+isGPhoneFlag);
	
	
	  String isGoodNo    = (String)request.getParameter("isGoodNo"); 
		String OperateFlag = (String)request.getParameter("OperateFlag");
		String contractNo  = (String)request.getParameter("contractNo");
		String postType    = (String)request.getParameter("postType"); 
		String postAdd     = (String)request.getParameter("postAdd");
		String postZip     = (String)request.getParameter("postZip");
		String postFax     = (String)request.getParameter("postFax");
		String postMail    = (String)request.getParameter("postMail");
		String postName    = (String)request.getParameter("postName"); 
		 
%>
					
<script language='JavaScript'>
//----------------�ͷź�������JS����-----------
	var branchNo = '<%=branchNo%>';
	var objectId = '<%=objectId1%>';
	var prodId = '<%=prodIdForRel%>';
</script>	

<%
UType ctrlInfoUtype = new UType();
  ctrlInfoUtype.setUe("STRING",batchFlag);

  UType batchDataListUtype = new UType();

	if(enterType.equals("1")){
	isBatch = 1;
		for(int i=0;i<phoneNoArr.length;i++){
	
    UType batchDataUtype = new UType();
      batchDataUtype.setUe("LONG","0");
      batchDataUtype.setUe("STRING",phoneNoArr[i]);
		
			if(simNoArr.length == phoneNoArr.length && simNoArr[i] != null){
			
      batchDataUtype.setUe("STRING",simNoArr[i]);
		
			}
			else{
      batchDataUtype.setUe("STRING","0");
			}
      batchDataListUtype.setUe(batchDataUtype);
		}
	}	
	

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
          System.out.println("1---------------------custOrderId-------------------"+custOrderId);
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
                  System.out.println("3-----hejwa------------servOrderId-----------------------"+servOrderId);
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("LONG","0");
                  servOrderMsgUtype.setUe("STRING",serviceNo);
                  //System.out.println("4---------------------hejwa-------------------"+serviceNo);
                  servOrderMsgUtype.setUe("INT","0");
                  servOrderMsgUtype.setUe("INT","0");
                  servOrderMsgUtype.setUe("LONG",addressId);
                  //System.out.println("5----------------------------------------"+addressId);
                  servOrderMsgUtype.setUe("INT","110");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("INT","0");
                  System.out.println("---------------------request.getParameter(servBusiId)------------------------"+request.getParameter("servBusiId"));
                  servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("servBusiId")));
                  //System.out.println("6----------------------------------------"+WtcUtil.repNull(request.getParameter("servBusiId")));
                  servOrderMsgUtype.setUe("STRING","N");
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("finishLimitTime")));
                  //System.out.println("7----------------------------------------"+WtcUtil.repNull(request.getParameter("finishLimitTime")));
                  servOrderMsgUtype.setUe("STRING","0");
                  servOrderMsgUtype.setUe("INT",WtcUtil.repNull(request.getParameter("dealLevel")));
                  //System.out.println("8----------------------------------------"+WtcUtil.repNull(request.getParameter("dealLevel")));
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
                    servOrderDataUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceOrderGroupId")));
                    System.out.println("11------hejwa----------------------------------"+WtcUtil.repNull(request.getParameter("serviceOrderGroupId")));
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
							
								if(hasOrderBookingMsg == 1){
							
                  servOrderBookingMsgUtype.setUe("STRING","0");
                  servOrderBookingMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("bookingServTime")));
                  //System.out.println("14----------------------------------------"+WtcUtil.repNull(request.getParameter("bookingServTime")));
                  servOrderBookingMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("bookingServTime")));
                  //System.out.println("15----------------------------------------"+WtcUtil.repNull(request.getParameter("bookingServTime")));
							
								}
								
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
              userBaseInfoUtype.setUe("STRING",serviceNo);
              userBaseInfoUtype.setUe("LONG","0");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("brandId")));
              userBaseInfoUtype.setUe("STRING","I");
              userBaseInfoUtype.setUe("DOUBLE",WtcUtil.repNull(request.getParameter("limitOwe")));
              userBaseInfoUtype.setUe("LONG",WtcUtil.repNull(request.getParameter("contractNo")));
              userBaseInfoUtype.setUe("LONG",custId);
              //System.out.println("21----------------------------------------"+custId);
              userBaseInfoUtype.setUe("STRING",phoneNo);
              System.out.println("22-------------hejwa---------------------------"+phoneNo);
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
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("userGroupId")));
              //System.out.println("23-----------------------------------------------"+WtcUtil.repNull(request.getParameter("userGroupId")));
              userBaseInfoUtype.setUe("STRING","N");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("billModeCd")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("userName")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("areaId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("openType")));
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("addCmgr")));
              userBaseInfoUtype.setUe("STRING","N");
              userBaseInfoUtype.setUe("STRING","01");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceManagerId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("innetScheme")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("saleMode")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("imeiNo")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("goodType")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("chargeGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("installGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("maintGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("sellGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("devGroupId")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("innetType")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("portInReason")));
              userInfoUtype.setUe(userBaseInfoUtype);
            UType userAddrMsgUtype = new UType();
				
					if(hasAddressMsg == 1){
					
              userAddrMsgUtype.setUe("STRING","1");
              userAddrMsgUtype.setUe("LONG",addressId);
              userAddrMsgUtype.setUe("INT","0");
              userAddrMsgUtype.setUe("INT",WtcUtil.repNull(request.getParameter("newbranchno")));
              userAddrMsgUtype.setUe("INT",groupId);
              userAddrMsgUtype.setUe("STRING",currentTime);
              userAddrMsgUtype.setUe("STRING","20500101 00:00:00");
              UType addrMsgUtype = new UType();
                addrMsgUtype.setUe("LONG",addressId);
                addrMsgUtype.setUe("INT",WtcUtil.repNull(request.getParameter("AddrSelect")));
                addrMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("addrTransIn")));
                addrMsgUtype.setUe("STRING","0");
                addrMsgUtype.setUe("STRING","");
                addrMsgUtype.setUe("STRING","000000");
                addrMsgUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("houseType")));
                userAddrMsgUtype.setUe(addrMsgUtype);
					
					}else{		//��Ϊ1ʱΪ������,��Ʒ��Ҫ��,��ҪΪ�ų���ֵ
						
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
					
					}
					
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
									for(int j=6;j<groupInstBaseInfo.length;j++){		//��6����ʼ��Ϊ������Ϣ
									//System.out.println(j+"------------Ⱥ���������Ϣ===="+groupInstBaseInfo[j]);	
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
											for(int j=10;j<memberAttrInfoArr.length;j++){		//��10����ʼ��Ϊ������Ϣ
											//System.out.println(j+"------------��Ա��������Ϣ===="+memberAttrInfoArr[j]);	
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
							
							if(hasDiscountParamInfo == 1){
							
                  UType discountParamInfoUtype = new UType();
                    discountParamInfoUtype.setUe("STRING","1");
                    discountParamInfoUtype.setUe("STRING","38");
                    discountParamInfoUtype.setUe("STRING","39");
                    discountParamInfoUtype.setUe("STRING","40");
                    discountParamInfoUtype.setUe("STRING","41");
                    discountParamInfoUtype.setUe("STRING","42");
                    discountParamListUtype.setUe(discountParamInfoUtype);
							}
                  discountInfoListContainerUtype.setUe(discountParamListUtype);
                discountInfoListUtype.setUe(discountInfoListContainerUtype);
					}
              userInfoUtype.setUe(discountInfoListUtype);
            UType userCreditListUtype = new UType();
              userCreditListUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("controlType")));
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
					
					if(hasAgentInfo == 1){
					
              UType userContactInfoListUtype1 = new UType();
                userContactInfoListUtype1.setUe("STRING","ADD");
                userContactInfoListUtype1.setUe("INT","2");
                userContactInfoListUtype1.setUe("INT","1");
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("agent_name")));
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("agent_phone")));
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("agent_phone")));
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("agent_idType")));
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("agent_idNo")));
                userContactInfoListUtype.setUe(userContactInfoListUtype1);
					}	
					
					if(hasDevelopInfo == 1){
					
              UType userContactInfoListUtype1 = new UType();
                userContactInfoListUtype1.setUe("STRING","ADD");
                userContactInfoListUtype1.setUe("INT","3");
                userContactInfoListUtype1.setUe("INT","1");
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("develop_name")));
                userContactInfoListUtype1.setUe("STRING","0");
                userContactInfoListUtype1.setUe("STRING","0");
                userContactInfoListUtype1.setUe("STRING","9");
                userContactInfoListUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("develop_idNo")));
                userContactInfoListUtype.setUe(userContactInfoListUtype1);
					}	
              userInfoUtype.setUe(userContactInfoListUtype);
            UType userRelaInfoListUtype = new UType();
					
					if(hasUserRelaInfo == 1){
					
              UType userRelaInfoUtype = new UType();
                userRelaInfoUtype.setUe("STRING","ADD");
                userRelaInfoUtype.setUe("STRING","11211");
                userRelaInfoUtype.setUe("LONG","111222");
                userRelaInfoUtype.setUe("STRING","1");
                userRelaInfoUtype.setUe("STRING","20081005 00:00:00");
                userRelaInfoUtype.setUe("STRING","20081005 00:00:00");
                userRelaInfoListUtype.setUe(userRelaInfoUtype);
					
					}
					
              userInfoUtype.setUe(userRelaInfoListUtype);
            UType productListUtype = new UType();
				
					for(int i=0;i<prodIdArr.length;i++){
					String parentProdInstId = "0";
					String parentId = (String)son_Parent_Map.get(prodIdArr[i]);
					/*
					if(parentId.equals(offerIdArr[0])){	//����Ǹ��Ӳ�Ʒ,�������ϼ���Ʒʵ��ID��Ϊ1
						parentProdInstId = "1";
					}
					*/
				//System.out.println(prodIdArr[i]+"---->parentId-->"+parentId+"-------------------->"+parentProdInstId);	
					String parentInstId = (String)instanceMap.get(parentId);
					if(parentInstId == null){
						parentInstId = "0";
					}
					String isCompFlag = "0";
					if(isMainProduct[i].equals("1")){	//������Ʒ�ĸ��ϱ�ʶ��Ϊ1
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
									//System.out.println("��ƷID"+prodIdArr[i]+"--->��Ʒ����ID="+prodAttrTemp[0]+"------>����VALE="+prodAttrTemp[1].trim()+"-");	
							
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
                  acctRelaBaseUtype.setUe("LONG",WtcUtil.repNull(request.getParameter("contractNo")));
                  acctRelaBaseUtype.setUe("LONG","99999999");
                  acctRelaBaseUtype.setUe("LONG","0");
                  acctRelaBaseUtype.setUe("DOUBLE","0");
                  acctRelaBaseUtype.setUe("STRING","N");
                  acctRelaBaseUtype.setUe("STRING","Y");
                  acctRelaBaseUtype.setUe("STRING","20081005 00:00:00");
                  acctRelaBaseUtype.setUe("STRING","20081005 00:00:00");
                  acctRelaUtype.setUe(acctRelaBaseUtype);
                UType acctRateListUtype = new UType();
							
							if(rateFlag == 1){
							
                  UType acctRateUtype = new UType();
                    acctRateUtype.setUe("STRING","ADD");
                    acctRateUtype.setUe("STRING","000");
                    acctRateUtype.setUe("STRING","e164c");
                    acctRateUtype.setUe("LONG","0");
                    acctRateUtype.setUe("DOUBLE","0.60");
                    acctRateListUtype.setUe(acctRateUtype);
							
							}
							
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
				
					if(hasUserRes ==1){																//�ƶ�
					
              UType userResUtype1 = new UType();
                userResUtype1.setUe("STRING","1");
                userResUtype1.setUe("STRING","1");
                userResUtype1.setUe("STRING","0");
                userResUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("simCodeCfm")));
                userResListUtype.setUe(userResUtype1);
				
					}
					if(isBatch ==1 && mastServerType.equals("0")){			//���������ƶ�
					
              UType userResUtype1 = new UType();
                userResUtype1.setUe("STRING","1");
                userResUtype1.setUe("STRING","1");
                userResUtype1.setUe("STRING","0");
                userResUtype1.setUe("STRING","0");
                userResListUtype.setUe(userResUtype1);
				
					}
					
				userInfoUtype.setUe(userResListUtype);
              
//2010-7-7 9:04 wanghfa�޸� ��ͨ�����������ⱨ���з��õ��޸� start
				boolean isTT = false;
				String searchSql = "select count(*) from dloginmsg a,dchngroupmsg b where a.GROUP_ID=b.group_id and b.class_code='200' and a.login_no = '" + workNo + "'";
%>
				<wtc:pubselect name="sPubSelect" outnum="1" retcode="retCode2" retmsg="retMsg2">
					<wtc:sql><%=searchSql%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result2" scope="end"/>
<%
				if ((!"0".equals(result2[0][0])) && (phoneNo.substring(0,3).equals("451") || phoneNo.substring(0,3).equals("045") || phoneNo.substring(0,3).equals("046"))) {
					isTT = true;
					System.out.println("============wanghfa=============�Ƿ�Ϊ��ͨ������ ��");
				} else {
					isTT = false;
					System.out.println("============wanghfa=============�Ƿ�Ϊ��ͨ������ ��");
				}
				if (!isTT) {
					UType busiFeeFactorListUtype = new UType();
            

					UType busiFeeFactorUtype = new UType();
	                busiFeeFactorUtype.setUe("STRING","Z");
	                busiFeeFactorUtype.setUe("STRING","Z1");
							
								if(isBatch == 1){													//����ʱserviceNoΪ��,��Ϊ�ǿ��ֶ�,�����Ĭ��ֵ
							
	                busiFeeFactorUtype.setUe("STRING","11001");
							
							}else{
							
	                busiFeeFactorUtype.setUe("STRING",serviceNo);
							}	
	                busiFeeFactorUtype.setUe("STRING","1");
	                busiFeeFactorUtype.setUe("STRING","1");
	                //busiFeeFactorUtype.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype);
				
						
						//System.out.println("-----------------------------------simType--------------------------"+simType);
						//System.out.println("-------------------hasUserRes---------------------------------------"+hasUserRes);
						if(hasUserRes == 1&&(!simType.equals(""))){
							if(!cardstatus.equals("3")){
	              UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","C");
	                busiFeeFactorUtype1.setUe("STRING","C0");
	                busiFeeFactorUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("simTypeCfm")));
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
							}else{
								UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","C");
	                busiFeeFactorUtype1.setUe("STRING","C0");
	                busiFeeFactorUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("simTypeCfm")));
	                busiFeeFactorUtype1.setUe("STRING","3");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
								}
						}
						
						if(isBatch ==1 && mastServerType.equals("0")){			//���������ƶ�
	              UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","C");
	                busiFeeFactorUtype1.setUe("STRING","C0");
	                busiFeeFactorUtype1.setUe("STRING","0");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
						
						}
						if(innetType.equals("03")){			//�������
							
	              UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","C");
	                busiFeeFactorUtype1.setUe("STRING","C2");
	                busiFeeFactorUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("saleMode")));
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
						
						}
						if(innetType.equals("04")){			//��������
							if("1".equals(isGoodNo)){
	              UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","C");
	                busiFeeFactorUtype1.setUe("STRING","C3");
	                busiFeeFactorUtype1.setUe("STRING",phoneNo);
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
						    }
						}
						
	              UType busiFeeFactorUtype1 = new UType();
	                busiFeeFactorUtype1.setUe("STRING","F");
	                busiFeeFactorUtype1.setUe("STRING","F1");
	                //busiFeeFactorUtype1.setUe("STRING",WtcUtil.repNull(request.getParameter("openType")));
	                busiFeeFactorUtype1.setUe("STRING","01");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                busiFeeFactorUtype1.setUe("STRING","1");
	                //busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
	                busiFeeFactorUtype1.setUe("STRING","");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
	                
            	  userInfoUtype.setUe(busiFeeFactorListUtype);
				} else if (isTT) {
					UType busiFeeFactorListUtype = new UType();
					UType busiFeeFactorUtype = new UType();
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorUtype.setUe("STRING","0");
	                busiFeeFactorListUtype.setUe(busiFeeFactorUtype);
					userInfoUtype.setUe(busiFeeFactorListUtype);
				}
//2010-7-7 9:04 wanghfa�޸� ��ͨ�����������ⱨ���з��õ��޸� end

			//- ����utype�ڵ� hejwa 2009-8-5 9:48-
			
			
            UType UserExtMsgListUtype = new UType();
            
            System.out.println("---------------------is_not_adward-----------------"+is_not_adward);
            if(is_not_adward.equals("Y")){ //��������
              UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20010");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","1");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            }
            /*
            else{
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20010");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","0");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	}
            	*/
            if(largess_card.equals("Y")){ //���ͳ�ֵ��
              UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20011");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","1");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            }
            	/*��ɢ���� 20121128 gaopeng ���ڽ���NGBOSS2-BOSS(V3.5)֮��ɢ����֧�ŷֲ�ʵʩ������ start*/
			if(!"".equals(fszqVal)){
							UType UserExtMsgUtype34= new UType();  
									UserExtMsgUtype34.setUe("LONG","20199");
									UserExtMsgUtype34.setUe("INT","0");  
									UserExtMsgUtype34.setUe("STRING",fszqVal);
									UserExtMsgListUtype.setUe(UserExtMsgUtype34);
									}
			/*��ɢ���� 20121128 gaopeng ���ڽ���NGBOSS2-BOSS(V3.5)֮��ɢ����֧�ŷֲ�ʵʩ������ end*/	
            /*
            else{
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20011");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","0");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	}
            	*/
            	
            	if(cardstatus.equals("3")){
	            	UType UserExtMsgUtype = new UType();
	                UserExtMsgUtype.setUe("LONG","20014");
	                UserExtMsgUtype.setUe("INT","0");
	                UserExtMsgUtype.setUe("STRING",cardstatus);
	                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            	}

            	if(cardTypeN.equals("1")){
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20012");
                UserExtMsgUtype.setUe("INT","0");
                UserExtMsgUtype.setUe("STRING","1");
                UserExtMsgListUtype.setUe(UserExtMsgUtype);
            }else{
            	UType UserExtMsgUtype = new UType();
                UserExtMsgUtype.setUe("LONG","20012");
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
          System.out.println("mylog--------------pƴ�����Ľڵ�--------------innetType--------"+innetType); 
           /**�����������ʱ��Զ�����������
           ��ͨ���벻���������ʱ��ƴ����ڵ㡣
           ���� �������ֿ���ѡ���������ʱ����Ҫƴ�˽ڵ�
           hejwa upd 2010��5��17��13:41:38
           */System.out.println("mylog--------------pƴ�����Ľڵ�--------------isGPhoneDate-------"+isGPhoneDate);
          if(isGPhoneFlag.trim().equals("N")){
          	System.out.println("mylog--------------pƴ�����Ľڵ�--------------isGPhoneDate-------"+isGPhoneDate);
           	UType UserExtMsgUtypeh = new UType();
                	UserExtMsgUtypeh.setUe("LONG","20015");
                	UserExtMsgUtypeh.setUe("INT","1");
               	  UserExtMsgUtypeh.setUe("STRING",isGPhoneDate);
                	UserExtMsgListUtype.setUe(UserExtMsgUtypeh);
          }   	

					//2011/12/14 wanghfa���	ƴ���û��Ƿ�¼�����֤�������ж�ʵ����	start
					System.out.println("====wanghfa====ƴ�ڵ�:�Ƿ�¼�����֤==== firstId = " + firstId);
					UType UserExtMsgUtypeFirstId = new UType();
					UserExtMsgUtypeFirstId.setUe("LONG","20191");
					UserExtMsgUtypeFirstId.setUe("INT","0");
					if(firstId.trim().equals("")){
						UserExtMsgUtypeFirstId.setUe("STRING", "0");
					} else {
						UserExtMsgUtypeFirstId.setUe("STRING", "1");
					}
					UserExtMsgListUtype.setUe(UserExtMsgUtypeFirstId);
					System.out.println("====wanghfa====ƴ�ڵ�:�û�����Ϊ����ʱ��������ʱ�ʻ���������ʱ�˻�������xx���족��ȫΪ���֣�ֻ��һ������==== userName = " + userName);
					UType UserExtMsgUtypeUrNameLinshi = new UType();
					UserExtMsgUtypeUrNameLinshi.setUe("LONG","20192");
					UserExtMsgUtypeUrNameLinshi.setUe("INT","0");
					//Pattern p = Pattern.compile(".*����");
					Pattern p = Pattern.compile("(��ʱ|��ʱ�ʻ�|��ʱ�˻�|.*����|[0-9]+|[\\u4e00-\\u9fa5])");
					System.out.println("====wanghfa==== 20192 " + p.matcher(userName).matches());
					if(p.matcher(userName).matches() ) {
						System.out.println("====wanghfa==== 1");
						UserExtMsgUtypeUrNameLinshi.setUe("STRING", "1");
					} else {
						System.out.println("====wanghfa==== 0");
						UserExtMsgUtypeUrNameLinshi.setUe("STRING", "0");
					}
					UserExtMsgListUtype.setUe(UserExtMsgUtypeUrNameLinshi);
					
					System.out.println("====wanghfa====ƴ�ڵ�:�û����������ֻ���ĸ==== userName = " + userName);
					UType UserExtMsgUtypeUrNameNo = new UType();
					UserExtMsgUtypeUrNameNo.setUe("LONG","20193");
					UserExtMsgUtypeUrNameNo.setUe("INT","0");
					p = Pattern.compile(".*[0-9a-zA-Z]+.*");
					System.out.println("====wanghfa==== 20193 " + p.matcher(userName).matches());
					if(p.matcher(userName).matches()) {
						System.out.println("====wanghfa==== 1");
						UserExtMsgUtypeUrNameNo.setUe("STRING", "1");
					} else {
						System.out.println("====wanghfa==== 0");
						UserExtMsgUtypeUrNameNo.setUe("STRING", "0");
					}
					UserExtMsgListUtype.setUe(UserExtMsgUtypeUrNameNo);
					//2011/12/14 wanghfa���	ƴ���û��Ƿ�¼�����֤�������ж�ʵ����	end
             		UType UserExtMsgUtypeKhType = new UType();
					UserExtMsgUtypeKhType.setUe("LONG","20194");
					UserExtMsgUtypeKhType.setUe("INT","0");
					UserExtMsgUtypeKhType.setUe("STRING",khType);
					UserExtMsgListUtype.setUe(UserExtMsgUtypeKhType);                 
             
              userInfoUtype.setUe(UserExtMsgListUtype);
              

            UType UserAgreementMsgUtype = new UType();
              userInfoUtype.setUe(UserAgreementMsgUtype);
            UType UserPostUtype = new UType();
					if(ispostFlag.equals("0")){
              UserPostUtype.setUe("STRING",OperateFlag);
              UserPostUtype.setUe("LONG",contractNo);
              UserPostUtype.setUe("STRING",ispostFlag);
              UserPostUtype.setUe("STRING",postType);
              UserPostUtype.setUe("STRING",postAdd);
              UserPostUtype.setUe("STRING",postZip);
              UserPostUtype.setUe("STRING",postFax);
              UserPostUtype.setUe("STRING",postMail);
              UserPostUtype.setUe("STRING",postName);
              UserPostUtype.setUe("INT","");
              UserPostUtype.setUe("STRING","");
              UserPostUtype.setUe("INT","");
				  }
              userInfoUtype.setUe(UserPostUtype);
			//- ����utype�ڵ���� -			
							
            userInfoListUtype.setUe(userInfoUtype);
          customerUtype.setUe(userInfoListUtype);
        msgBodyTypeUtype.setUe(customerUtype);



	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(ctrlInfoUtype,1,"2",logBuffer);		
	System.out.println("\r\n\r\n\r\n\r\n\r\n--------------------------------��ͥ�����ڵ�-----------ctrlInfoUtype--------------\r\n");
	System.out.println(logBuffer.toString());
	System.out.println("\r\n--------��ͥ�����ڵ�--------------------------ctrlInfoUtype--------------\r\n\r\n\r\n\r\n\r\n");

	StringBuffer logBuffer1 = new StringBuffer(80);
	WtcUtil.recursivePrint(batchDataListUtype,1,"2",logBuffer1);		
	System.out.println("\r\n\r\n\r\n\r\n\r\n--------------------------------��ͥ�����ڵ�-----------batchDataListUtype--------------\r\n");
	System.out.println(logBuffer1.toString());
	System.out.println("\r\n--------��ͥ�����ڵ�--------------------------batchDataListUtype--------------\r\n\r\n\r\n\r\n\r\n");
	
	StringBuffer logBuffer2 = new StringBuffer(80);
	WtcUtil.recursivePrint(msgBodyTypeUtype,1,"2",logBuffer2);		
	System.out.println("\r\n\r\n\r\n\r\n\r\n--------------------------------��ͥ�����ڵ�-----------msgBodyTypeUtype--------------\r\n");
	System.out.println(logBuffer2.toString());
	System.out.println("\r\n--------��ͥ�����ڵ�--------------------------msgBodyTypeUtype--------------\r\n\r\n\r\n\r\n\r\n");
		
	%>
	
<%String regionCode_sCBatMultiUser = (String)session.getAttribute("regCode");%>
<wtc:utype name="sCBatMultiUser" id="retVal"  routerKey="region" routerValue="<%=regionCode_sCBatMultiUser%>">
	<wtc:uparam value="<%=ctrlInfoUtype%>" type="UTYPE"/> 
	<wtc:uparam value="<%=batchDataListUtype%>" type="UTYPE"/>
	<wtc:uparam value="<%=msgBodyTypeUtype%>" type="UTYPE"/>
</wtc:utype>


<%

 
%>

<%@ include file="/npage/common/qcommon/realseNumber.jsp" %> 		
<%
	String retrunCode=String.valueOf(retVal.getValue(0));//���ص�retCodeΪLONG���ͣ�
	String returnMsg=retVal.getValue(1);
	System.out.println("# from confm_new.jsp -> retCode = "+retrunCode + ",retMsg = "+returnMsg);
	
	
if(retrunCode.equals("0"))
		{
%>
            <script language='JavaScript'>
function goNext(custOrderId,custOrderNo,prtFlag)
{
	//alert("goNext#custOrderId|"+custOrderId+"\ncustOrderNo|"+"\nprtFlag|"+prtFlag);
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
  /***����������Ҫ�õ��Ĺ��˺���**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
function dnyCreatDiv(login_accept,printinfo){
	var newE = parent.document.createElement("DIV");
    
    newE.id = login_accept;
    newE.printinfo=printinfo;
    newE.style.display = "none";
    parent.document.appendChild(newE);
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
	  	var closeId=orderArrayId+servOrderId;
	  	if("<%=paramValue_zhaz%>" == "Y"){
		  	parent.parent.checkHasBill(funciton_code);
		  	if(parent.parent.hasBill == "N"){
			   		rdShowMessageDialog("������δ��������,���ܽ���ҵ�����!",0);
			   		parent.parent.addTab(true,"r615","ӪҵԱ����ͳ�Ʊ���","../rpt_new/f1615.jsp");
			   		return false;
			   }
			   if(parent.parent.todayHasBill == "Y"){
			   		rdShowMessageDialog("�������Ѿ��������,���ܽ���ҵ�����!",0);
			   		return false;
			   }
	  	}
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	var path="/npage/"+pageUrl+"?gCustId=<%=gCustId%>"
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
	  							+"&oldMSISDN=<%=work_flow_no%>";
 		dnyCreatDiv("<%=gCustId%>","<%=printinfo%>");
		parent.addTab(false,closeId,funciton_name,path);
	 			
	  }else{
	  		alert("��������ʧ��!");
	  }
}
		
                //rdShowMessageDialog("�����ɹ���",2);
                goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
            </script>            
<%		}else
        {
%>
            <script language='JavaScript'>
                rdShowMessageDialog("����ʧ�ܣ��������:"+'<%=retrunCode%>',0);
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
<script language="JavaScript">
//�����Ҽ�
document.oncontextmenu=new Function("event.returnValue=false");
	function backSpaceKeydown()
	{
		/*����backspace��ESC*/
	    if(event.keyCode==27){
	       event.returnValue = null;
	    }
	    if(event.keyCode==8){
	       event.returnValue = null;
	    }
	}
	document.onkeydown=backSpaceKeydown;
</script>