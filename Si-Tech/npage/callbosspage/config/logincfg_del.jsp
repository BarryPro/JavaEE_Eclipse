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
	String subccno = WtcUtil.repNull(request.getParameter("subccno"));
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  //add by hucw,20100618
	String delSql = "delete from dlogincfg where login_no=:v1 and subccno=:v2";
	//String delSql = "delete from dlogincfg where login_no=:v1";
	System.out.println("+++++++++++++"+delSql+"++++++++++++++++++");
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=delSql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=subccno%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);





