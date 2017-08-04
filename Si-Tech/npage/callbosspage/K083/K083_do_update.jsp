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
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String is_leaf = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name = WtcUtil.repNull(request.getParameter("item_name"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	String sqlStr = "update DMESSAGEMODEL_CON set Msg_Mod_Name=:item_name where msg_mod_id =:item_id ";
	myParams = "item_name="+item_name+",item_id="+item_id ;

%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);
