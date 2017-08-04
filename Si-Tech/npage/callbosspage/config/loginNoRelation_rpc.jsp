<%
  /*
   * 功能: 工号关系绑定配置-后台逻辑处理
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: donglei
　 * 版权: sitech
   * update:yinzx 2009/09/23 将语句替换成服务RK096
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String boss_login_no = WtcUtil.repNull(request.getParameter("boss_login_no"));
	String kf_login_no= WtcUtil.repNull(request.getParameter("kf_login_no"));
  String login_status= WtcUtil.repNull(request.getParameter("login_status"));
	String login_no = (String)session.getAttribute("workNo");	// 登陆工号代码
 
	 
	
	 
	 
	
%>
<wtc:service name="sK096Insert" outnum="2">
	<wtc:param value="<%=retType%>"/>
	<wtc:param value="<%=boss_login_no%>"/>
	<wtc:param value="<%=kf_login_no%>"/>
	<wtc:param value="<%=login_status%>"/>
	<wtc:param value="<%=login_no%>"/>				
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);