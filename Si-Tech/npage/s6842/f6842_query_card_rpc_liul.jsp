<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.lang.*"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%!
Logger logger = Logger.getLogger("f2266_query_card_rpc_liul.jsp");
%>
<%
	String res_group_id = (String)session.getAttribute("groupId");
	
	String begin_no = request.getParameter("begin_no");
	String end_no = request.getParameter("end_no");

	String card_num = request.getParameter("card_nums");
	String card_type = request.getParameter("card_type");
	String rpc_page = request.getParameter("rpc_page");
	boolean query_result = false;
	String card_type_name = "";
	String card_value = "";
	String errorMsg = "";
	 String loginNo = (String)session.getAttribute("workNo");

	String regionCode = (String)session.getAttribute("regCode");
	String op_strong_pwd = (String) session.getAttribute("password");
		String beizhus=loginNo+"校验流量卡";
%>
  <wtc:service name="si127Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="29">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="6842"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=begin_no%>"/>
		<wtc:param value="<%=end_no%>"/>
		<wtc:param value="<%=beizhus%>"/>
		<wtc:param value="<%=card_num%>"/>	
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
<%
	if(retCode2.equals("000000")) {
			query_result=true;
			errorMsg="";
			card_type_name=tempArr[0][0]; 
			card_value=tempArr[0][1];
	}else {
		query_result=false;
				errorMsg=retMsg2;
		}
%>		
		
var response = new AJAXPacket();
response.data.add("rpc_page","<%=rpc_page%>");
response.data.add("result","<%=query_result%>");
response.data.add("error_msg","<%=errorMsg%>");
response.data.add("card_type","<%=card_type_name%>");
response.data.add("card_value","<%=card_value%>");

core.ajax.receivePacket(response);
