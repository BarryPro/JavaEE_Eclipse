<%@ page contentType="text/html;charset=GBK"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper1.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<%
/* ip clientIp*/
	String ipAddr = (String)session.getAttribute("ipAddr");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	System.out.println("++++++++++++++ getTreasutyStatus start +++++++++++++++");
	String regionCode = (String)session.getAttribute("regCode");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String loginNo = (String)session.getAttribute("workNo");
	/** �ж�4A�ܿ��أ�������Ϊ��ʱ������4A��������Ϊ��ʱ������������� 
	*		0��û�����ǹ� �� 1�ǿ�
	**/
	int switchFlag = 0;
	int switchFlag1 = 0;
	String getSwitchFlag = " SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter " + 
													" WHERE LOGIN_NO = 'switch' and op_code = 'e269'";
	
 String getSwitchFlag2 = " SELECT TO_NUMBER(FLAG_SWITCH)  FROM SSYSTEMPARAMETER t "  +
													" WHERE LOGIN_NO = 'switch' AND OP_CODE = 'e768'";			
%>
<%!
private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
    private static String DETAIL_PATH = "";
    static {
        //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        //�������"/"��ʽ����,����"/"
        if (!DETAIL_PATH.endsWith("/")) {
            DETAIL_PATH = DETAIL_PATH+"/";
        }
    }
    
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
	System.out.println("client4A ningtn retCode === " + retCode);
	if(("000000".equals(retCode)) &&("000000".equals(retCode2))){
		if((switchResult != null && switchResult.length > 0) && (switchResult2 != null && switchResult2.length > 0)){
		/*if(switchResult != null && switchResult.length > 0){*/
			if("1".equals(switchResult[0][0]))
			{
				switchFlag = 1;
			}
			if(("1".equals(switchResult2[0][0])))
			{
				switchFlag1 = 1;
			}
		}
		/** ����ʹ�ã���Ӱ����� */
		/*switchFlag = 1;
		switchFlag1 = 1;*/
		
		if(switchFlag != 1){
			/* �ܿ���Ϊ�أ����أ������������ */
%>
			<script language="javascript">
					window.returnValue = "Y";
					window.close();
			</script>
<%
		}
	else if(switchFlag1 ==0)
	{
%>
	<script language="javascript">
					window.returnValue = "Y";
					window.close();
	</script>
<%	}
		else{
			try{
				
				/* ����ʱ�� requestTime�ڵ� */
				String currTime = new SimpleDateFormat(("yyyy-MM-dd HH:mm:ss"), Locale.getDefault()).format(new Date());
				/* currTime = "2012-10-13 12:05:00";*/
				/* ��Դ����Ӧ�� resType */
				String resTypeVal = "app";
				/* token */
				String token4a = (String)session.getAttribute("token4a");
				/* ����ʹ�ã�������ɾ�� */
				/*token4a = "c8c94fcca2fb469aa7543d40773558a4@aaiiAb@8aeeef50362f690a01362f882d7b0005@bocoadmin";*/
				/* 4A���˺� account */
				String accountVal = "";
				/* �����ã�����ɾ�� zhangyta at 20120824*/
				/*String accountVal = "zhangyingtan";*/
				String[] tokenArr = new String[]{""};
				tokenArr = token4a.split("@");
				if(tokenArr.length == 4||tokenArr.length == 5){
					accountVal = tokenArr[3];
				}
				/* BOSS��ǰ�˺� subAccount*/
				String workNo = (String)session.getAttribute("workNo");
				
				/* �����ó������ƣ�����ɾ�� by zhangyta at 20120824*/
				/*sceneName = "CRM_ǰ̨�������ѯ�ͻ��굥";*/
				/* ���ỰSESSIONID appSessionId */
				String appSessionIdFlag = "";
				String appSessionId = "";
				appSessionId = getRandomNum("allChar",32);
				/* ��ȡ�������ݺ����в��� */
				String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
				/* �������� */
				String sensitiveData = readValue("treasury",opCode,"sensitiveData",readPath);
				/* ���в��� */
				String sensitiveOperate = readValue("treasury",opCode,"sensitiveOperate",readPath);
				String serviceUrl = readValue("treasury",opCode,"serviceUrl",readPath);
				/* ��ԴID */
				String appId = readValue("treasury",opCode,"appId",readPath);
				/* ��Դ���� */
				String appName = readValue("treasury",opCode,"appName",readPath);
				/* ����ID sceneId */
				String sceneId = readValue("treasury",opCode,"sceneId",readPath);
				/* �����ó���ID������ɾ�� by zhangyta at 20120824*/
				/*sceneId = "ff808081395641c901395641c9220000";*/
				/* �������� sceneName */
				String sceneName = readValue("treasury",opCode,"sceneName",readPath);
				
				/* ����xmlģ�� */
				String postXmlUrl = request.getRealPath("npage/xmltemplet")+"/getTreasuryStatusTemplet.xml";
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
				System.out.println("client4A " + xmlStr);
				/* base64���� */
				xmlStr = encode(xmlStr);
				System.out.println("client4A mmmm [" +xmlStr + "]");
				
				/* Զ�̵���4A ��ⳡ��״̬��ѯ�ӿ� */
				String url = serviceUrl;
				String method = "getTreasuryStatus";
				String localPart = "SoapTreasury4A";
				
				/* ���� & ��ȡ���ر��� */	
				String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
				System.out.println("client4A firstauth returnStr==[" + returnStr + "]");
				/* ���� */
				String returnXmlStr = decode(returnStr);
				System.out.println("client4A returnXmlStr==[" + returnXmlStr + "]");
				
				/* ת����xml���� */
				Document resultDocument = CreateXMLDocument(returnXmlStr, "str");
				/* �Ƿ��� ������1  Ӧ����0����Ȩ��2 δ֪��3 */
				List StatusFlagResult =  getElementText(resultDocument,"result");
				String treasuryStatusFlag = "";
				if(StatusFlagResult != null && StatusFlagResult.size() > 0){
					treasuryStatusFlag = (String)StatusFlagResult.get(0);
				}
				/*add by zhangyta */
				List historyAppSessionIdResult =  getElementText(resultDocument,"historyAppSessionId");
				String historyAppSessionIdFlag = "";
				if(historyAppSessionIdResult != null && historyAppSessionIdResult.size() > 0){
					historyAppSessionIdFlag = (String)historyAppSessionIdResult.get(0);
					if(historyAppSessionIdFlag.equals("null")){
					session.setAttribute("appSessionId",appSessionId);
					appSessionIdFlag = appSessionId;
					}else{
					session.setAttribute("appSessionId",historyAppSessionIdFlag);
					appSessionIdFlag = appSessionId;
					}
				}
				session.setAttribute("flag4A","1");
				
				/**ȡmaxtimeΪ����ֹ���� add by zhangyta at 20120824*/
				List maxtimeResult =  getElementText(resultDocument,"maxTime");
				String maxtimeFlag = "";
				if(maxtimeResult != null && maxtimeResult.size() > 0){
					maxtimeFlag = (String)maxtimeResult.get(0);
				}
					
				System.out.println("zhangyta maxtimeFlag =  " + maxtimeFlag);
				

				
				
				if("1".equals(treasuryStatusFlag)){
					/*������ȡ�б���Ϣ*/
					/* ��Ȩ��ʽ���Ѿ���BOSSԼ��ΪԶ����Ȩ��ʽ�����Բ����� */
					String policyAuthMethodVal = "Զ����Ȩ";
					/* ���ʷ�ʽ */
					String policyAccessMethod = "";
					String policyAccessMethodVal = "";
					List policyAccessMethodResult =  getElementText(resultDocument,"policyAccessMethod");
					/*if(policyAccessMethodResult != null && policyAccessMethodResult.size() > 0){
						policyAccessMethod = (String)policyAccessMethodResult.get(0);
					}
					
					if(policyAccessMethod.indexOf("authent_type_static") != -1){
						policyAccessMethodVal = "���ʺ�����";
					}else if(policyAccessMethod.indexOf("authent_type_sms") != -1){
						policyAccessMethodVal = "��̬������ţ�";
					}else if(policyAccessMethod.indexOf("authent_type_flow") != -1){
						policyAccessMethodVal = "����ƥ��";
					}else if(policyAccessMethod.indexOf("authent_type_rsa") != -1){
						policyAccessMethodVal = "��̬����";
					}else if(policyAccessMethod.indexOf("authent_type_ca") != -1){
						policyAccessMethodVal = "֤��";
					}else if(policyAccessMethod.indexOf("authent_type_fingerprint") != -1){
						policyAccessMethodVal = "ָ��";
					} */
					List policyAccessMethodValResult= new ArrayList();
					if(policyAccessMethodResult != null && policyAccessMethodResult.size() > 0){
						for(int i=0;i< policyAccessMethodResult.size();i++){
							policyAccessMethod = (String)policyAccessMethodResult.get(i);
							if(policyAccessMethod.indexOf("authent_type_static") != -1){
								policyAccessMethodVal = "���ʺ�����";
							}else if(policyAccessMethod.indexOf("authent_type_sms") != -1){
								policyAccessMethodVal = "��̬������ţ�";
							}else if(policyAccessMethod.indexOf("authent_type_flow") != -1){
								policyAccessMethodVal = "����ƥ��";
							}else if(policyAccessMethod.indexOf("authent_type_rsa") != -1){
								policyAccessMethodVal = "��̬����";
							}else if(policyAccessMethod.indexOf("authent_type_ca") != -1){
								policyAccessMethodVal = "֤��";
							}else if(policyAccessMethod.indexOf("authent_type_fingerprint") != -1){
								policyAccessMethodVal = "ָ��";
							}
							policyAccessMethodValResult.add(policyAccessMethodVal);
						}
					}					
					List approverList = getElementText(resultDocument,"approver");					
					List sceneIdList = getElementText(resultDocument,"sceneId");
					if(sceneIdList != null && sceneIdList.size() > 0){
						sceneId = (String)sceneIdList.get(0);
					}
	%>
	<script language="javascript">
		function doFileInput(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**���óɹ� */
				return true;
			}else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
				return false;
			}
		}
	function nextStep(){
			var methodType = document.treasutyForm.policyAccessMethod.value;
			//alert(methodType);
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			if(endTime.trim() == ""){
				rdShowMessageDialog("��ѡ���ֹʱ��");
				return false;
			}
			endTime = endTime + beginTime.substring(13,19);		
			var cerReason = $("#cerReason").val();
			if(cerReason.trim().length == 0){
				rdShowMessageDialog("����������ԭ��");
				return false;
			}
			if(cerReason.length > 50){
				rdShowMessageDialog("����ԭ�������������50�֣����޸�");
				return false;
			}	
			if(methodType.indexOf("authent_type_static") != -1){
				$("#firstStep").hide();
				$("#staticStep").show();	
			}	
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
		function doRemoteFirstAuth(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**���óɹ� */
				$("#firstStep").hide();
				$("#secondStep").show();
			}else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
				window.returnValue = "N";
				window.close();
			}
		}
		function doCfm(){
			var dynamicCode = $("#dynamicCode").val();
			if(dynamicCode.trim() == ""){
				rdShowMessageDialog("��������֤��");
				return false;
			}
			if(!checkElement($("#dynamicCode")[0])){
				rdShowMessageDialog("��֤��Ϊ��λ����");
				return false;
			}
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			endTime = endTime + beginTime.substring(13,19);
			
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
		/**add by zhangyta at 2012-08-13 ��֤������������ Begin */
		<%
        Object o = null;
        String strNum = (String) session.getAttribute("Num"); //��session��ͬ
        int Num = 0;
        if (strNum != null)
          Num = Integer.parseInt(strNum);
        session.setAttribute("Num", String.valueOf(Num));
      %>
    /**add by zhangyta at 2012-08-13 ��֤������������ End */
		
		function doRemoteSecondAuth(packet){
			var resultqq = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			//alert("rust ls "+resultqq);
			if(resultqq == "1"){
				/**���óɹ� */
			
				window.returnValue = "Y";
				
				window.close();
				//alert("test now is "); 
			}else{
				/**����ʧ�� */
					/**add by zhangyta at 2012-08-13 ��֤������������ Begin*/
				//alert("22222222");
				var Num = document.treasutyForm.testCount.value;
				var Num1 = parseInt(Num) + 1;
		          document.getElementById("testCount").value =Num1;
				 if(resultDesc == "��������֤���������������"){
				  			var Num2 = 2 - parseInt(Num);
			          rdShowMessageDialog("У��ʧ�ܣ�ʧ��ԭ��" + resultDesc +",���Ѿ�����"+Num1+"�Σ�����3�ν��Զ��˳���ǰҳ�棬��ʣ��"+Num2+"�Ρ�");
			          
			          var Num1 = parseInt(Num) + 1;
			          document.getElementById("testCount").value =Num1;
			          if(Num2 == 0){
			          	doCancel();
			          	}
				/**add by zhangyta at 2012-08-13 ��֤������������ End*/  
				
				
				
				}else{
					rdShowMessageDialog("У��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
					}
			}
		}
		function doCancel(){
			var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("loginNo","<%=loginNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo","0");
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","1");
				getdataPacket.data.add("appSessionId","<%=appSessionIdFlag%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;
			
			window.returnValue = "N";
			window.close();
		}
		
// huangqi addd ��ӽ����֤ģʽ����̬������֤��
		function check4AType(methodtype){
			var methodType=methodtype;
			//alert(methodType);
			if(methodType.indexOf("authent_type_static") != -1){
				$("#firstStep").hide();
				$("#staticStep").show();	
			}
		}
		function doStaticCfm(){
				var staticCode = $("#staticCode").val();
			if(staticCode.trim() == ""){
				rdShowMessageDialog("�����뾲̬���룡");
				return false;
			}
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			endTime = endTime + beginTime.substring(13,19);
			
			var approverAccount = $("#approverAccount").val();
			var getdataPacket = new AJAXPacket("remoteStaticAuth.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("beginTime",beginTime);
			getdataPacket.data.add("endTime",endTime);
			getdataPacket.data.add("staticCode",staticCode);
			getdataPacket.data.add("approverAccount",approverAccount);
			getdataPacket.data.add("account","<%=accountVal%>");
			getdataPacket.data.add("sensitiveData","<%=sensitiveData%>");
			getdataPacket.data.add("sensitiveOperate","<%=sensitiveOperate%>");
			getdataPacket.data.add("appSessionId","<%=appSessionId%>");
			getdataPacket.data.add("sceneId","<%=sceneId%>");
			getdataPacket.data.add("serviceUrl","<%=serviceUrl%>");
			getdataPacket.data.add("appId","<%=appId%>");
			core.ajax.sendPacket(getdataPacket,doRemoteStaticAuth);
			getdataPacket = null;
		}
		function doRemoteStaticAuth(packet){
			var resultqq = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			//alert("rust ls "+resultqq);
			if(resultqq == "1"){
				/**���óɹ� */
			
				window.returnValue = "Y";
				
				window.close();
				//alert("test now is "); 
			}else if(resultqq == "0"){
				/**����ʧ�� */
					/**add by zhangyta at 2012-08-13 ��֤������������ Begin*/
				//alert("22222222");
				var Num = document.treasutyForm.testCountStatic.value;
				var Num1 = parseInt(Num) + 1;
		    document.getElementById("testCountStatic").value =Num1;				
				var Num2 = 2 - parseInt(Num);
			  rdShowMessageDialog("У��ʧ�ܣ�ʧ��ԭ��" + resultDesc +",���Ѿ�����"+Num1+"�Σ�����3�ν��Զ��˳���ǰҳ�棬��ʣ��"+Num2+"�Ρ�");
			  var Num1 = parseInt(Num) + 1;
			  document.getElementById("testCountStatic").value =Num1;
			  if(Num2 == 0){
			    doCancel();
			  }
				/**add by zhangyta at 2012-08-13 ��֤������������ End*/  	
			}else{
				rdShowMessageDialog("У��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
			}
		}
	</script>
	<body>
		<FORM name="treasutyForm" action="" method=post>
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
			<div id="title_zi">�����֤����</div>
		</div>
		<div id="firstStep">
			<table cellspacing="0">
				<tr>
					<td class='blue'>���ʷ�ʽ</td>
					<td>
						<!--input type="text" name="policyAccessMethod" id="policyAccessMethod" 
						 value="<%=policyAccessMethodVal%>" readonly="readOnly" class="InputGrey" />
						<input type="hidden" name="policyAccessMethodHide" id="policyAccessMethodHide" 
						 value="<%=policyAccessMethod%>"/-->
						 
						 <select id="policyAccessMethod" name="policyAccessMethod" >
						<%
							if(policyAccessMethodResult != null&&policyAccessMethodValResult!=null){
								for(int i = 0; i < policyAccessMethodResult.size(); i++){
						%>
							<option value="<%=policyAccessMethodResult.get(i)%>"><%=policyAccessMethodValResult.get(i)%></option>
						<%
								}
							}
						%>
						</select>
						
					</td>
				</tr>
				<tr>
					<td class='blue'>������</td>
					<td>
						<input type="text" name="workNo" id="workNo" 
						 value="<%=workNo%>" readonly="readOnly" class="InputGrey" />
					</td>
				</tr>
				<tr>
					<td class='blue'>��ʼʱ��</td>
					<td>
						<input type="text" name="beginTime" id="beginTime" value="<%=currTime %>" 
							readonly="readOnly" class="InputGrey" />
						<font class="orange">*</font>
					</td>
				</tr>
				
				<tr>
					<td class='blue'>��ֹʱ��</td>
					<td>
						<input type="text" name="endTime" id="endTime" readonly="readOnly" v_must="1"   
						 onClick="WdatePicker({startDate:'%y-%M-%d %H',dateFmt:'yyyy-MM-dd HH',minDate:'%y-%M-%d %H',maxDate:'%y-%M-%d {%H+<%=maxtimeFlag %>}',readOnly:true,alwaysUseStartDate:true})"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td class='blue'>������</td>
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
				<tr>
					<td class='blue'>����ԭ��</td>
					<td>
						<textarea name="cerReason" id="cerReason" rows="3" cols="40" v_must="1"></textarea>
						<font class="orange">*</font>
						&nbsp;(���50��)
					</td>
				</tr>
			</table>
			<table cellSpacing=0  align="center">
				<tr id="footer"  align="center">
					<td align="center"> 
						<input class="b_foot" id="cfmBtn" type="button" value="��һ��" onclick="nextStep()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="ȡ��" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<div id="secondStep" style="display:none;">
			<table cellSpacing="0">
				<tr>
					<td class='blue'>�����붯̬����</td>
					<td>
						<input type="text" name="dynamicCode" id="dynamicCode" 
						v_must="1" v_type="0_9" maxlength="6" onblur="checkElement(this)" />
						<font class="orange">*</font>
					</td>
					<td><input type="hidden" name ="testCount" id ="testCount" value =<%=Num%> /></td>
				</tr>
				<tr id="footer"  align="center">
					<td align="center" colspan="2"> 
						<input class="b_foot" id="cfmBtn" type="button" value="ȷ��" onclick="doCfm()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="ȡ��" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<div id="staticStep" style="display:none;">
			<table cellSpacing="0">
				<tr>
					<td class='blue'>�����뾲̬����</td>
					<td>
						<input type="password" name="staticCode" id="staticCode" 
						v_must="1" v_type="0_9" maxlength="32"  />
						<font class="orange">*</font>
					</td>
					<td><input type="hidden" name ="testCountStatic" id ="testCountStatic" value =<%=Num%> /></td>
				</tr>
				<tr id="footer"  align="center">
					<td align="center" colspan="2"> 
						<input class="b_foot" id="cfmBtn" type="button" value="ȷ��" onclick="doStaticCfm()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="ȡ��" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
		</FORM>
	</body>
	<%
				}else{
					/* ���迪�������أ��������� */
	%>
					<script language="javascript">
							window.returnValue = "Y";
							window.close();
					</script>
	<%
				}
		}catch(Exception e){
			System.out.println("ningtn eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
			e.printStackTrace();
			%>
			<table cellSpacing="0" width="100%">
				<tr style="height:200px;">
					<td align="center">
						<font color="red">����Զ�̷�����ʧ��</font>
					</td>
				</tr>
				<tr id="footer">
					<td align="center">
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
		rdShowMessageDialog("<%=retCode%> : <%=retMsg%>");
		window.returnValue = "N";
		window.close();
	</script>
<%
	}
%>