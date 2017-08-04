<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String path = request.getContextPath();
String id = request.getParameter("id");
String vop_code = request.getParameter("op_code");
String sql = "";
int int_op_code = Integer.parseInt(vop_code.substring(1,4));

%>
<%   
 
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
      
%>
<%
    StringBuffer xml = new StringBuffer();  
    StringBuffer ids = new StringBuffer();  
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");  

    if(id ==null)   {
    	xml.append("<tree id=\"0000\">");   
    	id="0000";
    }

    else{
      xml.append("<tree id=\""+id+"\">");  
    }		
    
    switch(int_op_code){
    

   		case 240:
   		sql = "select error_class_id,error_class_name,'0' from DQCERRORCLASS where parent_error_class_id = :id";
   		myParams = "id="+id ;
   		break;

   		case 250:
   		sql = "select error_level_id,error_level_name,'0' from dQcErrorlevel where parent_error_level_id= :id";
   		myParams = "id="+id ;
   		break;

   		case 260:
   		sql = "select reason_id,reason_name,'0' from DQCABORTREASON where parent_reason_id= :id";
   		myParams = "id="+id ;
   		break;

   		case 270:
   		sql = "select service_class_id,class_name,'0' from DQCSERVICECLASS where parent_service_class_id= :id";
   		myParams = "id="+id ;
   		break;
   		
   		/* add by hucw,20100531 */
   		case 271:
   		sql = "select remark_class_id,remark_class_name,'0' from DQCREMARKCLASS where parent_remark_class_id = :id";
			myParams = "id="+id ;
			break;
   }%>
   <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
   	  <wtc:param value="<%=sql%>"/>
   	  <wtc:param value="<%=myParams%>"/>
      </wtc:service>
   <wtc:array id="result" scope="end"/>	
   <%
    int res_len = result.length;
System.out.println("BBBBBBBBBBBBBBBBBBBB"+res_len);
    int res_len2 = 0;

    String[][] result2 = null;
    if(res_len>0){
   		for (int i = 0; i < res_len; i++) {
   	    if(i!=0){
   	    	ids.append(","); 
   	    }
        ids.append("'"+result[i][0]+"'");    
      }

    	switch(int_op_code){

   			case 240:
   			sql = "select parent_error_class_id,to_char(count(*)) from DQCERRORCLASS where parent_error_class_id in ("+ids.toString()+") group by parent_error_class_id";
   			break;

   			case 250:
   			sql = "select parent_error_level_id,to_char(count(*)) from dQcErrorlevel where parent_error_level_id in ("+ids.toString()+") group by parent_error_level_id";
   			break;

   			case 260:
   			sql = "select parent_reason_id,to_char(count(*)) from DQCABORTREASON where parent_reason_id in ("+ids.toString()+") group by parent_reason_id";
   			break;

   			case 270:
   			sql = "select parent_service_class_id,to_char(count(*)) from dqcserviceclass where parent_service_class_id in ("+ids.toString()+") group by parent_service_class_id";
   			break;
				
				/* add by hucw,20100531 */
				case 271:
				sql = "select parent_remark_class_id,to_char(count(*)) from dqcremarkclass where parent_remark_class_id in ("+ids.toString()+") group by parent_remark_class_id";
				break;
   		}
   %>
   <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
   	  <wtc:param value="<%=sql%>"/>
      </wtc:service>
   <wtc:array id="result_temp" scope="end"/>	
   <%
   	 result2 = result_temp;
   	 if(result2!=null){
   	 		res_len2 = result2.length;
   	 }
   
   	}
   	

   	for (int j = 0; j < res_len2; j++) {            
        for (int i = 0; i < res_len; i++) {
           if(result2[j][0].equals(result[i][0])){
               result[i][2] = result2[j][1];
               break;
           }
        }
    }

    StringBuffer xml_temp = new StringBuffer();  
    StringBuffer xml_temp2 = new StringBuffer();


    for (int i = 0; i < res_len; i++) {
            
        if(result[i][2].equals("0")){
        	xml_temp2.append("<item text= \""+result[i][1] +  "\"");    
        	xml_temp2.append("  id= \"" +result[i][0] + "\"");
        	xml_temp2.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");
        	xml_temp2.append(" child=\"0\">");  
        	xml_temp2.append("</item>"); 
        } else{     	       	
        	xml_temp.append("<item text= \""+result[i][1]+"("+result[i][2]+")\"");  
        	xml_temp.append("  id= \"" +result[i][0] + "\"");         	
        	xml_temp.append(" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");
        	xml_temp.append(" child=\"1\">"); 
        	xml_temp.append("</item>"); 
        }


        
    }
    xml.append(xml_temp.toString());
    xml.append(xml_temp2.toString());
    xml.append("</tree>");     
    
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 
