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
	System.out.println("<<--------------��ѯ����Ʒ������ϸ��ʼ--------------------->>"); 
	String workNo = (String)session.getAttribute("workNo");
	//String groupId = (String)session.getAttribute("siteId");
	String groupId = (String)session.getAttribute("groupId");
	String feeFactor=WtcUtil.repNull(request.getParameter("feeFactor"));	
	String oldOfferExpTime="";
	String errCode = "";
	String errMsg = "";
	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	int recordNum = 0; //��ѯ�����¼����
	
	StringBuffer discountInfoList_sb = new StringBuffer();//����Ʒ��Ϣ
	StringBuffer ProductBaseInfo_sb = new StringBuffer();
	StringBuffer ProductBaseInfo_sb2 = new StringBuffer();
	String discountInfo=WtcUtil.repNull(request.getParameter("discountInfo"));	
	String UserOffers=WtcUtil.repNull(request.getParameter("UserOffers"))+"~";	//������Ʒ������Ϣ
  String newOfferEffectTime = WtcUtil.repNull(request.getParameter("newOfferEffectTime")).trim();//�¹���������Ʒ��Ч����ʱ��
	newOfferEffectTime=newOfferEffectTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
System.out.println("�¹�����Ʒ��Чʱ��Ϊ��"+newOfferEffectTime);	
	String[] majorProductArr=WtcUtil.repNull(request.getParameter("majorProductArr")).split(",");
	String discountInfo_bas[]=discountInfo.split(",");
	String discountInfo_bas_ins="";
	if(discountInfo_bas.length>1){
		discountInfo_bas_ins=discountInfo_bas[1];
	}
	String UserOffers_s[]=UserOffers.split("~");
	String UserOffers_ss[][]=new String[UserOffers_s.length][2];

	String[] oldRemained=WtcUtil.repNull(request.getParameter("oldRemained")).split(",");
	String systemTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());	// 	ϵͳ��ǰʱ��
	String offer_effectTime="";//����Ʒ��Ҫ���ɵ�ʱ��
	String offer_expireTime=WtcUtil.repNull(request.getParameter("offer_expireTime"));	// �¹�������ƷʧЧ����ʱ��
	offer_expireTime=offer_expireTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
	String proType=WtcUtil.repNull(request.getParameter("proType")).trim();	// 
	String proDisNum=WtcUtil.repNull(request.getParameter("proDisNum")).trim();	// 
	String proDisType=WtcUtil.repNull(request.getParameter("proDisType")).trim();	// 
		offer_effectTime=newOfferEffectTime;	
		offer_effectTime=offer_effectTime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
	
	if("".equals(offer_effectTime)){
		offer_effectTime=new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	}
System.out.println("�¹�����Ʒ��Чʱ��Ϊ��"+newOfferEffectTime);	
	if("".equals(offer_expireTime)){
		offer_expireTime="20500101";
	}
	String offered=WtcUtil.repNull(request.getParameter("offId"));	//"100005329";	//  #����Ʒ��ʶ 100005610
	String opCode=WtcUtil.repNull(request.getParameter("opCode"));	//  #��������	//"1210";	
	String servId=WtcUtil.repNull(request.getParameter("servId"));	//servId//  #����Ʒʵ��ID "900000783066";	10099000990
	String gCustId=WtcUtil.repNull(request.getParameter("gCustId"));//  #�ͻ�ID 900001942251	//900001942251 "900000782559";	
	String ruleValue="";	//   #ҵ�����
	String oldTempArr="";
  String attrCode="aa";		//     #���Դ���
  String attrValue="bb";	//    #����ֵ
	String sale_mode=WtcUtil.repNull(request.getParameter("sale_mode"));
	String imeiNo=WtcUtil.repNull(request.getParameter("imeiNo"));
	String offerSrvId1 = WtcUtil.repNull(request.getParameter("offerSrvId"));
	String phoneNo1 = WtcUtil.repNull(request.getParameter("phoneNo"));
	System.out.println("11111111111111111111111111111111111111111111111111111111111111111111111111111===="+sale_mode+"||||");
	if(sale_mode!=null && !sale_mode.equals("")){
	System.out.println("*****************************************************����sIProdMidMac����**************");

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
	String [] seqArrDiscountPlan = new String[seqArrDiscountPlan_num];	//����Ʒʵ����ID
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
	String offerSrvId=WtcUtil.repNull(request.getParameter("offerSrvId"));	//�������װ���� //��װ����Ʒʵ��ID;����ǿͻ�������� idNo
	String num=WtcUtil.repNull(request.getParameter("num"));	//1			����
	String offerId=WtcUtil.repNull(request.getParameter("offerId"));	//0		����ƷID
	String offerName=WtcUtil.repNull(request.getParameter("offerName"));	//e8		����Ʒ����
	String phoneNo=WtcUtil.repNull(request.getParameter("phoneNo"));	//13083154258	ҵ�����
	String orderArrayId=WtcUtil.repNull(request.getParameter("orderArrayId"));	//A0209022000000180  �ͻ���������ID
	String custOrderId=WtcUtil.repNull(request.getParameter("custOrderId"));	//C0209022000000166  �ͻ�����ID
	String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));	//C0209022000000166  �ͻ��������
	String servOrderId=WtcUtil.repNull(request.getParameter("servOrderId"));	//			    ���񶩵�ID
	String closeId=WtcUtil.repNull(request.getParameter("closeId"));	//A0209022000000180		�ر�tab��ID
	String prtFlag=WtcUtil.repNull(request.getParameter("prtFlag"));	//Y                      ��ӡ��ʶ  Y �ϴ� N�ִ�
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
    String regionCode =((String)session.getAttribute("orgCode")).substring(0,2);//bureau_Id  ����ID  �൱������ԭ����regionCode 
    String opNote="����:"+workNo+" ��������:"+opCode+" ҵ��:"+opName;
    //String bureauId =(String)session.getAttribute("siteId");	//site_id   �����ID  �൱������ԭ����groupId
    //String objectId =(String)session.getAttribute("objectId");	//object_id �����ID	//bureau_id >  object_id > site_id
    
    String bureauId =(String)session.getAttribute("groupId");	//site_id   �����ID  �൱������ԭ����groupId
    String objectId =(String)session.getAttribute("groupId");	//object_id �����ID	//bureau_id >  object_id > site_id
    
    String productI = (String)request.getParameter("productI");
		
		System.out.println("---------------productI-------------"+productI);
		
		
		String servOrderNo ="0";	//�ͻ����񶨵����(Ϊ��ϵͳԤ��)
		String servOrderChangeId ="0";	//���񶨵�������
		String idNo = WtcUtil.repNull(request.getParameter("offerSrvId"));	//"200001868613"; //custInfo.getIdNo();//�û�ID/����Ʒʵ��ID//
		String serviceNo =phoneNo;	//"0";//����������//-------------j	WtcUtil.repNull(request.getParameter("selNum"));
		String dispathRule ="0"; //�滻0	�����ɷ������ʶ
		String decomposeRule ="0"; //�滻0	�����ֽ�����ʶ
		String addressId ="0"; //�滻0	//��ַID//-------------j ----------------@@@@
		String orderStatus ="110"; //�滻0 //0��ʼδ����״̬	//���շ�110
		String stateDate =opTime;;	//-------------j
		String stateReasonId ="3"; //�滻0	//����״̬ԭ��ID//-------------j
		String finishFlag ="N";	//δ���,����� Nδ����//-------------j
		String finishTime ="0";		//����ʱ��//-------------j
		String finishLimitTime =opTime;	//�������//-------------j	//-------------------@@@@
		String warningTime =opTime;	//Ԥ��ʱ��//-------------j	//-------------------@@@@
		String dealLevel ="1";		//1:��ͨ���ȼ�//-------------j  
		String payStatus ="0";		//�ɷ�״̬ char sPayState[1+1];//-------------j
		String backFlag ="0";		//�˷ѱ�־//-------------j
		String exceptionTimes ="0";	//"int";	//�쳣���ִ���//-------------j
		String servOrderSeq ="1";	//"int";	//���񶨵�����˳��dOrderArrayOrder.serv_order_seq//-------------j//-------------------@@@@
		String isPreCreateStatus ="Y";	//"string";��ʾ�Ƿ���Ԥ����״̬��dOrderArrayOrder.create_status��ȡֵ��Χ'Y','N'���������ҵ����񶨵�����ǰ���ɵ�	//��ʾ�Ƿ���Ԥ����״̬��dOrderArrayOrder.create_status��ȡֵ��Χ'Y','N'��//-------------j
		String contactPerson ="0";	//���񶨵��������ϵ�ˡ�//-------------j
		String contactPhone =WtcUtil.repNull(request.getParameter("phoneNo"));	//"string"; //���񶨵��������ϵ�绰��//-------------j	
		String classCode ="0";	//"long";	//��������  ----�ɿջ�Ĭ��
		String arraySeq ="0";	//"int";	//�������
		String classValue ="0";		//����ֵ
		String srvOrderSlaId ="0";	//����SLA��ʶ
		String slaIndexId ="0"; //�滻0	//ָ���ʶ
		String salValueSeq ="0"; //�滻0	//ָ�����
		String slaValue ="0";	//ָ�����
		String bookSrvId ="0";		//ԤԼ������Ϣ��ʶ
		String modifyTime =opTime;	//����޸�ʱ��
		String bookingTime =opTime;	//ԤԼʱ��
		String srvOrderExcpId ="0";	//�쳣��Ϣ��ʶ
		String excpType ="1"; //�滻0				//�쳣����
		String excpReason ="0";		//�쳣ԭ��
		String handleResult ="OK";		//�쳣������
		String handleLogin ="0";		//�쳣������
		String userId =idNo;		//"210001466327";	//"1010001242459"; //�滻0			//�û���ʶ//-------------j
		String brand ="0";			//�û���Ʒ����Ϣ���磺00 ����� 01 ������ 02 ����ͨ��//-------------j
		String userNo ="0";		//�û����ڲ�11λ���룬���ڳ���//-------------j
		String UseCustId =gCustId;	//ʹ�ÿͻ�ID
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
			DiscountInfos[i][0] =ss[0];//��������
			DiscountInfos[i][1] =ss[1];//����Ʒʵ��ID
			if(ss[1].equals(""))
			{
				DiscountInfos[i][1]=seqArrDiscountPlan[seqArrDiscountPlan_num2++];
			}
			DiscountInfos[i][2] =ss[2];//����ƷID
			DiscountInfos[i][3] =ss[3];//��Чʱ��
			DiscountInfos[i][4] =ss[4];//ʧЧʱ��
			DiscountInfos[i][7] = ss[5];//״̬
			DiscountInfos[i][5] ="0";	//��ʵ���ڵ�-------------------------�Լ�ȡ���ڵ�ʵ��ID
			DiscountInfos[i][6] ="1";	//��ǰ����	//string-------------�Լ�ȡ,0,1,2........
			if(i<1||i==discountInfoList_sbs-1){
			DiscountInfos[i][5] ="0";	//��ʵ���ڵ�-------------------------�Լ�ȡ���ڵ�ʵ��ID
			DiscountInfos[i][6] ="0";	//��ǰ����	//string-------------�Լ�ȡ,0,1,2........
			} 
			boolean ch=false;

			DiscountInfo_idMap.put(DiscountInfos[i][2],DiscountInfos[i][1]);
			DiscountInfo_effectMap.put(DiscountInfos[i][1],DiscountInfos[i][3]);
			DiscountInfo_expireMap.put(DiscountInfos[i][1],DiscountInfos[i][4]);
			}
		}
		String order ="0";	//seqArr[0]; //���к�  0	
		String custAgreementId ="0";	//�ͻ�Э���ʶ   0 ȡ����ķ���
		String status ="A";				//״̬  
		String developLoginNo =(String)session.getAttribute("workNo");
		//String channelId =(String)session.getAttribute("siteId");	//��������  group_id (���û���Ϣ��)//�����ʶ
		String channelId =(String)session.getAttribute("groupId");	//��������  group_id (���û���Ϣ��)//�����ʶ
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
	String DiscountAttrList=WtcUtil.repNull(request.getParameter("DiscountAttrList"));	//-----------------------------------j2				
	if(DiscountAttrList.trim().length() > 1)
			offer_productAttrMap.put(offered,DiscountAttrList+"^");
		
		String DiscountAttr_effDate =opTime;	//��Чʱ��
		String DiscountAttr_expDate ="20501231235959";	//ʧЧʱ��
HashMap groupInfoMap = new HashMap();
String[] allGroupInfo = new String[]{};	//ȡ��������ƷȺ����Ϣ
if(!WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).equals("")){
	allGroupInfo = WtcUtil.repNull(request.getParameter("groupInstBaseInfo")).split("\\@");
}
for(int i=0;i<allGroupInfo.length;i++){
	String[] offerGroupInfo = allGroupInfo[i].split("\\|");
	groupInfoMap.put(offerGroupInfo[0],offerGroupInfo[1]);
}			
		String operatorFlag ="1";	//�������ͣ�'ADD':���ӣ�'DEL':ɾ����'UPD':����
		String grpInstId ="0";		//Ⱥ��ʵ��ID
		String grpTypeId ="0";		//Ⱥ������ID
		String groupDesc ="0";		//Ⱥ������
		String groupState ="A";	//Ⱥ��״̬"A"
		String effectDate =opTime;	//��Чʱ��
		String expireDate ="20501231235959";	//ʧЧʱ��
		String grpAttr ="0";		//Ⱥ������
		String upGroupId ="0";		//�ϼ�Ⱥ��ID
		String memberId ="0";			//��Ա��ʶ	Ⱥ��ʵ����Ա��ʶ
		String memberDesc ="0";	//Ⱥ���Ա����
		String memberTypeId ="0";	//Ⱥ���Ա���ͱ�ʶ
		String memberRoleId ="0";	//Ⱥ���Ա��ɫ��ʶ
		String lifeCycleId ="0";	//�������ڱ�ʶ
		String mebState ="A";		//��Ա״̬
		String grpMebAttr ="0";	//Ⱥ���Ա����
		String memberObjectId ="0";	//Ⱥ��ʵ����Ա�����ʶ
		String attrType ="0";      //��������	AttrType  
		attrCode ="0";		//���Դ���	AttrCode  
		attrValue ="0";		//����ֵ	AttrValue   
		String attrRemark ="0";	//���Ա�ע	AttrRemark
		String operatorFlag0 ="0";	//�������ͣ�'ADD':���ӣ�'DEL':ɾ����'UPD':���� 
		String paramInstanceId ="0";	//����ȡֵ��ʶ
		String paramId ="0";		//����Ʒ������ʶ
		String paramValue ="0";	//����ֵ
		String paramAttrId ="0";	//�������Ա�ʶ
		String agreementId ="0";	//ʶ��ͻ�Э���Ψһ��ʶ�š�
		String subUserId ="0";		//�û���ϵ����long
		String relationType ="0";	//�û���ϵ����long
		String resType ="0";		//��Դ����
		String resSeq ="0";		//��Դ����
		String resNo =phoneNo;			//��Դ���
		String paramType ="C";			//������Ϣ------------Ӫҵ�Է�����
		String paramCode ="C2";			//��������
		String paramValueBegin =feeFactor;	//��ʼ����ֵ
		String paramValueEnd ="0";	
		String paramObj ="0";			//������չ��Ϣ
		

		
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
									rowtype = productIArr[hh].split("��");
									 
									
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
	retrunCode=retVal.getValue(0);//���ص�retCodeΪLONG���ͣ�
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
							System.out.println("url��"+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
	

var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode %>");
response.data.add("errorMsg","<%=returnMsg %>");
core.ajax.receivePacket(response);

