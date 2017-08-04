<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%String regionCode = (String)session.getAttribute("regCode");%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept"/>
<%	System.out.println("184918491849184918491849");
	String opr_source="01";  //"01表示boss侧，01表示平台侧"
	String login_no = request.getParameter("work_no");  //工号
	String id_type="01";   //"01"表示通过手机
	String id_value = request.getParameter("phone_no");							   //电话号码
	String opr_numb = "";   //操作流水号，boss侧传空
	String opr_code = request.getParameter("Td_code");  //操作代码
	String biz_type = "33";//业务类型代码
	String login_accept=request.getParameter("login_accept");
	//String effeti_time = request.getParameter("effetiTime");  //生效时间
	//String newPwd = request.getParameter("newPwd");  //新密码
	//String spId = request.getParameter("spId");  //SP企业代码
	//String packNumb = request.getParameter("packNumb");  //套餐编码
	//String bizCode = request.getParameter("bizCode");  //SP业务代码：


%>
<wtc:service name="s1849Cfm" outnum="2" routerKey="phone" routerValue="<%=id_value%>">
	<wtc:param value="<%=opr_source%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=id_type%>"/>
	<wtc:param value="<%=id_value%>"/>
	<wtc:param value="<%=opr_numb%>"/>
	<wtc:param value="<%=opr_code%>"/>
	<wtc:param value="<%=biz_type%>"/>
	<wtc:param value="<%=login_accept%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />
	<%
		String code = result[0][0];
		String msg = result[0][1];		
		if(code.equals("000000") && opr_code.equals("02"))
	{
		code="000009";
	}
	%>
	<%
    System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = code ;
		String loginAccept = login_accept; 
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1849&retCodeForCntt="+code+"&opName=视频共享&workNo="+login_no+"&loginAccept="+login_accept+"&pageActivePhone="+id_value+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
%>
<jsp:include page="<%=url%>" flush="true" />
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");

core.ajax.receivePacket(response);
//core.rpc.receivePacket(response);
