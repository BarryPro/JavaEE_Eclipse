<%
   /*
   * ����: 
�� * �汾: v2.0
�� * ����: 2008/10/09
�� * ����: 
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>	
<%
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String opCode = "6052";
	
	String retType = request.getParameter("retType");
	String role_code = request.getParameter("role_code");
	String login_no = request.getParameter("login_no");

	String returnCode = "";
	String returnMessage = "";
%>
	<wtc:service name="sWsRoleMembCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2" >
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=role_code%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=opCode%>"/>
	</wtc:service>

	var response = new AJAXPacket();
	var retType  = "<%=retType%>";
	var returnCode = "<%=retCode2%>";
	var returnMessage = "<%=retMsg2%>";
	
	response.data.add("returnCode",returnCode);
	response.data.add("returnMessage",returnMessage);
	response.data.add("retType",retType);
	core.ajax.receivePacket(response);
<%
			System.out.println("##########role_code->"+role_code+"&login_no->"+login_no+"&retCode2->"+retCode2+"&retMsg2->"+retMsg2);
%>

 