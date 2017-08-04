<%
  /*
   * 功能: 家庭客户开户
   * 版本: 1.0
   * 日期: 2016-2-25 10:21:11
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
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.phoneNo="+phoneNo);
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.custPassWord="+custPassWord);
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.workNo="+workNo);
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.passWord="+passWord);
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.groupId="+groupId);
	System.out.println("+++++++++++++++++fg638_checkPwd.jsp.regionCode="+regionCode);
%>

<wtc:service name="sG638Check" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	  <wtc:param value="<%=phoneNo%>"/>
	   <wtc:param value="<%=custPassWord%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>

<input type="hidden" id="checkRetCode" name="checkRetCode" value="<%=retCode%>" />
<input type="hidden" id="checkRetMsg" name="checkRetMsg" value="<%=retMsg%>" />