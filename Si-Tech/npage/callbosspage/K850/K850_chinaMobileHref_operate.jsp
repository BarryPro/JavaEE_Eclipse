<%
  /*
   * 功能: 常用网址维护页面
　 * 版本: 1.0
　 * 日期: 2013/03/06
　 * 作者: liuhaoa
　 * 版权: sitech
 　*/
 %>
 
<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%!
	public String getCurrDateStr(String format){
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(format);
		return objSimpleDateFormat.format(new java.util.Date());
	}
%>
<%  
	String op_login_no = (String)session.getAttribute("workNo");   //操作工号
	String retCode = "000000";
	String id_no = request.getParameter("id_no") == null ? "0" : request.getParameter("id_no");
	String adress_url = request.getParameter("adress_url") == null ? "" : request.getParameter("adress_url");
	Map pMap = new HashMap();
	pMap.put("id_no",id_no);
	pMap.put("adress_url",adress_url);
	pMap.put("op_login_no",op_login_no);
	try{
		KFEjbClient.update("query_K850_update",pMap);
	}catch(Exception e){
		retCode = "999999";
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);