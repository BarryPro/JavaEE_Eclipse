<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
public String returnSqlStr(String str){
String sqlStr ="";
if(str!=null){
 
 sqlStr="select t.callcause_id ,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where t.super_id=:str  order by t.callcause_id"; 
}
return sqlStr ;
}
%>
<%    
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
     /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
     String strNodeId=request.getParameter("id");
      String sqlStr="";
      if(strNodeId==""||strNodeId==null){
      sqlStr ="0" ;
      strNodeId
 ="0";
    } else{ 	
    	sqlStr= returnSqlStr (strNodeId);
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
    xml.append("<tree id=\"" + strNodeId + "\">"); 
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
    xml.append("</tree>");     
        
    //System.out.println("xml :\n" + xml.toString());    
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 