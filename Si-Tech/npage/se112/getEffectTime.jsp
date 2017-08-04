<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String iChnSource = (String)request.getParameter("iChnSource");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String iLoginPWD = (String)request.getParameter("iLoginPWD");
	String iPhoneNo = (String)request.getParameter("iPhoneNo");
	String iOprAccept = (String)request.getParameter("iOprAccept");
	String iPhoneNoStr = (String)request.getParameter("iPhoneNoStr");
	String iOfferIdStr = (String)request.getParameter("iOfferIdStr");
	String iOprTypeStr = (String)request.getParameter("iOprTypeStr");
	String iDateTypeStr = (String)request.getParameter("iDateTypeStr");
	String iOfferTypeStr = (String)request.getParameter("iOfferTypeStr");
	String iUnitStr = (String)request.getParameter("iUnitStr");
	String iOffsetStr = (String)request.getParameter("iOffsetStr");
	//==========================================
	String meansId = (String)request.getParameter("meansId");
	String codes = (String)request.getParameter("codes");
	String feeNames = (String)request.getParameter("feeNames");
	String showNames = (String)request.getParameter("showNames");
	String feeScores = (String)request.getParameter("feeScores");
	String orderStr = (String)request.getParameter("orderStr");
	
	String iLoginAccept = (String)request.getParameter("iLoginAccept")==null?"":(String)request.getParameter("iLoginAccept");
	//String iMeansId = (String)request.getParameter("iMeansId")==null?"":(String)request.getParameter("iMeansId");
	
	System.out.println("||||||||||||||||||||||||========================================start");
	System.out.println("||||||||||||||||||||||||========================================"+iChnSource);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginNo);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginPWD);
	System.out.println("||||||||||||||||||||||||========================================"+iPhoneNo);
	System.out.println("||||||||||||||||||||||||========================================"+iOprAccept);
	System.out.println("||||||||||||||||||||||||========================================"+iPhoneNoStr);
	System.out.println("||||||||||||||||||||||||========================================"+iOfferIdStr);
	System.out.println("||||||||||||||||||||||||========================================"+iOprTypeStr);
	System.out.println("||||||||||||||||||||||||========================================"+iUnitStr);
	System.out.println("||||||||||||||||||||||||========================================"+iDateTypeStr);
	System.out.println("||||||||||||||||||||||||========================================"+iOfferTypeStr);
	System.out.println("||||||||||||||||||||||||========================================"+iOffsetStr);
	System.out.println("||||||||||||||||||||||||========================================"+iLoginAccept);
	System.out.println("||||||||||||||||||||||||====================================meansId===="+meansId);
		//iUnitStr == 6
 %>
	<s:service name="sMarkDateQryWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="<%=iLoginAccept%>" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="g794" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iOprAccept" type="string" value="<%=iOprAccept%>" />
			<s:param name="iMarkType" type="string" value="0" />
			<s:param name="iPhoneNoStr" type="string" value="<%=iPhoneNoStr%>" />
			<s:param name="iOfferIdStr" type="string" value="<%=iOfferIdStr%>" />
			<s:param name="iOprTypeStr" type="string" value="<%=iOprTypeStr%>" />
			<s:param name="iUnitStr" type="string" value="<%=iUnitStr%>" />
			<s:param name="iDateTypeStr" type="string" value="<%=iDateTypeStr%>" />
			<s:param name="iOfferTypeStr" type="string" value="<%=iOfferTypeStr%>" />
			<s:param name="iOffsetStr" type="string" value="<%=iOffsetStr%>" />
			<s:param name="iMeansId" type="string" value="<%=meansId%>" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	System.out.println("||||||||||||||||||||||||========================================"+RETURN_CODE+"~~~"+RETURN_MSG);
	String effDateStr ="";
	String expDateStr ="";
	String split="";
	if("000000".equals(RETURN_CODE)){
		Map b = new HashMap();
		List felist = result.getList("OUT_DATA.FEE_LIST.FEE_INFO");
		for(int i =0;i<felist.size();i++){
			b = MapBean.isMap(felist.get(i));
			if(b==null) continue;
			String EFF_DATE= (String)b.get("EFF_DATE");
			String EXP_DATE= (String)b.get("EXP_DATE");
			effDateStr =  effDateStr + split + EFF_DATE;
			expDateStr =  expDateStr + split + EXP_DATE;
			split = "#";
		}
		System.out.println("effDateStr:"+effDateStr+"------expDateStr:"+expDateStr);
		
	}
%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		
		response.data.add("meansId","<%=meansId%>");
		response.data.add("codes","<%=codes%>");
		response.data.add("feeNames","<%=feeNames%>");
		response.data.add("showNames","<%=showNames%>");
		response.data.add("feeScores","<%=feeScores%>");
		response.data.add("orderStr","<%=orderStr%>");
		response.data.add("effDateStr","<%=effDateStr%>");
		response.data.add("expDateStr","<%=expDateStr%>");
		core.ajax.receivePacket(response);
