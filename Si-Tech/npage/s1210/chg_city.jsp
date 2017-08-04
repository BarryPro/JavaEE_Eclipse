<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1210.viewBean.S1210Impl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%
    SPubCallSvrImpl co=new SPubCallSvrImpl();

String region_code = request.getParameter("region_code");
String city_code = request.getParameter("city_code");

//取得第三级下拉框数据(1)
StringBuffer triBUF=new StringBuffer("select trim(town_name)||'#'||trim(town_code) from sTownCode where region_code='");
triBUF.append(region_code);
triBUF.append("' and district_code='");
triBUF.append(city_code);
triBUF.append("' order by town_code;");

String triSql=triBUF.toString();
System.out.println(" tribuf = " + triSql);
String[][] tri_metaData=co.fillSelect(triSql);
String tri_metaDataStr = CreatePlanerArray.createArray("js_tri_metaDataStr",tri_metaData.length);
%>
<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
<%
	  }
  }
%>
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","chg_city");
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);