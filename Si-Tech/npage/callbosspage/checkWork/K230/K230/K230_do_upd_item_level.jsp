<%
  /*
   * 功能: 修改考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "修改考评项等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType        = WtcUtil.repNull(request.getParameter("retType"));
	String serialno       = WtcUtil.repNull(request.getParameter("serialno"));
	String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
	String level_name     = WtcUtil.repNull(request.getParameter("level_name"));
	String score          = WtcUtil.repNull(request.getParameter("score"));
	String is_def_level   = WtcUtil.repNull(request.getParameter("is_def_level"));
	String note           = WtcUtil.repNull(request.getParameter("note"));
	String update_login_no= WtcUtil.repNull(request.getParameter("update_login_no"));
	
	
	
	String sqlStr = "update dqcckectitemlevel set level_name='" + level_name + "', score = '" + score + 
	                "', is_def_level = '" + is_def_level + "', note = '" + note + "' " + 
		            "where serialno = '" + serialno + "'";
	System.out.println("############################################");	                
   
    System.out.println(sqlStr);

    System.out.println("############################################");
%>

<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);

