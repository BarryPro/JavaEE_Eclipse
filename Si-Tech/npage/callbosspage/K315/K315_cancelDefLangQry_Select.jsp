<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
     String telphoneno = request.getParameter("telphoneno");
     String sqlStr = " select t.telphoneno,t.languagetype  from t_sce_telinfo t ";
     telphoneno="telphoneno="+telphoneno;
     sqlStr =sqlStr + " where t.telphoneno= :telphoneno" ;    
     System.out.println("<<<<<<<< result.length==null>>>>>>");        
%>
     <wtc:service name="TlsPubSelCrm" outnum="2">
       <wtc:param value="<%=sqlStr%>"/>
       <wtc:param value="<%=telphoneno%>"/>
	   </wtc:service>
		 <wtc:array id="queryList"  start="0" length="2"   scope="end"/> 
<%        
     String[][] result = queryList;
     String phone="";
     String lang="";
     if(result.length==0)
     {
         System.out.println("<<<<<<<< result.length==null>>>>>>");
         phone = "FAILURE";
         lang = "FAILURE";
     }
     else 
     {
         phone = result[0][0];
         lang  = result[0][1];
     }
%>           	
var response = new AJAXPacket();
response.data.add("telphoneno","<%=phone%>");
response.data.add("lang","<%=lang%>");
core.ajax.receivePacket(response);

