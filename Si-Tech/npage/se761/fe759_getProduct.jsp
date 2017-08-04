<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("============ ningtn fe759_getProduct.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	/* 查询类型 0代表查询产品分类 1代表查询分类条件  2失效时间*/
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	/* 产品分类 */
	String productType = WtcUtil.repNull(request.getParameter("productType"));
	/* 产品代码 prodCode */
	String productCode = WtcUtil.repNull(request.getParameter("productCode"));
	/* 产品生效时间 effDate */
	String effDate = WtcUtil.repNull(request.getParameter("effDate"));
	
	String wtcOutNum = "";
	if("0".equals(queryType)){
		wtcOutNum = "3";
	}else if("1".equals(queryType)){
		wtcOutNum = "4";
	}else if("2".equals(queryType)){
		wtcOutNum = "1";
	}
	
	/* 记录是否成功标志   1 = 成功    0 = 失败 */
	int successFlag = 0;
	String strArray = "var arrMsg; ";
%>
		<wtc:service name="sProdTypeConQry" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode" retmsg="retMsg" outnum="<%=wtcOutNum%>">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=queryType%>"/>
				<wtc:param value="<%=productType%>"/>
				<wtc:param value="<%=productCode%>"/>
				<wtc:param value="<%=effDate%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%

	System.out.println("============ ningtn fe759_getProduct.jsp sProdTypeConQry ====" + retCode);
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