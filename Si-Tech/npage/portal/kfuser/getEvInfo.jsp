<%
   /*
   * 功能: 查询客户评价信息
　 * 版本: v1.0
　 * 日期: 2008年4月22日
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%

	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");

%>

 <script>
 //$("#wait2").hide();		   
 </script>
 
