<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
System.out.println("----------------------------getOfferAttr.jsp-------------------------------------");  
	System.out.println("<<------------查询销售品属性开始------------>>");
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);

	String OfferId = request.getParameter("OfferId") == null?"":request.getParameter("OfferId");	
	System.out.println("# offerId= "+OfferId);
%>

<wtc:utype name="sGetAttrPage" id="retVal" scope="end">
	<wtc:uparam value="0" type="STRING"/>   
	<wtc:uparam value="<%=OfferId%>" type="LONG"/> 
</wtc:utype>

<%
  String retCode = retVal.getValue(0);
  String infoCode="";
  sb.append(verson_title).append(root_element);
	if((retCode.equals("0"))){
		for(int i=0;i<+retVal.getUtype("2").getSize();i++){
			sb.append("<field "+"order='"+i+"'"+"  dataType='"+retVal.getUtype("2."+i).getValue(2)+"'>");
			sb.append("<info_code>"+retVal.getUtype("2."+i).getValue(0)+"</info_code>");
			sb.append("<info_name>"+retVal.getUtype("2."+i).getValue(1).trim()+"</info_name>");
			sb.append("<read_only>"+retVal.getUtype("2."+i).getValue(3)+"</read_only>");
			sb.append("<data_length>"+retVal.getUtype("2."+i).getValue(4)+"</data_length>");
			sb.append("<data_preci>"+retVal.getUtype("2."+i).getValue(5)+"</data_preci>");
			sb.append("<data_remark>"+retVal.getUtype("2."+i).getValue(6).trim()+"</data_remark>");
			sb.append("<use_line>"+retVal.getUtype("2."+i).getValue(7)+"</use_line>");
			sb.append("<info_obj>"+retVal.getUtype("2."+i).getValue(8).trim()+"</info_obj>");
			sb.append("<option_flag>"+retVal.getUtype("2."+i).getValue(10).trim()+"</option_flag>");
			sb.append("<doc_flag>"+retVal.getUtype("2."+i).getValue(11).trim()+"</doc_flag>");
			sb.append("<show_length>"+retVal.getUtype("2."+i).getValue(12).trim()+"</show_length>");
			sb.append("<default_value>"+retVal.getUtype("2."+i).getValue(13).trim()+"</default_value>");
			sb.append("<id_flag>"+i+"</id_flag>");
			sb.append("</field>");
		}
	}
	
	sb.append(root_element1);
	

	System.out.println("@@@sb1.toString()==============================="+sb.toString());


	 
	System.out.println("<<------------查询销售品属性结束-------------------->>");
%>
	<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate_new.xsl"/>
<script>
	$().ready(function(){
		$("#OfferAttribute :input").not(":button").each(chkDyAttribute);
		<%
		if((retCode.equals("0"))){
			for(int i=0;i<+retVal.getUtype("2").getSize();i++){
				infoCode=retVal.getUtype("2."+i).getValue(0);
			%>
				var arrClassValue = new Array();
				arrClassValue.push("<%=OfferId%>");
				getMidPrompt("10702",arrClassValue,"template_<%=i%>");
			<%
			}
		}
		%>
	});
</script>


