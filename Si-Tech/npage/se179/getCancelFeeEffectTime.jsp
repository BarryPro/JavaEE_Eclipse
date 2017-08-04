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
	String iCurMOfferId = request.getParameter("iCurMOfferId");
	String iNextMOfferId = request.getParameter("iNextMOfferId");
	String iExpType = request.getParameter("iExpType");
		
 %>
	<s:service name="sProdMCancleWS_XML">
		<s:param name="ROOT">
			<s:param name="iLoginAccept" type="string" value="0" />
			<s:param name="iChnSource" type="string" value="<%=iChnSource%>" />
			<s:param name="iOpCode" type="string" value="g796" />
			<s:param name="iLoginNo" type="string" value="<%=iLoginNo%>" />
			<s:param name="iLoginPWD" type="string" value="<%=iLoginPWD%>" />
			<s:param name="iPhoneNo" type="string" value="<%=iPhoneNo%>" />
			<s:param name="iUserPwd" type="string" value="" />
			<s:param name="iOprAccept" type="string" value="<%=iOprAccept%>" />
			<s:param name="iCurMOfferId" type="string" value="<%=iCurMOfferId%>" />
			<s:param name="iNextMOfferId" type="string" value="<%=iNextMOfferId%>" />
			<s:param name="iExpType" type="string" value="<%=iExpType%>" />
		</s:param>
	</s:service>
<%	
String RETURN_CODE = result.getString("RETURN_CODE");
String RETURN_MSG = result.getString("RETURN_MSG");	
String CurMOfferEffTime = "";
String CurMOfferExpTime = "";
String NextMOfferId = "";
String NextMOfferName = "";
String NextMOfferEffTime = "";
String NextMOfferExpTime = "";
String CProdInstId = "";
String NProdInstId = "";
if("000000".equals(RETURN_CODE)){
	//String CurMOfferId = result.getString("OUT_DATA.CurMOfferId");
	//String CurMOfferName = result.getString("OUT_DATA.CurMOfferName");
	CurMOfferEffTime = result.getString("OUT_DATA.CurMOfferEffTime");
	CurMOfferExpTime = result.getString("OUT_DATA.CurMOfferExpTime");
	NextMOfferId = result.getString("OUT_DATA.NextMOfferId");
	NextMOfferName = result.getString("OUT_DATA.NextMOfferName");
	NextMOfferEffTime = result.getString("OUT_DATA.NextMOfferEffTime");
	NextMOfferExpTime = result.getString("OUT_DATA.NextMOfferExpTime");
	CProdInstId = result.getString("OUT_DATA.CProdInstId");
	NProdInstId = result.getString("OUT_DATA.NProdInstId");
	
	System.out.println("--------------------------------��ǰ�ʷ���Чʱ�� CurMOfferEffTime="+CurMOfferEffTime);
	System.out.println("--------------------------------��ǰ�ʷ�ʧЧʱ�� CurMOfferExpTime="+CurMOfferExpTime);
	System.out.println("--------------------------------��һ���ʷѴ��� NextMOfferId="+NextMOfferId);
	System.out.println("--------------------------------��һ���ʷ����� NextMOfferName ="+NextMOfferName);
	System.out.println("--------------------------------��һ���ʷ���Чʱ�� NextMOfferEffTime="+NextMOfferEffTime);
	System.out.println("--------------------------------��һ���ʷ�ʧЧʱ�� NextMOfferExpTime="+NextMOfferExpTime);
	System.out.println("--------------------------------��ǰ�ʷ�ʵ�� CProdInstId="+CProdInstId);
	System.out.println("--------------------------------��һ���ʷ�ʵ�� NProdInstId="+NProdInstId);
}
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("CurMOfferEffTime","<%=CurMOfferEffTime%>");
	response.data.add("CurMOfferExpTime","<%=CurMOfferExpTime%>");
	response.data.add("NextMOfferId","<%=NextMOfferId%>");
	response.data.add("NextMOfferName","<%=NextMOfferName%>");
	response.data.add("NextMOfferEffTime","<%=NextMOfferEffTime%>");
	response.data.add("NextMOfferExpTime","<%=NextMOfferExpTime%>");
	response.data.add("CProdInstId","<%=CProdInstId%>");
	response.data.add("NProdInstId","<%=NProdInstId%>");
	core.ajax.receivePacket(response);
	
