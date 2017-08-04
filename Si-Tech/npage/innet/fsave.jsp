<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd" %>
<%
	    String phoneList = request.getParameter("phoneList");
	    String simList = request.getParameter("simList");
	    String chFeeList = request.getParameter("chFeeList");
		String retType="y";
        boolean saveFlag =Pub_lxd.saveDetail(phoneList,simList,chFeeList);    
		if(!saveFlag) retType="n";
%>
var response = new RPCPacket();
var retType = "<%=retType%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
core.rpc.receivePacket(response);