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
		String sql= "delete from  DCALLLOGINMENU "+
		"where kf_login_no=:v1 and auth_id='K014' and boss_login_no=:v2";
		System.out.println("sqlDDDDDDDDDDDDDDDDDDDDDD"+sql);
%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=kf_login_no%>"/>
			<wtc:param value="<%=boss_no%>"/>
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





