<%
  /*
   * 功能: 更新客服登陆配置
　 * 版本: 1.0.0
　 * 日期: 2009/04/11
　 * 作者: fangyuan
　 * 版权: sitech
	 *update:  
　*/
%>


<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
 
	
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String passwd = WtcUtil.repNull(request.getParameter("passwd"));

	String updSql = "update dlogincfg t set t.password=:v1 where t.login_no=:v2";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
   
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=updSql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=passwd%>"/>
	<wtc:param value="<%=login_no%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);





