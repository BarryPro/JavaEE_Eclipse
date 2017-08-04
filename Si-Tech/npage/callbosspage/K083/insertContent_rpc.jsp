<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String opCode = "K083";
	String opName = "增加预定义短信";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_id = (String) request.getParameter("msg_mod_id");
	String loginNo = (String) session.getAttribute("workNo");
	String insertSql = "insert into DMESSAGEMODELCONTENT_CON (msg_mod_content_id,msg_mod_id,msg_mod_content,CREATE_LOGIN_NO,CREATE_TIME)"
										 + " select SEQ_12580.nextval, :v1,:v2,:v3,sysdate from dual";
	
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=insertSql %>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=msg_mod_id%>"/>
	<wtc:param value="<%=msg_mod_content%>"/>
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
			if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "增加预定义短信失败!";
	%>
	rdShowMessageDialog("增加预定义短信失败！错误代码:<%=rows[0][0] %>");
	<%
	  	}
	%>
	rdShowMessageDialog("增加预定义短信成功！");
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
