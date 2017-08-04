<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K502";
	String opName = "编辑预定义短信";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_content_id = (String) request.getParameter("msg_mod_content_id");
	
	String updateSql = "update DMESSAGEMODELCONTENT set MSG_MOD_CONTENT = '"+msg_mod_content+"' where msg_mod_content_id = '"+msg_mod_content_id+"'";
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=updateSql %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
			if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "更新预定义短信失败!";
	%>
	rdShowMessageDialog("更新预定义短信失败！错误代码:<%=rows[0][0] %>");
	<%
	  	}
	%>
	rdShowMessageDialog("更新预定义短信成功！");
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
