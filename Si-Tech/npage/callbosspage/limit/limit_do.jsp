<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String retType = WtcUtil.repNull(request.getParameter("retType"));
		String loginNo = (String)session.getAttribute("workNo");  //取login_no
	  String loginName = (String)session.getAttribute("workName"); //取login_name
	  String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
		
		String addMode = WtcUtil.repNull(request.getParameter("addMode")); //transType
		String kf_login_no = WtcUtil.repNull(request.getParameter("kf_login_no")); //op_code
		String boss_no = WtcUtil.repNull(request.getParameter("boss_no")); //op_code
		String sql= "insert into DCALLLOGINMENU (MENU_ID,KF_LOGIN_NO,AUTH_ID,BOSS_LOGIN_NO,OP_CODE,CREATE_TIME,CREATE_LOGIN_NO)"+
		"select lpad(seq_sys.nextval,14,'0'),:v1,'K014',:v2,'K088',sysdate,:v3 from dual";
System.out.println("sqlADD"+sql);
%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=kf_login_no%>"/>
			<wtc:param value="<%=boss_no%>"/>
			<wtc:param value="<%=loginNo%>"/>
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




