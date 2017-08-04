<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%    
     response.setHeader("Pragma", "No-cache");   
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "0"); 
     String CityCode="";
     String sqlStr="";
     String CalledNo=request.getParameter("CalledNo").trim();
     String UserClass=request.getParameter("UserClass").trim();
     CityCode=request.getParameter("CityCode").trim();
     String ServiceNo=request.getParameter("ServiceNo").trim();
     String inFlag=request.getParameter("inFlag").trim();
     String orgCode = (String)session.getAttribute("orgCode");
		 String regionCode = orgCode.substring(0,2);
		 String myParams="";
     if(!CityCode.equals("")&&!CalledNo.equals("")&&!UserClass.equals(""))
     {
       if(inFlag.equals("0")){
        sqlStr="select a.id,a.superid ,a.typeid,a.servicename,a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
        sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
        sqlStr=sqlStr+"and userclass=:UserClass ";
        sqlStr=sqlStr+"and citycode=:CityCode ";
        sqlStr=sqlStr+"and a.typeid not in('0','1','2','3') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid) order by a.id" ;
        myParams = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
       }
       else{
         sqlStr="select a.id,a.superid ,a.typeid,a.servicename,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
         sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
         sqlStr=sqlStr+"and userclass=:UserClass ";
         sqlStr=sqlStr+"and citycode=:CityCode ";
         sqlStr=sqlStr+"and not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid) order by a.id" ;
         myParams = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
       }
     }
     System.out.println("55555555555555555555555555555555555555555555++=: "+sqlStr);
      
      
    %>
 	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
		<wtc:param value="<%=sqlStr%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
    <% 
    StringBuffer xml = new StringBuffer();    
    xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");     
    xml.append("<tree id=\"-1\">");   
   // xml.append("<item text= \"" + queryList[0][3]+ "\"");	
   // xml.append("  id= \"" + queryList[0][0] + "\"");
    //xml.append(" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\" >");
    
    	
   // xml.append("<item text=\""+queryList[0][3]+"\"" id=\""+queryList[0][0]+"\"" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\"  >");  
   // xml.append("<userdata name='typeid'>"+queryList[0][2]+"</userdata>");  
   // xml.append("<userdata name='super_id'>"+queryList[0][1]+"</userdata>");   
   // xml.append("<userdata name='fullname'>root</userdata>");  
    
     for (int i = 0; i < queryList.length; i++) {
        xml.append("<item text= \"" + queryList[i][3]+ "\"");    
        xml.append("  id= \"" + queryList[i][0] + "\"");    
      if(queryList[i][2].equals("2001")||queryList[i][2].equals("2003")){
            xml.append(" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
            //xml.append(" child=\"1\">");   
        }else {    
            xml.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">"); 
            //xml.append(" child=\"0\">");     
        } 
            xml.append("<userdata name='typeid'>"+queryList[i][2]+"</userdata>");  
            xml.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
            xml.append("<userdata name='servicename'>"+queryList[i][3]+"</userdata>");
            xml.append("<userdata name='ttansfercode'>"+queryList[i][4]+"</userdata>"); 
            xml.append("<userdata name='digitcode'>"+queryList[i][5]+"</userdata>"); 
            xml.append("<userdata name='userclass'>"+queryList[i][6]+"</userdata>"); 
            xml.append("<userdata name='usertype'>"+queryList[i][7]+"</userdata>"); 
          xml.append("</item>"); 
       }
    
    //xml.append("</item>"); 
    xml.append("</tree>");     
        
    //System.out.println("xml :\n" + xml.toString());    
    response.setContentType("text/xml; charset=UTF-8");    
    response.getWriter().write(xml.toString());    
    response.getWriter().close();    
%> 