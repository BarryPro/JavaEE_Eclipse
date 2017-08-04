<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%  
    String wono=(String)request.getAttribute("wono");
		String wano=(String)request.getAttribute("wano");
		String xmlstr=(String)request.getAttribute("xmlStr");
 %>

	<xsl:apply xmlstr="<%=xmlstr%>" xsl="/page/workflow/xml/worksheet.xsl"/>
