<%
  /*
   * ����: �������ƽ��ģʽ�����������Ϣģ����������-���ģʽ
   * �汾: 1.0
   * ����: 2014/12/15 14:50:21
   * ����: gaopeng
   * ��Ȩ: si-tech
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
		opName = "���ģʽ��֤";
		String phoneNo = (String)request.getParameter("activePhone");
		String ip_Addr = (String)session.getAttribute("ipAddr");
	/** �ж�4A�ܿ��أ�������Ϊ��ʱ������4A��������Ϊ��ʱ������������� 
	*		0��û�����ǹ� �� 1�ǿ�
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
			rdShowMessageDialog("��ѯ��⿪�س���!",1);
			removeCurrentTab();
		</script>
		<%
	}
	if("000000".equals(retCode_region2) && resultGoldFlag.length > 0){
		goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ѯ��⿪�س���!",1);
			removeCurrentTab();
		</script>
		<%
	}
	

if("000000".equals(retCode_region2) && resultGoldFlag.length > 0  &&  "000000".equals(retCode_region) && resultSwitchFlag.length > 0  ){
	switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	/*Ĭ�ϸ�ֵΪ1*/
	//switchFlag = 1;
	//goldFlag = 1;
	
	System.out.println("~~~~~gaopengSee4ALog~~~~~switchFlag~~~~~~~~~~~~~~~~~~~"+switchFlag);
	System.out.println("~~~~~gaopengSee4ALog~~~~~goldFlag~~~~~~~~~~~~~~~~~~~"+goldFlag);

	if(switchFlag == 1 && goldFlag == 1){
	/* ȡֵ */
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
	/* ����ʱ�� requestTime�ڵ� */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ip clientIp*/
	String ipAddr = ip_Addr;	
	/* ��Դ����Ӧ�� resType */
	String resTypeVal = "app";
	/* BOSS��ǰ�˺� subAccount*/
	String workNo = loginNo;
	/* ����xmlģ�壬���ɱ��� */
	/* ����xmlģ�� */
	String postXmlUrl = request.getRealPath("/npage/public/intf4A/xmltemplet")+"/sceneFirstAuth.xml";
	Document document = CreateXMLDocument(postXmlUrl, "file");
	/* ��ֵ */
	document = updateElementText(document, "appId", appId);	
	document = updateElementText(document, "requestTime", currTime);
	document = updateElementText(document, "clientIp", ipAddr);
	document = updateElementText(document, "method", "authent_type_static");
	
	
	document = updateElementText(document, "account", accountVal);
	document = updateElementText(document, "subAccount", workNo);
	document = updateElementText(document, "approverAccount", approverAccount);
	document = updateElementText(document, "beginTime", beginTime);
	document = updateElementText(document, "endTime", endTime);
	/*��̬������*/
	document = updateElementText(document, "authCode", authCode);
	document = updateElementText(document, "moreMsg", cerReason);
	document = updateElementText(document, "appSessionId", appSessionId);
	document = updateElementText(document, "sceneId", sceneId);
	
	/* ת����xml���� */
	String xmlStr = doc2String(document);
	System.out.println("gaopengSeeLog==============client4A " + xmlStr);
	/* base64���� */
	xmlStr = encode(xmlStr);
	System.out.println("gaopengSeeLog==============client4A mmmm [" +xmlStr + "]");
	
	/* Զ�̵���4A ��ⳡ��״̬��ѯ�ӿ� */
	String url = serviceUrl;
	String method = "siteAuth";
	String localPart = "SoapTreasury4A";
	
	/* ���� & ��ȡ���ر��� */	
	String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
	System.out.println("gaopengSeeLog==============client4A sceneFirstAuth returnStr==[" + returnStr + "]");
	/* ���� */
	String returnXmlStr = decode(returnStr);
	System.out.println("gaopengSeeLog==============client4A sceneFirstAuth returnXmlStr==[" + returnXmlStr + "]");
	/* ת����xml���� */
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
String resultDesc="�������:��ֱ�Ӱ���ҵ��";
System.out.println("result~!!!"+result);
%>	
var response = new AJAXPacket();
response.data.add("result","<%=result%>");
response.data.add("resultDesc","<%=resultDesc%>");
core.ajax.receivePacket(response);
<%}

}%>