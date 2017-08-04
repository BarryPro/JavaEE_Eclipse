<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>

<%	//System.out.println("ppppppppppp");
	String opr_source = "01";
	String work_no = request.getParameter("work_no").trim();  	
	String id_type = "01";
	String id_value = request.getParameter("phone_no").trim();
	String opr_numb = "";
	System.out.println("9999999999999999999999");
	String opr_code = request.getParameter("opr_code").trim();      
	System.out.println("opr_codeopr_code="+opr_code);
	String biz_type = "31";
	String login_accept=request.getParameter("login_accept").trim();

	
	
	System.out.println("login_acceptlogin_acceptlogin_acceptlogin_accept="+login_accept);
%>

<wtc:service name="s1847Cfm" outnum="2" routerKey="phone" routerValue="<%=id_value%>">
	<wtc:param value="<%=opr_source%>"/>
	<wtc:param value="<%=work_no%>"/>
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
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1847&retCodeForCntt="+code+"&opName=多媒体彩铃&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+id_value+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
		
%>
<jsp:include page="<%=url%>" flush="true" />
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid")%>';
response.data.add("code","<%=code%>");
response.data.add("msg","<%=msg%>");
core.ajax.receivePacket(response);


//core.rpc.receivePacket(response);
