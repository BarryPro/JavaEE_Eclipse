<%
  /*
   * ����: �������ƽ��ģʽ�����������Ϣģ����������-���ģʽ
   * �汾: 1.0
   * ����: 2014/12/15 14:50:21
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.util.Calendar" %>
<%@ page import ="java.io.*" %>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
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
		String loginAccept = getMaxAccept();
		String randomNum = request.getParameter("rnd");
		
		
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
	
	/*��־��Ϣ*/
    /*����ʱ��*/
	java.util.Date sysdate = new java.util.Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String createTime = sf.format(sysdate);
	
	String fnTm=createTime.substring(0,11);
		
	String fileName=request.getRealPath("/npage/public/intf4A/client4A")+"/AAAA01.AVL";
	System.out.println("gaopengSee4ALog====fileName~~~~"+fileName);
	String readPath = request.getRealPath("/npage/public/intf4A/properties")+"/treasury.properties";
	
	String appSessionId = "";
	appSessionId = getRandomNum("allChar",32);	
	
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* ����ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	System.out.println("gaopengSee4ALog====sceneId~~~~~~~~~~"+sceneId);
	/* �������� sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	
	
	String goldSwitch="";
	
	
	if (goldFlag==1)
	{
		goldSwitch = readValue("treasury","public","goldSwitch1",readPath);
	}
	else
	{
		goldSwitch = readValue("treasury","public","goldSwitch0",readPath);
	}
	
	String fileCont=loginNo+"|"+sceneId+"|"+sceneName+"|"+opCode+"|"
		+createTime+"|"+appId+"|CRM|"+goldSwitch+"|"+appSessionId+"|"+java.net.InetAddress.getLocalHost().getHostAddress() +"|"+ip_Addr+"|\n";
	System.out.println("gaopengSee4ALog========fileCont~~~~"+fileCont);
	
	
			/* �ܿ���Ϊ�أ����أ������������ */
		%>	
			<%
			try
			{
				/*�����ļ�*/
				File file = new File(fileName);
				/*����ļ�������*/
				if (!file.exists()) 
				{
					/*�ļ����� >> �ļ��������ʧ��*/
					if (!file.createNewFile())
					{
						%>
							<script language='javascript'>
							rdShowMessageDialog("���������־�ļ�ʧ��!",1);
							window.return="N";
							</script>
						<%
					} 
				} 				
	
				FileWriter writer = new FileWriter(fileName, true);
				/*д�ļ��ļ�*/
				writer.write(fileCont);
				System.out.println("gaopengSee4ALog====writLog=================169");
				writer.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
				%>
					<script language='javascript'>
					rdShowMessageDialog("���������־ʧ��!",1);
					window.return="N";					
					</script>
				<%			
			}		
	
		/*�����һ��δ����,��ô�Ͳ���Ҫ��֤*/
		if(switchFlag!=1  ||  goldFlag!=1 )
		{		
			%>
			<script language="javascript">
					window.returnValue = "Y";
					window.close();
			</script>
<%
		}else{
			try{
				/* ����ʱ�� requestTime�ڵ� */
				String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
				/* ip clientIp*/
				String ipAddr = (String)ip_Addr;
				System.out.println("ipAddr==========================="+ipAddr);
				/* ��Դ����Ӧ�� resType */
				String resTypeVal = "app";
				/* token */
				String token4a = (String)session.getAttribute("token4a");
				System.out.println("gaopengSee4ALog====token4a~~~gaopeng-===================~~~~~~~~~~~~~`"+token4a);
				/* 4A���˺� account */
				String accountVal = "";
				String[] tokenArr = new String[]{""};
				/*����ʹ�� ������ſ�*/
				tokenArr = token4a.split("@");
				if(tokenArr.length == 4){
					accountVal = tokenArr[3];
					System.out.println("token4a~~~gaopeng-======accountVal=============~~~~~~~~~~~~~`"+accountVal);
				}
				if(tokenArr.length == 5){
					accountVal = tokenArr[3];
					System.out.println("token4a~~~gaopeng-======accountVal=============~~~~~~~~~~~~~`"+accountVal);
				}
				/* ����ʹ�ã�������ɾ�� 
				accountVal = "yanhua";
				*/
				/* BOSS��ǰ�˺� subAccount*/
				String workNo = loginNo;
				System.out.println("workNo~~~~~~~~~~"+workNo);
				/* ���ỰSESSIONID appSessionId */

				/* ��ȡ�������ݺ����в��� */
				System.out.println("--------------"+appSessionId);
				System.out.println("````````readPath`````````````"+readPath);
				/* �������� */
				String sensitiveData = readValue("treasury",opCode,"sensitiveData",readPath);
				System.out.println("gaopengSee4ALog====sensitiveData~~~~"+sensitiveData);
				/* ���в��� */
				String sensitiveOperate = readValue("treasury",opCode,"sensitiveOperate",readPath);
				String serviceUrl = readValue("treasury",opCode,"serviceUrl",readPath);
				

				System.out.println("gaopengSee4ALog====@@@@sensitiveOperate="+sensitiveOperate);
				System.out.println("gaopengSee4ALog====@@@@sensitiveData="+sensitiveData);
				System.out.println("gaopengSee4ALog====@@@@serviceUrl="+serviceUrl);
				/* ����xmlģ�� */
			
				String postXmlUrl = request.getRealPath("npage/public/intf4A/xmltemplet")+"/getTreasuryStatusTemplet.xml";
				Document document = CreateXMLDocument(postXmlUrl, "file");
				/* ��ֵ */
				document = updateElementText(document, "requestTime", currTime);
				document = updateElementText(document, "clientIp", ipAddr);
				document = updateElementText(document, "resType", resTypeVal);
				document = updateElementText(document, "account", accountVal);
				document = updateElementText(document, "subAccount", workNo);
				document = updateElementText(document, "sceneId", sceneId);
				document = updateElementText(document, "sceneName", sceneName);
				document = updateElementText(document, "sensitiveData", sensitiveData);
				document = updateElementText(document, "sensitiveOperate", sensitiveOperate);
				document = updateElementText(document, "appId", appId);
				document = updateElementText(document, "appSessionId", appSessionId);
				/* ת����xml���� */
				String xmlStr = doc2String(document);
				System.out.println("gaopengSee4ALog=====���ͱ���=====client4A " + xmlStr);
				/* base64���� */
				xmlStr = encode(xmlStr);
				System.out.println("gaopengSee4ALog======���ܺ���====client4A mmmm [" +xmlStr + "]");
				
				/* Զ�̵���4A ��ⳡ��״̬��ѯ�ӿ� */
				String url = serviceUrl;
				String method = "getTreasuryStatus";
				String localPart = "SoapTreasury4A";
				
				/*2014/10/14 9:30:25 gaopeng ���� ���ʺ����� Ϊ�ֳ���Ȩ��ֻ����һ���ӿڡ�����flag*/
				
				boolean sceneFlag = false;
				
				/* ���� & ��ȡ���ر��� */	
				System.out.println("gaopengSee4ALog===========url="+url);
				System.out.println("gaopengSee4ALog===========method="+method);
				System.out.println("gaopengSee4ALog===========localPart="+localPart);
				System.out.println("gaopengSee4ALog===========xmlStr="+xmlStr);
				String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
				System.out.println("gaopengSee4ALog===���صļ��ܱ���===client4A firstauth returnStr==[" + returnStr + "]");
				/* ���� */
				String returnXmlStr = decode(returnStr);
				/*2014/10/13 10:48:56 gaopeng ����CRM�����Ȩ�����ֳ���Ȩ��ʽ�ĺ� ģ�ⷵ�ر��ĸ�ʽ*/
				/*returnXmlStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><response><head><responseTime>2014-10-13 10:47:07</responseTime><method>CertificationStatusResponse</method></head><body><result>1</result><resultDesc>null</resultDesc><sceneId>ff8080813947e1d101394d5270740002</sceneId><historyAppSessionId>null</historyAppSessionId><relation><policyAuthMethod>remoteAuth</policyAuthMethod><policyAccessMethod>authent_type_sms:��̬����(����);</policyAccessMethod></relation><relation><policyAuthMethod>remoteAuth</policyAuthMethod><policyAccessMethod>authent_type_static:���ʺ�����;</policyAccessMethod></relation><maxTime>24</maxTime><approvers></approvers></body></response>";
				*/
				System.out.println("gaopengSee4ALog===���ܱ���===client4A returnXmlStr==[" + returnXmlStr + "]");
				
				/* ת����xml���� */
				Document resultDocument = CreateXMLDocument(returnXmlStr, "str");
				/* �Ƿ��� ������1  ���迪����0 */
				List StatusFlagResult =  getElementText(resultDocument,"result");
				String treasuryStatusFlag = "";
				if(StatusFlagResult != null && StatusFlagResult.size() > 0){
					treasuryStatusFlag = (String)StatusFlagResult.get(0);
				}
				
				System.out.println("gaopengSee4ALog====== treasuryStatusFlag =  " + treasuryStatusFlag);
				if("1".equals(treasuryStatusFlag)){
					/*������ȡ�б���Ϣ*/
					/* ��Ȩ��ʽ���Ѿ���BOSSԼ��ΪԶ����Ȩ��ʽ�����Բ����� */
					String policyAuthMethodVal = "Զ����Ȩ";
					/* ���ʷ�ʽ */
					String policyAccessMethod = "";
					String policyAccessMethodVal = "";
					List policyAccessMethodResult =  getElementText(resultDocument,"policyAccessMethod");
					for(int i=0;i<policyAccessMethodResult.size();i++){
						if(policyAccessMethodResult != null && policyAccessMethodResult.size() > 0){
							policyAccessMethod = (String)policyAccessMethodResult.get(i);
						}
						
						if(policyAccessMethod.indexOf("authent_type_static") != -1){
							policyAccessMethodVal += "<option value='authent_type_static' selected>���ʺ�����</option>";
							sceneFlag = true;
						}else if(policyAccessMethod.indexOf("authent_type_sms") != -1){
							policyAccessMethodVal += "<option value='authent_type_sms'>��̬������ţ�</option>";
						}else if(policyAccessMethod.indexOf("authent_type_flow") != -1){
							policyAccessMethodVal += "<option value='authent_type_flow'>����ƥ��</option>";
						}else if(policyAccessMethod.indexOf("authent_type_rsa") != -1){
							policyAccessMethodVal += "<option value='authent_type_rsa'>��̬����</option>";
						}else if(policyAccessMethod.indexOf("authent_type_ca") != -1){
							policyAccessMethodVal += "<option value='authent_type_ca'>֤��</option>";
						}else if(policyAccessMethod.indexOf("authent_type_fingerprint") != -1){
							policyAccessMethodVal += "<option value='authent_type_fingerprint'>ָ��</option>";
						}
					}
					List approverList = getElementText(resultDocument,"approver");
					
					List sceneIdList = getElementText(resultDocument,"sceneId");
					if(sceneIdList != null && sceneIdList.size() > 0){
						sceneId = (String)sceneIdList.get(0);
					}
					String maxTime="";
					List maxTimeList = getElementText(resultDocument,"maxTime");
					if(maxTimeList != null && maxTimeList.size() > 0){
						maxTime = (String)maxTimeList.get(0);
					}

					System.out.println("maxTime~~~~"+maxTime);
					Date d =new Date();
					Calendar nowC=Calendar.getInstance();
					nowC.setTime(d);
					nowC.set( Calendar.HOUR , nowC.get( Calendar.HOUR ) +Integer.parseInt(maxTime));
					SimpleDateFormat sfc = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String maxSelTime=sfc.format(nowC.getTime());
					System.out.println("maxSelTime~~~"+maxSelTime);
					
					String maxTimeValue="";
					String maxPickStyle="";
					if (maxTime.equals("0"))
					{
						maxTimeValue=currTime;
						maxPickStyle="style=\"display:none\"";
					}

	%>
	<html>
	<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		function daysBetween(DateOne,DateTwo) 
		{   
			var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-')); 
			var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1); 
			var OneYear = DateOne.substring(0,DateOne.indexOf ('-')); 
			var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-')); 
			var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1); 
			var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));    
			var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
			return cha; 
		} 	
		
		/*2014/10/14 10:22:50 gaopeng ����CRM�����Ȩ�����ֳ���Ȩ��ʽ�ĺ� */
		function setHideVal(obj){
			var objVal = obj.value;
			if(objVal != "authent_type_static"){
				document.getElementById("sceneShow").style.display = "none";
			}else{
				document.getElementById("sceneShow").style.display = "block";
			}
			
		}			
				
		function nextStep(){
			
			/*2014/10/14 14:48:40 gaopeng ����CRM�����Ȩ�����ֳ���Ȩ��ʽ�ĺ� 
				��ȡ���ʷ�ʽ Ŀǰ֧�ֵ��� ���˺����� �� ��̬���� 
				���˺��������һ����֤�ӿ� �����ֳ���֤
				��̬���Ż���ԭ�����߼����䣨Զ����Ȩ��
				
			*/
			var objVal = document.getElementById("policyAccessMethod").value;
			
			var beginTime = "<%=currTime%>";
			if(!checkElement($("#endTime")[0])){
				return false;
			}
			var endTime = $("#endTime").val();
			if(endTime.trim() == ""){
				rdShowMessageDialog("��ѡ���ֹʱ��",1);
				return false;
			}

		if ( daysBetween(endTime , beginTime  )  <0 )
		{
			rdShowMessageDialog("��ֹ���ڱ�����ڿ�ʼ����!",1);
			return false;
		}

	
			var cerReason = $("#cerReason").val();
			if(cerReason.trim().length == 0){
				rdShowMessageDialog("����������ԭ��!",1);
				return false;
			}
			if(cerReason.length > 50){
				
				rdShowMessageDialog("����ԭ�������������50�֣����޸�!",1);
				return false;
			}
			/* ����� ���˺����� */
			if(objVal == "authent_type_static"){
				var dynamicCode2 = $.trim($("#dynamicCode2").val());
				if(dynamicCode2.length == 0){
					rdShowMessageDialog("�����뾲̬���룡",1);
					return false;
				}
				
				/*start do ajax sceneFirstAuth.jsp*/
				
				var approverAccount = $("#approverAccount").val();
				var getdataPacket = new AJAXPacket("sceneFirstAuth.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("beginTime",beginTime);
				getdataPacket.data.add("endTime",endTime);
				getdataPacket.data.add("cerReason",cerReason);
				getdataPacket.data.add("approverAccount",approverAccount);
				getdataPacket.data.add("account","<%=accountVal%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("serviceUrl","<%=serviceUrl%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("authCode",dynamicCode2);
				
				core.ajax.sendPacket(getdataPacket,doSceneFirstAuth);
				getdataPacket = null;
				
				
			}
			/* ����*/
			else{
				var approverAccount = $("#approverAccount").val();
				var getdataPacket = new AJAXPacket("remoteFirstAuth.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("beginTime",beginTime);
				getdataPacket.data.add("endTime",endTime);
				getdataPacket.data.add("cerReason",cerReason);
				getdataPacket.data.add("approverAccount",approverAccount);
				getdataPacket.data.add("account","<%=accountVal%>");
				getdataPacket.data.add("sensitiveData","<%=sensitiveData%>");
				getdataPacket.data.add("sensitiveOperate","<%=sensitiveOperate%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("serviceUrl","<%=serviceUrl%>");
				getdataPacket.data.add("appId","<%=appId%>");
				core.ajax.sendPacket(getdataPacket,doRemoteFirstAuth);
				getdataPacket = null;
			}
		}
		/* 2014/10/14 15:13:40 gaopeng �ֳ���Ȩ�ص�����*/
		function doRemoteFirstAuth(packet){
			var result = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				
				/**���óɹ� */
				$("#firstStep").hide();
				$("#secondStep").show();
					
			}
			else if   (result == "$$$$$$"  )
			{
				/*���óɲ�ͨ�����У��ֱ�ӷ���Y*/
				rdShowMessageDialog(resultDesc);
				window.returnValue = "Y";
				window.close();			
			}
			else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc,1);
				window.returnValue = "N";
				window.close();
			}
		}

		function doSceneFirstAuth(packet){
			var result = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
					/**���óɹ� */
				//rdShowMessageDialog(resultDesc);
				window.returnValue = "Y";
				window.close();		
			}
			else if (result == "$$$$$$"  )
			{
				/*���óɲ�ͨ�����У��ֱ�ӷ���Y*/
				rdShowMessageDialog(resultDesc);
				window.returnValue = "Y";
				window.close();			
			}
			else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc,1);
				window.returnValue = "N";
				window.close();
			}
		}
		
		function doCfm(){
			var dynamicCode = $("#dynamicCode").val();
			if(dynamicCode.trim() == ""){
				rdShowMessageDialog("��������֤��",1);
				return false;
			}
			if(!checkElement($("#dynamicCode")[0])){
				rdShowMessageDialog("��֤��Ϊ��λ����",1);
				return false;
			}
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			endTime = endTime + " 23:59:59"
			var approverAccount = $("#approverAccount").val();
			var getdataPacket = new AJAXPacket("remoteSecondAuth.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("beginTime",beginTime);
			getdataPacket.data.add("endTime",endTime);
			getdataPacket.data.add("dynamicCode",dynamicCode);
			getdataPacket.data.add("approverAccount",approverAccount);
			getdataPacket.data.add("account","<%=accountVal%>");
			getdataPacket.data.add("sensitiveData","<%=sensitiveData%>");
			getdataPacket.data.add("sensitiveOperate","<%=sensitiveOperate%>");
			getdataPacket.data.add("appSessionId","<%=appSessionId%>");
			getdataPacket.data.add("sceneId","<%=sceneId%>");
			getdataPacket.data.add("serviceUrl","<%=serviceUrl%>");
			getdataPacket.data.add("appId","<%=appId%>");
			core.ajax.sendPacket(getdataPacket,doRemoteSecondAuth);
			getdataPacket = null;
		}
		function doRemoteSecondAuth(packet){
			var result = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**���óɹ� */			
				window.returnValue = "Y";
				window.close();
			}
			else if   (result == "$$$$$$"  )
			{	
				/*���óɲ�ͨ�����У��ֱ�ӷ���Y*/
				rdShowMessageDialog("111"+resultDesc,1);
				window.returnValue = "Y";
				window.close();			
			}
			else
			{
				/**����ʧ�� */
				rdShowMessageDialog("У��ʧ�ܣ�ʧ��ԭ��" + resultDesc,1);
				
			}
		}
		function doCancel(){
			window.returnValue = "N";
			window.close();
		}
	</script>

	
<body>
<form action="" method="post" name="treasutyForm">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���ģʽ��֤</div>
	</div>
		<div id="firstStep">
			<table>
				<tr>
					<td class='blue' width="30%">���ʷ�ʽ</td>
					<td>
						<select name="policyAccessMethod" id="policyAccessMethod" onchange="setHideVal(this)">
							<%=policyAccessMethodVal%>
						</select>
						<input type="hidden" name="policyAccessMethodHide" id="policyAccessMethodHide" 
						 value="<%=policyAccessMethod%>"/>
					</td>
				</tr>
				<tr>
					<td class='blue' width="30%">������</td>
					<td>
						<input type="text" name="workNo" id="workNo" 
						 value="<%=workNo%>" readonly="readOnly" class="InputGrey" />
					</td>
				</tr>
				<tr >
					<td class='blue' width="30%">��ʼʱ��</td>
					<td>
						<input type="text" name="beginTime" id="beginTime" value="<%=currTime%>" 
							readonly="readOnly" class="InputGrey" />
						<font color="orange">*</font>
					</td>
				</tr>
				
				<tr >
					<td class='blue' width="30%">��ֹʱ��</td>
					<td>
						<input type="text" name="endTime" id="endTime" v_type="date_time" v_must="1" readonly  value='<%=maxTimeValue%>'>
						<img id = "imgEndTime" name = "imgEndTime" <%=maxPickStyle%>
							onclick="WdatePicker({el:'endTime',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'<%=maxSelTime%>',alwaysUseStartDate:true})" src="/njs/plugins/My97DatePicker/skin/datePicker.gif" 
							width="16" height="22" align="absmiddle">							
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class='blue' width="30%">������</td>
					<td>
						<select id="approverAccount" name="approverAccount">
						<%
							if(approverList != null){
								for(int i = 0; i < approverList.size(); i++){
						%>
							<option value="<%=approverList.get(i)%>"><%=approverList.get(i)%></option>
						<%
								}
							}
						%>
						</select>
					</td>
				</tr>
				<%if(sceneFlag){%>
				<tr  id="sceneShow" style="display:block">
					<td class='blue' width="30%">��̬����</td>
					<td><input type="password" id="dynamicCode2" name="dynamicCode2" value=""/>&nbsp;<font color="red">*</font></td>
				</tr>
				<%}%>
				<tr>
					<td class='blue' width="30%">����ԭ��</td>
					<td>
						<textarea name="cerReason" id="cerReason" rows="3" cols="40" v_must="1"></textarea>
						<font class="red">*</font>
						&nbsp;(���50��)
					</td>
				</tr>

				<tr>
					<td align="center"  colspan="2" id="footer"> 
						<input class="b_foot" id="cfmBtn" type="button" value="��һ��" onclick="nextStep()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="ȡ��" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<div id="secondStep" style="display:none;">
			<table>
				<tr>
					<td class='blue' width="30%">�����붯̬����</td>
					<td>
						<input type="text" name="dynamicCode" id="dynamicCode" 
						v_must="1" v_type="0_9" maxlength="6" onblur="checkElement(this)" />
						<font class="orange">*</font>
					</td>
				</tr>
				<tr align="center">
					<td align="center" colspan="2" id="footer"> 
						<input class="b_foot" id="cfmBtn" type="button" value="ȷ��" onclick="doCfm()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="ȡ��" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		</FORM>
	</body>
	<%
				}else{
					/* ���迪�������أ��������� */
	%>
				<script>
							window.returnValue = "Y";
							window.close();
					</script>
	<%
				}
		}catch(Exception e){
			System.out.println("ningtn eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
			e.printStackTrace();
			%>
			<table>
				<tr>
					<td align="center" colspan="2">
						<font color="red">����Զ�̷�����ʧ��</font>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<input type="button" class="b_foot" name="errorBtn" id="errorBtn" 
			 				value="�ر�" onclick="window.close();" />
					</td>
				</tr>
			</table>
			<br/>
			<%
		}
		}
	}else{
		/* ��ѯʧ���ˣ��ñ��� */
%>
	<script language="javascript">
			rdShowMessageDialog("��ѯ��⿪�س���!",1);
			removeCurrentTab();
		</script>
<%
	}
%>