<%
  /*
   * 功能: 更新被检对象类别
　 * 版本: 1.0.0
　 * 日期: 2008/11/09
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "更新测评项";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String item_id = WtcUtil.repNull(request.getParameter("item_id"));
	String is_leaf = WtcUtil.repNull(request.getParameter("is_leaf"));
	String item_name = WtcUtil.repNull(request.getParameter("item_name"));
	String low_score = WtcUtil.repNull(request.getParameter("low_score"));
	String high_score = WtcUtil.repNull(request.getParameter("high_score"));
	String weight = WtcUtil.repNull(request.getParameter("weight"));
	String formula = WtcUtil.repNull(request.getParameter("formula"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String isDefault = WtcUtil.repNull(request.getParameter("isDefault"));
	
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	String sqlStr = "update dqccheckitem set item_name='" + item_name + "', weight='" + weight + "', " +
					"low_score='" + low_score + "', high_score='" + high_score + "', formula='" + formula + "', " +
	                "note='" + note +"',bak2='" + isDefault + "' where trim(item_id) = '" + item_id + "'";
	
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