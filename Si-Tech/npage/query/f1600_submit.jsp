<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
		String opName = request.getParameter("opName");
		String phone_no = request.getParameter("phone_no");
		String broadPhone = request.getParameter("broadPhone");
		String newPass = request.getParameter("t_new_pass");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0, 2);
		String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    String loginAccept = request.getParameter("loginAccept");
    
    String vOpNote="操作员"+workNo+"宽带号" + broadPhone + "进行"+opName+"操作";
    String vSystemNote=vOpNote;
    System.out.println("lipf    newPass==========   "+ newPass);	
    System.out.println("lipf    phone_no==========   "+ phone_no);
       
%>

<wtc:service name="sTripleDES" routerKey="region" routerValue="<%=regionCode%>" outnum="20" retcode="retCode1" retmsg="retMsg1">
    <wtc:param value="encrypt"/>
    <wtc:param value="<%=newPass%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
	
	<%
		newPass=result1[0][0];
		System.out.println("lipf    newPass==========   "+ newPass);
	%>
	<wtc:service name="s4991Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retcode" retmsg="retmsg" outnum="40">
	    <wtc:param value="4991"/>
	    <wtc:param value="<%=phone_no%>"/>
	    <wtc:param value=""/>
	    <wtc:param value="<%=newPass%>"/>
	    <wtc:param value="<%=workNo%>"/>
	    <wtc:param value="<%=password%>"/>
	    <wtc:param value="<%=ip_Addr%>"/>
	    <wtc:param value="<%=vOpNote%>"/>
	    <wtc:param value="<%=vSystemNote%>"/>
	    <wtc:param value="DD"/>	
	    <wtc:param value="<%=loginAccept%>"/>	
	</wtc:service>
	<wtc:array id="result" scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retcode%>");
response.data.add("retMsg","<%=retmsg%>");
core.ajax.receivePacket(response);