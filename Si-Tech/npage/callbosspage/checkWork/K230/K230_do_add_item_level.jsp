<%
  /*
   * 功能: 添加考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:zengzq 20091017
   * 做插入时，增加最低分相关
　 */
%>
<%
	String opCode = "K230";
	String opName = "添加考评项等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType        = WtcUtil.repNull(request.getParameter("retType"));
	String item_id        = WtcUtil.repNull(request.getParameter("item_id"));
	String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
	String level_name     = WtcUtil.repNull(request.getParameter("level_name"));
	String low_score      = WtcUtil.repNull(request.getParameter("low_score"));
	String score          = WtcUtil.repNull(request.getParameter("score"));
	String is_def_level   = WtcUtil.repNull(request.getParameter("is_def_level"));
	String note           = WtcUtil.repNull(request.getParameter("note"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
 	
	String sqlStr = "insert into dqcckectitemlevel (level_id, item_id, content_id, object_id, level_name, low_score, score, is_def_level, note, crete_login_no, create_date, serialno) " +
	                "select seq_check_item_level.nextval, :item_id,:content_id,:object_id,:level_name,:low_score,:score,:is_def_level,:note,:crete_login_no,sysdate, seq_check_item_level.currval from dual";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=item_id.trim()%>"/>
		<wtc:param value="<%=content_id.trim()%>"/>
		<wtc:param value="<%=object_id.trim()%>"/>
		<wtc:param value="<%=level_name.trim()%>"/>
		<wtc:param value="<%=low_score.trim()%>"/>
		<wtc:param value="<%=score.trim()%>"/>
		<wtc:param value="<%=is_def_level.trim()%>"/>
		<wtc:param value="<%=note.trim()%>"/>
		<wtc:param value="<%=crete_login_no.trim()%>"/>
</wtc:service>

<wtc:array id="queryList" scope="end"/>	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);

