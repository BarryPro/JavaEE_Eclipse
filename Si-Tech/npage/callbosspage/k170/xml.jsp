<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%    
    
    response.setHeader("Pragma", "No-cache");   
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "0");  
    String parent = "-1";//request.getParameter("id");  
        /*midify by yinzx 20091113 公共查询服务替换*/
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	  
    String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf from DCALLCAUSECFG t where t.super_id='000' order by t.callcause_id";
    %>
 
     			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
    <% 
    StringBuffer xml = new StringBuffer();    
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    if(parent==null){ 
     //虚拟根点击 
        xml.append("<tree id=\"0\">");     
        xml.append("<item text=\"root\" id=\"000\" open=\"0\">");    
    }else {   
    	parent="0" ;
        xml.append("<tree id=\"" + parent + "\">");  
        xml.append("<item text=\"root\" id=\"000\" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");  
       // xml.append(" child=\"0\" >"); 
    }   
    // 循环读取所有节点     
    for (int i = 0; i < queryList.length; i++) {    
        xml.append("<item text= \"" + queryList[i][2]+ "\"");    
        xml.append("  id= \"" + queryList[i][0] + "\"");    
      if(queryList.length>0){
            xml.append(" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");    
            xml.append(" child=\""+queryList[i][0]+">");  
        }else {    
            xml.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"");    
            xml.append(" child=\"0\" >");    
        }    
        //xml.append(" action=\"#\"");    
        //xml.append(" target=\"main\">");    
        xml.append("</item>");    
    }    
    if(parent==null){    
        xml.append("</item>");    
    }else{
 
    	 xml.append("</item>"); 
    }   
    xml.append("</tree>");     
        
    //System.out.println("xml :\n" + xml.toString());    
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 