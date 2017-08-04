<%
  /*
   * 功能: 更新被检对象
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "更新被检对象";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType         = WtcUtil.repNull(request.getParameter("retType"));
	String object_id       = WtcUtil.repNull(request.getParameter("object_id"));
	String object_name     = WtcUtil.repNull(request.getParameter("object_name"));
	String object_type     = WtcUtil.repNull(request.getParameter("object_type"));
	String note            = WtcUtil.repNull(request.getParameter("note"));
	String modify_flag     = WtcUtil.repNull(request.getParameter("modify_flag"));
	String update_login_no = WtcUtil.repNull(request.getParameter("update_login_no"));
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	if(update_login_no.equals("null")){
	update_login_no = "";
	}
	
	String sqlStr = "update dqcobject set object_name=:v1, object_type=:v2, " +
	                "note=:v3, update_login_no=:v4, update_date=sysdate, modify_flag=:v5 " + 
	                " where trim(object_id) = :v6 ";   
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=object_name.trim()%>"/>
		<wtc:param value="<%=object_type.trim()%>"/>
		<wtc:param value="<%=note.trim()%>"/>
		<wtc:param value="<%=update_login_no.trim()%>"/>
		<wtc:param value="<%=modify_flag.trim()%>"/>
		<wtc:param value="<%=object_id.trim()%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);