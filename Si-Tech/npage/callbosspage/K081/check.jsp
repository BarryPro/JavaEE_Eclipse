<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
       /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
   try{
   
   String check = request.getParameter("check");
   
   String sqlCheck = "SELECT to_char(COUNT(*)) FROM scalloutfailreson WHERE failure_code =:vcheck";
   myParams="vcheck="+check;
   
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
  <wtc:param value="<%=sqlCheck%>"/>
  <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>	

<%

   if("0".equals(rows[0][0]))
     {
       retCode = "000000";
       retMsg  = "通过验证";
     }
   else
     {
       retCode = "000001";
       retMsg  = "未通过验证";
     }
  
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

<%
	 }
   catch(Exception e)
   {
   e.printStackTrace();
   }
%>
