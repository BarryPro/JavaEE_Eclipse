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
	/** 判断4A总开关，当开关为开时，调用4A。当开关为关时，允许继续操作 
	*		0和没数据是关 ， 1是开
	**/
	int switchFlag = 0;
	int switchFlag1 = 0;
	String getSwitchFlag = " SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter " + 
													" WHERE LOGIN_NO = 'switch' and op_code = 'e269'";
	
 String getSwitchFlag2 = " SELECT TO_NUMBER(FLAG_SWITCH)  FROM SSYSTEMPARAMETER t "  +
													" WHERE LOGIN_NO = 'switch' AND OP_CODE = 'e768'";			
%>
<%!
private static HashMap cfgMap = new HashMap(200);//缓存话单格式
    private static String DETAIL_PATH = "";
    static {
        //从公共配置文件中读取配置信息，此信息被多sever共享
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        //如果不以"/"格式结束,加上"/"
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
		/** 测试使用，怕影响别人 */
		/*switchFlag = 1;
		switchFlag1 = 1;*/
		
		if(switchFlag != 1){
			/* 总开关为关，返回，允许继续操作 */
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
				
				/* 操作时间 requestTime节点 */
				String currTime = new SimpleDateFormat(("yyyy-MM-dd HH:mm:ss"), Locale.getDefault()).format(new Date());
				/* currTime = "2012-10-13 12:05:00";*/
				/* 资源类型应用 resType */
				String resTypeVal = "app";
				/* token */
				String token4a = (String)session.getAttribute("token4a");
				/* 测试使用，生产得删了 */
				/*token4a = "c8c94fcca2fb469aa7543d40773558a4@aaiiAb@8aeeef50362f690a01362f882d7b0005@bocoadmin";*/
				/* 4A主账号 account */
				String accountVal = "";
				/* 测试用，生产删掉 zhangyta at 20120824*/
				/*String accountVal = "zhangyingtan";*/
				String[] tokenArr = new String[]{""};
				tokenArr = token4a.split("@");
				if(tokenArr.length == 4||tokenArr.length == 5){
					accountVal = tokenArr[3];
				}
				/* BOSS当前账号 subAccount*/
				String workNo = (String)session.getAttribute("workNo");
				
				/* 测试用场景名称，上线删掉 by zhangyta at 20120824*/
				/*sceneName = "CRM_前台无密码查询客户详单";*/
				/* 金库会话SESSIONID appSessionId */
				String appSessionIdFlag = "";
				String appSessionId = "";
				appSessionId = getRandomNum("allChar",32);
				/* 获取敏感数据和敏感操作 */
				String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
				/* 敏感数据 */
				String sensitiveData = readValue("treasury",opCode,"sensitiveData",readPath);
				/* 敏感操作 */
				String sensitiveOperate = readValue("treasury",opCode,"sensitiveOperate",readPath);
				String serviceUrl = readValue("treasury",opCode,"serviceUrl",readPath);
				/* 资源ID */
				String appId = readValue("treasury",opCode,"appId",readPath);
				/* 资源名称 */
				String appName = readValue("treasury",opCode,"appName",readPath);
				/* 场景ID sceneId */
				String sceneId = readValue("treasury",opCode,"sceneId",readPath);
				/* 测试用场景ID，上线删掉 by zhangyta at 20120824*/
				/*sceneId = "ff808081395641c901395641c9220000";*/
				/* 场景名称 sceneName */
				String sceneName = readValue("treasury",opCode,"sceneName",readPath);
				
				/* 套用xml模板 */
				String postXmlUrl = request.getRealPath("npage/xmltemplet")+"/getTreasuryStatusTemplet.xml";
				Document document = CreateXMLDocument(postXmlUrl, "file");
				/* 换值 */
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
				/* 转化成xml报文 */
				String xmlStr = doc2String(document);
				System.out.println("client4A " + xmlStr);
				/* base64加密 */
				xmlStr = encode(xmlStr);
				System.out.println("client4A mmmm [" +xmlStr + "]");
				
				/* 远程调用4A 金库场景状态查询接口 */
				String url = serviceUrl;
				String method = "getTreasuryStatus";
				String localPart = "SoapTreasury4A";
				
				/* 调用 & 获取返回报文 */	
				String returnStr = getTreasuryStatus(url, method, localPart, xmlStr);
				System.out.println("client4A firstauth returnStr==[" + returnStr + "]");
				/* 解密 */
				String returnXmlStr = decode(returnStr);
				System.out.println("client4A returnXmlStr==[" + returnXmlStr + "]");
				
				/* 转化成xml对象 */
				Document resultDocument = CreateXMLDocument(returnXmlStr, "str");
				/* 是否开启 正常：1  应急：0已授权：2 未知：3 */
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
				
				/**取maxtime为最大截止日期 add by zhangyta at 20120824*/
				List maxtimeResult =  getElementText(resultDocument,"maxTime");
				String maxtimeFlag = "";
				if(maxtimeResult != null && maxtimeResult.size() > 0){
					maxtimeFlag = (String)maxtimeResult.get(0);
				}
					
				System.out.println("zhangyta maxtimeFlag =  " + maxtimeFlag);
				

				
				
				if("1".equals(treasuryStatusFlag)){
					/*开启，取列表信息*/
					/* 授权方式：已经与BOSS约定为远程授权方式，可以不解析 */
					String policyAuthMethodVal = "远程授权";
					/* 访问方式 */
					String policyAccessMethod = "";
					String policyAccessMethodVal = "";
					List policyAccessMethodResult =  getElementText(resultDocument,"policyAccessMethod");
					/*if(policyAccessMethodResult != null && policyAccessMethodResult.size() > 0){
						policyAccessMethod = (String)policyAccessMethodResult.get(0);
					}
					
					if(policyAccessMethod.indexOf("authent_type_static") != -1){
						policyAccessMethodVal = "主帐号密码";
					}else if(policyAccessMethod.indexOf("authent_type_sms") != -1){
						policyAccessMethodVal = "动态口令（短信）";
					}else if(policyAccessMethod.indexOf("authent_type_flow") != -1){
						policyAccessMethodVal = "工单匹配";
					}else if(policyAccessMethod.indexOf("authent_type_rsa") != -1){
						policyAccessMethodVal = "动态令牌";
					}else if(policyAccessMethod.indexOf("authent_type_ca") != -1){
						policyAccessMethodVal = "证书";
					}else if(policyAccessMethod.indexOf("authent_type_fingerprint") != -1){
						policyAccessMethodVal = "指纹";
					} */
					List policyAccessMethodValResult= new ArrayList();
					if(policyAccessMethodResult != null && policyAccessMethodResult.size() > 0){
						for(int i=0;i< policyAccessMethodResult.size();i++){
							policyAccessMethod = (String)policyAccessMethodResult.get(i);
							if(policyAccessMethod.indexOf("authent_type_static") != -1){
								policyAccessMethodVal = "主帐号密码";
							}else if(policyAccessMethod.indexOf("authent_type_sms") != -1){
								policyAccessMethodVal = "动态口令（短信）";
							}else if(policyAccessMethod.indexOf("authent_type_flow") != -1){
								policyAccessMethodVal = "工单匹配";
							}else if(policyAccessMethod.indexOf("authent_type_rsa") != -1){
								policyAccessMethodVal = "动态令牌";
							}else if(policyAccessMethod.indexOf("authent_type_ca") != -1){
								policyAccessMethodVal = "证书";
							}else if(policyAccessMethod.indexOf("authent_type_fingerprint") != -1){
								policyAccessMethodVal = "指纹";
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
				/**调用成功 */
				return true;
			}else{
				/**调用失败 */
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
				return false;
			}
		}
	function nextStep(){
			var methodType = document.treasutyForm.policyAccessMethod.value;
			//alert(methodType);
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			if(endTime.trim() == ""){
				rdShowMessageDialog("请选择截止时间");
				return false;
			}
			endTime = endTime + beginTime.substring(13,19);		
			var cerReason = $("#cerReason").val();
			if(cerReason.trim().length == 0){
				rdShowMessageDialog("请输入申请原因");
				return false;
			}
			if(cerReason.length > 50){
				rdShowMessageDialog("申请原因最多允许输入50字，请修改");
				return false;
			}	
			if(methodType.indexOf("authent_type_static") != -1){
				$("#firstStep").hide();
				$("#staticStep").show();	
			}	
			else{
			var approverAccount = $("#approverAccount").val();
			var getdataPacket = new AJAXPacket("remoteFirstAuth.jsp","正在获得数据，请稍候......");
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
				/**调用成功 */
				$("#firstStep").hide();
				$("#secondStep").show();
			}else{
				/**调用失败 */
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
				window.returnValue = "N";
				window.close();
			}
		}
		function doCfm(){
			var dynamicCode = $("#dynamicCode").val();
			if(dynamicCode.trim() == ""){
				rdShowMessageDialog("请输入验证码");
				return false;
			}
			if(!checkElement($("#dynamicCode")[0])){
				rdShowMessageDialog("验证码为六位数字");
				return false;
			}
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			endTime = endTime + beginTime.substring(13,19);
			
			var approverAccount = $("#approverAccount").val();
			var getdataPacket = new AJAXPacket("remoteSecondAuth.jsp","正在获得数据，请稍候......");
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
		/**add by zhangyta at 2012-08-13 验证码错误次数限制 Begin */
		<%
        Object o = null;
        String strNum = (String) session.getAttribute("Num"); //与session相同
        int Num = 0;
        if (strNum != null)
          Num = Integer.parseInt(strNum);
        session.setAttribute("Num", String.valueOf(Num));
      %>
    /**add by zhangyta at 2012-08-13 验证码错误次数限制 End */
		
		function doRemoteSecondAuth(packet){
			var resultqq = packet.data.findValueByName("result");
			var resultDesc = packet.data.findValueByName("resultDesc");
			//alert("rust ls "+resultqq);
			if(resultqq == "1"){
				/**调用成功 */
			
				window.returnValue = "Y";
				
				window.close();
				//alert("test now is "); 
			}else{
				/**调用失败 */
					/**add by zhangyta at 2012-08-13 验证码错误次数限制 Begin*/
				//alert("22222222");
				var Num = document.treasutyForm.testCount.value;
				var Num1 = parseInt(Num) + 1;
		          document.getElementById("testCount").value =Num1;
				 if(resultDesc == "短信码认证码错误，请重新输入"){
				  			var Num2 = 2 - parseInt(Num);
			          rdShowMessageDialog("校验失败，失败原因：" + resultDesc +",您已经错误"+Num1+"次，错误3次将自动退出当前页面，还剩余"+Num2+"次。");
			          
			          var Num1 = parseInt(Num) + 1;
			          document.getElementById("testCount").value =Num1;
			          if(Num2 == 0){
			          	doCancel();
			          	}
				/**add by zhangyta at 2012-08-13 验证码错误次数限制 End*/  
				
				
				
				}else{
					rdShowMessageDialog("校验失败，失败原因：" + resultDesc);
					}
			}
		}
		function doCancel(){
			var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","正在获得数据，请稍候......");
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
		
// huangqi addd 添加金库验证模式：静态密码验证：
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
				rdShowMessageDialog("请输入静态密码！");
				return false;
			}
			var beginTime = "<%=currTime%>";
			var endTime = $("#endTime").val();
			endTime = endTime + beginTime.substring(13,19);
			
			var approverAccount = $("#approverAccount").val();
			var getdataPacket = new AJAXPacket("remoteStaticAuth.jsp","正在获得数据，请稍候......");
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
				/**调用成功 */
			
				window.returnValue = "Y";
				
				window.close();
				//alert("test now is "); 
			}else if(resultqq == "0"){
				/**调用失败 */
					/**add by zhangyta at 2012-08-13 验证码错误次数限制 Begin*/
				//alert("22222222");
				var Num = document.treasutyForm.testCountStatic.value;
				var Num1 = parseInt(Num) + 1;
		    document.getElementById("testCountStatic").value =Num1;				
				var Num2 = 2 - parseInt(Num);
			  rdShowMessageDialog("校验失败，失败原因：" + resultDesc +",您已经错误"+Num1+"次，错误3次将自动退出当前页面，还剩余"+Num2+"次。");
			  var Num1 = parseInt(Num) + 1;
			  document.getElementById("testCountStatic").value =Num1;
			  if(Num2 == 0){
			    doCancel();
			  }
				/**add by zhangyta at 2012-08-13 验证码错误次数限制 End*/  	
			}else{
				rdShowMessageDialog("校验失败，失败原因：" + resultDesc);
			}
		}
	</script>
	<body>
		<FORM name="treasutyForm" action="" method=post>
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
			<div id="title_zi">金库认证请求</div>
		</div>
		<div id="firstStep">
			<table cellspacing="0">
				<tr>
					<td class='blue'>访问方式</td>
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
					<td class='blue'>申请人</td>
					<td>
						<input type="text" name="workNo" id="workNo" 
						 value="<%=workNo%>" readonly="readOnly" class="InputGrey" />
					</td>
				</tr>
				<tr>
					<td class='blue'>开始时间</td>
					<td>
						<input type="text" name="beginTime" id="beginTime" value="<%=currTime %>" 
							readonly="readOnly" class="InputGrey" />
						<font class="orange">*</font>
					</td>
				</tr>
				
				<tr>
					<td class='blue'>截止时间</td>
					<td>
						<input type="text" name="endTime" id="endTime" readonly="readOnly" v_must="1"   
						 onClick="WdatePicker({startDate:'%y-%M-%d %H',dateFmt:'yyyy-MM-dd HH',minDate:'%y-%M-%d %H',maxDate:'%y-%M-%d {%H+<%=maxtimeFlag %>}',readOnly:true,alwaysUseStartDate:true})"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td class='blue'>审批人</td>
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
					<td class='blue'>申请原因</td>
					<td>
						<textarea name="cerReason" id="cerReason" rows="3" cols="40" v_must="1"></textarea>
						<font class="orange">*</font>
						&nbsp;(最多50字)
					</td>
				</tr>
			</table>
			<table cellSpacing=0  align="center">
				<tr id="footer"  align="center">
					<td align="center"> 
						<input class="b_foot" id="cfmBtn" type="button" value="下一步" onclick="nextStep()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="取消" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<div id="secondStep" style="display:none;">
			<table cellSpacing="0">
				<tr>
					<td class='blue'>请输入动态短信</td>
					<td>
						<input type="text" name="dynamicCode" id="dynamicCode" 
						v_must="1" v_type="0_9" maxlength="6" onblur="checkElement(this)" />
						<font class="orange">*</font>
					</td>
					<td><input type="hidden" name ="testCount" id ="testCount" value =<%=Num%> /></td>
				</tr>
				<tr id="footer"  align="center">
					<td align="center" colspan="2"> 
						<input class="b_foot" id="cfmBtn" type="button" value="确定" onclick="doCfm()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="取消" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<div id="staticStep" style="display:none;">
			<table cellSpacing="0">
				<tr>
					<td class='blue'>请输入静态密码</td>
					<td>
						<input type="password" name="staticCode" id="staticCode" 
						v_must="1" v_type="0_9" maxlength="32"  />
						<font class="orange">*</font>
					</td>
					<td><input type="hidden" name ="testCountStatic" id ="testCountStatic" value =<%=Num%> /></td>
				</tr>
				<tr id="footer"  align="center">
					<td align="center" colspan="2"> 
						<input class="b_foot" id="cfmBtn" type="button" value="确定" onclick="doStaticCfm()"/>
						&nbsp;
						<input class="b_foot" id="cancelBtn" type="button" value="取消" onclick="doCancel()" />
					</td>
				</tr>
			</table>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp"%>
		</FORM>
	</body>
	<%
				}else{
					/* 无需开启，返回，继续办理 */
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
						<font color="red">调用远程服务器失败</font>
					</td>
				</tr>
				<tr id="footer">
					<td align="center">
						<input type="button" class="b_foot" name="errorBtn" id="errorBtn" 
			 				value="关闭" onclick="window.close();" />
					</td>
				</tr>
			</table>
			<br/>
			<%
		}
		}
	}else{
		/* 查询失败了，得报错 */
%>
	<script language="javascript">
		rdShowMessageDialog("<%=retCode%> : <%=retMsg%>");
		window.returnValue = "N";
		window.close();
	</script>
<%
	}
%>