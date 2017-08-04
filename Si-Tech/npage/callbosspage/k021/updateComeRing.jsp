<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%      
        System.out.println("opcode=k029_/npage/callbosspage/k021/updateComeRing.jsp");
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String caller = WtcUtil.repNull(request.getParameter("caller"));
	String called = WtcUtil.repNull(request.getParameter("called"));
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String workNo = WtcUtil.repNull(request.getParameter("workNo"));
	String ipAddress = WtcUtil.repNull(request.getParameter("ipAddress"));
	String orgCode = WtcUtil.repNull(request.getParameter("orgCode"));
	String regionCode = orgCode.substring(0,2);
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String accept_kf_no = WtcUtil.repNull(request.getParameter("accept_kf_no"));
	String agentSkill = WtcUtil.repNull(request.getParameter("agentSkill"));
  String nowYYYYMM =contactId.substring(0, 6);
  String table_name="dcallcall"+nowYYYYMM;
  String sql="update "+table_name+" set accept_login_no =:v1, op_code=:v2,accept_kf_login_no=:v3 where contact_id =:v4"; 


%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=login_no%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=contactId%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "更新来电信息表失败";
	  }
	%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
