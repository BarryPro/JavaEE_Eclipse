<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
System.out.println("----------------------------getOfferAttr.jsp-------------------------------------");  
	System.out.println("<<------------查询销售品属性开始------------>>");

	String OfferId = request.getParameter("OfferId") == null?"":request.getParameter("OfferId");	
	String[] v_code = (String[])request.getParameterValues("v_code") == null?new String[]{}:(String[])request.getParameterValues("v_code");	
	String[] v_text = (String[])request.getParameterValues("v_text") == null?new String[]{}:(String[])request.getParameterValues("v_text");	
	System.out.println("# offerId= "+OfferId);
%>
<table>
  <TR>
    <TD class='blue' id='template_0' >
      <span class='orange' >*小区代码</span>
    </TD>
    <TD name="0">
      <select v_readonly="N" id="newAttrIds" name="s_60001" v_type="5" v_preci="2" v_flag="N" v_name="小区代码"  v_selVal="100" v_optionFlag="Y" style="width:300px"/>
    </TD>
  </TR>
</table>
<script>
	$().ready(function(){
		//$("#OfferAttribute :input").not(":button").each(chkDyAttribute);
		<%
		if(v_code.length>0){
	  %>
	    var tempStr = "";
	  <%
	    for(int i = 0;i<v_code.length;i++){
	  %>
				tempStr += "<option value='<%=v_code[i]%>' ><%=v_text[i]%></option>";
		<%
			}
		%>
			$("#newAttrIds").append(tempStr);
	  <%
		}
		%>
	});
</script>


