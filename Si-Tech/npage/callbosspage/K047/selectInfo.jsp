<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String called_no_agent = (String) request.getParameter("called_no_agent")==null?"":request.getParameter("called_no_agent");//被监听工号
	SimpleDateFormat sdf  = new SimpleDateFormat("yyyyMM");
	Date nowt = new Date();
	String t = sdf.format(nowt);
	String contact_id = "";
	String sql = "select '1' from dstaffstatus where kf_no=:called_no_agent";
	myParams = "called_no_agent="+called_no_agent ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sql %>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rowsC1" scope="end" />
<%	
if(rowsC1 != null && rowsC1.length > 0){
	sql = "select max(contact_id) from dcallcall"+t+" where accept_kf_login_no = :called_no_agent";
	myParams = "called_no_agent="+called_no_agent; 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sql %>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rowsC4" scope="end" />
<%
		
	if(rowsC4 != null && rowsC4.length > 0){
		contact_id = rowsC4[0][0];
	}
}else{
	contact_id = "null";
}
%>
var response = new AJAXPacket();
response.data.add("called_no_agent","<%=called_no_agent %>");
response.data.add("contact_id","<%=contact_id %>");
core.ajax.receivePacket(response);