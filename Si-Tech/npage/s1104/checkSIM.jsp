<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%System.out.println("----------------------------checkSIM.jsp------------------------------------");  %>
<%
	  String simCode = WtcUtil.repNull(request.getParameter("simCode"));
	  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	  String workNo = (String)session.getAttribute("workNo");
	  String groupId = (String)session.getAttribute("groupId");
	  String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
	  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	  String offerId = WtcUtil.repNull(request.getParameter("offerId"));
	  String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	  System.out.println("--------------brandId---------------"+brandId);
	  String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
	  String majorProductId = WtcUtil.repNull(request.getParameter("majorProductId"));
	  String groupType = WtcUtil.repNull(request.getParameter("groupType"));
	  String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));
System.out.println("YCSX info-----majorProductId---"+majorProductId+"--groupType-"+groupType+"---orderArrayId---"+orderArrayId);	  

String smCodeSql = "SELECT  Sm_Code FROM Band where  Band_Id = "+brandId;
String simTypeSql = "select a.sim_type,b.res_name from dsimres a,sResCode b where a.sim_no='"+simCode+"' and a.sim_type=b.res_code";
String resultSmcode = "";
String resultSimtype = "";
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=smCodeSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>
	 	
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=simTypeSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>	 	


	<%
	
		if(result_t1.length>0&&result_t1[0][0]!=null)  resultSmcode = result_t1[0][0];
		if(result_t2.length>0&&result_t2[0][0]!=null)  resultSimtype = result_t2[0][0];
		
		
		System.out.println("--------------------------phoneNo------------------------"+phoneNo);
		System.out.println("--------------------------groupId------------------------"+groupId);
		System.out.println("--------------------------resultSmcode-------------------"+resultSmcode);
		System.out.println("--------------------------simCode------------------------"+simCode);
		System.out.println("--------------------------resultSimtype------------------"+resultSimtype);
	%>
	
	
    <wtc:service name="sChekPhoneSimNo" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=orgCode%>" />
			<wtc:param value="<%=resultSmcode%>" />					
			<wtc:param value="<%=simCode%>" />
			<wtc:param value="<%=resultSimtype%>" />		
		</wtc:service>
		<wtc:array id="result_t3" scope="end"/>
			
<%
String retrunCode = code;
String returnMsg  =msg;
System.out.println("------------------returnMsg---------------"+returnMsg);
String simType = "";
String checkedSimCode = "";
String isSell = "";
String sellId = "";
if(retrunCode.equals("000000") &&result_t3.length> 0){
	simType = result_t3[0][0];
	checkedSimCode = result_t3[0][1];
	isSell =  result_t3[0][2];
	sellId =  result_t3[0][3];
	System.out.println("@@checkSim===============isSell====="+isSell+"--sellId--"+sellId);	
}
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode%>");
response.data.add("errorMsg","<%=returnMsg%>");
response.data.add("simType","<%=simType%>");
response.data.add("checkedSimCode","<%=checkedSimCode%>");
response.data.add("isSell","<%=isSell%>");
response.data.add("sellId","<%=sellId%>");
core.ajax.receivePacket(response);