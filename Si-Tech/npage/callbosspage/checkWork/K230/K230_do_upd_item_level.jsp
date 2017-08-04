<%
  /*
   * 功能: 修改考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:zengzq 20091017
   * 增加最低分想关
　 */
%>
<%
	String opCode = "K230";
	String opName = "修改考评项等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	
	String retType        = WtcUtil.repNull(request.getParameter("retType"));
	String serialno       = WtcUtil.repNull(request.getParameter("serialno"));
	String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
	String level_name     = WtcUtil.repNull(request.getParameter("level_name"));
	String low_score      = WtcUtil.repNull(request.getParameter("low_score"));
	String score          = WtcUtil.repNull(request.getParameter("score"));
	String is_def_level   = WtcUtil.repNull(request.getParameter("is_def_level"));
	String note           = WtcUtil.repNull(request.getParameter("note"));
	String update_login_no= WtcUtil.repNull(request.getParameter("update_login_no"));
	
	
	
	String sqlStr = "update dqcckectitemlevel set level_name=:v0, score = :v1, low_score = :v2, is_def_level = :v3, note = :v4 " + 
		            "where serialno = :v5 ";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=level_name%>"/>
		<wtc:param value="<%=score%>"/>
		<wtc:param value="<%=low_score%>"/>
		<wtc:param value="<%=is_def_level%>"/>
		<wtc:param value="<%=note%>"/>
		<wtc:param value="<%=serialno%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);

