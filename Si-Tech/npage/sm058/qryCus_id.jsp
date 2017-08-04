<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%
String phoneNo = Pub_lxd.repNull(request.getParameter("phoneNo"));
String sq="select cust_id from dCustMsg where phone_no='"+phoneNo+"' and substr(run_code,2,1) < 'a'";
SPubCallSvrImpl co = new SPubCallSvrImpl();
ArrayList cussidArr=co.sPubSelect("1",sq);
String cussidStr="";
if(((String[][])cussidArr.get(0)).length>0)
  cussidStr=((String[][])cussidArr.get(0))[0][0];
%>

var response = new AJAXPacket();
var cussid = "<%=cussidStr.trim()%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("cussid",cussid); 
core.ajax.receivePacket(response);