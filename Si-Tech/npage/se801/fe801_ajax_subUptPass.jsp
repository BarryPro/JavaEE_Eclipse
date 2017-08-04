<%
    /*************************************
    * 功  能: 集团客户密码变更 e801
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-4-26
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode = (String)session.getAttribute("regCode");
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginPassword = WtcUtil.repNull((String)session.getAttribute("password"));
	
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String updateType=WtcUtil.repNull((String)request.getParameter("updateType"));
	String identityTypeVal=WtcUtil.repNull((String)request.getParameter("identityTypeVal"));
	String custId=WtcUtil.repNull((String)request.getParameter("custId"));
	String idNo=WtcUtil.repNull((String)request.getParameter("idNo"));
	String oldPassword=WtcUtil.repNull((String)request.getParameter("oldPassword"));
	String newPassword1=WtcUtil.repNull((String)request.getParameter("newPassword1"));
	String slecOperType=WtcUtil.repNull((String)request.getParameter("slecOperType"));
	
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
<%
  String [] inputParam = new String [13] ;
	inputParam[0] = printAccept; //流水
	inputParam[1] = "01";        //渠道
	inputParam[2] = opCode;      //操作代码
	inputParam[3] = loginNo;     //工号
	inputParam[4] = loginPassword;//工号密码
	inputParam[5] = "";           //号码
	inputParam[6] = "";           //号码密码
	inputParam[7] = updateType;   //修改类型（01-密码修改，02-密码重置）
	inputParam[8] = identityTypeVal; //修改范围（01、只修改集团客户密码；02、只修改集团用户密码；03、修改集团客户密码，则集团和集团下所有产品密码都为集团客户密码）
	inputParam[9] = custId;           //集团客户ID
	inputParam[10] = idNo;           //产品id（iUpdateRange为02时，有值)
	inputParam[11] = oldPassword;           //旧密码（iUpdateType为01时，有值）
	inputParam[12] = newPassword1 ;           //新密码
%>
	<wtc:service name="se801Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inputParam[0]%>"/>
		<wtc:param value="<%=inputParam[1]%>"/>
		<wtc:param value="<%=inputParam[2]%>"/>
		<wtc:param value="<%=inputParam[3]%>"/>
		<wtc:param value="<%=inputParam[4]%>"/>
		<wtc:param value="<%=inputParam[5]%>"/>
		<wtc:param value="<%=inputParam[6]%>"/>
		<wtc:param value="<%=inputParam[7]%>"/>
		<wtc:param value="<%=inputParam[8]%>"/>
		<wtc:param value="<%=inputParam[9]%>"/>
		<wtc:param value="<%=inputParam[10]%>"/>
		<wtc:param value="<%=inputParam[11]%>"/>
		<wtc:param value="<%=inputParam[12]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
  System.out.println("-----------e801-----------retcode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
response.data.add("slecOperType","<%=slecOperType%>");
core.ajax.receivePacket(response);
 
	    