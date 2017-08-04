<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String bossId = WtcUtil.repNull(request.getParameter("bossId"));
	String sql="update dcallhangup t set t.op_type = '2'"+
 				" where t.contact_id = :v1"+
  				" and t.id = (select max(a.id) from dcallhangup a  where a.contact_id=:v2 and a.login_no = :v3)";

System.out.println("1111111111111111111111111111111111111111111111");

System.out.println("111111111111      sql        111111111111111 = "+sql);

%>


<%

%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=bossId%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if (rows[0][0].equals("000000")) {
		retCode = "000000";
		retMsg = "更新保持日志成功！";
	  }else if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "更新保持日志失败";
	  }
	%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
