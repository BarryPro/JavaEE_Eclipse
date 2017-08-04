<%
  /*
   * 功能: 更新评测内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/08
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "更新评测内容";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String source_id = WtcUtil.repNull(request.getParameter("source_id"));
	String name = WtcUtil.repNull(request.getParameter("content_name"));
	String weight = WtcUtil.repNull(request.getParameter("weight"));
	String auto_get = WtcUtil.repNull(request.getParameter("auto_get"));
	String formula = WtcUtil.repNull(request.getParameter("formula"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String update_login_no = WtcUtil.repNull(request.getParameter("update_login_no"));
	
	String sqlStr = "update dqccheckcontect set object_id='" + object_id + "', source_id='" + source_id + "', " +
	                "name='" + name +"', weight=to_number(" + weight + "), auto_get='" + auto_get +"', formula='" + formula +"',"+
	                "note='" +note +"', update_login_no='" + update_login_no +"', update_date=sysdate " +                          
	                " where trim(contect_id) = '" + content_id + "'";
	
	System.out.println(sqlStr);

   System.out.println("############################################");
   
%>

<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","000000");
response.data.add("retMsg","success");
core.ajax.receivePacket(response);