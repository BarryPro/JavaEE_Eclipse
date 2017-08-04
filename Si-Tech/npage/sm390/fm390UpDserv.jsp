<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
 
<%
    String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
  
	String workno = (String)session.getAttribute("workNo");
	String paySeq  = request.getParameter("paySeq");
	String id_no  = request.getParameter("id_no");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
 
  

	String s_ret_code="";
	String s_ret_msg=""; 
	 
%>
 


	<wtc:service name="sUpDserv" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="8" >
 
		<wtc:param value="<%=paySeq%>"/>
		<wtc:param value="<%=id_no%>"/>
		<wtc:param value="<%=dateStr%>"/>
		 
	</wtc:service>
	<wtc:array id="bill_opy" scope="end"/>
 
<%
	s_ret_code=retCode1;
	s_ret_msg=retMsg1;
 
	 

%>
 
var response = new AJAXPacket();
var s_ret_code = "<%=s_ret_code%>";
var s_ret_msg = "<%=s_ret_msg%>"; 
 
response.data.add("s_ret_code",s_ret_code);
response.data.add("s_ret_msg",s_ret_msg); 
 
core.ajax.receivePacket(response);

 

 
