<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String ID_NO = (String)request.getParameter("ID_NO");
	String PHONE_NO = (String)request.getParameter("PHONE_NO");
	String REGION_CODE = (String)request.getParameter("REGION_CODE");
	String ACT_ID = (String)request.getParameter("ACT_ID");
	String MEANS_ID = (String)request.getParameter("MEANS_ID");
	String CUST_GROUP_ID = (String)request.getParameter("CUST_GROUP_ID");
	String BRAND_ID = (String)request.getParameter("BRAND_ID");
	String GROUP_ID = (String)request.getParameter("GROUP_ID");
	String MODE_CODE = (String)request.getParameter("MODE_CODE");
		
 %>
	<s:service name="WsGetMeansContent">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="ID_NO" type="string" value="<%=ID_NO%>" />
				<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO%>" />
				<s:param name="REGION_CODE" type="string" value="<%=REGION_CODE%>" />
				<s:param name="ACT_ID" type="string" value="<%=ACT_ID%>" />
				<s:param name="MEANS_ID" type="string" value="<%=MEANS_ID%>" />
				<s:param name="CUST_GROUP_ID" type="string" value="<%=CUST_GROUP_ID%>" />
				<s:param name="BRAND_ID" type="string" value="<%=BRAND_ID%>" />
				<s:param name="GROUP_ID" type="string" value="<%=GROUP_ID%>" />
				<s:param name="MODE_CODE" type="string" value="<%=MODE_CODE%>" />
				<s:param name="CHAN_TYPE" type="string" value="0" />
			</s:param>
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String DETAIL_MSG = result.getString("DETAIL_MSG");	

	String meansJsonStr = "";    
	String flag = "";            
	String cashInfo = "";      
	String specialfunds = "";    
	String assispecialfunds = "";
	String systemPay = "";       
	String agreementFEE = "";       
	String bankPayFee = "";      
	String giftInfo = "";        
	String isPhone = "";         
	String clientInfo = "";
	String priceCard="";       
	String ssfeeInfo = "";       
	String assiFeeInfo = "";     
	String spInfo = "";          
	String subScore = "";        
	String reScore = "";         
	String netcode = "";         
	String orderTypeInfo = "";   
	String specialallfunds = ""; 
	String allFee = "";          
	String gAddFee = "";         
	String gWlan = "";           
	String gData = "";           
	String gRes = "";            
	String bindingFeeInfo = "";  
	String memberFee = "";       
	String tdFee = "";           
	String memNo = "";      
	String memFee = "";      
	String memAddFee = "";       
	String memFund = "";         
	String memSysFee = "";   

	String familyLowType = "";
	String taxClass = "";//��˰��ʽ
	String broadDiscountPay = "";  
	String html = "";    
	String contracttime = "";//��Լ��
	String templet ="";//ģ�� 
	String giftMoney = "";//�ɰ�����ȯ
	
	if ("0".equals(RETURN_CODE)) {
		meansJsonStr = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEANSJSONSTR");//json��
		flag = (String) result.getValue("OUT_DATA.MEANS.MEAN.FLAG");//flag������֤
		cashInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.CASHINFO");//�ֽ�
		specialfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPECIALFUNDS");//ר��
		assispecialfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.ASSISPECIALFUNDS");//����ר��
		systemPay = (String) result.getValue("OUT_DATA.MEANS.MEAN.SYSTEMPAY");//ϵͳ��ֵ
		agreementFEE = (String) result.getValue("OUT_DATA.MEANS.MEAN.AGREEMENTFEE");//�ն��ʷѷ���
		bankPayFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.BANKPAYFEE");//���п����ڸ���
		giftInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.GIFTINFO");//����Ʒ
		isPhone = (String) result.getValue("OUT_DATA.MEANS.MEAN.ISPHONE");//�ֻ�ƾ֤
		clientInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.CLIENTINFO");//�ն�
		priceCard = (String) result.getValue("OUT_DATA.MEANS.MEAN.PRICECARD");//�����мۿ�
		ssfeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.SSFEEINFO");//���ʷ�
		assiFeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.ASSIFEEINFO");//�����ʷ�
		spInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPINFO");//spҵ��
		subScore = (String) result.getValue("OUT_DATA.MEANS.MEAN.SUBSCORE");//�ۼ�����
		reScore = (String) result.getValue("OUT_DATA.MEANS.MEAN.RESCORE");//��������
		netcode = (String) result.getValue("OUT_DATA.MEANS.MEAN.NETCODE");//�������
		orderTypeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.ORDERTYPEINFO");//������ʽ
		specialallfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPECIALALLFUNDS");//ȫ��ר��
		allFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.ALLFEE");//ȫ�����ʷ�
		gAddFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.GADDFEE");//ȫ�������ʷ�
		gWlan = (String) result.getValue("OUT_DATA.MEANS.MEAN.GWLAN");//ȫ��WLAN
		gData = (String) result.getValue("OUT_DATA.MEANS.MEAN.GDATA");//ȫ������ҵ��
		gRes = (String) result.getValue("OUT_DATA.MEANS.MEAN.GRES");//ȫ���ն�
		bindingFeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.BINDINGFEEINFO");//ȫ���ذ󸽼��ʷ�
		memberFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMBERFEE");//��Ա�ʷ�
		tdFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.TDFEE");//TD�ʷ�
		memNo = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMNO");//��Ա����
		memFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSSFEE");//��Ա���ʷ�
		memAddFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMASSIFEE");//��Ա�����ʷ�
		memFund = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSPECIALFUNDS");//��Աר��	
		memSysFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSYSTEMPAY");//��Աϵͳ��ֵ
		broadDiscountPay = (String) result.getValue("OUT_DATA.MEANS.MEAN.BROADDISCOUNTPAY");//���ϵͳ��ֵ/����ۿ� 
		html = (String) result.getValue("OUT_DATA.MEANS.MEAN.HTML");//��Աϵͳ��ֵ
		System.out.println("==============++++++++++++++++++html:"+html);
		//modify 2014-3-7 17:26:03
		familyLowType = (String) result.getValue("OUT_DATA.MEANS.MEAN.FAMILYLOWTYPE");//��������H47
		//taxClass = (String) result.getValue("OUT_DATA.MEANS.MEAN.TAX_CLASS");//��˰��ʽ
		//System.out.println("==============++++++++++++++++++taxClass:"+taxClass);
		contracttime = (String) result.getValue("OUT_DATA.MEANS.MEAN.CONTRACTTIME");//
		templet = (String) result.getValue("OUT_DATA.MEANS.MEAN.TEMPLET");//ģ��ҵ��
		giftMoney = (String) result.getValue("OUT_DATA.MEANS.MEAN.SCOREMONRY");//�ɰ�����ȯ
		System.out.println("==============++++++++++++++++++giftMoney:"+giftMoney);
	}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("DETAIL_MSG","<%=DETAIL_MSG%>");
		
		
		response.data.add("meansJsonStr","<%=meansJsonStr%>");
		response.data.add("flag","<%=flag%>");
		response.data.add("cashInfo","<%=cashInfo%>");
		response.data.add("specialfunds","<%=specialfunds%>");
		response.data.add("assispecialfunds","<%=assispecialfunds%>");
		response.data.add("systemPay","<%=systemPay%>");
		response.data.add("agreementFEE","<%=agreementFEE%>");
		response.data.add("bankPayFee","<%=bankPayFee%>");
		response.data.add("giftInfo","<%=giftInfo%>");
		response.data.add("isPhone","<%=isPhone%>");
		response.data.add("clientInfo","<%=clientInfo%>");
		response.data.add("priceCard","<%=priceCard%>");
		response.data.add("ssfeeInfo","<%=ssfeeInfo%>");
		response.data.add("assiFeeInfo","<%=assiFeeInfo%>");
		response.data.add("spInfo","<%=spInfo%>");
		response.data.add("subScore","<%=subScore%>");
		response.data.add("reScore","<%=reScore%>");
		response.data.add("netcode","<%=netcode%>");
		response.data.add("orderTypeInfo","<%=orderTypeInfo%>");
		response.data.add("specialallfunds","<%=specialallfunds%>");
		response.data.add("allFee","<%=allFee%>");
		response.data.add("gAddFee","<%=gAddFee%>");
		response.data.add("gWlan","<%=gWlan%>");
		response.data.add("gData","<%=gData%>");
		response.data.add("gRes","<%=gRes%>");
		response.data.add("bindingFeeInfo","<%=bindingFeeInfo%>");
		response.data.add("memberFee","<%=memberFee%>");
		response.data.add("tdFee","<%=tdFee%>");
		response.data.add("memNo","<%=memNo%>");
		response.data.add("memFee","<%=memFee%>");
		response.data.add("memAddFee","<%=memAddFee%>");
		response.data.add("memFund","<%=memFund%>");
		response.data.add("memSysFee","<%=memSysFee%>");
		response.data.add("broadDiscountPay","<%=broadDiscountPay%>");
		response.data.add("familyLowType","<%=familyLowType%>");
		
		response.data.add("html","<%=html%>");
		response.data.add("contracttime","<%=contracttime%>");
		response.data.add("templet","<%=templet%>");
		response.data.add("giftmoney","<%=giftMoney%>");
		core.ajax.receivePacket(response);
