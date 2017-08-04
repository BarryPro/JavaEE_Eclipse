<%
  /* *********************
   * 功能:家庭产品变更
   * 版本: 1.0
   * 日期: 2011/09/21
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	String familyCode = request.getParameter("familyCode");
	String familyProdInfo = request.getParameter("familyProdInfo");
	String phoneNoVal = request.getParameter("phoneNoVal");
	
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
%>
		<wtc:service name="sFamProdSel" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=familyProdInfo%>"/>
				<wtc:param value="<%=familyCode%>"/>
				<wtc:param value="<%=phoneNoVal%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>

	var response = new AJAXPacket();
	response.data.add("retCode","<%= retCode1 %>");
	response.data.add("retMsg","<%= retMsg1 %>");
	core.ajax.receivePacket(response);