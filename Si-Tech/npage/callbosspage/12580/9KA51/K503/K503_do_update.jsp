<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/15
　 * 作者: fengliang
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String is_leaf = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name = WtcUtil.repNull(request.getParameter("item_name"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	String sqlStr = "update DMESSAGEMODEL set Msg_Mod_Name= '"+item_name+"' where msg_mod_id = '"+item_id+"' ";
	

%>

<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);
