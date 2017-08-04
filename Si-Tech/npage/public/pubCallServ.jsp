<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	/******
	ningtn 2012-8-13 11:04:20
	*/
	System.out.println("============ ningtn pubSelectBySql.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
  
	String serviceName = WtcUtil.repNull(request.getParameter("serviceName"));
	String outnum = WtcUtil.repNull(request.getParameter("outnum"));
	String inputParamsLength = WtcUtil.repNull(request.getParameter("inputParamsLength"));
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	int paramsLength = Integer.parseInt(inputParamsLength);
	String[] inParams = new String[paramsLength];
	/* 记录是否成功标志   1 = 成功    0 = 失败 */
	int successFlag = 0;
	String strArray = "var arrMsg; ";
%>
	<wtc:service name="<%=serviceName%>" outnum="<%=outnum%>" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		 <%
		 for(int i = 0; i < paramsLength; i++){
		 inParams[i] = request.getParameter("inParams" + i);
		 %>
		 	<wtc:param value="<%=inParams[i]%>"/>
		 <%
		 }
		 %>
	</wtc:service>
	<wtc:array id="result" scope="end"/>

<%
	if(!(retCode.equals("0") || retCode.equals("000000"))){
		successFlag = 0;
	}else{
		successFlag = 1;
		strArray = WtcUtil.createArray("arrMsg",result.length);
	}
%>
<%=strArray%>
<%
	if(successFlag == 1){
	System.out.println("==== pubCallServ.jsp result.length =["+result.length+"]");
		for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){
      	if(result[i][j].trim().equals("") || result[i][j] == null){
				   result[i][j] = "";
				}
	%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
	<%
			}
		}
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	response.data.add("result",arrMsg);
	response.data.add("queryType","<%=queryType%>");
	core.ajax.receivePacket(response);