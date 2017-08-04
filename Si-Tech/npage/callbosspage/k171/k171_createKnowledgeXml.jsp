<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");

	StringBuffer xml = new StringBuffer();
	xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
	xml.append("<tree id=\"-100\">");
	xml.append("<item text=\"È«²¿\" id=\"-1\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
  xml.append("<userdata name='isleaf'>0</userdata>");
  xml.append("<userdata name='super_id'>-1</userdata>");
  xml.append("<userdata name='fullname'>root</userdata>");
	xml.append("</item>");
	xml.append("</tree>");

	response.setContentType("text/xml; charset=utf-8");
	response.getWriter().write(xml.toString());
	response.getWriter().close();
%>
