<%
/********************
 version v2.0
 ¿ª·¢ÉÌ: si-tech
 update by wangzn @ 2010-1-26 18:48:54
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
  
  String regionCode = request.getParameter("regionCode");
  
  
  String groupNo = request.getParameter("group_no");
  String arcGroupNo = request.getParameter("acr_group_no");
  String feeIndex = request.getParameter("fee_index");
  String opType = request.getParameter("op_type");
  
  String workNo = request.getParameter("workno");
  String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
  String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

%>

<wtc:service name="s4388Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage"  outnum="2" >
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=opType%>"/>
	<wtc:param value="<%=groupNo%>"/>
	<wtc:param value="<%=arcGroupNo%>"/>
	<wtc:param value="<%=feeIndex%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
  <wtc:param value="<%=iIpAddr%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<script type=text/javascript>	
	rdShowMessageDialog('<%=retMessage%>',1);
	window.location='f4388.jsp';
</script>