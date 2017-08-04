<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String myParams="";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode = org_code.substring(0,2);
 
	String opType = WtcUtil.repNull(request.getParameter("opType"));
	//查询抽取条数设置的值
	String getSerialNoCount = "select to_char(count) from dserialnocount";
	//统计接触日期设置的总条数
	String getTotalCount = "select to_char(sum(getcount)) from dserialNotime where getcount >= 0 ";
	String getCountResult = "0";
	String getTCResult = "0";
%>	

		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getSerialNoCount%>"/>
	</wtc:service>
	<wtc:array id="getSCount" scope="end"/>
<%
	if(getSCount.length>0){
	  	getCountResult = getSCount[0][0];
	}
%>  	

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=getTotalCount%>"/>
	</wtc:service>
	<wtc:array id="getTCount" scope="end"/>
<%
	if(getTCount.length>0){
	  	getTCResult = getTCount[0][0];
	}
%>  	

<%
	//added by tangsong 20100618
	if ("".equals(getCountResult)) {
		getCountResult = "0";
	}
	if ("".equals(getTCResult)) {
		getTCResult = "0";
	}
%>

  var response = new AJAXPacket();
  response.data.add("opType","<%=opType%>"); 
  response.data.add("getCountResult","<%=getCountResult%>"); 
  response.data.add("getTCResult","<%=getTCResult%>");
  core.ajax.receivePacket(response);