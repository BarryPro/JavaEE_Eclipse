<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->�����������������������
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: 
�� * ��Ȩ: sitech
   * update:
�� */
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
	xml.append("<item text=\"���б���������\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
	xml.append("<userdata name='isleaf'>N</userdata>");
	xml.append("</item>");
	xml.append("</tree>");     
  response.setContentType("text/xml; charset=gbk");    
  response.getWriter().write(xml.toString());    
  response.getWriter().close();    
%> 