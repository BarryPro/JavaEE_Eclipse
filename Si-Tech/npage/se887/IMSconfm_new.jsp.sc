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
	String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	String offerType = WtcUtil.repNull(request.getParameter("offerType"));
  String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
  String paramValue_zhaz="N";
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
  System.out.println("��ǰʱ��=="+currentTime);
  System.out.println("groupId========"+groupId);
  
	String phoneNo = "0";
	String serviceNo = WtcUtil.repNull(request.getParameter("phoneNo"));;
	String sysAcceptl	=  WtcUtil.repNull(request.getParameter("sysAcceptl"));
	String printinfo   	=  WtcUtil.repNull(request.getParameter("path"));  //��ӡʹ�����ݴ�
	System.out.println("---------------------------printinfo------------------------"+printinfo);
	String work_flow_no = WtcUtil.repNull(request.getParameter("work_flow_no"));//4603  ������ 4100 ԭ�ֻ���
	String phoneNo_h   = WtcUtil.repNull((String)request.getParameter("phoneNo"));  //�û����� 	 
	if(work_flow_no==null) work_flow_no = "";
	String mastServerType = WtcUtil.repNull(request.getParameter("mastServerType")); 
	String retnCode = "";
		phoneNo = phoneNo_h;
	
	String userpwd = WtcUtil.repNull(request.getParameter("userpwd"));	//�������
	String new_custPwd = (String)Encrypt.encrypt(userpwd);
	String cfmPwd = WtcUtil.repNull((String)request.getParameter("cfmPwd"));//�̻����� 
	/* ���������ʱ���
	cfmPwd = Encrypt.encrypt(cfmPwd);
	*/
	//System.out.println("---------------------------new_custPwd-------------------------"+new_custPwd);
	String serviceGroupId = WtcUtil.repNull(request.getParameter("serviceGroupId"));	
	if(serviceGroupId.equals("")){
		serviceGroupId = groupId;
	}
	String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));	//�ͻ�������
	String custOrderNo = WtcUtil.repNull(request.getParameter("custOrderNo"));	
	String prtFlag = WtcUtil.repNull(request.getParameter("prtFlag"));//Y �ϴ�N �ִ�
	String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));		//�ͻ���������ID
	String custId = WtcUtil.repNull(request.getParameter("gCustId"));
	String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));		//�ͻ����񶨵���
	if(servOrderId.equals("")){
		servOrderId = "0";
	}
	String offeridkd = WtcUtil.repNull(request.getParameter("offeridIMS"));
	/* ���޶˿�   1�޶˿�    0�ж˿� */
	String noPort = WtcUtil.repNull(request.getParameter("noPort"));
	/** Ʒ�� 
	 *	�Ƿ�����ʩ������ͨ�޶˿ڴ�Y���ж˿ڴ�N�����ʼ�մ�N��
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
	//------------------��ȡ����Ʒʵ����id----------------------------
	HashMap instanceMap = new HashMap();
	System.out.println("------------offerIdArr--------------"+WtcUtil.repNull(request.getParameter("offerIdArr")));
	String[] offerIdArr = WtcUtil.repNull(request.getParameter("offerIdArr")).split(",");//��������Ʒ�͸�������Ʒ
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
 //-------------------����ƷȺ��---------------------------
	HashMap groupInfoMap = new HashMap();
	String[] allGroupInfo = new String[]{};	//ȡ��������ƷȺ����Ϣ
	if(!WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).equals("")){
		allGroupInfo = WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).split("\\^");
	}
	for(int i=0;i<allGroupInfo.length;i++){
		String[] offerGroupInfo = allGroupInfo[i].split("\\|");
		groupInfoMap.put(offerGroupInfo[0],offerGroupInfo[1]);//����Ʒid��������Ϣ
	}
 //--------------��ƷȺ��-------------------------------
	String[] addGroupIdArrry = new String[]{};	//��ϲ�Ʒ�����Ŀ�ѡȺ����Ϣ
	if(!WtcUtil.repNull(request.getParameter("addGroupIdArr")).equals("")){
		addGroupIdArrry = WtcUtil.repNull(request.getParameter("addGroupIdArr")).split(",");
	}
	//--------------------------ѡ��Ĳ�Ʒ---------------------
	String[] prodIdArr = WtcUtil.repNull(request.getParameter("productIdArr")).split(",");
	String[] prodEffectDate = WtcUtil.repNull(request.getParameter("prodEffectDate")).split(",");
	String[] prodExpireDate = WtcUtil.repNull(request.getParameter("prodExpireDate")).split(",");
	String[] isMainProduct = WtcUtil.repNull(request.getParameter("isMainProduct")).split(",");
System.out.println("=====================ningtn imsconfmnew" + WtcUtil.repNull(request.getParameter("productIdArr")));
System.out.println("=====================ningtn prodIdArr length:" + prodIdArr.length);

	//--------------------����Ʒ,��Ʒ������Ϣ------------
	HashMap offer_productAttrMap = new HashMap();
	String[] offer_productAttrInfoArr = new String[]{};	//ȡ��������Ʒ,��Ʒ������Ϣ
	if(!WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).equals("")){
		offer_productAttrInfoArr = WtcUtil.repNull(request.getParameter("offer_productAttrInfo")).split("\\^");
	}
	for(int i=0;i<offer_productAttrInfoArr.length;i++){
		String[] offer_productAttrArr = offer_productAttrInfoArr[i].split("\\|");
		if(offer_productAttrArr.length > 1)
			offer_productAttrMap.put(offer_productAttrArr[0],offer_productAttrArr[1]);//����Ʒid���Ʒid��������Ϣ
	}

	//--------------------------��������Ϣ-----------------------
	int hasVouchInfo = 1;			//�Ƿ��е�������Ϣ���
	String vouch_idType = WtcUtil.repNull(request.getParameter("vouch_idType"));
	String vouch_idNo = WtcUtil.repNull(request.getParameter("vouch_idNo"));
	if(vouch_idType.equals("") && vouch_idNo.equals("")){
		hasVouchInfo = 0;
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
	String attrCode = userType+"000Y";
	String batchFlag = "0";	//������־  0,������1 ����
	String openType = WtcUtil.repNull(request.getParameter("openType")); //������ʽ,����ͨ�����������̷���
	String innetType = WtcUtil.repNull(request.getParameter("innetType")); //�������ͣ���ͨ��������������
	String is_not_adward = WtcUtil.repNull(request.getParameter("is_not_adward")); 	//��������
	String largess_card = WtcUtil.repNull(request.getParameter("largess_card")); 	//���ͳ�ֵ��
	String yzID = WtcUtil.repNull(request.getParameter("yzID")); 	 
	String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));
	
	String userName=WtcUtil.repNull(request.getParameter("userName"));//�û���
	String contactCustName=WtcUtil.repNull((String)request.getParameter("contactCustName"));//��ϵ��
	String contactPhone  = WtcUtil.repNull((String)request.getParameter("contactPhone")); //��ϵ���ֻ���
	String area_codeh  = WtcUtil.repNull((String)request.getParameter("area_codeh")); //���С��
	String area_nameh  = WtcUtil.repNull((String)request.getParameter("area_nameh")); //С������ 
 	if("".equals(area_codeh)){
 		area_codeh = "NULL";
 	}
 	if("".equals(area_nameh)){
 		area_nameh = "NULL";
 	}
	String cfm_login   = WtcUtil.repNull((String)request.getParameter("cfm_login"));  //�����¼�˺�
	

	String contract_no="0";//��ͬ��
	String enter_num="1";//��������
	String enter_type  = WtcUtil.repNull((String)request.getParameter("enter_type")); //���뷽ʽ
	String bandWidth   = WtcUtil.repNull((String)request.getParameter("bandWidth")); //������� 
	/*
		��ʶ��IMS�̻�ҵ�񣬻���Centrexҵ��
		IMS�̻���M
		Centrex��C
	*/
	String tdFlag = "C";
	/*String enter_type="GPON";
	String bandWidth="2M";*/
	String enter_addr  = WtcUtil.repNull((String)request.getParameter("enter_addr")); //��װ��ַ
	if(enter_addr.length() == 0){
		enter_addr = "NULL";
	}
	String appointvTime=WtcUtil.repNull((String)request.getParameter("appointvTime"));//ԤԼʱ��
	if(appointvTime.length() == 0){
		appointvTime = currentTime;
	}
	String deviceCode=WtcUtil.repNull((String)request.getParameter("deviceCode"));//�豸���
	if(deviceCode.length() == 0){
		deviceCode = "NULL";
	}
	String unitId  = WtcUtil.repNull((String)request.getParameter("unitId")); //���ű��
	if(unitId.length() == 0){
		unitId = "null";
	}
	System.out.println("====== ningtn unitId unitId [" + unitId + "]");
	String deviceType=WtcUtil.repNull((String)request.getParameter("deviceType"));//�豸���� 
	/*String deviceCode="abcedjijeikoe3089";*/
	/*String ipAddress = request.getParameter("ipAddress")==""?"û��":request.getParameter("ipAddress");ip��ַ*/
	String ipAddress=" ";//�����ip��ַ���Զ���ȡ�ģ����̶�ֵ0
	String deviceInAddress=WtcUtil.repNull((String)request.getParameter("deviceInAddress"));//�豸��װ��ַ
	String portCode=WtcUtil.repNull((String)request.getParameter("portCode"));//�˿ں�
	if(deviceInAddress.length() == 0){
		deviceInAddress = "NULL";
	}
	if(portCode.length() == 0){
		portCode = "NULL";
	}
	String portType=WtcUtil.repNull((String)request.getParameter("portType"));//�˿�����  
	/*String deviceInAddress="��̨���ƶ���˾";
	String portCode="408982";*/
	String constructRequest=WtcUtil.repNull((String)request.getParameter("construct_request"));//ʩ��Ҫ��
	String cctId=WtcUtil.repNull((String)request.getParameter("cctId"));//���žֱ���
	if(cctId.length() == 0){
		cctId = "NULL";
	}
	String userType1=WtcUtil.repNull((String)request.getParameter("userType1"));//�û�����
	String offerName=WtcUtil.repNull((String)request.getParameter("dOfferName"));//���ʷ�����
	String userRegionName=WtcUtil.repNull((String)request.getParameter("userRegionName"));//�û���������
	String isDoNoResource=WtcUtil.repNull((String)request.getParameter("isDoNoResource"));//�Ƿ�Ԥռ��Դ��ʶ
	String standardContent=WtcUtil.repNull((String)request.getParameter("standardContent"));//��׼��ַ����
	String ipAddType=WtcUtil.repNull((String)request.getParameter("ipAddType"));//��׼��ַ����
	
		/*ʵ��ʹ��������*/
	String realUserName = WtcUtil.repNull(request.getParameter("realUserName"));
	/*ʵ��ʹ���˵�ַ*/
	String realUserAddr = WtcUtil.repNull(request.getParameter("realUserAddr"));
	/*ʵ��ʹ����֤������*/
	String realUserIccId = WtcUtil.repNull(request.getParameter("realUserIccId"));
	/*ʵ��ʹ����֤������*/
	String realUserIdType = WtcUtil.repNull(request.getParameter("realUserIdType"));
	if("".equals(realUserName)){
		realUserName = "NULL";
	}
	if("".equals(realUserAddr)){
		realUserAddr = "NULL";
	}
	if("".equals(realUserIccId)){
		realUserIccId = "NULL";
	}
	
	System.out.println("--------------------����û�������չ��Ϣbegin---------------------");
	System.out.println("---------�������---------"+phoneNo);
	System.out.println("---------С������---------"+area_codeh);
	System.out.println("---------��ϵ��---------"+contactCustName);
	System.out.println("---------��ϵ�绰---------"+contactPhone);
	System.out.println("---------����˺�---------"+cfm_login);
	System.out.println("---------�˺�����---------"+cfmPwd);
	System.out.println("---------��ͬ��---------"+contract_no);
	System.out.println("---------С������---------"+area_nameh);
	System.out.println("---------��ϸ��װ��ַ---------"+enter_addr);
	System.out.println("---------ԤԼʱ��---------"+appointvTime);
	System.out.println("---------�������---------"+bandWidth);
	System.out.println("---------��������---------"+enter_num);
	//System.out.println("---------�ͻ�����---------"+cust_attr);
	System.out.println("---------���뷽ʽ---------"+enter_type);
	System.out.println("---------�豸���---------"+deviceCode);
	System.out.println("---------�˿ڱ��---------"+portCode);
	System.out.println("---------ip��ַ---------"+ipAddress);
	System.out.println("---------�豸��װ��ַ---------"+deviceInAddress);
	System.out.println("---------ʩ��Ҫ��---------"+constructRequest);
	System.out.println("---------�Ƿ�ʩ��---------"+"1");
	System.out.println("---------�Ƿ�Ԥռ��Դ---------"+isDoNoResource);
	System.out.println("---------��׼��ַ����---------"+standardContent);
	System.out.println("---------ip��ַ����---------"+ipAddType);
	/*System.out.println("----------���žֱ���--------"+cctId);*/
	System.out.println("--------------------����û�������չ��Ϣend---------------------");
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
                    servOrderDataUtype.setUe("STRING","0");//����������־
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
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("userName")));
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("areaId")));
              userBaseInfoUtype.setUe("STRING","");
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("openType")));
              userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("addCmgr")));/*�Ƿ���Ź�ע*/
              userBaseInfoUtype.setUe("STRING","01");
              //userBaseInfoUtype.setUe("STRING",WtcUtil.repNull(request.getParameter("serviceManagerId")));
              userBaseInfoUtype.setUe("STRING","");/*Ӫ��֧�ž���*/
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
						if(parentId.equals(offerIdArr[0])){	//����Ǹ��Ӳ�Ʒ,�������ϼ���Ʒʵ��ID��Ϊ1
							parentProdInstId = "1";
					}
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
                  productBaseInfoUtype.setUe("STRING","1002");
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

              UType busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","C");
                busiFeeFactorUtype1.setUe("STRING","C1");
                busiFeeFactorUtype1.setUe("STRING",serviceNo);
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
                
              busiFeeFactorUtype1 = new UType();
                busiFeeFactorUtype1.setUe("STRING","K");
                busiFeeFactorUtype1.setUe("STRING","K0");
                busiFeeFactorUtype1.setUe("STRING",regionCode);
                busiFeeFactorUtype1.setUe("STRING",opCode);
                busiFeeFactorUtype1.setUe("STRING","1");
                busiFeeFactorUtype1.setUe("STRING",offerIdArr[0]);
                busiFeeFactorListUtype.setUe(busiFeeFactorUtype1);
                
              userInfoUtype.setUe(busiFeeFactorListUtype);
			         
            UType UserExtMsgListUtype = new UType();
            
            System.out.println("---------------------is_not_adward-----------------"+is_not_adward);
            if(is_not_adward.equals("Y")){ //��������
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
            	
            if(largess_card.equals("Y")){ //���ͳ�ֵ��
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
         		 System.out.println("mylog--------------pƴ�����Ľڵ�--------------innetType--------"+innetType); 
          
		        /*
		        ��������������� 
		         if(isGPhoneFlag.equals("1")){  
		          	System.out.println("mylog--------------pƴ�����Ľڵ�--------------GoodPhoneDate-------"+request.getParameter("GoodPhoneDate"));
		           	UType UserExtMsgUtypeh = new UType();
		                	UserExtMsgUtypeh.setUe("LONG","20015");
		                	UserExtMsgUtypeh.setUe("INT","1");
		               	  UserExtMsgUtypeh.setUe("STRING",WtcUtil.repNull(request.getParameter("GoodPhoneDate")));
		                	UserExtMsgListUtype.setUe(UserExtMsgUtypeh);
		          } */
                    	
							UType UserExtMsgUtype01 = new UType();  /*�������*/
								UserExtMsgUtype01.setUe("LONG","20102");
								UserExtMsgUtype01.setUe("INT","0");
								UserExtMsgUtype01.setUe("STRING",phoneNo_h);
								UserExtMsgListUtype.setUe(UserExtMsgUtype01);
							
							UType UserExtMsgUtype02 = new UType(); /*С������*/
								UserExtMsgUtype02.setUe("LONG","20103");
								UserExtMsgUtype02.setUe("INT","0");
								UserExtMsgUtype02.setUe("STRING",area_codeh);
								UserExtMsgListUtype.setUe(UserExtMsgUtype02);
							
							UType UserExtMsgUtype03 = new UType(); /*��ϵ��*/
							  UserExtMsgUtype03.setUe("LONG","20105");
								UserExtMsgUtype03.setUe("INT","0");
								UserExtMsgUtype03.setUe("STRING",contactCustName);
								UserExtMsgListUtype.setUe(UserExtMsgUtype03);
							
							UType UserExtMsgUtype04 = new UType(); /*��ϵ�绰*/
								UserExtMsgUtype04.setUe("LONG","20106");
								UserExtMsgUtype04.setUe("INT","0");
								UserExtMsgUtype04.setUe("STRING",contactPhone);
								UserExtMsgListUtype.setUe(UserExtMsgUtype04);
							
						
							    	
							UType UserExtMsgUtype08 = new UType(); /*С������*/
								UserExtMsgUtype08.setUe("LONG","20117");
								UserExtMsgUtype08.setUe("INT","0");   
							  UserExtMsgUtype08.setUe("STRING",area_nameh);      
							  UserExtMsgListUtype.setUe(UserExtMsgUtype08); 
							    
							UType UserExtMsgUtype09 = new UType(); /*��ϸ��װ��ַ*/
								UserExtMsgUtype09.setUe("LONG","20119");
								UserExtMsgUtype09.setUe("INT","0");  
							  UserExtMsgUtype09.setUe("STRING",enter_addr);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype09);
							  
							UType UserExtMsgUtype10 = new UType(); /*ԤԼʱ��*/
								UserExtMsgUtype10.setUe("LONG","20120");
								UserExtMsgUtype10.setUe("INT","0");  
								UserExtMsgUtype10.setUe("STRING",appointvTime);       
								UserExtMsgListUtype.setUe(UserExtMsgUtype10);  
							  
							UType UserExtMsgUtype11 = new UType(); /*�̻���ʶ*/
								UserExtMsgUtype11.setUe("LONG","20121");
								UserExtMsgUtype11.setUe("INT","0");  
							  UserExtMsgUtype11.setUe("STRING",tdFlag);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype11);
							            
							UType UserExtMsgUtype12 = new UType(); /*��������*/
								UserExtMsgUtype12.setUe("LONG","20122");
								UserExtMsgUtype12.setUe("INT","0");  
							  UserExtMsgUtype12.setUe("STRING",enter_num);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype12);  
							  /*
							UType UserExtMsgUtype17= new UType(); ip��ַ
								UserExtMsgUtype17.setUe("LONG","20127");
								UserExtMsgUtype17.setUe("INT","0");  
							  UserExtMsgUtype17.setUe("STRING",ipAddress);       
							  UserExtMsgListUtype.setUe(UserExtMsgUtype17);
							*/
							UType UserExtMsgUtype27= new UType();  /*Ʒ��*/
									UserExtMsgUtype27.setUe("LONG","20181");
									UserExtMsgUtype27.setUe("INT","0");  
									UserExtMsgUtype27.setUe("STRING",brandId);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype27);
									
									
							UType UserExtMsgUtype29= new UType();  /*���ű��*/
									UserExtMsgUtype29.setUe("LONG","20170");
									UserExtMsgUtype29.setUe("INT","0");  
									UserExtMsgUtype29.setUe("STRING",unitId);       
									UserExtMsgListUtype.setUe(UserExtMsgUtype29);

							UType UserExtMsgUtype30= new UType();  /*IMS�û���ʶSUBID*/
									UserExtMsgUtype30.setUe("LONG","20100");
									UserExtMsgUtype30.setUe("INT","0");  
									UserExtMsgUtype30.setUe("STRING",WtcUtil.repNull(request.getParameter("SubId")));
									UserExtMsgListUtype.setUe(UserExtMsgUtype30);
									
							UType UserExtMsgUtype31= new UType();  /*sip����*/
									UserExtMsgUtype31.setUe("LONG","20104");
									UserExtMsgUtype31.setUe("INT","0");  
									UserExtMsgUtype31.setUe("STRING",WtcUtil.repNull(request.getParameter("IMPU")));
									UserExtMsgListUtype.setUe(UserExtMsgUtype31);
									
							UType UserExtMsgUtype32= new UType();  /*tel����*/
									UserExtMsgUtype32.setUe("LONG","20127");
									UserExtMsgUtype32.setUe("INT","0");  
									UserExtMsgUtype32.setUe("STRING",WtcUtil.repNull(request.getParameter("tel")));
									UserExtMsgListUtype.setUe(UserExtMsgUtype32);
									
							UType UserExtMsgUtype33= new UType();  /*�˺�����*/
									UserExtMsgUtype33.setUe("LONG","20108");
									UserExtMsgUtype33.setUe("INT","0");  
									UserExtMsgUtype33.setUe("STRING",cfmPwd);
									UserExtMsgListUtype.setUe(UserExtMsgUtype33);
							/*�û����� 20121101 gaopeng ����ͳһcentrex����centrex�û����Ե����� �����ֶ�Ϊ�û����� centrex��ͨ�û� �ǣ�HW-Centrex-VPN ����̨�û��ǣ�HW-Centrex-Operator*/
							UType UserExtMsgUtype34= new UType();  
									UserExtMsgUtype34.setUe("LONG","20198");
									UserExtMsgUtype34.setUe("INT","0");  
									UserExtMsgUtype34.setUe("STRING",WtcUtil.repNull(request.getParameter("custAttr")));
									UserExtMsgListUtype.setUe(UserExtMsgUtype34);
									
							UType UserExtMsgUtype35= new UType();  
									UserExtMsgUtype35.setUe("LONG","20220");
									UserExtMsgUtype35.setUe("INT","0");  
									UserExtMsgUtype35.setUe("STRING","NULL");
									UserExtMsgListUtype.setUe(UserExtMsgUtype35);
								
									
							UType UserExtMsgUtype36= new UType();  
									UserExtMsgUtype36.setUe("LONG","20221");
									UserExtMsgUtype36.setUe("INT","0");  
									UserExtMsgUtype36.setUe("STRING","NULL");
									UserExtMsgListUtype.setUe(UserExtMsgUtype36);
							/*2014/07/22 16:10:04 gaopeng ims�����ֳ������������ˣ��Ժ��������������͵ø��ż�*/		
									UType UserExtMsgUtype37= new UType();  
									UserExtMsgUtype37.setUe("LONG","20222");
									UserExtMsgUtype37.setUe("INT","0");  
									UserExtMsgUtype37.setUe("STRING","NULL");
									UserExtMsgListUtype.setUe(UserExtMsgUtype37);
									
									UType UserExtMsgUtype38= new UType();  
									UserExtMsgUtype38.setUe("LONG","20223");
									UserExtMsgUtype38.setUe("INT","0");  
									UserExtMsgUtype38.setUe("STRING","NULL");
									UserExtMsgListUtype.setUe(UserExtMsgUtype38);
									
									UType UserExtMsgUtype39= new UType();  
									UserExtMsgUtype39.setUe("LONG","20224");
									UserExtMsgUtype39.setUe("INT","0");  
									UserExtMsgUtype39.setUe("STRING","NULL");
									UserExtMsgListUtype.setUe(UserExtMsgUtype39);
									
									
									
			/* begin add ʵ��ʹ���������Ϣ for ���ڿ��������ն�CRMģʽAPP�ĺ� - ������@2015/4/7 */
			UType realUserUtype1= new UType();  
			realUserUtype1.setUe("LONG","20227");
			realUserUtype1.setUe("INT","0");  
			realUserUtype1.setUe("STRING",realUserIdType);
			UserExtMsgListUtype.setUe(realUserUtype1);
			
			UType realUserUtype2= new UType();  
			realUserUtype2.setUe("LONG","20228");
			realUserUtype2.setUe("INT","0");  
			realUserUtype2.setUe("STRING",realUserIccId);
			UserExtMsgListUtype.setUe(realUserUtype2);
			
			UType realUserUtype3= new UType();  
			realUserUtype3.setUe("LONG","20229");
			realUserUtype3.setUe("INT","0");  
			realUserUtype3.setUe("STRING",realUserName);
			UserExtMsgListUtype.setUe(realUserUtype3);
			
			UType realUserUtype4= new UType();  
			realUserUtype4.setUe("LONG","20230");
			realUserUtype4.setUe("INT","0");  
			realUserUtype4.setUe("STRING",realUserAddr);
			UserExtMsgListUtype.setUe(realUserUtype4);
			
			/* end add ʵ��ʹ���������Ϣ for ���ڿ��������ն�CRMģʽAPP�ĺ� - ������@2015/4/7 */									
									
									
									
							
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
	String retrunCode=String.valueOf(retVal.getValue(0));//���ص�retCodeΪLONG���ͣ�
	String returnMsg=retVal.getValue(1);
	System.out.println("# from KDconfm_new.jsp -> retCode = "+retrunCode + ",retMsg = "+returnMsg);
	

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
    
	if(parent.document.getElementById("<%=gCustId%>")==null||
		 parent.document.getElementById("<%=gCustId%>")=="null"){
				var newE = parent.document.createElement("DIV");
			    
			    newE.id = login_accept;
			    newE.printinfo=printinfo;
			    newE.style.display = "none";
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
	  	var path="/npage/se887/fq046.jsp?gCustId=<%=gCustId%>"
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
<%}else
  {
%>
<script language='JavaScript'>
		rdShowMessageDialog("����ʧ�ܣ��������:"+'<%=retrunCode%>',0);
    removeCurrentTab();
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

