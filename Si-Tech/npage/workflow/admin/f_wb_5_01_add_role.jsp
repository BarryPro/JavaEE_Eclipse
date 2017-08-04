<%
   /*
   * 功能: 
　 * 版本: v2.0
　 * 日期: 2008/10/09
　 * 作者: 
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>			
<%
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String opCode = "6045";
	
	String retType = request.getParameter("retType");
	String role_code = request.getParameter("role_code");
	String role_desc = request.getParameter("role_desc");
	
	String returnCode = "";
	String returnMessage = "";
%>
	<wtc:service name="sWsRoleCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=role_code%>"/>
		<wtc:param value="<%=role_desc%>"/>
		<wtc:param value="<%=opCode%>"/>
	</wtc:service>

	var response = new AJAXPacket();
	var retType  = "<%=retType%>";
	var returnCode = "<%=retCode1%>";
	var returnMessage = "<%=retMsg1%>";
	
	response.data.add("returnCode",returnCode);
	response.data.add("returnMessage",returnMessage);
	response.data.add("retType",retType);
	core.ajax.receivePacket(response);
<%
			System.out.println("##########role_code->"+role_code+"&role_desc->"+role_desc+"&retCode1->"+retCode1+"&retMsg1->"+retMsg1);
%>

 