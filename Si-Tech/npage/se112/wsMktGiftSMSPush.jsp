<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%


	String SUM_MONEY = (String)request.getParameter("SUM_MONEY");
	String PHONE_NO = (String)request.getParameter("PHONE_NO");
	String GIFT_CODE = (String)request.getParameter("GIFT_CODE");
	String OP_FLAG = (String)request.getParameter("OP_FLAG");
	String MEANS_ID = (String)request.getParameter("MEANS_ID");
	String selectMeansId = (String)request.getParameter("selectMeansId");
	String TEMPLET_TYPE = (String)request.getParameter("TEMPLET_TYPE");
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========SUM_MONEY="+SUM_MONEY);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========PHONE_NO="+PHONE_NO);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========GIFT_CODE="+GIFT_CODE);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========OP_FLAG="+OP_FLAG);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========MEANS_ID="+MEANS_ID);
	System.out.println("||||||||||||||||||||||||==================WsMktGiftSMSPush========selectMeansId="+selectMeansId);
 %>
	<s:service name="WsMktGiftSMSPush">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="SUM_MONEY" type="string" value="<%=SUM_MONEY %>" />
				<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO%>" />
				<s:param name="GIFT_CODE" type="string" value="<%=GIFT_CODE %>" />
				<s:param name="OP_FLAG" type="string" value="<%=OP_FLAG%>" />
				<s:param name="MEANS_ID" type="string" value="<%=MEANS_ID%>" />
				<s:param name="selectMeansId" type="string" value="<%=selectMeansId%>" />
				<s:param name="TEMPLET_TYPE" type="string" value="<%=TEMPLET_TYPE%>" />
			</s:param>
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String GIFTCODE = result.getString("GIFT_CODE");
	String FLAG = result.getString("GIFT_FLAG");
	System.out.println("||||||||||||||||||||||||======WsMktGiftSMSPush============RETURN_CODE==="+RETURN_CODE+"===RETURN_MSG="+RETURN_MSG);

%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>"); 
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
		response.data.add("GIFTCODE","<%=GIFTCODE%>");
		response.data.add("FLAG","<%=FLAG%>");
		core.ajax.receivePacket(response);
