<%
/*************************************
* 功  能: g378·虚拟V网用户办理 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:52:45
**************************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%

	/*主页面传递的参数*/
	String chnSource	= "01";
	String opCode		= request.getParameter("opCode");
	String loginNo		= (String)session.getAttribute("workNo");
	String loginPwd		= (String)session.getAttribute("password");
	String groupPhoneNo	= (String)request.getParameter("groupPhoneNo");
	String userPhoneNo	= (String)request.getParameter("userPhoneNo");
	String regionCode	= (String)session.getAttribute("regCode");
	String groupNo	    = request.getParameter("groupNo"); 	/*集团号*/
	String groupName    = request.getParameter("groupName");/*集团名称*/
	String loginAccept    = request.getParameter("loginAccept");/*集团名称*/
	
	String offerId 		= request.getParameter("offerId");/*资费id*/
	String method 		= request.getParameter("method"); 	
	String usernames="";
	%>
	
<%
	if(method != null && method != "" && method.equals("checkUserNo")) {	
%>	
		<wtc:service name="sVVpmnPhoneChk"  outnum="1"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="checkCode" retmsg="checkMsg"  >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=chnSource%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=groupPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupNo%>"/>
			<wtc:param value="<%=userPhoneNo%>"/>
	
		</wtc:service>
		<wtc:array id="rstCheck" scope="end" />
<%
if(rstCheck.length>0) {
		usernames = rstCheck[0][0];
}
%>			
		var response = new AJAXPacket();
		response.data.add("checkCode","<%=checkCode%>");
		response.data.add("checkMsg","<%=checkMsg%>");
		response.data.add("usernames","<%=usernames%>");
		response.data.add("loginAccept","<%=loginAccept%>");
		core.ajax.receivePacket(response);	
<%
	}else if(method != null && method != "" && method.equals("addUser")) {	

%>
		<wtc:service name="sg378Cfm"  outnum="1"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="addRstCode" retmsg="addRstMsg"  >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=chnSource%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=groupPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupNo%>"/>
			<wtc:param value="<%=groupName%>"/>
			<wtc:param value="<%=userPhoneNo%>"/>
			<wtc:param value="<%=offerId%>"/>
	
		</wtc:service>
		<wtc:array id="g378Rst" scope="end" />
			
		var response = new AJAXPacket();
		response.data.add("addRstCode","<%=addRstCode%>");
		response.data.add("addRstMsg","<%=addRstMsg%>");
		core.ajax.receivePacket(response);	
<%
	}else if(method != null && method != "" && method.equals("g380cfm")) {	

%>
		<wtc:service name="sg380Cfm"  outnum="1"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="g380cfmCode" retmsg="g380cfmMsg"  >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=chnSource%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=userPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupNo%>"/>
	
		</wtc:service>
		<wtc:array id="g380Rst" scope="end" />
			
		var response = new AJAXPacket();
		response.data.add("g380cfmCode","<%=g380cfmCode%>");
		response.data.add("g380cfmMsg","<%=g380cfmMsg%>");
		response.data.add("loginAccept","<%=loginAccept%>");
		core.ajax.receivePacket(response);	
<%
	}else if(method != null && method != "" && method.equals("g379cfm")) {

%>
		<wtc:service name="sg379Cfm"  outnum="1"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="g379cfmCode" retmsg="g379cfmMsg"  >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value="<%=chnSource%>"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=userPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupNo%>"/>
			<wtc:param value="<%=offerId%>"/>
		</wtc:service>
		<wtc:array id="g379Rst" scope="end" />	
		var response = new AJAXPacket();
		response.data.add("g379cfmCode","<%=g379cfmCode%>");
		response.data.add("g379cfmMsg","<%=g379cfmMsg%>");
		response.data.add("loginAccept","<%=loginAccept%>");
		core.ajax.receivePacket(response);	
<%
	}
%>