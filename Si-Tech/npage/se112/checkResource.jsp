<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%
	String imei_code = request.getParameter("imei_code")==null?"":request.getParameter("imei_code");
	String group_id = (String)session.getAttribute("groupId");
	String RESOURCE_RES_CODE= request.getParameter("RESOURCE_RES_CODE")==null?"":request.getParameter("RESOURCE_RES_CODE");
	String op_type = request.getParameter("OP_TYPE")==null?"":request.getParameter("OP_TYPE");
	String buss_type = request.getParameter("BUSS_TYPE")==null?"":request.getParameter("BUSS_TYPE");
	String op_accept= request.getParameter("OP_ACCEPT")==null?"":request.getParameter("OP_ACCEPT");
	String act_type= request.getParameter("ACT_TYPE")==null?"":request.getParameter("ACT_TYPE");
	//<!--是否校验，铺货模式 小类72的（i101 传Y，其他传N）-->
	String CHECK_BUSSTYPE = request.getParameter("res_contract_type");
	System.out.println("=====123232321321321321312321321321======="+CHECK_BUSSTYPE);
	if("72".equals(act_type) ||"76".equals(act_type)||"95".equals(act_type)||"117".equals(act_type)||"140".equals(act_type)||"155".equals(act_type)){
		CHECK_BUSSTYPE="Y";
	}else{
		CHECK_BUSSTYPE="N";
	}
	System.out.println("RESOURCE_RES_CODE============"+RESOURCE_RES_CODE);
	System.out.println("OP_TYPE============"+op_type);
	System.out.println("BUSS_TYPE============"+buss_type);
	System.out.println("OP_ACCEPT============"+op_accept);
 %>
<s:service name="validImeiNew">
								<s:param name="ROOT">
								 <s:param name="REQUEST_INFO">
								 		<s:param name="OP_TYPE " type="string" value="<%=op_type %>" />
								 		<s:param name="BUSS_TYPE " type="string" value="<%=buss_type %>" />
								 		<s:param name="OP_ACCEPT " type="string" value="<%=op_accept %>" />
								 		<s:param name="GROUP_ID " type="string" value="<%=group_id %>" />
										<s:param name="IMEI_NO" type="string" value="<%=imei_code %>" />
										<s:param name="OP_CODE" type="string" value="g794" />
										<s:param name="RES_CODE" type="string" value="<%=RESOURCE_RES_CODE %>" />
		                                <s:param name="CHECK_BUSSTYPE" type="string"value="<%=CHECK_BUSSTYPE%>" />
									</s:param>
								</s:param>
</s:service>

<%
	String RETURN_CODE = result.getString("RETURN_CODE");	
	String RETURN_MSG = result.getString("RETURN_MSG");	
	String DETAIL_MSG =result.getString("DETAIL_MSG");
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
	System.out.println("DETAIL_MSG============="+DETAIL_MSG);
		
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("DETAIL_MSG","<%=DETAIL_MSG%>");

	core.ajax.receivePacket(response);
