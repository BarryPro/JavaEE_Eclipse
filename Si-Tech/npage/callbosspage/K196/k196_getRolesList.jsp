<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String showmessage="";
String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));

 String sql_getSpecial = " select nvl(t.bak1,'') from scallspeciallist t where t.funcid =  :selectedItemId "  ;
 myParams="selectedItemId="+selectedItemId;
 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
	<wtc:param value="<%=sql_getSpecial%>" />
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
 
 
<%
	if( retCode.equals("000000") )
	{
	     showmessage=rows[0][0];
	}
%>

var response = new AJAXPacket();
response.data.add("showmessage","<%=showmessage%>");
core.ajax.receivePacket(response);

