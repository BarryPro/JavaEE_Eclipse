<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
System.out.println("--------²éÑ¯idNo--------");
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	String sqlStr = "SELECT id_no FROM dcustmsg a, band b WHERE phone_no='"+phoneNo+"' AND a.sm_code = b.sm_code AND b.band_id = '"+brandId+"'";
	String idNo = "";
	System.out.println("sqlStr-------------"+sqlStr);
%>

<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>

<%
	if(retCode.equals("000000") && result1.length > 0){
		idNo = result1[0][0];
	}
	System.out.println("idNo-------------"+idNo);

%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("idNo","<%=idNo%>");
core.ajax.receivePacket(response);