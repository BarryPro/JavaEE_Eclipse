<%
  /*
   * 功能: 关于完善金库模式管理和敏感信息模糊化的需求-金库模式
   * 版本: 1.0
   * 日期: 2014/12/15 14:50:21
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%request.setCharacterEncoding("GBK");%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.util.Calendar" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/public/intf4A/client4A/connect4A.jsp" %>
<%@ include file="/npage/public/intf4A/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/public/intf4A/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/public/intf4A/properties/getRDMessage.jsp" %>


	<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		opName = "金库模式验证";
		String phoneNo = (String)request.getParameter("activePhone");
		String ip_Addr = (String)session.getAttribute("ipAddr");
	/** 判断4A总开关，当开关为开时，调用4A。当开关为关时，允许继续操作 
	*		0和没数据是关 ， 1是开
	**/
	int switchFlag = 0;
	int goldFlag=0;
	String getSwitchFlag = " SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter " + 
													" WHERE LOGIN_NO = 'switch' and op_code = 'e269'";
	String sqlGoldFlag= " SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter " + 
													" WHERE LOGIN_NO = 'switch' and op_code = 'e768'";
	
	String inParamsSwitchFlag [] = new String[2];
	inParamsSwitchFlag[0] = "SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter WHERE LOGIN_NO =:loginNo and op_code =:opCode ";
	inParamsSwitchFlag[1] = "loginNo=switch,opCode=e269";
	
	String inParamsGoldFlag [] = new String[2];
	inParamsGoldFlag[0] = "SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter WHERE LOGIN_NO =:loginNo and op_code =:opCode ";
	inParamsGoldFlag[1] = "loginNo=switch,opCode=e768";
	
	%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region" retmsg="retMessage_region" outnum="1"> 
	    <wtc:param value="<%=inParamsSwitchFlag[0]%>"/>
	    <wtc:param value="<%=inParamsSwitchFlag[1]%>"/> 
	  </wtc:service>  
	  <wtc:array id="resultSwitchFlag"  scope="end"/>
	  	
	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region2" retmsg="retMessage_region2" outnum="1"> 
	    <wtc:param value="<%=inParamsGoldFlag[0]%>"/>
	    <wtc:param value="<%=inParamsGoldFlag[1]%>"/> 
	  </wtc:service>  
	  <wtc:array id="resultGoldFlag"  scope="end"/>
	<%	
	
	if("000000".equals(retCode_region) && resultSwitchFlag.length > 0){
		switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("查询金库开关出错!",1);
			removeCurrentTab();
		</script>
		<%
	}
	if("000000".equals(retCode_region2) && resultGoldFlag.length > 0){
		goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("查询金库开关出错!",1);
			removeCurrentTab();
		</script>
		<%
	}
	

if("000000".equals(retCode_region2) && resultGoldFlag.length > 0  &&  "000000".equals(retCode_region) && resultSwitchFlag.length > 0  ){
	switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	/*默认赋值为1*/
	//switchFlag = 1;
	//goldFlag = 1;
	
	System.out.println("~~~~~gaopengSee4ALog~~~~~switchFlag~~~~~~~~~~~~~~~~~~~"+switchFlag);
	System.out.println("~~~~~gaopengSee4ALog~~~~~goldFlag~~~~~~~~~~~~~~~~~~~"+goldFlag);

	if(switchFlag == 1 && goldFlag == 1){
	/* 取值 */
	String approverAccount = request.getParameter("approverAccount");
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
	String cerReason = request.getParameter("cerReason");
	String accountVal = request.getParameter("account");
	String appSessionId = request.getParameter("appSessionId");
	
	String sceneId = request.getParameter("sceneId");
	String serviceUrl = request.getParameter("serviceUrl");
	String appId = request.getParameter("appId");
	String authCode = request.getParameter("authCode");
	
	System.out.println("ningtn remoteFirst approverAccount = " + approverAccount);
	System.out.println("ningtn beginTime  = " + beginTime);
	System.out.println("ningtn endTime  = " + endTime);
	System.out.println("ningtn cerReason  = " + cerReason);
	/* 操作时间 requestTime节点 */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ip clientIp*/
	String ipAddr = ip_Addr;	
	/* 资源类型应用 resType */
	String resTypeVal = "app";
	/* BOSS当前账号 subAccount*/
	String workNo = loginNo;
	/* 根据xml模板，生成报文 */
	/* 套用xml模板 */
	String postXmlUrl = request.getRealPath("/npage/public/intf4A/xmltemplet")+"/sceneFirstAuth.xml";
	Document document = CreateXMLDocument(postXmlUrl, "file");
	/* 换值 */
	document = updateElementText(document, "appId", appId);	
	document = updateElementText(document, "requestTime", currTime);
	document = updateElementText(document, "clientIp", ipAddr);
	document = updateElementText(document, "method", "authent_type_static");
	
	
	document = updateElementText(document, "account", accountVal);
	document = updateElementText(document, "subAccount", workNo);
	document = updateElementText(document, "approverAccount", approverAccount);
	document = updateElementText(document, "beginTime", beginTime);
	document = updateElementText(document, "endTime", endTime);
	/*动态令牌码*/
	document = updateElementText(document, "authCode", authCode);
	document = updateElementText(document, "moreMsg", cerReason);
	document = updateElementText(document, "appSessionId", appSessionId);
	document = updateElementText(document, "sceneId", sceneId);
	
	/* 转化成xml报文 */
	String xmlStr = doc2String(document);
	System.out.println("gaopengSeeLog==============client4A " + xmlStr);
	/* base64加密 */
	xmlStr = encode(xmlStr);
	System.out.println("gaopengSeeLog==============client4A mmmm [" +xmlStr + "]");
	
	/* 远程调用4A 金库场景状态查询接口 */
	String url = serviceUrl;
	String method = "siteAuth";
	String localPart = "SoapTreasury4A";
	
	/* 调用 & 获取返回报文 */	
	String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
	System.out.println("gaopengSeeLog==============client4A sceneFirstAuth returnStr==[" + returnStr + "]");
	/* 解密 */
	String returnXmlStr = decode(returnStr);
	System.out.println("gaopengSeeLog==============client4A sceneFirstAuth returnXmlStr==[" + returnXmlStr + "]");
	/* 转化成xml对象 */
	Document resultDocument = CreateXMLDocument(returnXmlStr, "str");
	String result = "";
	String resultDesc = "";
	List resultList = getElementText(resultDocument,"result");
	if(resultList != null && resultList.size() > 0){
		result = (String)resultList.get(0);
	}
	List resultDescList = getElementText(resultDocument,"resultDesc");
	if(resultDescList != null && resultDescList.size() > 0){
		resultDesc = (String)resultDescList.get(0);
	}
	System.out.println("=gaopengSeeLog===================client4A sceneFirstAuth " + result + " | " + resultDesc);
%>

	var response = new AJAXPacket();

	response.data.add("result","<%=result%>");
	response.data.add("resultDesc","<%=resultDesc%>");
	core.ajax.receivePacket(response);
<%}
else
{
String result="$$$$$$";
String resultDesc="金库设置:可直接办理业务";
System.out.println("result~!!!"+result);
%>	
var response = new AJAXPacket();
response.data.add("result","<%=result%>");
response.data.add("resultDesc","<%=resultDesc%>");
core.ajax.receivePacket(response);
<%}

}%>