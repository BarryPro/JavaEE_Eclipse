<%
  /*
   * 功能: 删除指定评测内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/08
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "删除指定评测内容";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	
	//String sqlStr = "delete from dqccheckcontect where trim(contect_id) = '" + content_id + "'";
   String sqlStr = "update dqccheckcontect set bak1='N' where trim(contect_id) = '" + content_id+"'";
   System.out.println(sqlStr);

   System.out.println("############################################");
   
%>

<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>

<%
 //不管添加成功还是失败，都没有返回值，这是个问题。
%>

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

