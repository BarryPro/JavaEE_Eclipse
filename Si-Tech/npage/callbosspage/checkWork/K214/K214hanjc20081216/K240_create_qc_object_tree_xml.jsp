<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%   
 
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
     String op_code = request.getParameter("op_code");
     System.out.print("\n\n[" + op_code + "]\n\n");
     String service_name = new String();
     int int_op_code = Integer.parseInt(op_code.substring(1,4));
     switch(int_op_code){
     		case 240:service_name = "sK240Qry";break;
     		case 250:service_name = "sK250Qry";break;
     		case 260:service_name = "sK260Qry";break;
     		case 270:service_name = "sK270Qry";break;
     }
     System.out.print("\n\n[" + service_name + "]\n\n");
%>
 	<wtc:service name="<%=service_name%>" outnum="5">
	</wtc:service>
	<wtc:array id="result" scope="end"/>	
    <%
    StringBuffer xml = new StringBuffer(); 
    
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    xml.append("<tree id=\"-1\">");   		
    xml.append("<item text=\"\" id=\"0\" open=\"0\"  ");    
    //xml.append("<item text=\"\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");    
    xml.append(" child=\"0\"  >");
    xml.append("<userdata name='isleaf'>0</userdata>");  
    xml.append("<userdata name='super_id'>-1</userdata>");   
    xml.append("<userdata name='fullname'>root</userdata>");  
    
    for (int i = 0; i < result.length; i++) {
        xml.append("<item text= \"" + result[i][0]+ "\"");    
        xml.append("  id= \"" + result[i][2] + "\"");    
      if(0==0){
            xml.append(" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");
            xml.append(" child=\"1\">");   
        }else {    
            xml.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\""); 
            xml.append(" child=\"0\">");     
        } 
            xml.append("<userdata name='isleaf'>0</userdata>");  
            xml.append("<userdata name='super_id'>"+result[i][3]+"</userdata>");   
            xml.append("<userdata name='fullname'>"+result[i][0]+"</userdata>");   


						xml.append("<item text= \"11111\"  id= \"01\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\" child=\"1\">");
						xml.append("<userdata name=\'isleaf\'>0</userdata>");
						xml.append("<userdata name=\'super_id\'>01</userdata>");
						xml.append("<userdata name=\'fullname\'>11111</userdata>");
						xml.append("</item>");
          xml.append("</item>"); 
      }
    
  xml.append("</item>"); 
    xml.append("</tree>");     
        
    System.out.println("xml :\n[" + xml.toString() + "]");    
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 