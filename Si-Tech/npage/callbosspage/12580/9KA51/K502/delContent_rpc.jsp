<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "K502";
	String opName = "删除预定义短信内容";
	
	String msg_mod_content = (String) request.getParameter("msg_mod_content");
	String msg_mod_content_ids = (String) request.getParameter("msg_mod_content_ids");
	
	
	String[] str = (String[])msg_mod_content_ids.split(",");
	String[] sqlArr = new String[]{};
	List sqlList = new ArrayList();
	String delSql = "";
	for(int i = 0; i < str.length; i++){
		delSql = "delete from DMESSAGEMODELCONTENT where msg_mod_content_id = '"+str[i]+"'";
		sqlList.add(delSql);
	}
	sqlArr = (String[])sqlList.toArray(new String[sqlList.size()]); 
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:params value="<%=sqlArr %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
			if(rows[0][0].equals("000001")){
	     retCode = "1";
	     retMsg = "删除预定义短信内容失败!";
	%>
	rdShowMessageDialog("删除预定义短信内容失败！错误代码:<%=rows[0][0] %>");
	<%
	  	}
	%>
	rdShowMessageDialog("删除预定义短信内容成功！");
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode %>");
	response.data.add("retMsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
