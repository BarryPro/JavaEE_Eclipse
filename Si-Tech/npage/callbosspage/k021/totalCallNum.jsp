<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%
  	String WorkNo = WtcUtil.repNull(request.getParameter("workNo"));
    String tableNameEnd = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	Dcallcallyyyymm causeDcall=new Dcallcallyyyymm();
	causeDcall.setAccept_kf_login_no(WorkNo);
	causeDcall.setContactMonth(tableNameEnd);
	Integer inta=(Integer)KFEjbClient.queryForObject("getTotalCallData",causeDcall);
	String totalNum=String.valueOf(inta);
%>



<%
out.print(totalNum);
%>



	
	

