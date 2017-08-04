<%
/********************
version v3.0
¿ª·¢ÉÌ: si-tech
ningtn 2012-4-25 10:56:54
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String funcType = request.getParameter("funcType");
  String[] questionIdList =  (String[])request.getParameterValues("questionList");
  String[] PwdAnswerList 	=  (String[])request.getParameterValues("answerList");

	if(questionIdList == null){
		questionIdList = new String[0];
	}
	if(PwdAnswerList == null){
		PwdAnswerList = new String[0];
	}
%>
		<wtc:service name="se791Cfm" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=funcType%>"/>
				<wtc:params value="<%=questionIdList%>"/>
				<wtc:params value="<%=PwdAnswerList%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("retMsg","<%=retMsg1%>");
	core.ajax.receivePacket(response);