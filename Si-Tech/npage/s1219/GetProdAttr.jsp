<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
	System.out.println("<<------------查询产品属性------------>>");
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	
	String quetype =WtcUtil.repNull(request.getParameter("quetype"));	//0：销售品；1：产品
	String quevalue =WtcUtil.repNull(request.getParameter("quevalue"));	
%>

<wtc:utype name="sGetAttrPage" id="retVal" scope="end">
	<wtc:uparam value="<%=quetype %>" type="STRING"/>   
	<wtc:uparam value="<%=quevalue %>" type="LONG"/>   
</wtc:utype>

<%

System.out.println("--------------------------quetype-----------------------"+quetype);
System.out.println("--------------------------quevalue----------------------"+quevalue);



  String retCode = retVal.getValue(0);
  String retMsg = retVal.getValue(1);
  
  System.out.println("--------------------------retCode----------------------"+retCode);
  System.out.println("--------------------------retMsg-----------------------"+retMsg);
  
  sb.append(verson_title).append(root_element);
   int detLen = 0;
	if((retCode.equals("0"))){
		detLen = retVal.getUtype("2").getSize();
		for(int i=0;i<+retVal.getUtype("2").getSize();i++){
			String ss=retVal.getUtype("2."+i).getValue(8).trim();
			String ss2=retVal.getUtype("2."+i).getValue(13).trim();
			if(ss2!=null&&!ss2.equals("")){
			if(ss!=null&&ss.indexOf(ss2+"~")>=0){
				if(ss.substring(ss.indexOf(ss2+"~")).indexOf(",")<0){
					ss2=ss.substring(ss.indexOf(ss2+"~"));
				}else{
					ss2=ss.substring(ss.indexOf(ss2+"~"),ss.indexOf(ss2+"~")+ss.substring(ss.indexOf(ss2+"~")).indexOf(","));
				}
				if(ss.indexOf(ss2)+ss2.length()+1<=ss.length()){
					ss=ss.substring(0,ss.indexOf(ss2))+ss.substring(ss.indexOf(ss2)+ss2.length()+1);
				}else{
					ss=ss.substring(0,ss.indexOf(ss2))+ss.substring(ss.indexOf(ss2)+ss2.length());
				}
				}				
			}
			
			System.out.println(i+"-----------------------0-------------------------------"+retVal.getUtype("2."+i).getValue(0));
			System.out.println(i+"-----------------------1-------------------------------"+retVal.getUtype("2."+i).getValue(1));
			System.out.println(i+"-----------------------2-------------------------------"+retVal.getUtype("2."+i).getValue(2));
			System.out.println(i+"-----------------------3-------------------------------"+retVal.getUtype("2."+i).getValue(3));
			System.out.println(i+"-----------------------4-------------------------------"+retVal.getUtype("2."+i).getValue(4));
			System.out.println(i+"-----------------------5-------------------------------"+retVal.getUtype("2."+i).getValue(5));
			System.out.println(i+"-----------------------6-------------------------------"+retVal.getUtype("2."+i).getValue(6));
			System.out.println(i+"-----------------------7-------------------------------"+retVal.getUtype("2."+i).getValue(7));
			System.out.println(i+"-----------------------10------------------------------"+retVal.getUtype("2."+i).getValue(10));
			System.out.println(i+"-----------------------11------------------------------"+retVal.getUtype("2."+i).getValue(11));
			System.out.println(i+"-----------------------12------------------------------"+retVal.getUtype("2."+i).getValue(12));
			System.out.println(i+"----------------------13-------------------------------"+ss);
			System.out.println(i+"---------------------14--------------------------------"+ss2);
			System.out.println("---------------------quevalue----------------------------"+quevalue);
			
			
			
			
			sb.append("<field "+"order='"+i+"'"+"  dataType='"+retVal.getUtype("2."+i).getValue(2)+"'>");
			sb.append("<info_code>"+retVal.getUtype("2."+i).getValue(0)+"</info_code>");
			sb.append("<info_name>"+retVal.getUtype("2."+i).getValue(1).trim()+"</info_name>");
			sb.append("<read_only>"+retVal.getUtype("2."+i).getValue(3)+"</read_only>");
			sb.append("<data_length>"+retVal.getUtype("2."+i).getValue(4)+"</data_length>");
			sb.append("<data_preci>"+retVal.getUtype("2."+i).getValue(5)+"</data_preci>");
			sb.append("<data_remark>"+retVal.getUtype("2."+i).getValue(6).trim()+"</data_remark>");
			sb.append("<use_line>"+retVal.getUtype("2."+i).getValue(7)+"</use_line>");
			sb.append("<info_obj>"+ss+"</info_obj>");
			sb.append("<option_flag>"+retVal.getUtype("2."+i).getValue(10).trim()+"</option_flag>");
			sb.append("<doc_flag>"+retVal.getUtype("2."+i).getValue(11).trim()+"</doc_flag>");
			sb.append("<show_length>"+retVal.getUtype("2."+i).getValue(12).trim()+"</show_length>");
			sb.append("<ins_id>"+quevalue+"</ins_id>");
			sb.append("<default_value>"+ss2+"</default_value>");	
			sb.append("<id_flag>"+i+"</id_flag>");
			sb.append("</field>");
		}
	}
	
	sb.append(root_element1);		
	System.out.println("sb.toString() =="+sb.toString());
	if(detLen>0){

%>
<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate_new.xsl"/>

<%	}	%>		
<script>
	$().ready(function(){
		$("#OfferAttribute :input").not(":button").each(chkDyAttribute);
		<%
		if((retCode.equals("0"))){
			for(int i=0;i<+retVal.getUtype("2").getSize();i++){
			%>
				var arrClassValue = new Array();
				arrClassValue.push("<%=quevalue%>");
				getMidPrompt("10702",arrClassValue,"template_<%=i%>");
			<%
			}
		}
		%>
	});
</script>


