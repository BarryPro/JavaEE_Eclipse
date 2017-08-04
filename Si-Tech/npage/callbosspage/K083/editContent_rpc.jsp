<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String opCode = "K083";
	String opName = "编辑预定义短信";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_content_id = (String) request.getParameter("msg_mod_content_id");
	
	String updateSql = "update DMESSAGEMODELCONTENT_CON set MSG_MOD_CONTENT = :v1 where msg_mod_content_id = :v2";
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=updateSql %>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=msg_mod_content%>"/>
	<wtc:param value="<%=msg_mod_content_id%>"/>
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
