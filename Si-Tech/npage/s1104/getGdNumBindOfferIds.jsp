<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
System.out.println("----------------------------getGdNumBindOfferIds.jsp------------------------------------");  
System.out.println("--------查询靓号绑定销售品ID--------");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String goodType = WtcUtil.repNull(request.getParameter("goodType"));
System.out.println("@@@@@@@@regionCode===="+regionCode+"goodType================"+goodType);	
	String sqlStr = "Select replace(replace(replace(mode_code,'1|',''),'0|',''),',','|') from sselffeescheme where region_code='"+regionCode+"' and good_type='"+goodType+"'";
	String gdNumBindOfferIds = "";
%>

<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>

<%
System.out.println("-------result1.length------"+result1.length);
	if(retCode.equals("000000") && result1.length > 0){
		gdNumBindOfferIds = result1[0][0];
System.out.println("------gdNumBindOfferIds------"+gdNumBindOfferIds);		
	}
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("gdNumBindOfferIds","<%=gdNumBindOfferIds%>");
core.ajax.receivePacket(response);