<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr  = request.getRemoteAddr();

		
	String op_strong_pwd  = (String)session.getAttribute("password");//登陆密码
	
    String spCode = request.getParameter("spCode");
    String bizCode = request.getParameter("bizCode");
    String phoneNo = request.getParameter("phoneNo");
    //liujian 2012-8-30 14:45:32  添加操作时间 begin
    String countNum = request.getParameter("countNum");
    String oprDate = request.getParameter("oprDate");
	if(oprDate == null) {
  		oprDate = "";
	}
	//liujian 2012-8-30 14:45:32  添加操作时间 end
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%

	String[] params = new String[13];
	params[0] = loginAccept;
	params[1] = "01";
	params[2] = "2893";
	params[3] = workNo;
	params[4] = op_strong_pwd;
	params[5] = phoneNo;
	params[6] = "";
	params[7] = spCode;
	params[8] = bizCode;
	params[9] = oprDate;
	params[10] = "0";
	params[11] = countNum;
	params[12] = "1";//查询0；打印1
%>

<wtc:service name="s2893Qry" routerKey="phone" routerValue="<%=phoneNo%>"
	retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:param value="<%=params[0]%>"/>
	<wtc:param value="<%=params[1]%>"/>
	<wtc:param value="<%=params[2]%>"/>
	<wtc:param value="<%=params[3]%>"/>
	<wtc:param value="<%=params[4]%>"/>
	<wtc:param value="<%=params[5]%>"/>
	<wtc:param value="<%=params[6]%>"/>
	<wtc:param value="<%=params[7]%>"/>
	<wtc:param value="<%=params[8]%>"/>
	<wtc:param value="<%=params[9]%>"/>
	<wtc:param value="<%=params[10]%>"/>
	<wtc:param value="<%=params[11]%>"/>
	<wtc:param value="<%=params[12]%>"/>
</wtc:service>
<wtc:array id="qryRst"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retcode","<%= retCode %>");
response.data.add("retmsg","<%= retMsg %>");
core.ajax.receivePacket(response);