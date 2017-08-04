<%
/********************
 * version v2.0
 * 开发商: si-tech
 * create by wanglm @ 2010-8-9
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode=(String)session.getAttribute("regCode");
	String acc = "";
	String qd = request.getParameter("qd");
	String opCode = request.getParameter("opCode"); 
	String workNo = request.getParameter("workNo"); 
	String password = request.getParameter("password"); 
	String phone = request.getParameter("phone"); 
	String phonePass = request.getParameter("phonePass"); 
	String workName = request.getParameter("workName");
	String code = "";
	String note = workName+"用户解锁";		
	System.out.println(".......///////////////////////////////////////////////////////////////////////////////////////////////////////////////////");
%>    
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
	<%
	   acc = seq;
	%>
    <wtc:service name="sb284Cfm" outnum="2"  retcode="Code" retmsg="Msg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=acc%>"/>
        <wtc:param value="<%=qd%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=phone%>"/>
        <wtc:param value="<%=phonePass%>"/>	
        <wtc:param value="<%=note%>"/>
	</wtc:service>
	<%
	   code = Msg;
	   System.out.println(".......///////////////////////////////////////////////////////////////////////////////////////////////////////////////////"+code);
	%>	
		
  var response = new AJAXPacket();
  response.data.add("code","<%=code%>");
  core.ajax.receivePacket(response);
