<%
  /*
   * 功能: 安保部身份证查询录入 g689
   * 版本: 1.0
   * 日期: 2012/5/20
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), ""); 
	String idIccid_input = WtcUtil.repStr(request.getParameter("idIccid_input"), ""); //身份证号码
  String regCode = (String)session.getAttribute("regCode");
  String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
  String password=WtcUtil.repNull((String)session.getAttribute("password"));	
  String notes = workNo+"办理了"+opName;
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
  String [] inputParam = new String [9] ;
	inputParam[0] = printAccept; //流水
	inputParam[1] = "01";        //渠道
	inputParam[2] = opCode;      //操作代码
	inputParam[3] = workNo;     //工号
	inputParam[4] = password;//工号密码
	inputParam[5] = "";           //号码
	inputParam[6] = "";           //号码密码
	inputParam[7] = notes;   //备注
	inputParam[8] = idIccid_input; //身份证号
%>
	<wtc:service name="sG689Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    