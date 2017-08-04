<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.ibatis.sqlmap.client.SqlMapClient" %>
<%@ page import="com.sitech.crmpd.ibatis.SqlConfigClient" %>
<%@ page import="com.sitech.crm.callcenter.common.dao.CommonDao" %> 
<%@ page import="com.sitech.crm.callcenter.common.model.CommonData" %> 
<%
//获取参数
  String strContactId=request.getParameter("strContactId");
  String strContactMonth= request.getParameter("strContactMonth");
  String sqlStr="select 1 A1 from dual " ;     
  System.out.println("########################"+sqlStr);
   try{	 
		 SqlMapClient sqlMap = SqlConfigClient.getSqlMapInstatce();
		 CommonData data=(CommonData)CommonDao.getObject(sqlStr, sqlMap);
		 System.out.println(data.getA1());
	  }catch(Exception e){
		  e.printStackTrace();
	  }
       
%>