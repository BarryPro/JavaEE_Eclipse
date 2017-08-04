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
	System.out.println("############################################");

	String retType         = WtcUtil.repNull(request.getParameter("retType"));
	String object_id       = WtcUtil.repNull(request.getParameter("object_id"));
	String object_name     = WtcUtil.repNull(request.getParameter("object_name"));
	String object_type     = WtcUtil.repNull(request.getParameter("object_type"));
	String note            = WtcUtil.repNull(request.getParameter("note"));
	String modify_flag     = WtcUtil.repNull(request.getParameter("modify_flag"));
	String update_login_no = WtcUtil.repNull(request.getParameter("update_login_no"));
	if(update_login_no.equals("null")){
	update_login_no = "";
	}
	
	String sqlStr = "update dqcobject set object_name='" + object_name + "', object_type='" + object_type + "', " +
	                "note='" + note + "', update_login_no='" + update_login_no + "', update_date=sysdate, modify_flag='" + modify_flag + "'" + 
	                " where trim(object_id) = '" + object_id + "'";
	
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