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
	String taxClass = "";//计税方式
	String broadDiscountPay = "";  
	String html = "";    
	String contracttime = "";//合约期
	String templet ="";//模板 
	String giftMoney = "";//荷包电子券
	
	if ("0".equals(RETURN_CODE)) {
		meansJsonStr = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEANSJSONSTR");//json串
		flag = (String) result.getValue("OUT_DATA.MEANS.MEAN.FLAG");//flag用于验证
		cashInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.CASHINFO");//现金
		specialfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPECIALFUNDS");//专款
		assispecialfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.ASSISPECIALFUNDS");//副卡专款
		systemPay = (String) result.getValue("OUT_DATA.MEANS.MEAN.SYSTEMPAY");//系统充值
		agreementFEE = (String) result.getValue("OUT_DATA.MEANS.MEAN.AGREEMENTFEE");//终端资费分离
		bankPayFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.BANKPAYFEE");//银行卡分期付款
		giftInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.GIFTINFO");//促销品
		isPhone = (String) result.getValue("OUT_DATA.MEANS.MEAN.ISPHONE");//手机凭证
		clientInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.CLIENTINFO");//终端
		priceCard = (String) result.getValue("OUT_DATA.MEANS.MEAN.PRICECARD");//电子有价卡
		ssfeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.SSFEEINFO");//主资费
		assiFeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.ASSIFEEINFO");//附加资费
		spInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPINFO");//sp业务
		subScore = (String) result.getValue("OUT_DATA.MEANS.MEAN.SUBSCORE");//扣减积分
		reScore = (String) result.getValue("OUT_DATA.MEANS.MEAN.RESCORE");//抵消积分
		netcode = (String) result.getValue("OUT_DATA.MEANS.MEAN.NETCODE");//宽带号码
		orderTypeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.ORDERTYPEINFO");//订购方式
		specialallfunds = (String) result.getValue("OUT_DATA.MEANS.MEAN.SPECIALALLFUNDS");//全网专款
		allFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.ALLFEE");//全网主资费
		gAddFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.GADDFEE");//全网附加资费
		gWlan = (String) result.getValue("OUT_DATA.MEANS.MEAN.GWLAN");//全网WLAN
		gData = (String) result.getValue("OUT_DATA.MEANS.MEAN.GDATA");//全网数据业务
		gRes = (String) result.getValue("OUT_DATA.MEANS.MEAN.GRES");//全网终端
		bindingFeeInfo = (String) result.getValue("OUT_DATA.MEANS.MEAN.BINDINGFEEINFO");//全网必绑附加资费
		memberFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMBERFEE");//成员资费
		tdFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.TDFEE");//TD资费
		memNo = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMNO");//成员号码
		memFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSSFEE");//成员主资费
		memAddFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMASSIFEE");//成员附加资费
		memFund = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSPECIALFUNDS");//成员专款	
		memSysFee = (String) result.getValue("OUT_DATA.MEANS.MEAN.MEMSYSTEMPAY");//成员系统充值
		broadDiscountPay = (String) result.getValue("OUT_DATA.MEANS.MEAN.BROADDISCOUNTPAY");//宽带系统充值/宽带折扣 
		html = (String) result.getValue("OUT_DATA.MEANS.MEAN.HTML");//成员系统充值
		System.out.println("==============++++++++++++++++++html:"+html);
		//modify 2014-3-7 17:26:03
		familyLowType = (String) result.getValue("OUT_DATA.MEANS.MEAN.FAMILYLOWTYPE");//低消类型H47
		//taxClass = (String) result.getValue("OUT_DATA.MEANS.MEAN.TAX_CLASS");//计税方式
		//System.out.println("==============++++++++++++++++++taxClass:"+taxClass);
		contracttime = (String) result.getValue("OUT_DATA.MEANS.MEAN.CONTRACTTIME");//
		templet = (String) result.getValue("OUT_DATA.MEANS.MEAN.TEMPLET");//模板业务
		giftMoney = (String) result.getValue("OUT_DATA.MEANS.MEAN.SCOREMONRY");//荷包电子券
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
