<%
  /*
   * 功能: 更新考评项
　 * 版本: 1.0.0
　 * 日期: 2008/11/09
　 * 作者: mixh
　 * 版权: sitech
   * update:	mixh 2009/02/23  更新条件为item_id + object_id + contect_id
   *            
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "更新测评项";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	
	String retType    = WtcUtil.repNull(request.getParameter("retType"));
	String item_id    = WtcUtil.repNull(request.getParameter("item_id"));
	String object_id  = WtcUtil.repNull(request.getParameter("object_id"));
	String contect_id = WtcUtil.repNull(request.getParameter("contect_id"));
	String is_leaf    = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name  = WtcUtil.repNull(request.getParameter("item_name"));
	String low_score  = WtcUtil.repNull(request.getParameter("low_score"));
	String high_score = WtcUtil.repNull(request.getParameter("high_score"));
	String weight     = WtcUtil.repNull(request.getParameter("weight"));
	String formula    = WtcUtil.repNull(request.getParameter("formula"));
	String note       = WtcUtil.repNull(request.getParameter("note"));
	String isDefault  = WtcUtil.repNull(request.getParameter("isDefault"));
	String is_scored  = WtcUtil.repNull(request.getParameter("is_scored"));
	String update_login_no  = WtcUtil.repNull(request.getParameter("update_login_no"));
	
	String sqlStr = "update dqccheckitem set item_name=:item_name, weight=:weight, " +
									"low_score=:low_score, high_score=:high_score, formula=:formula, " +
	                "note=:note,bak2=:isDefault, is_scored = :is_scored, update_login_no =:update_login_no , update_date = sysdate " +  
	                "where trim(item_id) = :item_id and trim(object_id) = :object_id and trim(contect_id) = :contect_id ";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=item_name%>"/>
		<wtc:param value="<%=weight%>"/>
		<wtc:param value="<%=low_score%>"/>
		<wtc:param value="<%=high_score%>"/>
		<wtc:param value="<%=formula%>"/>
		<wtc:param value="<%=note%>"/>
		<wtc:param value="<%=isDefault%>"/>
		<wtc:param value="<%=is_scored%>"/>
		<wtc:param value="<%=update_login_no%>"/>
		<wtc:param value="<%=item_id.trim()%>"/>
		<wtc:param value="<%=object_id.trim()%>"/>
		<wtc:param value="<%=contect_id.trim()%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);