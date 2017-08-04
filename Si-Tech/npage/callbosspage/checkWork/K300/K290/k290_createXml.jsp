
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Expires", "0");
%>

<%
String parent_group_id = WtcUtil.repNull(request.getParameter("id"));
if("".equals(parent_group_id)){
	parent_group_id = "0";
}

String sqlStr = "SELECT t.check_group_id, t.parent_group_id, t.group_name, t.is_leaf " +
                "FROM dqccheckgroup t " +
                "WHERE trim(t.parent_group_id)= :parent_group_id AND is_del = 'N' " +
                "ORDER BY t.check_group_id";            
myParams = "parent_group_id="+parent_group_id ;   
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6" scope="end"/>

<%
StringBuffer xml = new StringBuffer();
xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
xml.append("<tree id=\"" + parent_group_id + "\">");

for(int i = 0; i< resultList.length; i++){
	if("Y".equals(resultList[i][3])){
		xml.append(	"<item text=\"" + resultList[i][2] + "\" id=\"" + resultList[i][0] + "\" child=\"0\" >");
	}else{
		xml.append(	"<item text=\"" + resultList[i][2] + "\" id=\"" + resultList[i][0] + "\" child=\"1\" >");
	}
	xml.append(		"<userdata name='parent_group_id'>" + resultList[i][1] + "</userdata>");
	xml.append("</item>");
}
	xml.append("<userdata name='parent_group_id'>" + parent_group_id + "</userdata>");

xml.append("</tree>");

response.setContentType("text/xml; charset=UTF-8");
response.getWriter().write(xml.toString());
response.getWriter().close();
%>