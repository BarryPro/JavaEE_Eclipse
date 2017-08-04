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
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
  String sqlStr = "update dqccheckcontect set bak1='N' " +
  		"where trim(contect_id) =:v1 and trim(object_id)=:v2";
      		
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="dbchange"/>
		<wtc:param value="<%=content_id.trim()%>"/>
		<wtc:param value="<%=object_id%>"/>
</wtc:service>

<%
 //不管添加成功还是失败，都没有返回值，这是个问题。
%>

<wtc:array id="queryList" scope="end"/>	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);

