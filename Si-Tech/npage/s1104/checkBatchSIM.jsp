<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%System.out.println("----------------------------checkBatchSIM.jsp------------------------------------");  %>
<%
	  String simCode = WtcUtil.repNull(request.getParameter("simCode"));
	  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	  String groupId = (String)session.getAttribute("groupId");
	  String simFlag = WtcUtil.repNull(request.getParameter("simFlag"));
	  String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	  String fileName = WtcUtil.repNull(request.getParameter("fileName"));
	  String belongCode = ((String)session.getAttribute("orgCode")).substring(0,7);
	  System.out.println("-----------------belongCode------------------"+belongCode);
%>

<wtc:service name="sQryMulPhSimEx" outnum="8">
			<wtc:param value="" />
			<wtc:param value="" />	
			<wtc:param value="" />
			<wtc:param value="" />	
			<wtc:param value="<%=brandId%>" />			
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=groupId%>" />
			<wtc:param value="" />
			<wtc:param value="<%=simFlag%>" />
			<wtc:param value="0" />
			<wtc:param value="10" />	
			<wtc:param value="<%=fileName%>"/>
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=belongCode%>" />				
</wtc:service>
<wtc:array id="rows" scope="end" />
<wtc:array id="rows2" start="2" length="1" scope="end"/> 
<wtc:array id="rows3" start="3" length="1" scope="end"/> 
<%
String successNum = "";
String simFee = "";
String checkedPhoneNoStr = "";
String checkedSimNoStr = "";
String chFeeList = "";			//选号费信息串

	System.out.println("@###retcode============="+retCode);
System.out.println("@###retcode==rows.length==========="+rows.length+"---"+rows[0].length);	
if(retCode.equals("000000") && rows.length > 0){
	successNum = rows[0][0];
	simFee = rows[0][1];
	for(int i=0;i<rows2.length;i++){
		checkedPhoneNoStr = checkedPhoneNoStr+rows2[i][0]+"~";
		checkedSimNoStr = checkedSimNoStr+rows3[i][0]+"~";
		chFeeList = chFeeList + "0" + "~";	
	}
	System.out.println("@###checkedPhoneNoStr============="+checkedPhoneNoStr+"---checkedSimNoStr"+checkedSimNoStr);	
}	

System.out.println("-----------------retMsg---------------"+retMsg);
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("successNum","<%=successNum%>");
response.data.add("simFee","<%=simFee%>");
response.data.add("checkedPhoneNoStr","<%=checkedPhoneNoStr%>");
response.data.add("checkedSimNoStr","<%=checkedSimNoStr%>");
response.data.add("chFeeList","<%=chFeeList%>");
core.ajax.receivePacket(response);