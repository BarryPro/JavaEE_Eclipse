<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String workNo = (String)session.getAttribute("workNo");

		String sqlStr="select  offerid from prodOfferTmpSect  where   loginno = '"+workNo +"' and     loginaccept ='"+loginAccept+"'  and     offertype != 40  and     optype = '1'";
		String RealOfferId="0";
%>
<wtc:service name="sPubSelect"  retCode="retCode"  retMsg="retMsg" outnum="2" >
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resPosc" scope="end"/>

<%
 System.out.println("liubo2 --------------------");
	if(retCode.equals("000000")&&resPosc.length>0){
			RealOfferId=resPosc[0][0];
	 }

%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("RealOfferId","<%=RealOfferId%>");
core.ajax.receivePacket(response);