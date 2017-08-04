<%
   /*
    * 功能: 添加被检对象类别
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
    * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "添加被检对象类别";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String retType           = WtcUtil.repNull(request.getParameter("retType"));
	String object_name     = WtcUtil.repNull(request.getParameter("object_name"));
	String object_type      = WtcUtil.repNull(request.getParameter("object_type"));
	String modify_flag       = WtcUtil.repNull(request.getParameter("modify_flag"));
	String note                = WtcUtil.repNull(request.getParameter("note"));
	String create_login_no = WtcUtil.repNull(request.getParameter("create_login_no"));
	if(create_login_no.equals("null")){
		create_login_no = "";
	}  

%>


<wtc:service name="sK230ist" outnum="3">
	<wtc:param value="<%=object_name.trim()%>"/>
	<wtc:param value="<%=object_type.trim()%>"/>
	<wtc:param value="<%=note.trim()%>"/>
	<wtc:param value="<%=create_login_no.trim()%>"/>
	<wtc:param value="<%=modify_flag.trim()%>"/>
</wtc:service>

<wtc:row id="row" start="0" length="3">
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%=row[2]%>");
core.ajax.receivePacket(response);
</wtc:row>