<%
  /*
   * 功能: 添加考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "添加考评项等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType        = WtcUtil.repNull(request.getParameter("retType"));
	String item_id        = WtcUtil.repNull(request.getParameter("item_id"));
	String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
	String level_name     = WtcUtil.repNull(request.getParameter("level_name"));
	String score          = WtcUtil.repNull(request.getParameter("score"));
	String is_def_level   = WtcUtil.repNull(request.getParameter("is_def_level"));
	String note           = WtcUtil.repNull(request.getParameter("note"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	
	
	
	String sqlStr = "insert into dqcckectitemlevel (level_id, item_id, content_id, object_id, level_name, score, is_def_level, note, crete_login_no, create_date, serialno) " +
	                "select seq_check_item_level.nextval, '"+item_id+"','"+content_id+"','"+object_id+"','"+level_name+"',"+
	                "'"+score+"','"+is_def_level+"','"+note+"','"+crete_login_no+"',sysdate, seq_check_item_level.currval from dual";
	                
   
   System.out.println(sqlStr);

   System.out.println("############################################");
   
%>

<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>

<wtc:array id="queryList" scope="end"/>	
<%
//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
//System.out.println(queryList.length);
//System.out.println(queryList[0][0]);
//System.out.println(queryList[0][1]);
//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);

