<%
/********************
 * version v2.0
 * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%

		String iLoginAcceptnew = getMaxAccept();		

%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("retMsg","success");
response.data.add("iLoginAcceptnew","<%=iLoginAcceptnew%>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         