<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String imeiNo = request.getParameter("imeiNo")==null?"":request.getParameter("imeiNo");
	String groupId = request.getParameter("groupId")==null?"":request.getParameter("groupId");
	String is4G = request.getParameter("IS_4G")==null?"":request.getParameter("IS_4G");
	String isVolte = request.getParameter("VOLTE_FLAG")==null?"":request.getParameter("VOLTE_FLAG");
	String bussType = request.getParameter("CUSTOM_FLAG")==null?"":request.getParameter("CUSTOM_FLAG");
	String PRODUCT_TYPE = request.getParameter("RESOUCE_CUSTOM_FLAG")==null?"2":request.getParameter("RESOUCE_CUSTOM_FLAG");
	if("null".equals(PRODUCT_TYPE)||"".equals(PRODUCT_TYPE)){
		PRODUCT_TYPE="2";
	}
	System.out.println("imeiNo============="+imeiNo);
	System.out.println("is4G============="+is4G);
	System.out.println("isVolte============="+isVolte);
	System.out.println("bussType============="+bussType);
	System.out.println("PRODUCT_TYPE============="+PRODUCT_TYPE);
 %>
<s:service name="getTermImei">
								<s:param name="ROOT">
									<s:param name="REQUEST_INFO">
										<s:param name="OP_TYPE" type="string" value="0" />
										<s:param name="IMEI_NO" type="string" value="<%=imeiNo %>" />
										<s:param name="GROUP_ID" type="string" value="<%=groupId %>" />
										<s:param name="RES_TYPE" type="string" value="<%=bussType %>" />
										<s:param name="IS_4G" type="string" value="<%=is4G %>" />
								 		<s:param name="IS_VOLTE" type="string" value="<%=isVolte %>" />
								 		<s:param name="PRODUCT_TYPE" type="string" value="<%=PRODUCT_TYPE %>" />
								 		<s:param name="BUSS_TYPE" type="string" value="2" />
								 		
									</s:param>
							   </s:param>
</s:service>

<%
	String RETURN_CODE =result.getString("RETURN_CODE");
	String RETURN_MSG =result.getString("RETURN_MSG");
	String BRAND_NAME =result.getString("BRAND_NAME");
	String BRAND_CODE =result.getString("BRAND_CODE");
	String RES_NAME =result.getString("RES_NAME");
	String RES_CODE =result.getString("RES_CODE");
	String PRICE_VALUE =result.getString("PRICE_VALUE");
	String IS_4G =result.getString("IS_4G");
	String IS_VOLTE =result.getString("IS_VOLTE");
	String RES_TYPE =result.getString("RES_TYPE");
	String RESOUCE_CUSTOM_FLAG =result.getString("PRODUCT_TYPE");//Õ½ÂÔ
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
    System.out.println("BRAND_NAME============="+BRAND_NAME);
    System.out.println("BRAND_CODE============="+BRAND_CODE);
    System.out.println("RES_NAME============="+RES_NAME);
    System.out.println("RES_CODE============="+RES_CODE);
    System.out.println("PRICE_VALUE============="+PRICE_VALUE);
    System.out.println("IS_4G============="+IS_4G);
    System.out.println("IS_VOLTE============="+IS_VOLTE);
    System.out.println("RES_TYPE============="+RES_TYPE);
    System.out.println("RESOUCE_CUSTOM_FLAG============="+RESOUCE_CUSTOM_FLAG);
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("BRAND_NAME","<%=BRAND_NAME%>");
	response.data.add("BRAND_CODE","<%=BRAND_CODE%>");
	response.data.add("RES_NAME","<%=RES_NAME%>");
	response.data.add("RES_CODE","<%=RES_CODE%>");
	response.data.add("PRICE_VALUE","<%=PRICE_VALUE%>");
	response.data.add("IS_4G","<%=IS_4G%>");
	response.data.add("IS_VOLTE","<%=IS_VOLTE%>");
	response.data.add("RES_TYPE","<%=RES_TYPE%>");
	response.data.add("RESOUCE_CUSTOM_FLAG","<%=RESOUCE_CUSTOM_FLAG%>");
	core.ajax.receivePacket(response);
