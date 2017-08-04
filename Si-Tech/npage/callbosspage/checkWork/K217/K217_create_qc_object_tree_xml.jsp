<%
  /*
   * 功能: 质检对象树
　 * 版本: 1.0.0
　 * 日期: 2008/12/20
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 	String sqlStr = "select t.object_id, t.parent_object_id, t.object_name, '0', t.object_name " + 
                 "from dqcobject t where t.parent_object_id='0' order by t.object_id";
%>

<%   
 response.setHeader("Pragma", "No-cache");   
 response.setHeader("Cache-Control", "no-cache");
 response.setHeader("Expires", "0"); 
%>

 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
			<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
		
<%
  StringBuffer xml = new StringBuffer();    
  xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
  xml.append("<tree id=\"-1\">");   		
  xml.append("<item text=\"\" id=\"0\" open=\"0\"  >");    
  xml.append(" child=\"0\"  >");
  xml.append("<userdata name='isleaf'>0</userdata>");  
  xml.append("<userdata name='super_id'>-1</userdata>");   
  xml.append("<userdata name='fullname'>root</userdata>");  
  
  for (int i = 0; i < queryList.length; i++) {
      xml.append("<item text= \"" + queryList[i][2]+ "\"");    
      xml.append("  id= \"" + queryList[i][0] + "\"");    
	    if(queryList[i][3]=="0"){
	          xml.append(" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");
	          xml.append(" child=\"1\">");   
	    }else {    
	          xml.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\""); 
	          xml.append(" child=\"0\">");     
	    } 
      xml.append("<userdata name='isleaf'>"+queryList[i][3]+"</userdata>");  
      xml.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
      xml.append("<userdata name='fullname'>"+queryList[i][4]+"</userdata>");   
    	xml.append("</item>"); 
  }
  
	xml.append("</item>"); 
  xml.append("</tree>");     
  
  response.setContentType("text/xml; charset=UTF-8");    
  response.getWriter().write(xml.toString());    
  response.getWriter().close();    
%> 