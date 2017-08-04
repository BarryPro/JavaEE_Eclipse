<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String localIp = WtcUtil.repNull(request.getParameter("localIp"));		
		String workNo = WtcUtil.repNull(request.getParameter("work1No"));
		String loginNo = (String)session.getAttribute("workNo");  //取login_no		
		String workName = (String)session.getAttribute("workName");  //取login_no	
		String skillListStr = WtcUtil.repNull(request.getParameter("skillListStr")); //获取技能队列id	
		String ccno = (String)session.getAttribute("ccno");  //取ccno	
		String sql= "insert into DLOGINLOG (SERIAL_NO,LOGIN_NO,KF_LOGIN_NO,SIGN_IN_IP,SIGN_IN_NAME,SIGN_IN_TIME,SIGN_IN_SKILLS,ccno)"+
		"select lpad(SEQ_LOGIN.nextval,14,'0'),:v1,:v2,:v3,:v4,sysdate,:v5,:v6 from dual";
		
		//System.out.println("------------>  ");
		System.out.println("------------>  签入时间sql= "+sql);
		System.out.println("------------>  签入时间sql= "+skillListStr+"$$"+ccno);
		//System.out.println("------------>  ");
		

%>
  <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=localIp%>"/>
			<wtc:param value="<%=workName%>"/>
		  <wtc:param value="<%=skillListStr%>"/>
		  <wtc:param value="<%=ccno%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败1";
	  }
	%>


	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);




