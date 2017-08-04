<%
    /*************************************
    * 功  能: 电子工单增加附件名称存储
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: wanghyd @ 2012-8-1
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
	String login_accept= WtcUtil.repStr(request.getParameter("login_accept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String password = (String)session.getAttribute("password");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String fujianname = WtcUtil.repStr(request.getParameter("fujianname"), "");
	String fujiannotes=loginNo+"对"+phoneNo+"进行了上传附件操作";
	System.out.println("shenfenzheng1"+fujianname);
%>
	<wtc:service name="sUploadAttchCfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="01"/>	
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/> 
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=fujianname%>"/>
		<wtc:param value="<%=fujiannotes%>"/>
				
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>


var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    