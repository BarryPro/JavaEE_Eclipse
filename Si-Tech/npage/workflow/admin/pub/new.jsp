<%  
    String wono=(String)request.getAttribute("wono");
		String wano=(String)request.getAttribute("wano");
		String xmlstr=(String)request.getAttribute("xmlStr");
 %>
<xsl:apply xmlstr="<%=xmlstr%>" xsl="/page/workflow/xml/worksheet.xsl"/>
