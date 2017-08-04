<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/autocomplete_ms.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>

<%
    String opName = "销售品属性设置";
System.out.println("--------------------------------showAttr.jsp--------------------------------------");
	String queryId = WtcUtil.repNull(request.getParameter("queryId"));	
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	String attrInfo = WtcUtil.repNull(request.getParameter("attrInfo"));
System.out.println("-----------------------attrInfo1------------------"+attrInfo);	
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); //当前时间
	
	String queryTypeId = "0";					//0:销售品;1:产品
	String queryIdTemp = "";
	if(queryType.equals("prod")){
		queryTypeId = "1";
		if(queryId.indexOf("A") != -1){
			queryIdTemp = queryId.split("A")[1];
		}else{
			queryIdTemp  = queryId;
		}		
	}else{
		queryIdTemp = queryId;
	}
%>
<wtc:utype name="sGetAttrPage" id="retVal" scope="end">
	<wtc:uparam value="<%=queryTypeId%>" type="STRING"/>   
	<wtc:uparam value="<%=queryIdTemp%>" type="LONG"/>   
</wtc:utype>

<%
    int detLen = retVal.getUtype("2").getSize();
		String returnCode = retVal.getValue(0);
	  sb.append(verson_title).append(root_element);
		if((returnCode.equals("0"))){
		for(int i=0;i<retVal.getUtype("2").getSize();i++){
 
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
		sb.append("</field>");
		}
	}
	
	sb.append(root_element1);
	
	//System.out.println("@sb==="+sb.toString());
	
%>	
<html xmlns="http://www.w3.org/1999/xhtml"> 
<SCRIPT type=text/javascript>
var memberInfoHash = new Object(); //群成员信息	
$().ready(function(){
	var attributeInfo = "";
	attributeInfo = "<%=attrInfo%>";
	$("#attrInfo :input").not(":button").each(chkDyAttribute);
	
	$("#operation :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
	
	if(attributeInfo !="undefined" && attributeInfo != ""){
		var strtemp = attributeInfo.split("|")[1];
		$.each(strtemp.split("$"),function(i,n){
			var temp = n.split("~");
			if(typeof(temp[1]) != "undefined"){
				if(temp[1].trim().indexOf(",") != -1){
					$("[name='s_"+temp[0]+"'] option").attr("selected",false);
					$.each(temp[1].trim().split(","),function(i,n){
						$("[name='s_"+temp[0]+"'] option[value='"+n+"']").attr("selected",true);
					});
				}else{
					$("[name='s_"+temp[0]+"']").val(temp[1].trim());	
				}	
			}	
		});	
	}
});	

function saveTo()
{		
		
		if(!checksubmit(attrFm)) return false ;
		var str = "";
		str += "<%=queryId%>"+"|";
		$("#attrInfo :input").not(":button").each(function(){
				str+=this.name.substring(2);
				str+="~";
				str+=$(this).val()+" $";
		});
		str += "^";		
		
		window.returnValue = str;
		window.close();
}

</SCRIPT>	
<body>
<FORM name="attrFm" action="" method=post>
<%@ include file="/npage/include/header_pop.jsp" %>	
<div class="title">
	<div id="title_zi">属性信息</div>
</div>

<div id="attrInfo">
		<%
		 if(detLen>0)
		{
		%>
		<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate.xsl"/>
		<%
		  }
		%>
</div>

<div id="footer">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
</div>

<%@ include file="/npage/include/footer_pop.jsp"%>
</FORM>
</BODY>
</HTML>