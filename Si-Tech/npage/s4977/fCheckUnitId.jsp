<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	/******
	*2013/09/06 9:20:09 gaopeng 加入校验集团的服务,服务提供：zhangzhea;调用：gaopeng
	*/
	System.out.println("============ gaopeng fCheckUnitId.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  
	String unitId = WtcUtil.repNull(request.getParameter("unitId"));
	/* 记录是否成功标志   1 = 成功    0 = 失败 */
	int successFlag = 0;
	String strArray = "var arrMsg; ";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=regionCode%>" id="sLoginAccept"/>
	<wtc:service name="sCustTypeQryJ" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1" >
		      <wtc:param value="<%=sLoginAccept%>"/>
		      <wtc:param value="01"/>
		      <wtc:param value="4977"/>
		      <wtc:param value="<%=work_no%>"/>
		      <wtc:param value="<%=password%>"/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value="<%=unitId%>"/>
		      <wtc:param value="2"/>
  			</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
  System.out.println("============ gaopeng fCheckUnitId.jsp  ====" + unitId);
	System.out.println("============ gaopeng fCheckUnitId.jsp  ====" + retCode);
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
	core.ajax.receivePacket(response);