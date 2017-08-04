<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String phoneBrand = request.getParameter("phoneBrand");//手机品牌
	String phoneType = request.getParameter("phoneType");//手机型号
	String iPhoneNo = request.getParameter("iPhoneNo");//手机号码
	String checkGoalUserFlay = "N"; //表中是否存在目标用户标识 Y 存在 N 不存在
	String id_no = "";

  String  inParams [] = new String[2];
  inParams[0] = " SELECT to_char(id_no) "
               +"  FROM dcustmsg "
               +"  WHERE phone_no =:phone_no ";
  inParams[1] = "phone_no="+iPhoneNo;
  
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if(("000000").equals(retCode)) {
    if(ret.length>0){
      id_no = ret[0][0];
    }
  }	
%>
<%
  String  inParams1 [] = new String[2];
  inParams1[0] = " SELECT count(*) "
               +" FROM dTermTargCust "
               +" WHERE  (brand_code =:brand_code OR brand_code='all') "
               +" AND (res_code =:res_code or res_code='all') "
               +" AND sysdate BETWEEN begin_time AND end_time"
               +" and id_no=:id_no "
               +" and region_code=:region_code";
  inParams1[1] = "brand_code="+phoneBrand+",res_code="+phoneType+",id_no="+id_no+",region_code="+regionCode;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams1[0]%>"/>
    <wtc:param value="<%=inParams1[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret1"  scope="end"/>
<%
	  if(("000000").equals(retCode1)) {
	    if(ret1.length>0){
	      if(Integer.parseInt(ret1[0][0])>0){ //此目标用户已存在
	        checkGoalUserFlay = "Y";
	      }
	    }
	 }	
%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("retMsg","<%=retMsg1%>");
	response.data.add("checkGoalUserFlay","<%=checkGoalUserFlay%>");
	core.ajax.receivePacket(response);
