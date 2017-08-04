<%
    /*************************************
    * 功  能: 获取用户积分 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-6-25
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String loginAccept = WtcUtil.repStr(request.getParameter("loginAccept"), "");
	String iChnSource=WtcUtil.repNull((String)request.getParameter("iChnSource"));
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo = WtcUtil.repStr(request.getParameter("workNo"), "");
	String noPass = WtcUtil.repStr(request.getParameter("noPass"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String iUserPwd = WtcUtil.repStr(request.getParameter("iUserPwd"), "");
	String custJFv1 = "";
%>
	<wtc:service name="sMarkMsgQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/> 
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
	</wtc:service>
	<wtc:array id="integralRet"  scope="end"/>
<%
  System.out.println("---1213--积分--retCode="+retCode);
  if("000000".equals(retCode)){
    if (integralRet.length<1) {
      custJFv1 = "没有符合条件的数据!";
    }else{
      custJFv1 = integralRet[0][0];
    }
  }else{
    custJFv1 = "没有符合条件的数据!";
  }
 
	 System.out.println("---1213--积分--custJFv1="+custJFv1);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("custJFv1","<%=custJFv1%>");
core.ajax.receivePacket(response);