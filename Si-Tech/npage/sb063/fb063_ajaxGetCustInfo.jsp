<%
  /*
   * 功能: 老帅带新兵
   * 版本: 2.0
   * 日期: 2010/07/28
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String logacc = "0";
	String chnSrc = "01";
	String opCode = request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String passwd = (String)session.getAttribute("passwd");

	String inPhone = request.getParameter("inPhone");
	String userPwd = "";
	String ipAddr = (String)session.getAttribute("ipAddr");
	String opNote = "根据电话号码:"+inPhone+"查询用户姓名,密码等信息.";
	String cust_id = "";
	
	String cust_name = "";
	String idiccid = "";
	String owner_type = "";
	String regCode = (String)session.getAttribute("regCode");
	
	String custName = "";
	String custAddress = "";
	String custPasswd = "";
%>
<wtc:service name = "sUserCustInfo" outnum="50" routerKey="region" routerValue="<%=regCode%>"  
	retcode="ret_code" retmsg="retMessage"  >
	<wtc:param value="<%=logacc%>"/>
	<wtc:param value="<%=chnSrc%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passwd%>"/>
		
	<wtc:param value="<%=inPhone%>"/>
	<wtc:param value="<%=userPwd%>"/>
	<wtc:param value="<%=ipAddr%>"/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=cust_id%>"/>
		
	<wtc:param value="<%=cust_name%>"/>
	<wtc:param value="<%=idiccid%>"/>
	<wtc:param value="<%=owner_type%>"/>	
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
if(result1.length > 0)
{
	custName = result1[0][5];
	custAddress = result1[0][11];
	custPasswd = result1[0][40];
}
%>
var response = new AJAXPacket();
response.data.add("custName","<%=custName%>");
response.data.add("custAddress","<%=custAddress%>");
response.data.add("custPasswd","<%=custPasswd%>");
core.ajax.receivePacket(response);
