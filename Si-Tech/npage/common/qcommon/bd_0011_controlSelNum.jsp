<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	
<%
	String branch_no=request.getParameter("branch_no");//所在局站编号；
	String servNo=request.getParameter("servNo");//老号码,服务号码；
	System.out.println("branch_no of selectNum========================================="+branch_no);
	System.out.println("servNo of selectNum========================================="+servNo);
	int recordNum=1;
%>
	<wtc:utype name="sSelNumJudge" id="retNumInfo" scope="end">
	     <wtc:uparam value="<%=branch_no%>" type="STRING"/>
	     <wtc:uparam value="<%=servNo%>" type="STRING"/>
	</wtc:utype>
<%
	String retrunCode =retNumInfo.getValue(0);
	String returnMsg  =retNumInfo.getValue(1);
	System.out.println("retrunCode of selectNum========================================="+retrunCode);
	System.out.println("returnMsg of selectNum========================================="+returnMsg);
	if(retrunCode.equals("0")){
		recordNum=Integer.parseInt(retNumInfo.getValue("2.0"));
		System.out.println("returnMsg of recordNum========================================="+recordNum);
	}
%>
var verifyType="selNumJudge";
var response = new AJAXPacket();
	response.data.add("verifyType",verifyType);
	response.data.add("recordNum",<%=recordNum%>);
	response.data.add("errorCode","<%= retrunCode %>");
	response.data.add("errorMsg","<%= returnMsg %>");
	core.ajax.receivePacket(response);