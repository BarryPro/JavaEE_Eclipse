<%
  /*
   * 功能: 网站开户
   * 版本: 2.0
   * 日期: 2010/11/26
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%

	String opCode 	= "b893";
	String loginNo 	= (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	String groupId 	= (String)session.getAttribute("groupId");
	String phoneNo 	= request.getParameter("phoneNo");
	//号码处理状态 0-网上开户,1-营业员预占,2-客户开户成功,3-普通开户成功
	String phoneStatus= "1";//request.getParameter("phoneStatus");
	String retCode = "";
	String retMsg = "";
%>
<wtc:service name="sb893Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="2" >
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=phoneStatus%>"/>
</wtc:service>
<wtc:array id="result11" scope="end"/>
<%
	System.out.println("=============preparedDo.jsp==============="+retCode1+"-----------"+result11.length);
	if("000000".equals(retCode1)){
		System.out.println("=============sb893Cfm执行成功！===============");
		retCode = "000000";
		retMsg  = retMsg1;
	}else{
		System.out.println("sb893Cfm执行失败 ["+retCode1+"],"+retMsg1+"");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
