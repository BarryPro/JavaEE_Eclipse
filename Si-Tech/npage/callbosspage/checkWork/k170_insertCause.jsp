<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
//获取参数
String strNodeId=request.getParameter("strNodeId");
String strNodeName=request.getParameter("strNodeName");
String strContactId=request.getParameter("strContactId");
String strContactMonth= request.getParameter("contactMonth");
	System.out.println("strContactId222222222:\t"+strContactId);
String strUpdSql="update dcallcall"+strContactMonth+" t set t.call_cause_id='"+strNodeId+"',";
       strUpdSql+="t.callcausedescs='"+strNodeName+"' where t.contact_id='"+strContactId+"'";
List sqlList=new ArrayList();
System.out.println("########################"+strUpdSql);
String[] sqlArr = new String[]{};
		     sqlList.add(strUpdSql);
		     sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);  
//String add_flag="";     
       
%>
<wtc:service name="sPubModify"  outnum="<%=outnum%>">
<wtc:params value="<%=sqlArr%>"/>
<wtc:param value="dbcall"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
