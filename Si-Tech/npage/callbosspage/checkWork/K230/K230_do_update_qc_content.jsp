<%
   /*
    * 功能: 更新评测内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/08
　 * 作者: mixh
　 * 版权: sitech
    * update:		mixh 2009/03/23		去掉调试注释
    * 改用绑定变量调用服务                                                     
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "更新评测内容";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType         = WtcUtil.repNull(request.getParameter("retType"));
	String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id 	   = WtcUtil.repNull(request.getParameter("object_id"));
	String source_id 	   = WtcUtil.repNull(request.getParameter("source_id"));
	String name 		   = WtcUtil.repNull(request.getParameter("content_name"));
	String weight 		   = WtcUtil.repNull(request.getParameter("weight"));
	String auto_get 	   = WtcUtil.repNull(request.getParameter("auto_get"));
	String formula 	   = WtcUtil.repNull(request.getParameter("formula"));
	String note 		   = WtcUtil.repNull(request.getParameter("note"));
	String update_login_no = WtcUtil.repNull(request.getParameter("update_login_no"));
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String sqlStr = "update dqccheckcontect set source_id=:source_id, " +
	                "name=:name, weight=:weight, auto_get=:auto_get, formula=:formula,"+
	                "note=:note, update_login_no=:update_login_no, update_date=sysdate " +                          
	                " where trim(contect_id) = :content_id and trim(object_id)= :object_id ";  
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=source_id.trim()%>"/>
		<wtc:param value="<%=name.trim()%>"/>
		<wtc:param value="<%=weight%>"/>
		<wtc:param value="<%=auto_get.trim()%>"/>
		<wtc:param value="<%=formula.trim()%>"/>
		<wtc:param value="<%=note.trim()%>"/>
		<wtc:param value="<%=update_login_no.trim()%>"/>
		<wtc:param value="<%=content_id.trim()%>"/>
		<wtc:param value="<%=object_id.trim()%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);