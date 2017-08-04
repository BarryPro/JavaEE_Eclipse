<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%

	String reginCode = (String) session.getAttribute("regCode");//ÇøÓò
	String loginNo   = (String)session.getAttribute("workNo");//µÇÂ¼¹¤ºÅ
	String password   = (String)session.getAttribute("password");//µÇÂ¼ÃÜÂë
	String gPriFee = (String)request.getParameter("gPriFee");;//×Ê·Ñ
	System.out.println("gPriFee================"+gPriFee);

%>	
	<s:service name="sWebDxQryWS_XML">
		<s:param name="ROOT">
			<s:param name="LoginAccept" type="string" value="0" />
			<s:param name="ChnSource" type="string" value="<%=reginCode%>" />
			<s:param name="OpCode" type="string" value="g794" />
			<s:param name="LoginNo" type="string" value="<%=loginNo%>" />
			<s:param name="LoginPwd" type="string" value="<%=password%>" />
			<s:param name="PhoneNo" type="string" value="" />
			<s:param name="UserPwd" type="string" value="" />
			<s:param name="OfferAttrType" type="string" value="<%=gPriFee%>" />
			<s:param name="GroupId" type="string" value="" />
			<s:param name="QryType" type="string" value="1" />
		</s:param>
	</s:service>
<%	
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");
	String feeCode = result.getString("FEE_CODE");
	String feeName = result.getString("FEE_NAME");
	String feemoney = result.getString("FEE_MONEY");
	System.out.println("||||||||||||||||||||||||========================================"+RETURN_CODE+"~~~"+RETURN_MSG+"^^^"+feemoney);

%>			
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
		response.data.add("RETURN_MSG","<%=RETURN_MSG%>");		
		response.data.add("prcNo","<%=feeCode%>");
		response.data.add("prcName","<%=feeName%>");
		response.data.add("prcMoney","<%=feemoney%>");
		core.ajax.receivePacket(response);
