<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnSqlStr(String str,String manage){
String sqlStr ="";
String sqlStrPlus ="";
if(manage.equals("0")){
	sqlStrPlus = "and visible='1'";
}
if(str!=null){
 
 sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.super_id='"+str+"' and t.is_del='N' "+sqlStrPlus+" order by t.callcause_id"; 

}
return sqlStr ;
}
%>
<%    
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
     String myParams="";
     String org_code = (String)session.getAttribute("orgCode");
 	   String regionCode = org_code.substring(0,2);
     String strNodeId=request.getParameter("id");
     String manage=request.getParameter("manage");
    	if(manage==null||manage.equals("")){
         manage ="0";
      }
      String sqlStr="";
      if(strNodeId==""||strNodeId==null){
      sqlStr ="0";
    } else{
    	sqlStr= returnSqlStr (strNodeId,manage);
    	myParams="str="+strNodeId;
    	}
    	
      
    %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
    <% 
    StringBuffer xml = new StringBuffer();    
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    xml.append("<tree id=\"-1\">");   		
    xml.append("<item text=\"ȫʡ\" id=\"0\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");    
  //xml.append(" child=\"0\"  >");  
    xml.append("<userdata name='isleaf'>0</userdata>");  
    xml.append("<userdata name='super_id'>-1</userdata>");   
    xml.append("<userdata name='fullname'>root</userdata>");  
    
  //   for (int i = 0; i < queryList.length; i++) {
 //       xml.append("<item text= \"" + queryList[i][2]+ "\"");    
 //       xml.append("  id= \"" + queryList[i][0] + "\"");    
  //    if(queryList[i][3]=="0"){
   //         xml.append(" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");
   //         xml.append(" child=\"1\">");   
   //     }else {    
   //         xml.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\""); 
   //         xml.append(" child=\"0\">");     
   //     } 
   //         xml.append("<userdata name='isleaf'>"+queryList[i][3]+"</userdata>");  
   //         xml.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
   //         xml.append("<userdata name='fullname'>"+queryList[i][4]+"</userdata>");   

   //       xml.append("</item>"); 
    //   }
    
    xml.append("</item>"); 
    xml.append("</tree>");     
        
    System.out.println("xml :\n" + xml.toString());    
    response.setContentType("text/xml; charset=utf-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 