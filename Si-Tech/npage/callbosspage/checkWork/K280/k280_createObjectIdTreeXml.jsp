<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->所属对象类别树的数据生成
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<% 
  response.setHeader("Pragma", "No-cache");   
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Expires", "0"); 
  StringBuffer xml = new StringBuffer();    
	xml.append("<?xml version=\"1.0\" encoding=\"gbk\"?>");
	xml.append("<tree id=\"-1\">");
	xml.append("<item text=\"所有被检对象类别\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
	xml.append("<userdata name='isleaf'>N</userdata>");
	xml.append("</item>");
	xml.append("</tree>");     
  response.setContentType("text/xml; charset=gbk");    
  response.getWriter().write(xml.toString());    
  response.getWriter().close();    
%> 