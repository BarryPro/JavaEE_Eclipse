<%
  /*
   * 功能: 考评项树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
String sqlStr = "select t.item_id, t.parent_item_id, t.item_name, t.is_leaf from " + 
                "(select item_id, parent_item_id, item_name, is_leaf from dqccheckitem where object_id=:object_id and contect_id=:content_id ) t " + 
                "start with parent_item_id='0' connect by prior item_id = parent_item_id";
myParams = "object_id="+object_id+",content_id="+content_id;

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>

<%

 response.setHeader("Pragma", "No-cache");
 response.setHeader("Cache-Control", "no-cache");
 response.setHeader("Expires", "0");

%>


<%
StringBuffer xml = new StringBuffer();
xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
xml.append("<tree id=\"-1\">");
xml.append("<item text=\"全部\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");


//xml.append("<item text=\"node1\" id=\"001\"/>");
//xml.append("<item text=\"node2\" id=\"002\"/>");
//xml.append("<item text=\"node3\" id=\"003\">");
//xml.append("<item text=\"node4\" id=\"004\"/>");
//xml.append("<item text=\"node5\" id=\"005\"/>");
//xml.append("</item>");


xml.append("<userdata name='isleaf'>0</userdata>");
xml.append("<userdata name='super_id'>-1</userdata>");
xml.append("</item>");
xml.append("</tree>");

//System.out.println("xml :\n" + xml.toString());
response.setContentType("text/xml; charset=UTF-8");
response.getWriter().write(xml.toString());
response.getWriter().close();
%>