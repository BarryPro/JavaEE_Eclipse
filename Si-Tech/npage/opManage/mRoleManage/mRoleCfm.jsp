<%
/********************
 version v2.0
开发商: si-tech
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var resultArray = new Array();
<%
		String regionCode = (String)session.getAttribute("regCode");
		String optype     = WtcUtil.repNull(request.getParameter("optype"));
		String mRole      = WtcUtil.repNull(request.getParameter("mRole"));
		String sysRole    = WtcUtil.repNull(request.getParameter("sysRole"));
		String mRoleName  = WtcUtil.repNull(request.getParameter("mRoleName"));
		String sysRoleName  = WtcUtil.repNull(request.getParameter("sysRoleName"));
		
		String mbid       = WtcUtil.repNull(request.getParameter("mbid"));
		
		String retCode = "";
		String retMsg = "";
		try{
%>		
 		<wtc:service name="sMRoleCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
 			 <wtc:param value="<%=optype%>" />
 			 <wtc:param value="<%=mRole%>" />
 			 <wtc:param value="<%=sysRole%>" />
 			 <wtc:param value="<%=mRoleName%>" />			
 			 <wtc:param value="<%=mbid%>" />			
 			 <wtc:param value="<%=sysRoleName%>" />			
		</wtc:service>
<%
	retCode = code;
	retMsg = msg;
		}catch(Exception e){
		retCode = "000409";
		retMsg = "调用服务sMRoleCfm系统错误";
	}
	
%>

var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
