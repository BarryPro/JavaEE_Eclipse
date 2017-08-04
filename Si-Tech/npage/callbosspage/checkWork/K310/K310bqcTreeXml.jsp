<%
  /*
   * 功能: 选择质检工号群组树初始化
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>
<%@page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
  response.setHeader("Pragma", "No-cache");   
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Expires", "0"); 
	StringBuffer xml = new StringBuffer();
	xml.append("<?xml version=\"1.0\" encoding=\"gbk\"?>");
	xml.append("<tree id=\"-1\">");
	xml.append("<item text=\"质检组\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
	xml.append("<userdata name='isleaf'>N</userdata>");

	xml.append("</item>");
	xml.append("</tree>");

	response.setContentType("text/xml; charset=gbk");
	response.getWriter().write(xml.toString());
	response.getWriter().close();
%>
