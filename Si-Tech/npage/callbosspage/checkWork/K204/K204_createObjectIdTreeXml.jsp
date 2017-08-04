<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<% 
  response.setHeader("Pragma", "No-cache");   
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Expires", "0"); 
  StringBuffer xml = new StringBuffer();    
	xml.append("<?xml version=\"1.0\" encoding=\"gb2312\"?>");
	xml.append("<tree id=\"-1\">");
	xml.append("<item text=\"所有被检对象类别\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
	xml.append("<userdata name='isleaf'>N</userdata>");
	xml.append("</item>");
	xml.append("</tree>");     
  response.setContentType("text/xml; charset=gb2312");    
  response.getWriter().write(xml.toString());    
  response.getWriter().close();    
%> 