<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String loginNo   = (String)session.getAttribute("workNo");					//��¼����
	String password   = (String)session.getAttribute("password");				//��¼����
	String reginCode = (String) session.getAttribute("regCode");				//����
	String groupId = (String) session.getAttribute("groupId");					//Ӫҵ�ڵ����
    String powerRight = (String)session.getAttribute("powerRight");				//�û�Ȩ��
    String ip_address = (String)session.getAttribute("ipAddr");					//IP��ַ
	String serialNo = (String)request.getParameter("serialNo").trim();			//����������ˮ�����������serial_no��ѯ�ӱ��order_no
	String actName = (String)request.getParameter("actName").trim();			//�����
	String phoneNo = (String)request.getParameter("phoneNo").trim();			//�ֻ���
	String actClass = (String)request.getParameter("actClass").trim();			//Ӫ��������
	String custOrderId = (String)request.getParameter("custOrderId").trim();	//�ͻ�������crm������
	String custOrderNo = (String)request.getParameter("custOrderNo").trim();	//crm�������ģ���ת���ɷ�ҳ������
    String orderArrayId = (String)request.getParameter("orderArrayId").trim();	//�������crm������
    String servBusiId = (String)request.getParameter("servBusiId").trim();		//CRM������
    String gCustId = (String)request.getParameter("gCustId").trim();
    String opCode = (String)request.getParameter("opCode").trim();				//��������,g796
    String opName = (String)request.getParameter("opName").trim();				//��������,Ӫ��ȡ�� 
    String busiId = (String)request.getParameter("busiId").trim();				//������ˮ
	String concelPrifee = (String)request.getParameter("concelPrifee").trim();	//�����ʷ�����_�����ʷѴ���,�߻�ʱ���õģ�ȡ�����û��������µ����ʷѣ��п���Ϊ��
	//String meansId = (String)request.getParameter("meansId").trim();	
	String selectType = (String)request.getParameter("selectType")!=null ? (String)request.getParameter("selectType").trim():"";//�����:g798�˻���ʱ��ʹ��
	String cancelType = (String)request.getParameter("cancelType")!=null ?(String)request.getParameter("cancelType").trim():"";//ȡ����ʶ add by zhouwy date 2014-03-20
    String chn_type = (String)request.getParameter("chn_type")!=null ? (String)request.getParameter("chn_type").trim():"";		//��������
    String act_Class = (String)request.getParameter("actClass")!=null ? (String)request.getParameter("actClass").trim():"";			//�С��
	//String expType = "0";//��Ч��ʶ
	String expType = "2";//��Ч��ʶ   ����˫Ѽɽ�ֹ�˾�������G796Ӫ����ȡ���ʷ�ʧЧ���Ե���ʾ �涨ԤԼʧЧ
	String v_smCode = "";
	System.out.println("gaopeng==========22222222222====busiId="+busiId);
	System.out.println("gaopeng==========22222222222====actName="+actName);
	System.out.println("gaopeng==========22222222222====selectType="+selectType);
	System.out.println("gaopeng==========22222222222====cancelType="+cancelType);
	System.out.println("gaopeng==========22222222222====chn_type="+chn_type);
	System.out.println("gaopeng==========22222222222====v_smCode="+v_smCode);
	System.out.println("gaopeng==========22222222222====act_Class="+act_Class);
	if("3".equals(cancelType)){
		expType="2";
	}
	String newPriFeeCode = "";													//�����ʷѴ���
	String newPriFeeName  = "";													//�����ʷ�����
	String sysNote = "";														//����ģ��
	if(!"".equals(selectType)){
		sysNote = "Ӫ���˻�";
	}else{
		sysNote = "Ӫ��ȡ��";
	}
	String busiType = request.getParameter("busiType").trim();                  //ҵ������
	if(concelPrifee!=null && (!"".equals(concelPrifee))){
		String[] concelPrifeeArr = concelPrifee.split("_");
		newPriFeeCode = concelPrifeeArr[1];
		newPriFeeName = concelPrifeeArr[0];
	}
	
	/* servbusiId��ȡ-����ҵ���ṩ*/
	String resServBusiId = "";//����Ʒ/�ն�(����)
	String feeServBusiId = "";//����((����)
	String prodServBusiId = "";//�ʷ�(����)
	String commServBusiId = "";//ͨ��ҵ��(����)
	String spServBusiId = "";//SPҵ��(����)
	String scoreServBusiId = "";//����ҵ��(����)
	if("40017".equals(servBusiId)){
		resServBusiId = "40035";
		feeServBusiId = "40038";
		prodServBusiId ="40041";
		commServBusiId = "40062";
		spServBusiId = "40123";
		scoreServBusiId = "40032";
	}else if("40018".equals(servBusiId)){
		resServBusiId = "40036";
		feeServBusiId = "40039";
		prodServBusiId ="40042";
		commServBusiId = "40063";
		spServBusiId = "40124";
		scoreServBusiId = "40033";
	}else if("40019".equals(servBusiId)){
		resServBusiId = "40037";
		feeServBusiId = "40040";
		prodServBusiId ="40043";
		commServBusiId = "40064";
		spServBusiId = "40125";
		scoreServBusiId = "40034";
	}else if("40079".equals(servBusiId)){
		resServBusiId = "40085";
		feeServBusiId = "40088";
		prodServBusiId ="40091";
		commServBusiId = "40094";
		scoreServBusiId = "40082";
	}else if("40080".equals(servBusiId)){
		resServBusiId = "40086";
		feeServBusiId = "40089";
		prodServBusiId ="40092";
		commServBusiId = "40095";
		scoreServBusiId = "40083";
	}else if("40081".equals(servBusiId)){
		resServBusiId = "40087";
		feeServBusiId = "40090";
		prodServBusiId ="40093";
		commServBusiId = "40096";
		scoreServBusiId = "40084";
	}else if("40101".equals(servBusiId)){
		resServBusiId = "40111";
		feeServBusiId = "40112";
		prodServBusiId ="40113";
		commServBusiId = "40109";
		scoreServBusiId = "40110";
	}
	
	Calendar calendar = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	SimpleDateFormat format2 = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat format3 = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String oper_time = format.format(calendar.getTime());	//ȡ���Ĳ���ʱ�䣬��ʽ:yyyyMMddHHmmss,ȡ��������ʹ��
	String cancel_time = format2.format(calendar.getTime());//�����ʹ�ã���ʽ:yyyyMMdd
	String addfee_endtime = format3.format(calendar.getTime());//�������ʷ�ԤԼ��Ч��ʧЧʱ�䴫��ǰʱ��
	  
	String print_flag = "0";//��ӡ��ʶ��0�ϴ�1�ִ�-ȡ��ʱ�̶�ֵΪ0�������ڷִ�����
	String showFlag = "style=\"display:block\"";
	
	String id_no_main = "";
	String cust_id_main = "";
	String brand_id_main = "";
	String group_id_main = "";
	String cust_name_main = "";
	String mode_name_main = "";
	String id_name_main = "";
	String cust_address_main = "";
	String belong_code_main = "";
	String mode_code_main = "";
	String tbselect = "";
	String meansId = "";
	Map UserInfoMap = null;
	
	Map tempMap = new HashMap();
	%>
	<!-- ��ȡ�������Ϣ���� -->
	<s:service name="sActInfoQryWS_XML" >
		<s:param name="ROOT">
				<s:param name="iLoginAccept" type="string" value="" />
				<s:param name="iChnSource" type="string" value="0" />
				<s:param name="iOpCode" type="string" value="<%=opCode %>" />
				<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
				<s:param name="iLoginPWD" type="string" value="<%=password %>" />
				<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
				<s:param name="iUserPwd" type="string" value="" />
				<s:param name="iQryAccept" type="string" value="<%=busiId %>" />
				<s:param name="iTabName" type="string" value="MK_ACTRECORD_INFO" />
		</s:param>
	</s:service>
	<%
	String actInfoRtnCode = result.getString("RETURN_CODE");
	String actInfoRtnMsg = result.getString("RETURN_MSG");	
	String actionId = result.getString("OUT_DATA.ACT_INFO.ACT_ID");//�ID
	meansId = result.getString("OUT_DATA.ACT_INFO.MEANS_ID");//��ʽ���
	String old_loginaccept = result.getString("OUT_DATA.ACT_INFO.BUSI_ID");//ԭ������ˮ
	String lowCon_type = result.getString("OUT_DATA.ACT_INFO.LOWCON_TYPE");//��������
	System.out.println("orderedInfo.jsp----�ID-----"+actionId);
	System.out.println("orderedInfo.jsp----��ʽ���-----"+meansId);
	System.out.println("orderedInfo.jsp----ԭ������ˮ-----"+old_loginaccept);
	System.out.println("orderedInfo.jsp----��������-----"+lowCon_type);
	if("N/A".equals(actionId)){
		actionId = "";
	}
	if("N/A".equals(meansId)){
		meansId = "";
	}
	if("N/A".equals(old_loginaccept)){
		old_loginaccept = "";
	}
	if("N/A".equals(lowCon_type)){
		lowCon_type = "";
	}
	
	%>
	<!-- ��ȡ������Ϣ:ר�����ר�ϵͳ��ֵ���˵��Ż� -->
	<s:service name="sFeeInfoQryWS_XML" >
		<s:param name="ROOT">
				<s:param name="iLoginAccept" type="string" value="" />
				<s:param name="iChnSource" type="string" value="0" />
				<s:param name="iOpCode" type="string" value="<%=opCode %>" />
				<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
				<s:param name="iLoginPWD" type="string" value="<%=password %>" />
				<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
				<s:param name="iUserPwd" type="string" value="" />
				<s:param name="iQryAccept" type="string" value="<%=serialNo %>" />
				<s:param name="iTabName" type="string" value="MK_ACTRECORDFEEEXT_INFO" />
		</s:param>
	</s:service>
<%	
	String feeInfoRtnCode = result.getString("RETURN_CODE");
	String feeInfoRtnMsg = result.getString("RETURN_MSG");	
	//�ֽ�
	String showCash="F";
	String cashMoney = result.getString("OUT_DATA.CASH.MONEY");//�ֽ���
	String cashName = result.getString("OUT_DATA.CASH.NAME");//����
	String cashFactorTen = result.getString("OUT_DATA.CASH.FACTOR_TEN");//0���ҳ� ��1����Ա��2������ ���˶�����0
	String cashFactorEleven = result.getString("OUT_DATA.CASH.FACTOR_ELEVEN");//�ҳ��ͳ�Ա�Լ���������
	String cashFactorNineteen = result.getString("OUT_DATA.CASH.FACTOR_NINETEEN");//����˺�
	if((!"".equals(cashMoney))&&cashMoney!=null && (!"N/A".equals(cashMoney))){
		showCash="T";
	}
	//ר��
	String showPayType = "F";
	List payTypeList = result.getList("OUT_DATA.PRODPRC_INFO");//ר����ϢLIST
	if(payTypeList!=null&&payTypeList.size()>0 && (!"N/A".equals(payTypeList.get(0)))){
		showPayType = "T";
	}
	//ϵͳ��ֵ
	String showSysPayType = "F";
	List sysPayList = result.getList("OUT_DATA.SYSPAYTYPE");//ר����ϢLIST
	if(sysPayList != null && sysPayList.size()>0 && (!"N/A".equals(sysPayList.get(0)))){
		showSysPayType = "T";
	}
	
    //�˵��Ż�
    String showBillDiscount ="F";
	String billDiscountRatio = result.getString("OUT_DATA.BILLDISCOUNT.RATIO");//���˵��Żݱ���
	String maxTotalDiscount = result.getString("OUT_DATA.BILLDISCOUNT.MAX_TOTAL_DISCOUNT");//���Ż�����
	String contractPeriod = result.getString("OUT_DATA.BILLDISCOUNT.CONTRACT_PERIOD");//��Լ��
	String billFactorTen = result.getString("OUT_DATA.BILLDISCOUNT.FACTOR_TEN");//0���ҳ� ��1����Ա��2���������˶�����0
	String billFactorEleven = result.getString("OUT_DATA.BILLDISCOUNT.FACTOR_ELEVEN");//�ҳ��ͳ�Ա�Լ���������
	String billFactorNineteen = result.getString("OUT_DATA.BILLDISCOUNT.FACTOR_NINETEEN");//����˺�
	if((!"".equals(billDiscountRatio))&&billDiscountRatio!=null&&(!"N/A".equals(billDiscountRatio))){
		showBillDiscount = "T";
	}
	
	//��������
	String showUnConsumer = "F";
	String unConFactorTen = result.getString("OUT_DATA.UNDERLINECONSUMER.FACTOR_TEN");//0���ҳ� ��1����Ա��2���������˶�����0
	String unConFactorEleven = result.getString("OUT_DATA.UNDERLINECONSUMER.FACTOR_ELEVEN");//�ҳ��ͳ�Ա�Լ���������
	String unConFactorNineteen = result.getString("OUT_DATA.UNDERLINECONSUMER.FACTOR_NINETEEN");//����˺�
	if((!"".equals(unConFactorTen)) && unConFactorTen != null && (!"N/A".equals(unConFactorTen))){
		showUnConsumer = "T";
	}
	
	%>
	
	<%
		String showScore = "F";//�˻���
		String scoreType = "";//��������
		String scoreValue= "";//����ֵ
		String offsettype = "";//��������
		String showNetScore = "F";//���ֵ�����������
		System.out.println("++++++++++++====act_Class="+act_Class);
		if(("70".equals(act_Class) && "g798".equals(opCode)) || ("19".equals(act_Class)) ){

	%>
			<!-- ��ȡ������Ϣ -->
			<s:service name="sScoreInfoQryWS_XML" >
				<s:param name="ROOT">
						<s:param name="iLoginAccept" type="string" value="" />
						<s:param name="iChnSource" type="string" value="0" />
						<s:param name="iOpCode" type="string" value="<%=opCode %>" />
						<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
						<s:param name="iLoginPWD" type="string" value="<%=password %>" />
						<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
						<s:param name="iUserPwd" type="string" value="" />
						<s:param name="iQryAccept" type="string" value="<%=serialNo %>" />
						<s:param name="iTabName" type="string" value="MK_ACTRECORDSCORE_INFO" />
				</s:param>
			</s:service>
	<%
			String scoreRtnCode = result.getString("RETURN_CODE");
			String scoreRtnMsg = result.getString("RETURN_MSG");	
			List scoreList = result.getList("OUT_DATA.SCORE_INFO");//������Ϣ
			if(scoreList != null && scoreList.size() > 0 && (!"N/A".equals(scoreList.get(0)))){
				tempMap = MapBean.isMap(scoreList.get(0));
				scoreType = (String)tempMap.get("SCORE_TYPE");
				offsettype = (String)tempMap.get("OFFSET_TYPE");
				scoreValue = (String)tempMap.get("DEDUCTION_VALUE");
				if("1".equals(scoreType)&&"1".equals(offsettype)){
					showScore = "T";
				}else if("1".equals(scoreType)&&"3".equals(offsettype)){
					showNetScore = "T";
				}
				
			}
		}
	%>
	
	
	<!-- ��ȡ�ն���Ϣ -->
	<s:service name="sResInfoQryWS_XML" >
		<s:param name="ROOT">
				<s:param name="iLoginAccept" type="string" value="" />
				<s:param name="iChnSource" type="string" value="0" />
				<s:param name="iOpCode" type="string" value="<%=opCode %>" />
				<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
				<s:param name="iLoginPWD" type="string" value="<%=password %>" />
				<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
				<s:param name="iUserPwd" type="string" value="" />
				<s:param name="iQryAccept" type="string" value="<%=serialNo %>" />
				<s:param name="iTabName" type="string" value="MK_ACTRECORDRES_INFO" />
		</s:param>
	</s:service>
	<%
	String resInfoRtnCode = result.getString("RETURN_CODE");
	String resInfoRtnMsg = result.getString("RETURN_MSG");	
	String showResource="F";
	String isComMeans = "F";//�Ƿ���Ӫ����,����Ӫ���������ж�
	String showGift = "F";
	
	String resourceBrand  = "";
	String resourceModel = "";
	String resourceFee = "";
	String resourceImeiCode = "";
	String resPercent = "";
	String resMonthPay = "";
	String resCostPrice = "";
	String resUndeadLine = "";
	String resPayResult = "0";
	
	String resourceBrandCode = "";
	String deliveryTime = "";
	String qualityLimit = "";
	String resourceResCode = "";
	String resRealFee = "";
	String marketPrice = "";//�г���
	String taxPercent = "";//˰��
	String taxFee = "";//˰��
	
	List resList = result.getList("OUT_DATA.RES_INFO");//�ն���Ϣ
	if(resList != null && resList.size() > 0 && (!"N/A".equals(resList.get(0)))){
		tempMap = MapBean.isMap(resList.get(0));
		resourceBrand = (String)tempMap.get("RES_NAME");//�ն�Ʒ��
		resourceModel = (String)tempMap.get("RES_MODEL");//�ն�����
		resourceFee = (String)tempMap.get("RES_SALE_FEE");//������
		resourceImeiCode = (String)tempMap.get("IMEI_NO");//�ն˴���
		resPercent = (String)tempMap.get("RESOURCE_PERCENT");//�ն�ϵ������
		resMonthPay = (String)tempMap.get("RESOURCE_MONTH_PAY");//�ն��µ�������
		
		resourceBrandCode = (String)tempMap.get("RES_TYPE_CODE");//��Դ�ͺű���
		deliveryTime = (String)tempMap.get("DELIVERY_TIME");//����ʱ��
		qualityLimit = (String)tempMap.get("QUALITY_LIMIT");//����ʱ��
		resourceResCode = (String)tempMap.get("RES_CODE");//��Դ����
		resRealFee = (String)tempMap.get("RES_REAL_FEE");//ʵ�տ�
		
		marketPrice = (String)tempMap.get("MARKET_PRICE");//�г���
		taxPercent = (String)tempMap.get("TAX_PERCENT");//˰��
		taxFee = (String)tempMap.get("TAX_FEE");//˰��
		System.out.println("+++++++++++++orderedInfo.jsp++11111111++++++++++++++++marketPrice="+marketPrice);
		System.out.println("+++++++++++++orderedInfo.jsp+++1111111111+++++++++++++++taxPercent="+taxPercent);
		System.out.println("+++++++++++++orderedInfo.jsp+++111111111111+++++++++++++++taxFee="+taxFee);
		if("".equals(marketPrice)||"N/A".equals(marketPrice) || "0".equals(marketPrice)){
			marketPrice = resourceFee;
		}
		if("".equals(taxPercent)||"N/A".equals(taxPercent)){
			taxPercent = "0.17";
		}
		if("".equals(taxFee)||"N/A".equals(taxFee)){
			taxFee = "0";
		}
		
		System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++marketPrice="+marketPrice);
		System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++taxPercent="+taxPercent);
		System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++taxFee="+taxFee);
		
	    resCostPrice = result.getString("OUT_DATA.RES_INFO.RES_COST_FEE");//�ն˳ɱ�
	    resUndeadLine = result.getString("OUT_DATA.RES_INFO.RESOURCE_UNDEADLINE");//�ն˲������
		if(resPercent != null && (!"".equals(resPercent)) && (!"N/A".equals(resPercent)) && resMonthPay != null && (!"".equals(resMonthPay)) && (!"N/A".equals(resMonthPay))){
			resPayResult = String.valueOf(Double.parseDouble(resCostPrice)*Double.parseDouble(resPercent)-
					Double.parseDouble(resourceFee)-Double.parseDouble(resUndeadLine)*Double.parseDouble(resMonthPay));
		}
		showResource="T";
		if("15".equals(actClass) && (!"0".equals(resPayResult))){//������Ӫ����ȡ���Զ���䲹������
			isComMeans = "T";
		}
	}
	
	String chkLength = "";
	List giftList = result.getList("OUT_DATA.GIFT_INFO");//����Ʒ��Ϣ
	if(giftList != null && giftList.size() > 0 && (!"N/A".equals(giftList.get(0)))){
		tempMap = MapBean.isMap(giftList.get(0));
		chkLength = (String)tempMap.get("CHK_LENGTH");//����ƷУ��λ��
		showGift = "T";
	}
	%>
	<!-- ��ȡ�ʷ���Ϣ�������ʷѡ����ʷѡ�С���ʷ� -->
	<s:service name="sProdInfoQryWS_XML" >
		<s:param name="ROOT">
				<s:param name="iLoginAccept" type="string" value="" />
				<s:param name="iChnSource" type="string" value="0" />
				<s:param name="iOpCode" type="string" value="<%=opCode %>" />
				<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
				<s:param name="iLoginPWD" type="string" value="<%=password %>" />
				<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
				<s:param name="iUserPwd" type="string" value="" />
				<s:param name="iQryAccept" type="string" value="<%=serialNo %>" />
				<s:param name="iTabName" type="string" value="MK_ACTRECORDPRODUCT_INFO" />
		</s:param>
	</s:service>
	<%
	String prodInfoRtnCode = result.getString("RETURN_CODE");
	String prodInfoRtnMsg = result.getString("RETURN_MSG");	
	//���ʷ�
    String showPriFee="F";
    
    List priFeeList = result.getList("OUT_DATA.PRIFEE_INFO");//�ʷ���ϢLIST 
    if(priFeeList != null && priFeeList.size() > 0 && (!"N/A".equals(priFeeList.get(0)))){
    	showPriFee = "T";
	}

    //�����ʷ�
    String showAddFee ="F";
    List addFeeList = result.getList("OUT_DATA.ADDFEE_INFO");//�����ʷ���ϢLIST 
    if(addFeeList != null && addFeeList.size() > 0 && (!"N/A".equals(addFeeList.get(0)))){
    	showAddFee = "T";
	}
    
    //ȡ���ʷѰ󶨸����ʷ�
    String showExtFee = "F";
    List extFeeList = result.getList("OUT_DATA.EXTFEE_INFO");
    if(!"N/A".equals(extFeeList.get(0))){
    	showExtFee = "T";
	}
 %>
 	<!-- ȡ����������Ϣ -->
	<s:service name="sExtInfoQryWS_XML" >
		<s:param name="ROOT">
				<s:param name="iLoginAccept" type="string" value="" />
				<s:param name="iChnSource" type="string" value="0" />
				<s:param name="iOpCode" type="string" value="<%=opCode %>" />
				<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
				<s:param name="iLoginPWD" type="string" value="<%=password %>" />
				<s:param name="iPhoneNo" type="string" value="<%=phoneNo %>" />
				<s:param name="iUserPwd" type="string" value="" />
				<s:param name="iQryAccept" type="string" value="<%=serialNo %>" />
				<s:param name="iTabName" type="string" value="MK_ACTRECORDEXT_INFO" />
		</s:param>
	</s:service>
<%
	
	String showSP = "F";
    String showGIFT = "F";
	String gSpStr = "";//ȫ��һ�廯�ʷѴ� 
	String extRtnCode = result.getString("RETURN_CODE");
	String extRtnMsg = result.getString("RETURN_MSG");
	String factorType = "";
	String factorOne = "";
	String factorTwo = "";
	String factorThree = "";
	String factorFour = "";
	String SCORE_VALUE = "";
	String GIFT_CODE = "";
	String PLANT_FLAG = "";
	List FQList = result.getList("OUT_DATA.FQ_INFO");
	List SPList = result.getList("OUT_DATA.SP_INFO");
	List GIFTList = result.getList("OUT_DATA.GIFT_INFO");
	if(!"N/A".equals(FQList.get(0))){
    	Map FQMap = MapBean.isMap(FQList.get(0));
    	if("FQ".equals((String)FQMap.get("RECORD_TYPE"))){
    		gSpStr = (String)FQMap.get("FACTOR_NINE");
    	}
    	
	}
	if(!"N/A".equals(SPList.get(0))){
		showSP = "T";
	}
	if(!"N/A".equals(GIFTList.get(0))){
		showGIFT = "T";
		Map GIFTMap = MapBean.isMap(GIFTList.get(0));
			SCORE_VALUE = (String)GIFTMap.get("FACTOR_ELEVEN");
			GIFT_CODE = (String)GIFTMap.get("FACTOR_TWELVE");
			PLANT_FLAG = (String)GIFTMap.get("FACTOR_THIRTEEN");
			System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++SCORE_VALUE="+SCORE_VALUE);
			System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++GIFT_CODE="+GIFT_CODE);
			System.out.println("+++++++++++++orderedInfo.jsp++++++++++++++++++PLANT_FLAG="+PLANT_FLAG);
			
	}
		
%>
 <!-- ���������ˮ-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept"  routerKey="region" routerValue="<%=reginCode%>" id="printAccept"/>

<%
String netRtnCode = "000000";
String netRtnMsg = "";
String netFlag = "";
String feeFlag = "-1";
String validType = "-1";
String netPhoneNo = "";
String netFeeCode = "";
String netFeeName = "";
String netEffTime = "";
String netExpTime = "";
String netNextFee = "";
String netNextFeeName = "";
String netNextEffTime = "";
String netNextExpTime = "";
String netInstId = "";
String netIdNo = "";
String netCustId = "";
String netBrandId = "";
String netGroupId = "";
if("1".equals(busiType) || "2".equals(busiType)){
%>
<!-- ��ȡ�����ʶ -->
 	<s:service name="WsNetCancel">
		<s:param name="ROOT">
				<s:param name="SERIAL_NO" type="string" value="<%=serialNo %>" />
				<s:param name="ACT_CLASS" type="string" value="<%=actClass %>" />
				<s:param name="LOGIN_NO" type="string" value="<%=loginNo %>" />
				<s:param name="PASSWORD" type="string" value="<%=password %>" />
				<s:param name="PRINT_ACCEPT" type="string" value="<%=printAccept %>" />
		</s:param>
	</s:service>
<%
	netRtnCode = result.getString("RETURN_CODE");
	netRtnMsg = result.getString("RETURN_MSG");
	netFlag = result.getString("CANCEL_FLAG");
	feeFlag = result.getString("FEE_FLAG");
	validType = result.getString("VALID_TYPE");
    netPhoneNo = result.getString("NET_NO");
    netFeeCode = result.getString("NET_FEE");
    netFeeName = result.getString("FEE_NAME");
    netEffTime = result.getString("EFF_TIME");
    netExpTime = result.getString("EXP_TIME");
    netNextFee = result.getString("NEXT_FEE");
    netNextFeeName = result.getString("NEXT_FEE_NAME");
    netNextEffTime = result.getString("NEXT_EFF_TIME");
    netNextExpTime = result.getString("NEXT_EXP_TIME");
    netInstId = result.getString("INST_ID");
    netIdNo = result.getString("NET_ID_NO");
    netCustId = result.getString("NET_CUST_ID");
    netBrandId = result.getString("NET_BRAND_ID");
    netGroupId = result.getString("NET_GROUP_ID");
    v_smCode = netBrandId;
    System.out.println("++++++++++++++++++++++++++++++gaopengSeeLOg+++++++++++++++ netBrandId = "+netBrandId);
    System.out.println("++++++++++++++++++++++++++++++gaopengSeeLOg+++++++++++++++ v_smCode = "+v_smCode);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netFlag = "+netFlag);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ feeFlag = "+feeFlag);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ validType = "+validType);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netPhoneNo = "+netPhoneNo);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netFeeCode = "+netFeeCode);
    System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netNextFee = "+netNextFee);
}



if("F".equals(showPayType)){
	print_flag = "1";
}else{
	print_flag = "2";
}


String netScoreRtnCode = "000000";
String netScoreRtnMsg = "";
String netScorePayMoney = "";
String netScore = "";

if("T".equals(showNetScore)){
	%>
	<!-- ��ȡ���ֵ�����������ʣ���� -->
 	<s:service name="bs_getMarkPayWS_XML">
		<s:param name="ROOT">
				<s:param name="PHONE_NO" type="string" value="<%=netPhoneNo %>" />
				<s:param name="PAY_TYPE" type="string" value="IR" />
		</s:param>
	</s:service>
<%
	netScoreRtnCode = result.getString("RETURN_CODE");
	netScoreRtnMsg = result.getString("RETURN_MSG");
	netScorePayMoney = result.getString("PAY_MONEY");
	//netScorePayMoney = "25.35";
     System.out.println("++++++++++++++++++++++++++++++++++++return+++++++++ netScorePayMoney = "+netScorePayMoney);
	if((!"".equals(netScorePayMoney)) && (!"N/A".equals(netScorePayMoney))){
		netScore = String.valueOf((Double.parseDouble(netScorePayMoney)*100)-(Double.parseDouble(netScorePayMoney)*100%100));
		 System.out.println("++++++++++++++++++++++++++++++++++++����+++++++++ netScore = "+netScore);
		netScore = netScore.substring(0, netScore.indexOf("."));
		System.out.println("++++++++++++++++++++++++++++++++++++����С����+++++++++ netScore = "+netScore);
	}else{
		netScore = "0";
		netScorePayMoney = "0";
	}
}
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ showNetScore = "+showNetScore);
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netScoreRtnCode = "+netScoreRtnCode);
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netScoreRtnMsg = "+netScoreRtnMsg);
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netScorePayMoney = "+netScorePayMoney);
System.out.println("+++++++++++++++++++++++++++++++++++++++++++++ netScore = "+netScore);


%>
	
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>Ӫ���ȡ��</title>
	</head>
	<body onload = "checkResPay();">
		<div id="operation">

						<s:service name="sMKTGetUsrInf">
								<s:param name="ROOT">
										<s:param name="PHONE_NO" type="string" value="<%=phoneNo%>" />
								</s:param>
						</s:service>	
								<%
									if ("0".equals(retCode) &&  result != null) {
										com.sitech.crmpd.core.bean.MapBean mp = new com.sitech.crmpd.core.bean.MapBean();
										List actions = result.getList("OUT_DATA.USER_INFO");
										HashMap map = new HashMap();
										if (null != actions) {
												Iterator itr = actions.iterator();
												while (itr.hasNext()) {
														UserInfoMap = mp.isMap(itr.next());
												}
										}
									}
							
								
									if (null == UserInfoMap){
										out.print("�û���Ϣ������!");
							    	}else{
							    		id_no_main = (String) UserInfoMap.get("ELEMENT0")==null?"":(String) UserInfoMap.get("ELEMENT0");//0 �û�ID
										cust_id_main = (String) UserInfoMap.get("ELEMENT1")==null?"":(String) UserInfoMap.get("ELEMENT1");//cust_id
										brand_id_main = (String) UserInfoMap.get("ELEMENT4")==null?"":(String) UserInfoMap.get("ELEMENT4");//brand_id
										group_id_main = (String) UserInfoMap.get("ELEMENT27")==null?"":(String) UserInfoMap.get("ELEMENT27");
										cust_name_main = (String) UserInfoMap.get("ELEMENT7")==null?"":(String) UserInfoMap.get("ELEMENT7");//7.�ͻ�����
										mode_name_main = (String) UserInfoMap.get("ELEMENT32")==null?"":(String) UserInfoMap.get("ELEMENT32");
										id_name_main = (String) UserInfoMap.get("ELEMENT18")==null?"":(String) UserInfoMap.get("ELEMENT18");
										cust_address_main = (String) UserInfoMap.get("ELEMENT15")==null?"":(String) UserInfoMap.get("ELEMENT15");//15 �ͻ���ַ					
										belong_code_main = (String) UserInfoMap.get("ELEMENT3")==null?"":(String) UserInfoMap.get("ELEMENT3");// 3 �û�����
										mode_code_main =(String) UserInfoMap.get("ELEMENT31")==null?"":(String) UserInfoMap.get("ELEMENT31");//31 ��ǰ���ʷ�code
							    		
							    	}
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ id_no_main = "+id_no_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ cust_id_main = "+cust_id_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ brand_id_main = "+brand_id_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ group_id_main = "+ group_id_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ cust_name_main = "+ cust_name_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ mode_name_main = "+ mode_name_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ id_name_main = "+ id_name_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ cust_address_main = "+ cust_address_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ belong_code_main = "+ belong_code_main);
									System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ mode_code_main = "+ mode_code_main);
				%>

			<div id="operation_table">
				<!-- --------�ֽ�------------ -->
				<%if("T".equals(showCash)){%>
				<div class="title">
					<div class="text">�ֽ�</div>
				</div>
				<div class="input">
					<table>
					<tr>
						<th>���	</th>
						<td><%=cashMoney%></td>
						<th></th><td></td>
						<th></th><td></td>
					</tr>
				</table>
				</div>
				<%} %>
				<!-- --------ר��------------ -->
				<%
				String split = "#";
				float allPays = 0;
				String allPayTypes = "";//ר��������ʹ�����#�ָ�
				String allPayMoneys = "";//ר��Ǯ������#�ָ�
				String allPayNames = "";//ר�����ƴ�����#�ָ�
				String allPayRtnTypes = "";//ר�����ʽ������#�ָ�
				String allPayRtnClasses = "";//ר������ʹ���û�е���~ռλ
				String allPayFactorTens = "";//ר��ҳ���ʶ����#�ָ�
				String allPayFactorElevens = "";//�ҳ��ͳ�Ա�Լ���������
				String allFactorTwelve = "";//ר�ʽ�ַ�������#�ָ�
				String allFactorNineteens = "";//ר�����ʽ
				if("T".equals(showPayType)&&payTypeList!=null){%>
				<div class="title">
					<div class="text">ר��</div>
				</div>
				<div class="input">
					<table>
						<tr>
							<th>ר������</th>
							<th>ר����</th>
							<th>��������</th>
							<th>ÿ�·������</th>
							<th>������������</th>
						</tr>
						<%  
							for(int i=0;i<payTypeList.size();i++ ){
							tempMap = MapBean.isMap(payTypeList.get(i));
							String payTypeName = (String)tempMap.get("NAME");
							String payTypeMoney = (String)tempMap.get("MONEY");
							String consumeTime = (String)tempMap.get("CONSUME_TIME");
							String allowPay = (String)tempMap.get("ALLOW_PAY");
							if("999999".equals(allowPay)){
								allowPay = "0";
							}
							String startTime = (String)tempMap.get("START_TIME");
							String returnType = (String)tempMap.get("RETURN_TYPE");//0���Ԥ�棻1������Ԥ��
							String returnClass = (String)tempMap.get("RETURN_CLASS");
							String factorTen = (String)tempMap.get("FACTOR_TEN");//0���ҳ� ��1����Ա��2������ ,���˶�����0
							String factorEleven = (String)tempMap.get("FACTOR_ELEVEN");//�ҳ��ͳ�Ա�Լ���������
							String factorTwelve = (String)tempMap.get("FACTOR_TWELVE");//ת�ʽ
							String factorThirteen = (String)tempMap.get("FACTOR_THIRTEEN");//�ɷ�����
							String factorNineteen = (String)tempMap.get("FACTOR_NINETEEN");//ר�����ʽ
							String payType = (String)tempMap.get("PAY_TYPE");//ר������
							allPays +=  Float.parseFloat(payTypeMoney);
							allPayNames += payTypeName + split;
							allPayRtnTypes += returnType + split;
							if("0".equals(returnType)){
								allPayRtnClasses += "~" + split;
							}else if("1".equals(returnType)){
								allPayRtnClasses += returnClass +split;
							}
							if("2".equals(factorThirteen)|| "1".equals(factorThirteen)){
								print_flag = "2";
								if("2".equals(factorThirteen)){
									print_flag = "1";
								}
							}
							allPayFactorTens += factorTen + split;
							allPayFactorElevens += factorEleven + split;
							allPayTypes += payType + split;
							allPayMoneys += payTypeMoney + split;
							allFactorTwelve += factorTwelve + split;
							allFactorNineteens +=factorNineteen + split;
						%>
						<tr>
							<td><%=payTypeName %></td>
							<td><%=payTypeMoney %></td>
							<td><%=consumeTime %></td>
							<td><%=allowPay %></td>
							<td><%=factorEleven %></td>
					   </tr>
					<%} %>
					</table>
				</div>
				<%} %>
				 <input type="hidden" name="allPaysTemp" id="allPaysTemp" value="<%=allPays %>">
				 <input type="hidden" name="allPayTypesTemp" id="allPayTypesTemp" value="<%=allPayTypes %>">
				 <input type="hidden" name="allPayNamesTemp" id="allPayNamesTemp" value="<%=allPayNames %>">
				 <input type="hidden" name="allPayMoneysTemp" id="allPayMoneysTemp" value="<%=allPayMoneys %>">
				 <input type="hidden" name="allPayRtnTypesTemp" id="allPayRtnTypesTemp" value="<%=allPayRtnTypes %>">
				 <input type="hidden" name="allPayRtnClassesTemp" id="allPayRtnClassesTemp" value="<%=allPayRtnClasses %>">
				 <input type="hidden" name="allPayFactorTensTemp" id="allPayFactorTensTemp" value="<%=allPayFactorTens %>">
				 <input type="hidden" name="allPayFactorElevensTemp" id="allPayFactorElevensTemp" value="<%=allPayFactorElevens %>">
				 <input type="hidden" name="allFactorTwelveTemp" id="allFactorTwelveTemp" value="<%=allFactorTwelve %>">
				 <input type="hidden" name="allFactorNineteensTemp" id="allFactorNineteensTemp" value="<%=allFactorNineteens %>">
				
				<!-- --------ϵͳ��ֵ------------ -->
				<%
					String sysPayTypeNameTemp = "";//ϵͳ��ֵ���ƴ�,��#�ָ�
					String sysPayTypeTemp = "";//ϵͳ��ֵ���ʹ�,��#�ָ�
					String sysPayMoneysTemp = "";//ϵͳ��ֵǮ��,��#�ָ�
					String sysRtnTypeTemp = "";//ϵͳ��ֵ������ʽ��,��#�ָ�
					String sysRtnClassTemp = "";//ϵͳ��ֵ�������ʹ�,��#�ָ�,û�е���~ռλ
					String sysFactorTenTemp = "";//0���ҳ� ��1����Ա��2���������˶�����0,��#�ָ�
					String sysFactorElevenTemp = "";//�ҳ��ͳ�Ա�Լ��������봮,��#�ָ�
					String sysFactorFourteenTemp = "";//ϵͳ��ֵ�Ƿ��н���,��#�ָ�
					String sysFactorFifteenTemp = "";//0��������1��������2�������͸���,��#�ָ�
					String sysFactorsixteenTemp = "";//ϵͳ��ֵ�������봮,��#�ָ�
					String sysFactorNineteenTemp = "";//��Ч��ʽ��,��#�ָ�
					String sysFactorTwentysixTemp = "";// 1-��ҵ��SPϵͳ��ֵ 0���������������
					if("T".equals(showSysPayType)){
				%>
				<div class="title">
					<div class="text">ϵͳ��ֵ</div>
				</div>
				<div class="input">
					<table>
						<tr>
							<th>ר������</th>
							<th>ϵͳ��ֵ���</th>
							<th>������������</th>
						</tr>
						<%  
							for(int i=0;i<sysPayList.size();i++ ){
								tempMap = MapBean.isMap(sysPayList.get(i));
								String sysPayTypeName = (String)tempMap.get("NAME");//ϵͳ��ֵ����
								String sysPayMoney = (String)tempMap.get("MONEY");//ϵͳ��ֵ���
								String sysPayType = (String)tempMap.get("PAY_TYPE");//ϵͳ��ֵ����
							 	String sysRtnType = (String)tempMap.get("RETURN_TYPE");//ϵͳ��ֵ������ʽ
								String sysRtnClass = "";
								if("1".equals(sysRtnType)){
									sysRtnClass = (String)tempMap.get("RETURN_CLASS");//ϵͳ��ֵ��������
									sysRtnClassTemp += sysRtnClass + split;
								}else{
									sysRtnClassTemp += "~" + split;
								}
								String sysFactorTen = (String)tempMap.get("FACTOR_TEN");//0���ҳ� ��1����Ա��2���������˶�����0
								String sysFactorEleven = (String)tempMap.get("FACTOR_ELEVEN");//�ҳ��ͳ�Ա�Լ���������
								String sysFactorFourteen = (String)tempMap.get("FACTOR_FOURTEEN");//ϵͳ��ֵ�Ƿ��н�
								String sysFactorFifteen = (String)tempMap.get("FACTOR_FIFTEEN");//0��������1��������2�������͸���
								String sysFactorsixteen = (String)tempMap.get("FACTOR_SIXTEEN");//ϵͳ��ֵ��������
								String sysFactorNineteen = (String)tempMap.get("FACTOR_NINETEEN");//��Ч��ʽ
								String sysFactorTwentysix = (String)tempMap.get("FACTOR_TWENTYFSIX");//ϵͳ��ֵ��ҵ���ʶ
							
								sysPayTypeNameTemp +=  sysPayTypeName + split;
								sysPayTypeTemp += sysPayType + split;
								sysPayMoneysTemp += sysPayMoney + split;
								sysRtnTypeTemp += sysRtnType + split;
								sysFactorTenTemp += sysFactorTen + split;
								sysFactorElevenTemp += sysFactorEleven + split;
								sysFactorFourteenTemp += sysFactorFourteen + split;
								sysFactorFifteenTemp += sysFactorFifteen + split;
								sysFactorsixteenTemp += sysFactorsixteen + split;
								sysFactorNineteenTemp +=sysFactorNineteen + split;
								//TODO �����ϵͳ��ֵ���ջأ���ʶƴ�� 2�����ݴ�������
								System.out.println("========================actClass = "+actClass);
								if(actClass.equals("72")|| actClass.equals("117")){
									sysFactorTwentysixTemp +="2" + split;
								}else if("3".equals(cancelType)){
									sysFactorTwentysixTemp +="1" + split;
								}else{
									sysFactorTwentysixTemp +=sysFactorTwentysix + split;
								}
						%>
						<tr>
							<td><%=sysPayTypeName %></td>
							<td><%=sysPayMoney %></td>
							<td><%=sysFactorEleven %></td>
					   </tr>
					<%
						} 
						System.out.println("========================sysPayTypeNameTemp = "+sysPayTypeNameTemp);
						System.out.println("========================sysPayTypeTemp = "+sysPayTypeTemp);
						System.out.println("========================sysPayMoneysTemp = "+sysPayMoneysTemp);
						System.out.println("========================sysRtnTypeTemp = "+sysRtnTypeTemp);
						System.out.println("========================sysRtnClassTemp = "+sysRtnClassTemp);
						System.out.println("========================sysFactorTenTemp = "+sysFactorTenTemp);
						System.out.println("========================sysFactorElevenTemp = "+sysFactorElevenTemp);
						System.out.println("========================sysFactorFourteenTemp = "+sysFactorFourteenTemp);
						System.out.println("========================sysFactorFifteenTemp = "+sysFactorFifteenTemp);
						System.out.println("========================sysFactorsixteenTemp = "+sysFactorsixteenTemp);
						System.out.println("========================sysFactorNineteenTemp = "+sysFactorNineteenTemp);
						System.out.println("========================sysFactorTwentysixTemp = "+sysFactorTwentysixTemp);
					%>
					</table>
				</div>
				<%} %>
				 <input type="hidden" name="sysPayTypeNameTemp" id="sysPayTypeNameTemp" value="<%=sysPayTypeNameTemp %>">
				 <input type="hidden" name="sysPayTypeTemp" id="sysPayTypeTemp" value="<%=sysPayTypeTemp %>">
				 <input type="hidden" name="sysPayMoneysTemp" id="sysPayMoneysTemp" value="<%=sysPayMoneysTemp %>">
				 <input type="hidden" name="sysRtnTypeTemp" id="sysRtnTypeTemp" value="<%=sysRtnTypeTemp %>">
				 <input type="hidden" name="sysRtnClassTemp" id="sysRtnClassTemp" value="<%=sysRtnClassTemp %>">
				 <input type="hidden" name="sysFactorTenTemp" id="sysFactorTenTemp" value="<%=sysFactorTenTemp %>">
				 <input type="hidden" name="sysFactorElevenTemp" id="sysFactorElevenTemp" value="<%=sysFactorElevenTemp %>">
				 <input type="hidden" name="sysFactorFourteenTemp" id="sysFactorFourteenTemp" value="<%=sysFactorFourteenTemp %>">
				 <input type="hidden" name="sysFactorFifteenTemp" id="sysFactorFifteenTemp" value="<%=sysFactorFifteenTemp %>">
				 <input type="hidden" name="sysFactorsixteenTemp" id="sysFactorsixteenTemp" value="<%=sysFactorsixteenTemp %>">
				 <input type="hidden" name="sysFactorNineteenTemp" id="sysFactorNineteenTemp" value="<%=sysFactorNineteenTemp %>">
				 <input type="hidden" name="sysFactorTwentysixTemp" id="sysFactorTwentysixTemp" value="<%=sysFactorTwentysixTemp %>">
				
				<!-- --------�ն�------------ -->
				<% if("T".equals(showResource)){%>
				<div class="title">
					<div class="text">�ն�</div>
				</div>
				<div class="input">	
					<table>
						<tr>
							<th>�ն�Ʒ��</th>
							<td><%=resourceBrand %></td>
							<th>�ն�����</th>
							<td><%=resourceModel %></td>
							<th>������</th>
							<td><%=resourceFee %></td>
							<th>ʵ�տ�</th>
							<td><%=resRealFee %></td>
						</tr>
					</table>
				</div>
				<%} %>
				<!-- --------���ʷѼ������ѡ�ʷ�------------ -->
				<%@ include file="/npage/se179/feeInfo.jsp"%>
				
				<!-- --------�����ʷ�------------ -->
				<%
				
				String addFeeCodeTemp = "";
				String addFeeNameTemp = "";
				String dateTypeTemp = "";
				String phoneNoStrTemp = "";
				String phoneNoStrType = "";
				String oprTypeStrTemp = "";
				String offerTypeStrTemp = "";
				String unitStrTemp = "";
				String addFeeIdNoStrTemp = "";
				String addFeeCustIdStrTemp = "";
				String addFeeBrandIdStrTemp = "";
				if("T".equals(showAddFee)){
				%>
				<div class="title">
					<div class="text">�����ʷ�</div>
				</div>
				<div class="input">	
					<table>
					<%
					for(int i=0;i<addFeeList.size();i++ ){
						tempMap = MapBean.isMap(addFeeList.get(i));
						String phoneType = (String)tempMap.get("PHONE_TYPE");
						String memPhoneNo = (String)tempMap.get("PHONE_NO");
						String addFeeCode = (String)tempMap.get("ADDFEE_CODE");
						String addFeeName = (String)tempMap.get("ADDFEE_NAME");
						addFeeCodeTemp = addFeeCodeTemp+addFeeCode.trim() + split;
						addFeeNameTemp = addFeeNameTemp+addFeeName.trim() + split;
						dateTypeTemp = dateTypeTemp + expType + split;
						phoneNoStrTemp =phoneNoStrTemp + memPhoneNo + split;
						phoneNoStrType =phoneNoStrType + phoneType + split;
						oprTypeStrTemp = oprTypeStrTemp + "3" + split;
						offerTypeStrTemp = offerTypeStrTemp + "1" + split;//�ʷ�����(0�����ʷ� 1�������ʷ�)
						unitStrTemp = unitStrTemp + "x"+split; 
					%>
						<tr>
							<th>�����ʷѱ���</th>
							<td><%=addFeeCode %></td>
							<th>�����ʷ�����</th>
							<td><%=addFeeName %></td>
					<%
						if("0".equals(phoneType)){
					%>
							<th>�����ֻ�����</th>
							<td><%=memPhoneNo %></td>
					<%
						}else{
					%>
							<th>��Ա�ֻ�����</th>
							<td><%=memPhoneNo %></td>
					<%		
						}
					%>
						</tr>
						
						<s:service name="sMKTGetUsrInf">
							<s:param name="ROOT">
								<s:param name="PHONE_NO" type="string" value="<%=memPhoneNo%>" />
							</s:param>
						</s:service>
					<%
						String idNo = result.getString("OUT_DATA.USER_INFO.ELEMENT0");
						String custId = result.getString("OUT_DATA.USER_INFO.ELEMENT1");
						String belongCode = result.getString("OUT_DATA.USER_INFO.ELEMENT3");
						String memgroupId = result.getString("OUT_DATA.USER_INFO.ELEMENT27");
						String brandId = result.getString("OUT_DATA.USER_INFO.ELEMENT4");
						String modeCode = result.getString("OUT_DATA.USER_INFO.ELEMENT31");
						
						addFeeIdNoStrTemp =addFeeIdNoStrTemp + idNo + split;
						addFeeCustIdStrTemp = addFeeCustIdStrTemp+ custId + split;
						addFeeBrandIdStrTemp = addFeeBrandIdStrTemp + brandId +split;
					
					}
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ phoneNoStrTemp = "+ phoneNoStrTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ addFeeCodeTemp = "+ addFeeCodeTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ addFeeNameTemp = "+ addFeeNameTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ addFeeIdNoStrTemp = "+ addFeeIdNoStrTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ addFeeCustIdStrTemp = "+ addFeeCustIdStrTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ addFeeBrandIdStrTemp = "+ addFeeBrandIdStrTemp);
					
					%>
					</table>
				</div>
				<%} %>
				<input type="hidden" name="addFeeCodeTemp" id="addFeeCodeTemp" value="<%=addFeeCodeTemp %>">
				<input type="hidden" name="addFeeNameTemp" id="addFeeNameTemp" value="<%=addFeeNameTemp %>">
				<input type="hidden" name="dateTypeTemp" id="dateTypeTemp" value="<%=dateTypeTemp %>">
				<input type="hidden" name="phoneNoStrTemp" id="phoneNoStrTemp" value="<%=phoneNoStrTemp %>">
				<input type="hidden" name="phoneNoStrType" id="phoneNoStrType" value="<%=phoneNoStrType %>">
				<input type="hidden" name="oprTypeStrTemp" id="oprTypeStrTemp" value="<%=oprTypeStrTemp %>">
				<input type="hidden" name="offerTypeStrTemp" id="offerTypeStrTemp" value="<%=offerTypeStrTemp %>">
				<input type="hidden" name="unitStrTemp" id="unitStrTemp" value="<%=unitStrTemp %>">
				
				<!-- --------�˵��Ż�------------ -->
				<%
					if("T".equals(showBillDiscount)){
				%>
				<div class="title">
					<div class="text">
						�˵��Ż�
					</div>
				</div>
					<div class="input">	
						<table>
							<tr>
								<th>���˵��Żݱ��� </th>
								<td><%=billDiscountRatio %></td>
								<th>���Ż�����</th>
								<td><%=maxTotalDiscount %></td>
								<th>��Լ��</th>
								<td><%=contractPeriod %></td>
							</tr>
						</table>
				</div>
				<%
					} 		
		 		 %>
		 		 
		 		<!-- --------SPҵ��------------ -->
				<%
				String spCodeTemp = "";
				String busiCodeTemp = "";
				String startDateTemp = "";
				String endDateTemp = "";
				String boxIdTemp = "";
				if("T".equals(showSP)){
				%>
				<div class="title">
					<div class="text">SPҵ��</div>
				</div>
				<div class="input">	
					<table>
					<%
					for(int i=0;i<SPList.size();i++ ){
						tempMap = MapBean.isMap(SPList.get(i));
						String type = (String)tempMap.get("FACTOR_TYPE");
						String spCode = (String)tempMap.get("FACTOR_ONE");
						String busiCode = (String)tempMap.get("FACTOR_TWO");
						String startDate = (String)tempMap.get("FACTOR_THREE");
						String endDate = (String)tempMap.get("FACTOR_FOUR");
						String boxId = (String)tempMap.get("FACTOR_FIVE");
						spCodeTemp += spCode.trim() + split;
						busiCodeTemp += busiCode.trim() + split;
						startDateTemp += startDate.trim() + split;
						if("0".equals(endDate.trim())){
							endDateTemp += endDate.trim() + split;//ƴ����ʱ��
						}else{
							endDateTemp += oper_time.trim() + split;//ƴ��ǰʱ��
						}
						boxIdTemp += boxId.trim() + split;//ƴ�����б���
					%>
						<tr>
							<th>��ҵ����</th>
							<td><%=spCode %></td>
							<th>ҵ�����</th>
							<td><%=busiCode %></td>
						</tr>
					<%
					}
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ spCodeTemp = "+ spCodeTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ busiCodeTemp = "+ busiCodeTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ startDateTemp = "+ startDateTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ endDateTemp = "+ endDateTemp);
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++ boxIdTemp = "+ boxIdTemp);
					%>
					</table>
				</div>
				<%} %>
				<input type="hidden" name="spCodeTemp" id="spCodeTemp" value="<%=spCodeTemp %>">
				<input type="hidden" name="busiCodeTemp" id="busiCodeTemp" value="<%=busiCodeTemp %>">
				<input type="hidden" name="startDateTemp" id="startDateTemp" value="<%=startDateTemp %>">
				<input type="hidden" name="endDateTemp" id="endDateTemp" value="<%=endDateTemp %>">
				<input type="hidden" name="boxIdTemp" id="boxIdTemp" value="<%=boxIdTemp %>">
				
			    <!-- --------���ֵֿۿ�������------------ -->
				<%if("T".equals(showNetScore)){%>
				<div class="title">
					<div class="text">���ֵֿ۰����</div>
				</div>
				<div class="input">
					<table>
					<tr>
						<th>ʣ��������</th>
						<td><%=netScorePayMoney%></td>
						<th>���˻�����ֵ</th>
						<td><%=netScore %></td>
						<th></th><td></td>
					</tr>
				</table>
				</div>
				<%} %>
				
				<%if("".equals(selectType)){ %>
				<div class="input">
		 			<table>
		 				<tr>
			 				<th>��������</th>
			 				<td><input type="text" name = "resFee"  id  = "resFee"  onkeyup="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]};"/></td>
			 				<th>�ն�����</th>
			 				<td><input type="text" name = "resModel" id  = "resModel"></td>
		 				</tr>
		 				<tr>
			 				<th>������Ʒ��</th>
			 				<td><input type="text" name = "giftFee" id  = "giftFee" onkeyup="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]};"/></td>
			 				<th>����Ʒ����</th>
			 				<td><input type="text" name = "gfitModel" id  = "gfitModel"></td>
		 				</tr>
		 				<tr>
			 				<th>�����ֿ�</th>
			 				<td><input type="text" name = "scoreFee" id  = "scoreFee" onkeyup="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]};"/></td>
		 				</tr>
		 			</table>
		 		</div>
		 		<%}else{ %>
		 		<div class="input">
		 			<table>
		 				<tr>
			 				<th>�Ƿ���ش���Ʒ</th>
			 				<td>
			 				   <select id="choosType" name="choosType" onchange="javascript:hidshowTR();">
								 <option value="0">��</option>
								 <option value="1">��</option>
							   </select>
							</td>
							<%if("T".equals(showScore)){%>
							<th>�˵�������</th>
			 				<td><%=scoreValue %></td>
							<%	}else{%>
							<th></th>
			 				<td></td>
							<%} %>
			 				
		 				</tr>
		 				<tr id="tr_1">
			 				<th>������Ʒ��</th>
			 				<td><input type="text" name = "giftFee" id  = "giftFee" onkeyup="this.value=this.value.replace(/[^\.\d]/g,'');if(this.value.split('.').length>2){this.value=this.value.split('.')[0]+'.'+this.value.split('.')[1]};"/></td>
			 				<th>����Ʒ����</th>
			 				<td><input type="text" name = "gfitModel" id  = "gfitModel"></td>
		 				</tr>
		 				
		 				
		 				<%if("T".equals(showGIFT)){%>
							<th>�ֿ�ȯ�ֿۻ���ֵ</th>
			 				<td><%=SCORE_VALUE %></td>
			 				<th>�ֿ�ȯ��</th>
			 				<td><%=GIFT_CODE %></td>
							<%	} %>
		 				
		 				
		 			</table>
		 		</div>	 		
		 		<%}%>
		 		<% 
		 			String repayResourceFees = resRealFee ;
					String TotConsumMoneys = "0.00";
		 			if(!"".equals(selectType)){
						String repayRtnCode = "";
						String repayRtnMsg = "";
						String PhoneNo = "";
						String allFactorElevens = "";
						String allTypes = "";
						String allMoneys = "";
						if("T".equals(showSysPayType)){
							allFactorElevens = allPayFactorElevens+sysFactorElevenTemp;
							allTypes = allPayTypes+sysPayTypeTemp;
							allMoneys = allPayMoneys+sysPayMoneysTemp;
						}else{
							allFactorElevens = allPayFactorElevens;
							allTypes = allPayTypes;
							allMoneys = allPayMoneys;
						}
						if("2".equals(selectType)|| "3".equals(selectType)){
					 	%>
						 	<!-- ����ר��������Ϣ��ѯ -->
						 	<s:service name="sGetPayInfoWS_XML">
								<s:param name="ROOT">
										<s:param name="iOpCode" type="string" value="<%=opCode %>" />
										<s:param name="iLoginNo" type="string" value="<%=loginNo %>" />
										<s:param name="iPhoneNo" type="string" value="<%=allFactorElevens %>" />
										<s:param name="iPayType" type="string" value="<%=allTypes %>" />
										<s:param name="iPayMoney" type="string" value="<%=allMoneys %>" />
								</s:param>
							</s:service>
						<%
							Map sGetMap = new HashMap();
							if ("000000".equals(retCode)) {
								List sGetPaylist = result.getList("OUT_DATA.BUSI_INFO");
								for(int i =0;i<sGetPaylist.size();i++){
									sGetMap = MapBean.isMap(sGetPaylist.get(i));
									if(sGetMap==null) continue;
									PhoneNo = (String)sGetMap.get("PhoneNo");
									String TotConsumMoney= (String)sGetMap.get("TotConsumMoney");
									TotConsumMoneys = String.valueOf(Double.parseDouble(TotConsumMoneys)+Double.parseDouble(TotConsumMoney));
								}
								if("3".equals(selectType)){
								 	repayResourceFees = String.valueOf(Double.parseDouble(repayResourceFees)-Double.parseDouble(TotConsumMoneys));
								}
							}else {
						%>
							<script type="text/javascript">
								$(document).ready(function(){
										showDialog("���üƷѲ�ѯ�ͻ�����ר��ӿ�:sGetPayInfo��������ϵ����Ա����",0);
								});
							</script>
						<%
							return;
							}
						}
					 %>	
					<div class="input">
			 			<table>
			 				<tr>
				 				<th>�˻��ͻ��ֽ�</th>
				 				<td><%=repayResourceFees %> Ԫ</td>
				 				<th>�ͻ������ѵ�ר��</th>
				 				<td><%=TotConsumMoneys %> Ԫ</td>
			 				</tr>
			 			</table>
			 		</div>
		 		<%} %>		 		
		 		 <div class="input">
		 			<table>
		 				<tr>
			 				<th>��ע</th>
			 				<td>
			 					<textarea name="note" id="note" rows="5" cols="100" ></textarea>
			 					<font color='red'>*</font>
			 				</td>
		 				</tr>
		 			</table>
		 		</div>

		 		<script type="text/javascript" src="/npage/se179/js/sitechJson.js"></script>
		 		<!-- ������װ -->
		 		<%@ include file="/npage/se179/jsXML.jsp"%>
		 		<!-- ����JS -->
		 		<%@ include file="/npage/se179/jsGlobal.jsp"%>
		 		<!--����ͳһ�ɷ�ҳ��-->
		        <%@ include file="/npage/se112/public_title_name_p.jsp"%>
				<div id="operation_button">
					<input class="b_foot" type="button"  name="qry" id="qry" value="ȷ��" onclick="doSub();">
				</div>
			</div><!-- operation_table end div -->
		</div>
	</body>
</html>
<script type="text/javascript">
//����Ǽ�����Ӫ�������򲹹������Զ���� 
function checkResPay(){
	checkServiceRtn();
	if("T" == "<%=isComMeans%>"){
		document.getElementById("resFee").value = "<%=resPayResult%>";
	}else if("F" == "<%=isComMeans%>" && "<%=opCode%>"=="g796"){
		document.getElementById("resFee").value = "";
	}
}
</script>