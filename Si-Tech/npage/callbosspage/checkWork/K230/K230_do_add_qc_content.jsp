<%
   /*
    * 功能: 添加考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
    * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "添加考评内容";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String source_id = WtcUtil.repNull(request.getParameter("source_id"));
	String name = WtcUtil.repNull(request.getParameter("content_name"));
	String weight = WtcUtil.repNull(request.getParameter("weight"));
	String auto_get = WtcUtil.repNull(request.getParameter("auto_get"));
        String formula = WtcUtil.repNull(request.getParameter("formula"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String crete_login_no = WtcUtil.repNull(request.getParameter("crete_login_no"));
	formula = formula.replaceAll(" ","+");
%>

<wtc:service name="sK230istCt" outnum="3">
	<wtc:param value="<%=object_id.trim()%>"/>
	<wtc:param value="<%=source_id.trim()%>"/>
	<wtc:param value="<%=name.trim()%>"/>
	<wtc:param value="<%=weight.trim()%>"/>
	<wtc:param value="<%=auto_get.trim()%>"/>
	<wtc:param value="<%=formula.trim()%>"/>
	<wtc:param value="<%=note.trim()%>"/>
	<wtc:param value="<%=crete_login_no.trim()%>"/>		
</wtc:service>

<wtc:row id="row" start="0" length="3">
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
response.data.add("content_id","<%=row[2]%>");
core.ajax.receivePacket(response);
</wtc:row>