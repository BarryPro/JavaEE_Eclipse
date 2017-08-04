<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K502";
	String opName = "增加预定义短信";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_id = (String) request.getParameter("msg_mod_id");
	String loginNo = (String) session.getAttribute("workNo");
	String insertSql = "insert into DMESSAGEMODELCONTENT (msg_mod_content_id,msg_mod_id,msg_mod_content,CREATE_LOGIN_NO,CREATE_TIME)"
										 + " select SEQ_12580.nextval, '"+msg_mod_id+"','"+msg_mod_content+"','"+loginNo+"',sysdate from dual";
	
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=insertSql %>"/>
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
