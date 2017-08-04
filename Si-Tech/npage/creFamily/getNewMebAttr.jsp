<%
   /*
   * 功能: 根据成员类型取得成员属性
　 * 版本: v2.0
　 * 日期: 2009/02/20
　 * 作者: chengwen
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	
	String mebRoleId = WtcUtil.repNull(request.getParameter("mebRoleId"));	
%>

<wtc:utype name="sQMebAttrShow" id="retVal" scope="end">  
	<wtc:uparam value="<%=mebRoleId%>" type="LONG"/>   
</wtc:utype>

<%
  String retCode = retVal.getValue(0);
  String retMsg = retVal.getValue(1);
  sb.append(verson_title).append(root_element);
  
	if(retCode.equals("0")){
		String location="";
		for(int i=0;i<retVal.getUtype("2").getSize();i++){
			location="2."+i;
			int sonNum = retVal.getUtype(location).getSize();
			if(sonNum>0){
			sb.append("<field "+"order='"+i+"'"+"  dataType='"+retVal.getUtype(location).getValue(2)+"'>");
			sb.append("<info_code>"+retVal.getUtype(location).getValue(0)+"</info_code>");
			sb.append("<info_name>"+retVal.getUtype(location).getValue(1).trim()+"</info_name>");
			sb.append("<read_only>"+retVal.getUtype(location).getValue(3)+"</read_only>");
			sb.append("<data_length>"+retVal.getUtype(location).getValue(4)+"</data_length>");
			sb.append("<data_preci>"+retVal.getUtype(location).getValue(5)+"</data_preci>");
			sb.append("<data_remark>"+retVal.getUtype(location).getValue(6).trim()+"</data_remark>");
			sb.append("<use_line>"+retVal.getUtype(location).getValue(7)+"</use_line>");
			sb.append("<info_obj>"+retVal.getUtype(location).getValue(8).trim()+"</info_obj>");
			sb.append("<option_flag>"+retVal.getUtype(location).getValue(9).trim()+"</option_flag>");
			sb.append("<doc_flag>"+retVal.getUtype(location).getValue(10).trim()+"</doc_flag>");
			sb.append("<info_control>"+retVal.getUtype(location).getValue(11).trim()+"</info_control>");
			sb.append("<show_length>"+retVal.getUtype(location).getValue(12).trim()+"</show_length>");
			sb.append("<attr_value>"+retVal.getUtype(location).getValue(13).trim()+"</attr_value>");
			sb.append("<default_value>"+retVal.getUtype(location).getValue(14).trim()+"</default_value>");
			sb.append("</field>");
			}
		}
	}
	
	sb.append(root_element1);
%>
	<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate.xsl"/>



