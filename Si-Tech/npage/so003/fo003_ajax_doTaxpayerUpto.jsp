<%
   /*
   * 功能: 修改
　 * 版本: v1.0
　 * 日期: 2013/10/17
　 * 作者: wangjxc
　 * 版权: sitech
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 <%
	String approveStaff = request.getParameter("approveStaff");
	String approveAdd = request.getParameter("approveAdd");
	String UpCustId = request.getParameter("UpCustId");
	String LoginNo = request.getParameter("LoginNo");
	String regionCode = (String)session.getAttribute("regCode");
%>

<wtc:service name="so001AppUptO" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=approveStaff%>"/>
	      <wtc:param value="<%=approveAdd%>"/>
	      <wtc:param value="<%=UpCustId%>"/>
	      <wtc:param value="<%=LoginNo%>"/>
	      <wtc:param value="o010"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);