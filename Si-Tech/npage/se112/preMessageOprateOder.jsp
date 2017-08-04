<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="org.json.*"%>
<%Date start = new Date(); %>
<%
	String saleOrderOp = request.getParameter("saleOrder")==null?"":request.getParameter("saleOrder");
	System.out.println("saleOrderOp注意了:"+saleOrderOp);
	JSONObject jsonObj=new JSONObject(saleOrderOp);
	String jsonXML = (String)JSONML.toString(jsonObj);
	System.out.println("saleOrderJsonXml:"+jsonXML);
%>

<s:service name="WsMktOrderInter">
	<s:param name="ROOT">
		<s:param name="REQUEST_INFO">
			<s:param name="XML_STR" type="string" value="<%=jsonXML%>" />
		</s:param>
	</s:param>
</s:service>
<%	
	String RETURN_CODE =  (String)result.getString("RETURN_CODE");	
	String RETURN_MSG =  (String)result.getString("RETURN_MSG");	
	String XML_STR =  (String)result.getString("XML_STR").replaceAll( "\"", "\'");
		
	if ("0".equals(RETURN_CODE)) {
%>
<s:service name="WsActRecordForH">
	<s:param name="ROOT">
		<s:param name="REQUEST_INFO">
			<s:param name="BUSI_TYPE" type="string" value="0" />
			<s:param name="XML_STR" type="string" value="<%=XML_STR%>" />
		</s:param>
	</s:param>
</s:service>
<%
		RETURN_CODE = (String)result.getString("RETURN_CODE");	
		RETURN_MSG = (String)result.getString("RETURN_MSG");	
		if(!"0".equals(RETURN_CODE)){
				RETURN_CODE ="-2";//返回的retCode为LONG类型；
				RETURN_MSG ="入反馈表失败！！";
		}
	}else{
		   RETURN_CODE ="-1";//返回的retCode为LONG类型；
		   RETURN_MSG ="生成订单报文失败！！";
	}
%>
var response = new AJAXPacket(); 
var RETURN_CODES = "<%=RETURN_CODE%>";
var RETURN_MSGS = "<%=RETURN_MSG%>";
var XML_STR = "<%=XML_STR%>";
response.data.add("RETURN_CODE",RETURN_CODES);
response.data.add("RETURN_MSG",RETURN_MSGS);
response.data.add("XML_STR",XML_STR);
core.ajax.receivePacket(response);
