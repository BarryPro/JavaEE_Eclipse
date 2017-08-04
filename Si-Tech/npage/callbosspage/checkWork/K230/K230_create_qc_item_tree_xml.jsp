<%
  /*
   * 功能: 考评项树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/04/07
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Expires", "0");
%>

<%
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
if("".equals(object_id)){
	object_id = "01";
}
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
if("".equals(content_id)){
	content_id = "02";
}
String parent_item_id = WtcUtil.repNull(request.getParameter("parent_item_id"));
if("".equals(parent_item_id)){
	parent_item_id = "0";
}

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";

String sqlStr = "select t.item_id, t.parent_item_id, t.item_name, t.is_leaf, t.is_scored,t.object_id " +
                "from dqccheckitem t "+
                "where trim(t.parent_item_id)='0' and object_id = :object_id and contect_id = :content_id and bak1='Y' " +
                "order by t.item_id";
myParams = "object_id="+object_id+",content_id="+content_id;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="6" scope="end"/>

<%
StringBuffer xml = new StringBuffer();
xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
xml.append("<tree id=\"-1\">");
xml.append("<item text=\"全部\" id=\"0\" open=\"1\" call=\"0\" select=\"0\" child=\"1\" >");

for(int i = 0; i< resultList.length; i++){
	xml.append(	"<item text=\"" + resultList[i][2] + "\" id=\"" + resultList[i][0] + "\" child=\"1\" >");
	xml.append(		"<userdata name='isleaf'>" + resultList[i][3] + "</userdata>");
	xml.append(		"<userdata name='super_id'>" + resultList[i][1] + "</userdata>");
	xml.append(		"<userdata name='isscored'>" + resultList[i][4] + "</userdata>");
	xml.append("</item>");
}

xml.append("<userdata name='isleaf'>0</userdata>");
xml.append("<userdata name='super_id'>-1</userdata>");
xml.append("<userdata name='isscored'>0</userdata>");
xml.append("<userdata name='object_id'></userdata>");
xml.append("</item>");
xml.append("</tree>");

response.setContentType("text/xml; charset=UTF-8");
response.getWriter().write(xml.toString());
response.getWriter().close();
%>