<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%    
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
     String strNodeId=request.getParameter("id");
     String sqlStr="";
     if(strNodeId==""||strNodeId==null){
      sqlStr ="0" ;
      } 
    String caption=request.getParameter("caption"); 
    String isleaf=request.getParameter("isleaf"); 
    String super_id=request.getParameter("super_id");
    String fullname = request.getParameter("fullname");
    String selectPara =request.getParameter("selectPara");
    %>   
    <% 
    String temp=null;
    StringBuffer xml = new StringBuffer();
    if(selectPara.equals("1")){
    StringBuffer full = new StringBuffer();
     temp= full.append(caption).append(" ").append("[ ").append(fullname).append(" ]").toString();
    //System.out.println("aaaaaaaaaaaaaaaaaa+++++"+temp); 
    }
    else
    {
      temp=caption;
    }  
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    xml.append("<tree id=\"-1\">");   		
    xml.append("<item text=\""+temp+"\" id=\""+strNodeId+"\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");    
    xml.append(" child=\"0\"  >");  
    xml.append("<userdata name='isleaf'>"+isleaf+"</userdata>");  
    xml.append("<userdata name='super_id'>"+strNodeId+"</userdata>");   
    xml.append("<userdata name='fullname'>"+fullname+"</userdata>");   
    xml.append("</item>"); 
    xml.append("</tree>");  
    System.out.println("xml :\n" + xml.toString());          
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 