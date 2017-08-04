<%
/********************
 version v2.0
开发商: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNoIn   = request.getParameter("workNoIn");
		String regionCode = (String)session.getAttribute("regCode");
		
		String getSqlStr  = "select to_char(substr(org_code,0,2)) from dloginmsg  where login_no=:workNo ";
		String paraIn     = "workNo="+workNoIn;
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=getSqlStr%>" />
		<wtc:param value="<%=paraIn%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"  />
<%
	String regCodeGet = "";
	String retmsg = "";
	if(result_t.length>0){
		regCodeGet = result_t[0][0];
	}
	System.out.println("------------------regCode-------ng35-----------"+regCodeGet);
	System.out.println("------------------regionCode-------ng35--------"+regionCode);
	
	if(regCodeGet.equals(regionCode)){
		retmsg = "";
	}else{
		retmsg = "只能查本地市工号";
	}
%>		
var response = new AJAXPacket();
response.data.add("msg","<%=retmsg%>");
core.ajax.receivePacket(response);
