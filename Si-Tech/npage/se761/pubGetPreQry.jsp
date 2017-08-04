<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("============ ningtn pubGetPreQry.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	/* 查询类型 0代表查询转赠号码合法性     
							1查询该用户是否有转赠功能，并返回销户号码
	*/
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	/* 转赠号码 */
	String preNo = WtcUtil.repNull(request.getParameter("preNo"));
	/* 转赠号码类型  0身份证 1手机号码 */
	String preNoType = WtcUtil.repNull(request.getParameter("preNoType"));
	/* 服务名 */
	String serivceName = WtcUtil.repNull(request.getParameter("serivceName"));
	
	String wtcOutNum = "1";
	/* 记录是否成功标志   1 = 成功    0 = 失败 */
	int successFlag = 0;
	String strArray = "var arrMsg; ";
%>
		<wtc:service name="<%=serivceName%>" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode" retmsg="retMsg" outnum="<%=wtcOutNum%>">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=queryType%>"/>
				<wtc:param value="<%=preNo%>"/>
				<wtc:param value="<%=preNoType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	System.out.println("============ ningtn pubGetPreQry.jsp  ====" + serivceName + " : " + retCode);
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