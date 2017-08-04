<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
 /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 String nodeId = request.getParameter("nodeId");
 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where 1=1 and t.callcause_id=:nodeId";
 myParams="nodeId="+nodeId; 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>
<%
 StringBuffer xml = new StringBuffer();
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    xml.append("<tree id=\"-1\">");   		
    xml.append("<item text=\""+resultList[0][2]+"\" id=\""+nodeId+"\" open=\"0\" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");    
    xml.append(" child=\"0\"  >");  
           xml.append("<userdata name='caption'>"+resultList[0][2]+"</userdata>");
           xml.append("<userdata name='isleaf'>"+resultList[0][3]+"</userdata>");  
           xml.append("<userdata name='super_id'>"+resultList[0][1]+"</userdata>");   
           xml.append("<userdata name='fullname'>"+resultList[0][4]+"</userdata>");  
    xml.append("</item>"); 
    xml.append("</tree>");           
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();   
%>
