<%
  /* *********************
   * 功能: 家庭业务公共校验
   * 版本: 1.0
   * 日期: 2011/10/03
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		/*这个是当前添加角色号码，不是家长号码*/
		String phoneNo = request.getParameter("parentPhone") == null ? "":request.getParameter("parentPhone");
		/*家长手机号码*/
		String parentPhoneNo = request.getParameter("parentPhoneNo") == null ? "":request.getParameter("parentPhoneNo");
		String opCode = request.getParameter("opCode") == null ? "":request.getParameter("opCode");
		String famCode = request.getParameter("famCode") == null ? "":request.getParameter("famCode");
		String memberRoleId = request.getParameter("memberRoleId") == null ? "":request.getParameter("memberRoleId");
		String checkType = request.getParameter("checkType") == null ? "":request.getParameter("checkType");
		String backAccept = request.getParameter("backAccept") == null ? "":request.getParameter("backAccept");
		String sgroupgs = request.getParameter("sgroupgs") == null ? "":request.getParameter("sgroupgs");
		System.out.println("===fe280PubCheck.jsp===" + phoneNo + "|" + opCode + "|" + famCode + "|" + memberRoleId + "|" + checkType + " |" + backAccept);
		//记录是否成功标志   1 = 成功    0 = 失败
		int successFlag = 0;
%>
		<wtc:service name="sFamBusiLimit" routerKey="region" 
			 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=memberRoleId%>"/>
				<wtc:param value="<%=checkType%>"/>
				<wtc:param value="<%=backAccept%>"/>
			  <wtc:param value="<%=sgroupgs%>"/>
			  <wtc:param value="<%=parentPhoneNo%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>


	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);