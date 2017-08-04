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

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "0");

	StringBuffer xml = new StringBuffer();
	xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
	xml.append("<tree id=\"-1\">");
	xml.append("<item text=\"全部\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");
	xml.append("<userdata name='isleaf'>0</userdata>");
	xml.append("<userdata name='super_id'>-1</userdata>");
	xml.append("<userdata name='isscored'>0</userdata>");
	xml.append("</item>");
	xml.append("</tree>");

	response.setContentType("text/xml; charset=UTF-8");
	response.getWriter().write(xml.toString());
	response.getWriter().close();
%>