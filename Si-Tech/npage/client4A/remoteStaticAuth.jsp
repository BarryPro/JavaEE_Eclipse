<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	/* 取值 */
	String regionCode = (String)session.getAttribute("regCode");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String approverAccount = WtcUtil.repNull(request.getParameter("approverAccount"));
	String beginTime = WtcUtil.repNull(request.getParameter("beginTime"));
	String endTime = WtcUtil.repNull(request.getParameter("endTime"));
	String authCode = WtcUtil.repNull(request.getParameter("staticCode"));
	String accountVal = WtcUtil.repNull(request.getParameter("account"));
	String sensitiveData = WtcUtil.repNull(request.getParameter("sensitiveData"));
	String sensitiveOperate = WtcUtil.repNull(request.getParameter("sensitiveOperate"));
	String appSessionId = WtcUtil.repNull(request.getParameter("appSessionId"));
	String sceneId = WtcUtil.repNull(request.getParameter("sceneId"));
	String serviceUrl = WtcUtil.repNull(request.getParameter("serviceUrl"));
	String appId = WtcUtil.repNull(request.getParameter("appId"));
	String result = "";
	String resultDesc = "";
	int switchFlag = 0;
	int switchFlag2 = 0;
	String getSwitchFlag = " SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter " + 
													" WHERE LOGIN_NO = 'switch' and op_code = 'e269'";
	
	String getSwitchFlag2 = " SELECT TO_NUMBER(FLAG_SWITCH)  FROM SSYSTEMPARAMETER t "  +
													" WHERE LOGIN_NO = 'switch' AND OP_CODE = 'e768'";	
%>
		<wtc:pubselect name="sPubSelect" outnum="1" 
					routerKey="region" routerValue="<%=regionCode%>"  
					retcode="retCode" retmsg="retMsg" >
			<wtc:sql><%=getSwitchFlag%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="switchResult" scope="end"/>

		<wtc:pubselect name="sPubSelect" outnum="1" 
					routerKey="region" routerValue="<%=regionCode%>"  
					retcode="retCode2" retmsg="retMsg2" >
			<wtc:sql><%=getSwitchFlag2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="switchResult2" scope="end"/>
<%
	System.out.println("AAAAAAAAAAAAAAAAAAAAAa test switchFlag is "+switchFlag);
	if("000000".equals(retCode) && "000000".equals(retCode2)){
		if(switchResult != null && switchResult.length > 0 && switchResult2 != null && switchResult2.length > 0){
			if("1".equals(switchResult[0][0])){
				switchFlag = 1;
			}
			if("1".equals(switchResult2[0][0])){
				switchFlag2 = 1;
			}
		}	
	}
	if(switchFlag == 1 &&switchFlag2 == 1){
	System.out.println("ningtn siteAuth approverAccount = " + approverAccount);
	System.out.println("ningtn beginTime  = " + beginTime);
	System.out.println("ningtn endTime  = " + endTime);
	System.out.println("ningtn authCode  = " + authCode);
	/* 操作时间 requestTime节点 */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ip clientIp*/
	String ipAddr = (String)session.getAttribute("ipAddr");
	/* 资源类型应用 resType */
	String resTypeVal = "app";
	String moreMsg="";
	/* BOSS当前账号 subAccount*/
	String workNo = (String)session.getAttribute("workNo");
	/* 根据xml模板，生成报文 */
	/* 套用xml模板 */
	String postXmlUrl = request.getRealPath("npage/xmltemplet")+"/remoteStaticAuth.xml";
	Document document = CreateXMLDocument(postXmlUrl, "file");
	/* 换值 */
	document = updateElementText(document, "appId", appId);
	document = updateElementText(document, "requestTime", currTime);
	document = updateElementText(document, "clientIp", ipAddr);
	document = updateElementText(document, "account", accountVal);
	document = updateElementText(document, "subAccount", workNo);
	document = updateElementText(document, "approverAccount", approverAccount);
	document = updateElementText(document, "beginTime", beginTime);
	document = updateElementText(document, "endTime", endTime);
	document = updateElementText(document, "authCode", authCode);
	document = updateElementText(document, "moreMsg", moreMsg);
	document = updateElementText(document, "appSessionId", appSessionId);
	document = updateElementText(document, "sceneId", sceneId);

	/* 转化成xml报文 */
	String xmlStr = doc2String(document);
	System.out.println("client4A " + xmlStr);
	/* base64加密 */
	xmlStr = encode(xmlStr);
	System.out.println("client4A mmmm [" +xmlStr + "]");
	
	/* 远程调用4A 金库场景状态查询接口 */
	String url = serviceUrl;
	String method = "siteAuth";
	String localPart = "SoapTreasury4A";
	
	/* 调用 & 获取返回报文 */	
	String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
	/* 解密 */
	String returnXmlStr = decode(returnStr);
	System.out.println("client4A siteAuth returnXmlStr== " + returnXmlStr);
	/* 转化成xml对象 */
	Document resultDocument = CreateXMLDocument(returnXmlStr, "str");
	
	
	List resultList = getElementText(resultDocument,"result");
	if(resultList != null && resultList.size() > 0){
		result = (String)resultList.get(0);
	}
	List resultDescList = getElementText(resultDocument,"resultDesc");
	if(resultDescList != null && resultDescList.size() > 0){
		resultDesc = (String)resultDescList.get(0);
	}
	System.out.println("======client4A siteAuth " + result + " | " + resultDesc);
	}else{
		result = "1";
	}
%>

	var response = new AJAXPacket();

	response.data.add("result","<%=result%>");
	response.data.add("resultDesc","<%=resultDesc%>");