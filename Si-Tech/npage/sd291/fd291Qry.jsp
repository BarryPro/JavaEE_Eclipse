<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("========fd291Qry======开始");
		String opCode = "d291";
 		String opName = "提醒短信查询";
 		
 		String workNo = (String)session.getAttribute("workNo");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String strArray = "var arrMsg; ";
		/*记录是否成功标志   1 = 成功    0 = 失败*/
		int successFlag = 0;
		
		String msgCode = WtcUtil.repNull(request.getParameter("msgCode"));
		String msgName = WtcUtil.repNull(request.getParameter("msgName"));	
		String startTime = WtcUtil.repNull(request.getParameter("startTime"));
		String endTime = WtcUtil.repNull(request.getParameter("endTime"));
		String qryGroupId = WtcUtil.repNull(request.getParameter("qryGroupId"));
		String denormLevel = WtcUtil.repNull(request.getParameter("denormLevel"));
		String iLevel = "";
		if("0".equals(denormLevel) || "1".equals(denormLevel)){
			iLevel = "1";
		}else if("2".equals(denormLevel)){
			iLevel = "0";
		}
		System.out.println("iLevel : " + iLevel);
%>
		<wtc:service name="sd291Qry" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode1" retmsg="retMsg1" outnum="11">
			<wtc:param value="<%=msgCode%>"/>
			<wtc:param value="<%=msgName%>"/>
			<wtc:param value="<%=startTime%>"/>
			<wtc:param value="<%=endTime%>"/>
			<wtc:param value="<%=qryGroupId%>"/>
			<wtc:param value="<%=iLevel%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
<%
		if("000000".equals(retCode1)){
			if(result != null && result.length > 0){
				System.out.println("========fd291Qry: " + result.length);
				strArray = WtcUtil.createArray("arrMsg",result.length);
				successFlag = 1;
			}
		}else{
			successFlag = 0;
		}
		System.out.println(" --- " + strArray);
%>
<%=strArray%>
<%
	//如果调用查询成功，初始化返回的数组strArray
	if(successFlag == 1){
		for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){
      System.out.println("[" + i + "|" + j + "]: " + result[i][j]);
%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
<%
      }
    }
  }
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("result",arrMsg);
	core.ajax.receivePacket(response);
<%
System.out.println("========fd291Qry end== " + retCode1);
%>