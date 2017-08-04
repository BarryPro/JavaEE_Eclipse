<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se179/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iChnSource = request.getParameter("iChnSource");
	String opCode = request.getParameter("opCode");
	String iLoginNo = request.getParameter("iLoginNo");
	String iLoginPWD = request.getParameter("iLoginPWD");
	String iPhoneNo = request.getParameter("iPhoneNo");
	String iOprAccept = request.getParameter("iOprAccept");
	String iPhoneNoStr = request.getParameter("iPhoneNoStr");
	String iOfferIdStr = request.getParameter("iOfferIdStr");
	String iOprTypeStr = request.getParameter("iOprTypeStr");
	String iDateTypeStr = request.getParameter("iDateTypeStr");
	String iOfferTypeStr = request.getParameter("iOfferTypeStr");
	String iUnitStr = request.getParameter("iUnitStr");
	String BUSI_ID = request.getParameter("BUSI_ID");//订购时流水 省内魔百合添加
	String iOffsetStr = request.getParameter("iOffsetStr");
	String meansId = request.getParameter("meansId");
	System.out.println("||||||||||||||||||||||||====取消getEffectTime=============meansId===="+meansId);
	System.out.println("||||||||||||||||||||||||====取消getEffectTime=============BUSI_ID===="+BUSI_ID);
		
 %>
	<s:service name="sMarkDateQryWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="<%=BUSI_ID%>" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="<%=opCode %>" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iOprAccept" type="string" value="<%=iOprAccept%>" />
			<s:param name="iMarkType" type="string" value="1" />
			<s:param name="iPhoneNoStr" type="string" value="<%=iPhoneNoStr%>" />
			<s:param name="iOfferIdStr" type="string" value="<%=iOfferIdStr%>" />
			<s:param name="iOprTypeStr" type="string" value="<%=iOprTypeStr%>" />
			<s:param name="iDateTypeStr" type="string" value="<%=iDateTypeStr%>" />
			<s:param name="iOfferTypeStr" type="string" value="<%=iOfferTypeStr%>" />
			<s:param name="iUnitStr" type="string" value="<%=iUnitStr %>" />
			<s:param name="iOffsetStr" type="string" value="<%=iOffsetStr %>" />
			<s:param name="iMeansId" type="string" value="<%=meansId %>" />
		</s:param>
	</s:service>
<%	
String RETURN_CODE = result.getString("RETURN_CODE");	
String RETURN_MSG = result.getString("RETURN_MSG");	
System.out.println("===============获取附加资费生失效时间服务 [sMarkDateQryWS_XML] =RETURN_CODE="+RETURN_CODE);
String[] arr = iOfferIdStr.split("#");
String[] effDateArrTemp = new String[arr.length];
String[] expDateArrTemp = new String[arr.length];
String[] instIdArrTemp = new String[arr.length];
String effDateTemp = "";
String expDateTemp = "";
String instIdTemp = "";
if("000000".equals(RETURN_CODE)){
	Map b = new HashMap();
	List felist = result.getList("OUT_DATA.FEE_LIST.FEE_INFO");
	for(int i =0;i<felist.size();i++){
		b = MapBean.isMap(felist.get(i));
		if(b==null) continue;
		String ADDFEE_OFFER_ID = (String)b.get("OFFER_ID");
		String ADDFEE_EFF_DATE = (String)b.get("EFF_DATE");
		String ADDFEE_EXP_DATE = (String)b.get("EXP_DATE");
		String DISCOUNTPLANINSTID = (String)b.get("DISCOUNTPLANINSTID");
		for(int j=0;j<arr.length;j++){
			if(ADDFEE_OFFER_ID.equals(arr[j])){
				effDateArrTemp[j] = ADDFEE_EFF_DATE;
				expDateArrTemp[j] = ADDFEE_EXP_DATE;
				instIdArrTemp[j] = DISCOUNTPLANINSTID;
			}else{continue;}
		}
	}
	for(int i=0;i<effDateArrTemp.length;i++){
		effDateTemp = effDateTemp + effDateArrTemp[i] + "#";
		expDateTemp = expDateTemp + expDateArrTemp[i] + "#";
		instIdTemp = instIdTemp + instIdArrTemp[i] + "#";
	}			
System.out.println("--------------------------------附加费生效时间effDateTemp="+effDateTemp);
System.out.println("--------------------------------附加资费失效时间expDateTemp="+expDateTemp);
System.out.println("--------------------------------附加资费实例 instIdTemp="+instIdTemp);
System.out.println("--------------------------------附加资费号码 iPhoneNoStr ="+iPhoneNoStr);
}
%>		
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("iOfferIdStr","<%=iOfferIdStr%>");
	response.data.add("iPhoneNoStr","<%=iPhoneNoStr%>");
	response.data.add("effDateTemp","<%=effDateTemp%>");
	response.data.add("expDateTemp","<%=expDateTemp%>");
	response.data.add("instIdTemp","<%=instIdTemp%>");
	core.ajax.receivePacket(response);
		
