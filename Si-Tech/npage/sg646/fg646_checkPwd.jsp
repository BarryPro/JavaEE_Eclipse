<%
  /*
   * 功能: 家庭客户查询
   * 版本: 1.0
   * 日期: 2016-5-15 10:21:11
 	*/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
	String phoneNo = request.getParameter("phoneNo");
	String custPassWord = request.getParameter("passWord");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.phoneNo="+phoneNo);
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.custPassWord="+custPassWord);
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.workNo="+workNo);
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.passWord="+passWord);
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.groupId="+groupId);
	System.out.println("+++++++++++++++++fg646_checkPwd.jsp.regionCode="+regionCode);
%>

<wtc:service  name="sPubCustCheck"  routerKey="phone"  routerValue="<%=phoneNo%>"  outnum="5" retcode="return_code" retmsg="return_msg">
	<wtc:param  value="01"/>
	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value="<%=custPassWord%>"/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value="<%=workNo%>"/>
</wtc:service>
<wtc:array  id="nameArr"  start="0"  length="1" scope="end" />
<wtc:array  id="statArr"  start="0"  length="1" scope="end" />
<wtc:array  id="brandArr"  start="2"  length="1" scope="end" />

<input type="hidden" id="checkRetCode" name="checkRetCode" value="<%=return_code%>" />
<input type="hidden" id="checkRetMsg" name="checkRetMsg" value="<%=return_msg%>" />
