/*
  获取以下信息：
      购机款
      赠送系统充值底线金额
      赠送系统充值活动金额
      系统充值活动专款返还期限
      系统充值底线专款返还期限
*/
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");

	String saleCode = (String)request.getParameter("saleCode");//营销案代码
	String opCode = (String)request.getParameter("opCode");
	
	String monBaseFee = ""; //赠送系统充值底线金额 
	String freeFee	 = "";  //赠送系统充值活动金额
	String baseFee = "";    //购机款  
	String activeTerme = "";//赠送系统充值月份
%>
  <wtc:service name="sFamYXSel" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="4">
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=saleCode%>"/>
    <wtc:param value="<%=regionCode%>"/>
  </wtc:service>
  <wtc:array id="result" scope="end" />
<%
  if("000000".equals(retCode)){
    if(result.length>0){
      monBaseFee = result[0][0];
      freeFee = result[0][1];
      baseFee = result[0][2];
      activeTerme = result[0][3];
    }
  } 
%>		
	var response = new AJAXPacket();
	response.data.add("monBaseFee","<%=monBaseFee%>");
	response.data.add("freeFee","<%=freeFee%>");
	response.data.add("baseFee","<%=baseFee%>");
	response.data.add("activeTerme","<%=activeTerme%>");
	core.ajax.receivePacket(response);