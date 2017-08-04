<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String phoneBrand = request.getParameter("phoneBrand");//手机品牌
	String phoneType = request.getParameter("phoneType");//手机型号
	String checkDeployFlay = "N"; //目标用户表是否已配置标识 Y 已配置 N 没配置

  String  inParams [] = new String[2];
  inParams[0] = " SELECT count(*) "
               +" FROM dTermTargCust "
               +" WHERE  (brand_code =:brand_code OR brand_code='all') "
               +" AND (res_code =:res_code or res_code='all') "
               +" AND sysdate BETWEEN begin_time AND end_time"
               +" and region_code=:region_code";
  inParams[1] = "brand_code="+phoneBrand+",res_code="+phoneType+",region_code="+regionCode;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
	  if(("000000").equals(retCode1)) {
	    if(ret.length>0){
	      if(Integer.parseInt(ret[0][0])>0){ //表中已配置数据
	        checkDeployFlay = "Y";
	      }
	    }
	 }	
%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("retMsg","<%=retMsg1%>");
	response.data.add("checkDeployFlay","<%=checkDeployFlay%>");
	core.ajax.receivePacket(response);
