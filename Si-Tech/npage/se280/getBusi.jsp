<%
  /* *********************
   * 功能:家庭产品变更
   * 版本: 1.0
   * 日期: 2011/09/21
   * 作者: ningtn
   * 版权: si-tech
   * *********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String famRole = request.getParameter("famRole");
	
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("getBusi.jsp-----[" + famCode + "|" + prodCode + "|" + famRole + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String strArray = "var arrMsg; ";
  //记录是否成功标志   1 = 成功    0 = 失败
	int successFlag = 0;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="0"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famRole%>"/>
				<wtc:param value="<%=memRoleId%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
		System.out.println("====sFamSelCheck====" + retCode1 + "|" + retMsg1);
		if(!(retCode1.equals("0") || retCode1.equals("000000"))){
			successFlag = 0;
		}else{
			strArray = WtcUtil.createArray("arrMsg",result.length);
			successFlag = 1;
		}
	%>
	<%=strArray%>
	<%
	//如果调用查询成功，初始化返回的数组strArray
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

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("famRole","<%= famRole %>");
	response.data.add("memRoleId","<%= memRoleId %>");
	response.data.add("prodCode","<%= prodCode %>");
	response.data.add("result",arrMsg);
	core.ajax.receivePacket(response);