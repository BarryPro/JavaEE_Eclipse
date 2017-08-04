<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%	
	String reginCode = (String) session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password =(String)session.getAttribute("password");
	String phoneNo = request.getParameter("svcNum");
	String id_no = request.getParameter("id_no");
	String brandId = request.getParameter("brandId");
	String actType = request.getParameter("act_type").trim();
	String mode_code =request.getParameter("mode_code").trim();
	String powerRight=request.getParameter("powerRight").trim();//用户权限
	String belong_code=request.getParameter("belong_code").trim();//用户归属
	String meansId = request.getParameter("meansId");
	String orderId = request.getParameter("orderId");
	String resourceMoney = request.getParameter("resourceMoney");
	String selectMeansId = request.getParameter("selectMeansId");
	System.out.println("selectMeansId========================="+selectMeansId);
	
	//add zhangxy 20161222
	String actId = request.getParameter("actId");
	
	System.out.println("reginCode========================="+reginCode);
	System.out.println("loginNo========================="+loginNo);
	System.out.println("password========================="+password);
	System.out.println("phoneNo========================="+phoneNo);
	System.out.println("id_no========================="+id_no);
	System.out.println("brandId========================="+brandId);
	System.out.println("actType========================="+actType);
	System.out.println("mode_code========================="+mode_code);
	System.out.println("powerRight========================="+powerRight);
	System.out.println("belong_code========================="+belong_code);
	System.out.println("meansId========================="+meansId);
	System.out.println("orderId========================="+orderId);
	System.out.println("resourceMoney合约价========================="+resourceMoney);
	System.out.println("actId=============================="+actId);
	
	/**
	   getMemberData.jsp中sQryBroadInfoWS_XML 服务的入参：oper_type,默认为0，如果是魔百和SP业务，则oper_type=2
	*/
	String xml = request.getParameter("templet");
	System.out.println("xml=========================\n"+xml);
	MapBean mb = new MapBean();	
%>
<%@ include file="getMapBean.jsp"%>
<%
	String templetName = "";
	String templetId = "";
	String  TEMPLET_TYPE = "0";
	if(null!= mb){
		templetName = mb.getString("OUT_DATA.H54.TEMPLET_NAME");
		templetId = mb.getString("OUT_DATA.H54.TEMPLET_ID");
		TEMPLET_TYPE = mb.getString("OUT_DATA.H54.TEMPLET_TYPE");
		System.out.println("_________H54________templetName:" + templetName+"-----templetId:"+templetId+"----------TEMPLET_TYPE:"+TEMPLET_TYPE);
	}
	
%>
<html>
	<head>
	<title></title>
	<!-- add 20161207 zhangxy 添加alert,输出传入到界面的参数 -->	
	<script>
		 //alert("zhangxy templetInfo.jsp xml(templet xml):"+"<%= xml %>");
		var paramStr = "reginCode:"+"<%=reginCode%>"+"、loginNo:"+"<%=loginNo%>"+"、password:"+"<%=password%>"+"、phoneNo:"+
		"<%=phoneNo%>"+"、id_no:"+"<%=id_no%>"+"、brandId:"+"<%=brandId%>"+"、actType:"+"<%=actType%>"+"、mode_code:"+
		"<%=mode_code%>"+"、powerRight:"+"<%=powerRight%>"+"、belong_code:"+"<%=belong_code%>"+"、meansId:"+"<%=meansId%>"+"、orderId:"+"<%=orderId%>"+"、resourceMoney:"+"<%=resourceMoney%>";
		//alert("paramStr:"+paramStr);
	</script>
	</head>
	<body>
		<div id="operation">
		  <div id="operation_table">
			<div class="title">
				<div class = "text" >
					查询条件
				</div>
			</div>
			<div class="input" id="member_list_fixed">
				<table id='table_member'>
					<tr>
						<th>请选择合约期</th>
						<td>
							<select id="consumeTime" name="consumeTime" onchange="getAssfeeCodeValue();">
							</select>
						</td>
						<th>请选择资费</th>
						<td>
							<select id="assifeeCode" name="assifeeCode"  style= "width:90%" onchange="getTempletDetail();">
							</select>
						</td>
					</tr>
					<input type="hidden" name="kx_code_bunch" id = "kx_code_bunch"/>
					<input type="hidden" name="kx_name_bunch" id = "kx_name_bunch"/>
					<input type="hidden" name="kx_habitus_bunch" id = "kx_habitus_bunch"/>
					<input type="hidden" name="kx_operation_bunch" id = "kx_operation_bunch"/>
					<input type="hidden" name="kx_stream_bunch" id = "kx_stream_bunch"/>
					<input type="hidden" name="kx_begintime_bunch" id = "kx_begintime_bunch"/>
					<input type="hidden" name="kx_endtime_bunch" id = "kx_endtime_bunch"/>
				</table>
			</div>
		  </div>
		</div>
		<div id="order_info" style="display:none">
			<div id="operation_table">
				<div class="title">
					<div class = "text">
						模板详细信息
					</div>
				</div>
				<div class="input" id="order_html">
				</div>
			</div>
		</div>
		<div id="operation_button">
			<input type="button" class="b_foot" value="确定" id="btnSubmit"  disabled="disabled"
						 name="btnSubmit" onclick="submitAll()" />
			<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
		</div>
	</body>
	<script type="text/javascript">
	
	var gGiftCode = "";
	var gFlag = "";
	
		//--------------------------页面加载-------------------------------------
		/**quyl add 20151230
		根据regioncode和模板id调用方法获取合约期限
		*/
		$(document).ready(function(){
			var myPacket = new AJAXPacket("getTempletDetail.jsp","请稍后...");
			myPacket.data.add("TEMPLET_ID","<%=templetId%>");
			myPacket.data.add("REGIN_CODE","<%=reginCode%>");
			myPacket.data.add("selectMeansId","<%=selectMeansId%>");
			myPacket.data.add("orderId","<%=orderId%>");
			myPacket.data.add("QUERY_TYPE","1");
			core.ajax.sendPacket(myPacket,doConsumeTimeCat);
			myPacket =null;
		});
	
		function doConsumeTimeCat(packet){
			var html = packet.data.findValueByName("html");
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			if(RETURN_CODE!=0){
				showDialog(RETURN_MSG+",页面过期，请重新登录！！",0);
				return false;		
			}
			$("#consumeTime").html(html);
		}

		//获取资费名称和code
		function getAssfeeCodeValue(){
			var consumeTime = $("#consumeTime").val();
			if(consumeTime == "0"){
				$("#assifeeCode").html("");
				$("#order_info").css("display","none");
				$("#order_html").html("");
				resetParams();
			}else{
				var myPacket = new AJAXPacket("getTempletDetail.jsp","请稍后...");
				myPacket.data.add("TEMPLET_ID","<%=templetId%>");
				myPacket.data.add("REGIN_CODE","<%=reginCode%>");
				myPacket.data.add("CONSUME_TIME",consumeTime);
				myPacket.data.add("selectMeansId","<%=selectMeansId%>");
				myPacket.data.add("orderId","<%=orderId%>");
				myPacket.data.add("QUERY_TYPE","2");
				core.ajax.sendPacket(myPacket,doAssfeeCodeCat);
				myPacket =null;
			}
		}
		
		function doAssfeeCodeCat(packet){
			var html = packet.data.findValueByName("html");
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			if(RETURN_CODE!=0){
				showDialog(RETURN_MSG,0);
				return false;		
			}
			$("#assifeeCode").html(html);
		}
		//获取模板策划信息
		function getTempletDetail(){
			var tmContentId = $("#assifeeCode").val();
			//alert("zhangxy tmContentId:"+tmContentId);
			if(tmContentId == "0"){
				$("#order_info").css("display","none");
				$("#order_html").html("");
				resetParams();
			}else{
				//alert("zhangxy getTempletDetail.jsp服务:ASSIFEE_CODE："+tmContentId+" PHONE_NO:"+"<%=phoneNo%>"+" ACT_ID:"+"<%=actId%>");

				var myPacket = new AJAXPacket("getTempletDetail.jsp","请稍后...");
				myPacket.data.add("TM_CONTENT_ID",tmContentId);
				myPacket.data.add("QUERY_TYPE","3");
				//add zhangxy 20161222  订购营销活动时，对营销内容模板选中的档位进行一体化自费校验
				myPacket.data.add("ASSIFEE_CODE", tmContentId);
				myPacket.data.add("PHONE_NO", "<%=phoneNo%>");
				myPacket.data.add("ACT_ID", "<%=actId%>");
				myPacket.data.add("REGIN_CODE","<%=reginCode%>");
				myPacket.data.add("TEMPLET_TYPE", "<%=TEMPLET_TYPE%>");
				core.ajax.sendPacket(myPacket,doTempletDetail);
				myPacket =null;
			}
		}
		//根据模板配置信息生成详细信息页面
		function doTempletDetail(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var meansjsonstr = packet.data.findValueByName("meansjsonstr");
			var flag = packet.data.findValueByName("flag");
			var specialfunds = packet.data.findValueByName("specialfunds");
			var systempay = packet.data.findValueByName("systempay");
			var ssfeeinfo = packet.data.findValueByName("ssfeeinfo");
			var assifeeinfo = packet.data.findValueByName("assifeeinfo");
			var scoreinfo = packet.data.findValueByName("scoreinfo");
			//add zhangxy20170505 for 关于终端类营销活动承载数据业务及优化营销管理平台BOSS侧配置选项的函
			var spInfo = packet.data.findValueByName("spInfo");

			if(RETURN_CODE!=0){
				showDialog(RETURN_MSG,0);
				return false;		
			}
			var money = parent.document.getElementById("pay_moneycouldhid").value;
			var myPacket = new AJAXPacket("templetOrderInfo.jsp","请稍后...");
			myPacket.data.add("meansjsonstr",meansjsonstr);
			myPacket.data.add("flag",flag);
			myPacket.data.add("specialfunds",specialfunds);
			myPacket.data.add("systempay",systempay);
			myPacket.data.add("ssfeeinfo",ssfeeinfo);
			myPacket.data.add("assifeeinfo",assifeeinfo);
			myPacket.data.add("scoreinfo",scoreinfo);
			
			//add zhangxy20170505 for 关于终端类营销活动承载数据业务及优化营销管理平台BOSS侧配置选项的函
			myPacket.data.add("spInfo",spInfo);

			myPacket.data.add("selectMeansId","<%=selectMeansId%>");
			myPacket.data.add("TEMPLET_TYPE","<%=TEMPLET_TYPE%>");
			myPacket.data.add("money",money);
			myPacket.data.add("actType","<%=actType%>");
			core.ajax.sendPacketHtml(myPacket,doTempletOrderInfo,true);
			myPacket =null;
		}
		
		function doTempletOrderInfo(renderHtml){
			$("#order_info").css("display","block");
			$("#order_html").html(renderHtml);
			var feeNum = $("#feeNum").val();
			if(feeNum<0){
				$("#btnSubmit").attr("disabled", "");
			}
		}
	
		function getExtFeeAjax(feeCode){
			var myPacket = new AJAXPacket("getPriFee.jsp","请稍后...");
			myPacket.data.add("id_no","<%=id_no%>");
			myPacket.data.add("brandId","<%=brandId%>");
			myPacket.data.add("mode_code","<%=mode_code%>");
			myPacket.data.add("powerRight","<%=powerRight%>");
			myPacket.data.add("belong_code","<%=belong_code%>");
			myPacket.data.add("prodPrcId",feeCode);
			myPacket.data.add("actType","<%=actType%>");//117模板小类
			core.ajax.sendPacketHtml(myPacket,doExtFeeDate,true);
			myPacket =null;
		}
		
		function doExtFeeDate(data){
			var idAndName = data.split("~");
			if(trim(idAndName[0])!= '000000'){ 
				 showDialog(trim(idAndName[1]),1);
				 return false;
			}
			document.all("kx_code_bunch").value=trim(idAndName[2]);
			document.all("kx_name_bunch").value=trim(idAndName[3]);
			document.all("kx_habitus_bunch").value=trim(idAndName[4]);
			document.all("kx_operation_bunch").value=trim(idAndName[5]);
			document.all("kx_stream_bunch").value=trim(idAndName[6]);
			document.all("kx_begintime_bunch").value=trim(idAndName[7]);
			document.all("kx_endtime_bunch").value=trim(idAndName[8]);
			$("#btnSubmit").attr("disabled", "");
		}
		
		var gPriFee = "";
		var gPriFeeName = "";
		var gPrintInfo = "";
		var gPriFeeValid = "";
		var effDateStr = "";
		var expDateStr = "";
		var retCode ="";
		var retMsg ="";
		var gFeeCodeStr = "";
		var gFeeDescStr = "";
		var gFeeDescMoney = "";

		function resetParams(){
			gPriFee = "";
			gPriFeeName="";
			gPrintInfo = "";
			gPriFeeValid = "";
			effDateStr = "";
			expDateStr = "";
			retCode = "";
			retMsg = "";
			gFeeCodeStr = "";
			gFeeDescMoney = "";
		}
		
		var checkSmsCode = "";
		var checkSmsMsg = "";
		
		function submitAll(){
			var money = parent.document.getElementById("pay_moneycouldhid").value;
			//alert("4444444444444==="+gGiftCode);
			var chektmContentId = $("#assifeeCode").val();
			if(chektmContentId=="0"){
				showDialog("请选择主资费",0);
				return false;
			}
			if("<%=selectMeansId%>"==""||"<%=selectMeansId%>"==null||"<%=selectMeansId%>"=="null"){

				var hid_feevalue = $("#hid_feevalue_Str").val();

				if(hid_feevalue!=null&&hid_feevalue!=""&&"N/A"!=hid_feevalue){
					if(gGiftCode==null||gGiftCode==""||"N/A"==gGiftCode){
						showDialog("积分兑换码业务请处理兑换码操作",0);
						return false;
					}
				}
			
				if(gGiftCode!=null&&gGiftCode!=""&&"N/A"!=gGiftCode){
					getSmsPush();
					 if(trim(checkSmsCode)!="000000"){
							showDialog(checkSmsMsg,0);
							return false;
					}
				}
		}else{		
			var hid_feevalue = $("#hid_feevalue_Str").val();
			//alert("2gGiftCode"+gGiftCode+" hid_feevalue:"+hid_feevalue);

				if(hid_feevalue!=null&&hid_feevalue!=""&&"N/A"!=hid_feevalue){
						getSmsPush();
					 if(trim(checkSmsCode)!="000000"){
							showDialog(checkSmsMsg,0);
							return false;
					}
				}
		}
			var consumeTime = $("#consumeTime").val();
			var feeNum = $("#feeNum").val();//主资费数量
			var payMoneyStr = $("#hid_fund_payMoneyStr").val();
			if(feeNum > 0){
				if($("#table_fee input:checked").size() == 0){
					showDialog("请选择主资费",1);
					return ;
				}
				gPriFee = $("#table_fee input:checked").val();
				gPriFeeName = $("#hid_feeName_"+gPriFee).val();
				gPriFeeValid = $("#hid_feeValid_"+gPriFee).val();
				var priFeeValidName ="";
				if(gPriFeeValid == "0"){
					priFeeValidName="立即生效";
				}else{
					priFeeValidName="预约生效";
				}
				gPrintInfo += " 办理主资费："+gPriFee+"-"+gPriFeeName+"，生效方式："+priFeeValidName;
				sendPriFeeAjax(); 
				//组装主资费订购报文
				if(retCode != "000000"){
					showDialog(retMsg, 1);
					return ;
				}
				makePriFeeXml();
				multiOffQry(gPriFee);
				if(trim(qryfee_code)!="000000"){
					showDialog("调用服务sMultiOffQryWS_XML获取资费描述失败："+qryfee_msg,0);
					return false;
				}
				if(gFeeCodeStr!="" && gFeeDescStr !=""){
					gPrintInfo+="，套餐描述："+gFeeDescStr+"<br>";
				}
			}
			//add 20161210 zhangxy
			//是否存在附加资费
			if($("#addFeeNum").val()!="0"){
				var addFeeXmlResult = makeAddFeeXml();
				if(!addFeeXmlResult){
					return ;
				}
			}
			
			//组装专款订购报文
			var fundNum = $("#fundNum").val();
<%-- 			if("<%=actType%>"=="140" && fundNum <= 0){
				showDialog("140业务小类模板中必须配置专款元素，否则不能办理!",0);
				return false;
			} --%>
			
			if(fundNum > 0){
				makeFunFeeXml();
			}
			//组装系统充值订购报文
			var sysPayNum = $("#sysPayNum").val();
			if(sysPayNum > 0){
				makeSysFeeXml();
			}
			//组装积分订购报文
			var scoreValue = $("#hid_scorevalue_Str").val();
			
			var payMoneyAll = "0";			
			if(scoreValue>0){
			
				if("<%=actType%>"=="140"&&"<%=TEMPLET_TYPE%>"=="0"){
					payMoneyAll = $("#hid_feevalue_Str").val();
					//alert("zhangxy templetInfo.jsp->payMoneyAll="+payMoneyAll);
					var resFeeTemp = parseFloat("<%=resourceMoney%>")-parseFloat(payMoneyAll);
					/*if(resFeeTemp <= 0){
						showDialog("办理140业务小类，其中购机款=合约价-电子券金额，购机款必须大于0，否则不能办理!",0);
						return false;
					}*/
					//update zhangxy 20161219
					if(resFeeTemp < 0){
						showDialog("办理140业务小类，其中购机款=合约价-电子券金额，购机款必须大于等于0，否则不能办理!",0);
						return false;
					}
					
					//alert("resFeeTemp="+resFeeTemp);
					parent.saveResFee(resFeeTemp);
				}else if("<%=actType%>"=="140"&&"<%=TEMPLET_TYPE%>"=="1"){
					
					var hid_payagenet = $("#hid_payagenet_"+gPriFee).val();//网龄月数
					var hid_resoucemon = $("#hid_resoucemon_"+gPriFee).val();//终端成本 如果有积分电子券 也是积分电子券的钱
					var hid_resfeeagemon = $("#hid_resfeeagemon_"+gPriFee).val();//购机款
					parent.saveResFee(hid_resfeeagemon);
					
					

					
				}else if("<%=actType%>"=="141"){
					showDialog("办理141业务小类，不允许办理带电子券的营销案",0);
					var resFeeTemp = parseFloat("<%=resourceMoney%>")-parseFloat(payMoneyStr);
					if(resFeeTemp < 0){
						showDialog("办理141业务小类，其中购机款必须大于0",0);
						return false;
					}
					
					//alert("resFeeTemp="+resFeeTemp);
					parent.saveResFee(resFeeTemp);
				}
				makeScoreValueXml();
			}else{
				if("<%=actType%>"=="141"){
					var resFeeTemp = parseFloat("<%=resourceMoney%>")-parseFloat(payMoneyStr);
					if(resFeeTemp < 0){
						showDialog("办理141业务小类，其中购机款必须大于0",0);
						return false;
					}
					
					//alert("resFeeTemp="+resFeeTemp);
					parent.saveResFee(resFeeTemp);
				}else if("<%=actType%>"=="140"&&"<%=TEMPLET_TYPE%>"=="1"){

					var hid_payagenet = $("#hid_payagenet_"+gPriFee).val();//网龄月数
					var hid_resoucemon = $("#hid_resoucemon_"+gPriFee).val();//终端成本 如果有积分电子券 也是积分电子券的钱
					var hid_resfeeagemon = $("#hid_resfeeagemon_"+gPriFee).val();//购机款
					parent.saveResFee(hid_resfeeagemon);				
				}else{
					var resFeeTemp = parseFloat("<%=resourceMoney%>");
					parent.saveResFee(resFeeTemp);
				}
			}
			parent.changeContractTime(consumeTime);
			parent.changeResourceUndeadline(consumeTime);
			
			if(fundNum <= 0){
				payMoneyStr="0";
			}

			//应收=总金额+专款-电子券
			//alert(parseFloat(payMoneyStr)+parseFloat(money)-parseFloat(payMoneyAll));
			if("<%=actType%>"=="140"&&"<%=TEMPLET_TYPE%>"=="0"){
				parent.document.getElementById("pay_moneycould").value=parseFloat(payMoneyStr)+parseFloat(money)-parseFloat(payMoneyAll);
			}else if("<%=actType%>"=="140"&&"<%=TEMPLET_TYPE%>"=="1"){
				var hid_resfeeagemons = $("#hid_resfeeagemon_"+gPriFee).val();//购机款
				if(hid_resfeeagemons==null||hid_resfeeagemons==""||hid_resfeeagemons==undefined||hid_resfeeagemons=="null"){
					showDialog("计算程序出现问题请重新选择",0);
					return false;
				}
				parent.document.getElementById("pay_moneycould").value=parseFloat(payMoneyStr)+parseFloat(hid_resfeeagemons);
			}else if("<%=actType%>"=="141"){
				parent.document.getElementById("pay_moneycould").value=parseFloat(money);
			}else{
				parent.document.getElementById("pay_moneycould").value=parseFloat(payMoneyStr)+parseFloat(money);
			}
			parent.document.getElementById("templetDetails<%=meansId%>").innerHTML = gPrintInfo;
			//add zhangxy 20170217 
			makeTempletInfoXml();
			
			var spInfoNum = $("#spInfoNum").val();
			if(spInfoNum>0){
				var spInfoObj = getSpInfoObj();
				
				//调试信息输出
				var bugInfoStr = "";
				for(var k in spInfoObj){
					bugInfoStr += k+":"+spInfoObj[k]+"  "; 
				}
				//alert("bugInfoStr:"+bugInfoStr);

				
				spCheck(spInfoObj);
				//alert("spCheck.result 2:"+spCheck.result);

				if(!spCheck.result){
					return false;
				}
				
				//压入SP元素信息
				parent.SpBusinessfuc("", spInfoObj.spName, spInfoObj.spCode, spInfoObj.spBizCode, spInfoObj.spValidFlag, spInfoObj.spConsumeTime ,spInfoObj.spSystem, ""/* boxIds */,spInfoObj.spType, ""/* netcode */);
				//parent.addSpSystemPay(get_winnings,winning_rates,pay_types,return_moneys,return_months,per_month_moneys,limit_moneys,return_types,return_classs,consume_times,pay_flags,assPhoneNos,sp_systems);	
				parent.sp_Checkfuc();
				parent.BuildSPNetFlag(spInfoObj.netFlag);
				gPrintInfo += printSpInfo(spInfoObj)+"<br/>";
			}
			
			parent.document.getElementById("templetDetails<%=meansId%>").innerHTML = gPrintInfo;
			parent.templet_Checkfuc();
			closeDivWin();
		}
		
		//add zhangxy20170505 for 关于终端类营销活动承载数据业务及优化营销管理平台BOSS侧配置选项的函
		//sp描述信息
		function printSpInfo(spInfoObj){
			var msg = "SP业务信息：SP名称："+spInfoObj.spName+"，SP企业代码:"+spInfoObj.spCode+"，SP业务代码:"+spInfoObj.spBizCode+";";
			return msg;
		}
		
		//获取SP信息
		function getSpInfoObj(){
			var spType = $("#hid_sptype_value_Str").val();
			var spName = $("#hid_spname_value_Str").val();
			var spCode = $("#hid_spcode_value_Str").val();
			var spBizCode= $("#hid_spbiecode_value_Str").val();
			var spSystem = $("#hid_spsystem_value_Str").val();
			var spConsumeTime = $("#hid_spconsumetime_value_Str").val();
			var spValidFlag = $("#hid_spvalidflag_value_Str").val();
			
			var netFlag = "";	//对 netFlag 取值逻辑参见spInfo.jsp
			if(spBizCode=="20830000" && (spCode=="699212"||spCode=="699213")){
				netFlag="Y";
			}
			
			return {
				"spType":spType,
				"spName":spName,
				"spCode":spCode,
				"spBizCode":spBizCode,
				"spSystem":spSystem,
				"spConsumeTime":spConsumeTime,
				"spValidFlag":spValidFlag,
				"netFlag":netFlag
			};
		}
		//校验SP,此校验逻辑参照
		function spCheck(spInfoObj){
			//最终对SP验证的结果
			spCheck.result = false;
			//alert("reginCode:"+"<%=reginCode%>"+" loginNo:"+"<%=loginNo%>"+" password:"+"<%=password%>"+" phoneNo:"+"<%=phoneNo%>"+" orderId:"+"<%=orderId%>");
			//spCode是否重复办理
			var sPacket = new AJAXPacket("getSPContent.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo","<%=phoneNo%>");
			sPacket.data.add("iOprAccept","<%=orderId%>");
			core.ajax.sendPacket(sPacket,function(packet){
				spCheck.result = backGetSPContent(packet, spInfoObj);
				//alert("spCheck.result 1:"+spCheck.result);
				//如果没有重复办理 ,继续调用checkSPContent服务进行另一个逻辑的是否重复办理验证
				if(spCheck.result){
					var sPackets = new AJAXPacket("checkSPContent.jsp","请稍候......");
					sPackets.data.add("iPhoneNo","<%=phoneNo%>");
					sPackets.data.add("iSpCode",spInfoObj.spCode);
					sPackets.data.add("iBizCode",spInfoObj.bizCode);
					sPackets.data.add("actType","<%=actType%>");
					sPackets.data.add("iBoxId",spInfoObj.boxId);
					sPackets.data.add("spType",spInfoObj.spType);
					core.ajax.sendPacket(sPackets,function(packet){
						spCheck.result = backCheckSPContent(packet, spInfoObj);
					});
					sPackets = null;
				}
				
			});
			sPackets = null;

			function backGetSPContent(packet, spInfoObj){
				var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
				var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
				
				if(RETURN_CODE!="000000"){
					showDialog(RETURN_MSG,0);
					return false;
				}
				
				var spIdStr = packet.data.findValueByName("spIdStr");
				//alert("zhangxy getSPContent spIdStr:"+spIdStr);
				var spCode = spInfoObj.spCode;
				if(spIdStr.indexOf(spCode)!=-1){
					showDialog("该用户已存在包年的sp业务，不可以重复办理，请重选！！",0);
	  				return false;
				}
				
				return true;
			}
			
			function backCheckSPContent(packet, spInfoObj){
				var return_code = packet.data.findValueByName("RETURN_CODE");
				var return_msg = packet.data.findValueByName("RETURN_MSG");
				if(return_code!="0"){
					showDialog(return_msg,0);
					return false;
				}
				return true;
			}
		}
		
		//add zhangxy 20170217 组装营销活动模版报文
		function makeTempletInfoXml(){
			var tmContentId = $("#assifeeCode").val();
			parent.buildTempletInfo(tmContentId, "<%=TEMPLET_TYPE%>");
		}
		
		//组装积分订购报文
		function makeScoreValueXml(){
			var scoreValue = $("#hid_scorevalue_Str").val();
			var deductMoney =$("#hid_feevalue_Str").val();
			gPrintInfo += " 赠送积分值："+scoreValue+"<br>";
			parent.buildScoreValueXml(scoreValue,gGiftCode,gFlag,deductMoney);
		}
		
		//组装主资费
		function makePriFeeXml(){
			var kx_code_bunch = $("#kx_code_bunch").val();//退订必绑资费代码
			var kx_name_bunch = $("#kx_name_bunch").val();//退订必绑资费名称
			var kx_habitus_bunch = $("#kx_habitus_bunch").val();//退订必绑资费状态
			var kx_operation_bunch = $("#kx_operation_bunch").val();//退订必绑资费生效
			var kx_stream_bunch = $("#kx_stream_bunch").val();//退订必绑资费原开通流水串
			var kx_begintime_bunch = $("#kx_begintime_bunch").val();//退订必绑资费开始时间
			var kx_endtime_bunch = $("#kx_endtime_bunch").val();//退订必绑资费结束时间
			var kx_begintime = "";
			var kx_endtime = "";
			var kx_habitus_bunchs  = kx_habitus_bunch.substring(0,kx_habitus_bunch.length-1).split("#");
			var kx_begin_times  = kx_begintime_bunch.substring(0,kx_begintime_bunch.length-1).split("#");
			for(var i =0; i<kx_habitus_bunchs.length;i++){
				if(kx_habitus_bunchs[i] == "Y"){
					kx_begintime = kx_begintime + kx_begin_times[i] + "#";
					kx_endtime = kx_endtime + effDateStr + "#";
				}else{
					kx_begintime = kx_begintime + effDateStr + "#";
					kx_endtime = kx_endtime + expDateStr + "#";
				}
			}
		   parent.buildPriFeeXml(gPriFee,gPriFeeName,gPriFeeValid,effDateStr,expDateStr,"","",kx_code_bunch,kx_name_bunch,kx_habitus_bunch,kx_operation_bunch,kx_stream_bunch,kx_begintime,kx_endtime,"","");
		}
		
		//add 20161210 zhangxy 组装附加资费
		function makeAddFeeXml(){
			var result = true;
			//var addFeeCode = $("#table_addFee input[type='radio']:checked").val();
			var addFeeType = $("#addfee_type_id").val(),					//附加资费类型
				addFeeCheckChannel = $("#addfee_check_channel_id").val(),	//是否可以提前退订 
				addFeeValidFalg = $("#addfee_valid_flag_id").val();			//生效方式
				
			var s1 = "",s2="";
			var iPhoneNoStr = "", addFeeCodeStr = "", addFeeNameStr = "", addFeeScoreStr = "", addFeeOffsetTypeStr="", iOfferTypeStr="", 
			iOprTypeStr="", iDateTypeStr="", orderStr = "";//, effDateStr1 = "", expDateStr1 = "";
			var addFeeCodesStr = $("#addfee_codes_str").val();
			var addFeeCodeArray = addFeeCodesStr.split(",");
			for(var i=0,len=addFeeCodeArray.length;i<len;i++){
				var code = addFeeCodeArray[i];
				var addFeeName = $("#addfee_name_"+code).text(), 
					addFeeScore = $("#addfee_score_"+code).text();
				var addFeeOffsetType = $("#addfee_offset_type_"+code).val();
				
				var showMsg = "附加资费：名称："+code+"-"+addFeeName+"，消费期限："+addFeeScore+"个月;";
				gPrintInfo+=showMsg+"<br/>";
				
				iPhoneNoStr = iPhoneNoStr + s1 + "<%=phoneNo%>";
				
				addFeeCodeStr += s1+code;
				addFeeNameStr += s1+addFeeName;
				addFeeScoreStr += s1+addFeeScore;
				addFeeOffsetTypeStr += s1+addFeeOffsetType;
				iOfferTypeStr += s1 + "1";
				//alert("gPriFeeValid:"+gPriFeeValid+" addFeeValidFalg:"+addFeeValidFalg);
				iOprTypeStr += s1 + "1";
				iDateTypeStr += s1 + addFeeValidFalg;
				orderStr += s2+addFeeCheckChannel;
			    s1="#";
			    s2=",";
			}
			//alert("zhangxy templetInfo.jsp iPhoneNoStr:"+iPhoneNoStr+"addFeeCodeStr:"+addFeeCodeStr+" iOprTypeStr:"+iOprTypeStr+" iDateTypeStr:"+iDateTypeStr+" iOfferTypeStr:"+iOfferTypeStr+" addFeeScoreStr:"+addFeeScoreStr+" addFeeOffsetTypeStr:"+addFeeOffsetTypeStr);
			
			var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo","<%=phoneNo%>");
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",iPhoneNoStr);
			sPacket.data.add("iOfferIdStr",addFeeCodeStr);
			sPacket.data.add("iOprTypeStr",iOprTypeStr);
			sPacket.data.add("iDateTypeStr",iDateTypeStr);	 //生效方式sPacket.data.add("iDateTypeStr",iDateTypeStr);
			sPacket.data.add("iOfferTypeStr",iOfferTypeStr); //资费类型
			sPacket.data.add("iOffsetStr",addFeeScoreStr);   //消费期限
			sPacket.data.add("iUnitStr",addFeeOffsetTypeStr);//偏移量类型 或 H1105 -- 偏移单位  --偏移量sPacket.data.add("iUnitStr",iUnitStr);
			sPacket.data.add("meansId","<%=meansId%>");
		
			core.ajax.sendPacket(sPacket,function(packet){
				
				var resunt_code = packet.data.findValueByName("RETURN_CODE");
				var return_msg = packet.data.findValueByName("RETURN_MSG");
				if("000000"!=resunt_code){
					//alert("templetInfo.jsp iPhoneNoStr:"+iPhoneNoStr+"addFeeCodeStr:"+addFeeCodeStr+" iOprTypeStr:"+iOprTypeStr+" iDateTypeStr:"+iDateTypeStr+" iOfferTypeStr:"+iOfferTypeStr+" addFeeScoreStr:"+addFeeScoreStr+" addFeeOffsetTypeStr:"+addFeeOffsetTypeStr);
					showDialog(return_msg,1);
					result = false;
					return result;
				}
				
				var meansId = packet.data.findValueByName("meansId");
				var codes = packet.data.findValueByName("codes");
				var feeNames = packet.data.findValueByName("feeNames");
				var showNames = packet.data.findValueByName("showNames");
				var feeScores = packet.data.findValueByName("feeScores");
				//var orderStr = packet.data.findValueByName("orderStr");
				//orderStr = ((orderStr==null||"null"==orderStr)?"":orderStr);
				var effDateStr = packet.data.findValueByName("effDateStr");
				var expDateStr = packet.data.findValueByName("expDateStr");
				//alert("zhangxy templetInfo.jsp effDateStr:"+effDateStr+" expDateStr:"+expDateStr);
				parent.buildAddFeeXml(addFeeCodeStr, addFeeNameStr, addFeeScoreStr, effDateStr, expDateStr, orderStr, "", "");

			});
			sPacket = null;
			
			return result;
		}
		
		//组装专款
		function makeFunFeeXml(){
			var payTypeStr = $("#hid_fund_payTypeStr").val();
			var payMoneyStr = $("#hid_fund_payMoneyStr").val();
			var validFlagStr = $("#hid_fund_validFlagStr").val();
			var consumeTimeStr = $("#hid_fund_consumeTimeStr").val();
			var allowPayStr = $("#hid_fund_allowPayStr").val();
			var startTimeStr = $("#hid_fund_startTimeStr").val();
			var returnTypeStr = $("#hid_fund_returnTypeStr").val();
			var returnClassStr = $("#hid_fund_returnClassStr").val();
			var paymentTypeStr = $("#hid_fund_paymentTypeStr").val();
			var relativeMonthStr = $("#hid_fund_relativeMonthStr").val();
			//gPrintInfo += " 办理专款："+payTypeStr+"，"+ payMoneyStr + "元，"+consumeTimeStr + "个月<br>";
			if("<%=actType%>"=="140"||"<%=actType%>"=="141"){
				gPrintInfo += " 办理专款：" + payTypeStr;
				gPrintInfo += "，" + payMoneyStr + "元";
				//alert("returnTypeStr="+returnTypeStr);
				if(returnTypeStr=="1"){
					gPrintInfo += "，每月返还金额:" + allowPayStr + "元";
				}
				gPrintInfo +="，" + consumeTimeStr + "个月;<br>";
			}else{
				gPrintInfo += " 办理专款："+payTypeStr+"，"+ payMoneyStr + "元，"+consumeTimeStr + "个月;<br>";
			}
			parent.buildFundFeeXml(payTypeStr,payMoneyStr,validFlagStr,consumeTimeStr,allowPayStr,startTimeStr,returnTypeStr,returnClassStr,paymentTypeStr,relativeMonthStr);
		}
		
		//组装系统充值
		function makeSysFeeXml(){
			var getWinningStr = $("#hid_sysPay_getWinningStr").val();
			var winningRateStr = $("#hid_sysPay_winningRateStr").val();
			var payTypeStr = $("#hid_sysPay_payTypeStr").val();
			var returnMoneyStr = $("#hid_sysPay_returnMoneyStr").val();
			var returnMonthStr = $("#hid_sysPay_returnMonthStr").val();
			var perMonthMoneyStr = $("#hid_sysPay_perMonthMoneyStr").val();
			var limitMoneyStr = $("#hid_sysPay_limitMoneyStr").val();
			var returnTypeStr = $("#hid_sysPay_returnTypeStr").val();
			var returnClassStr = $("#hid_sysPay_returnClassStr").val();
			var consumeTimeStr = $("#hid_sysPay_consumeTimeStr").val();
			var payFlagStr = $("#hid_sysPay_payFlagStr").val();
			var assPhoneNoStr = $("#hid_sysPay_assPhoneNoStr").val();
			var spSystemStr = $("#hid_sysPay_spSystemStr").val();
			var validFlagStr = $("#hid_sysPay_validFlagStr").val();
			
			
			if("<%=actType%>"=="140"||"<%=actType%>"=="141"){
				gPrintInfo += " 办理系统充值：" + payTypeStr;
				gPrintInfo += "，" + returnMoneyStr + "元";
				//alert("returnTypeStr="+returnTypeStr);
				if(returnTypeStr=="1"){
					gPrintInfo += "，每月返还金额:" + perMonthMoneyStr + "元";
				}
				gPrintInfo +="，" + consumeTimeStr + "个月;<br>";
			}else{
				gPrintInfo += " 办理系统充值："+payTypeStr+"，"+ returnMoneyStr + "元，"+consumeTimeStr + "个月;<br>";
			}
			
			parent.addSystemPayData(getWinningStr,winningRateStr,payTypeStr,returnMoneyStr,returnMonthStr,perMonthMoneyStr,limitMoneyStr,returnTypeStr,returnClassStr,consumeTimeStr,payFlagStr,assPhoneNoStr,spSystemStr,validFlagStr);
		}
		
		
		function sendPriFeeAjax(){
			var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo","<%=phoneNo%>");
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr","<%=phoneNo%>");
			sPacket.data.add("iOfferIdStr",gPriFee);
			sPacket.data.add("iOprTypeStr","1");
			sPacket.data.add("iDateTypeStr",gPriFeeValid);	
			sPacket.data.add("iOfferTypeStr","0");
			sPacket.data.add("iOffsetStr","x"); 			
			sPacket.data.add("iUnitStr","x");   			
			sPacket.data.add("meansId","<%=meansId%>");
			
			core.ajax.sendPacket(sPacket,getPriFeeTime);
			sPacket = null;
		}

		
		function getPriFeeTime(packet){
			retCode = packet.data.findValueByName("RETURN_CODE");
			retMsg = packet.data.findValueByName("RETURN_MSG");
	
			effDateStr = packet.data.findValueByName("effDateStr");
			expDateStr = packet.data.findValueByName("expDateStr");
		}
		function sendPriFeeMoneyAjax(gPriFee){
			var myPacket = new AJAXPacket("sendPriFeeMoney.jsp","请稍后...");
			myPacket.data.add("gPriFee",gPriFee);
			core.ajax.sendPacket(myPacket,doFeeCat);
			myPacket = null;
		}
		function doFeeCat(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			gFeeDescMoney = packet.data.findValueByName("prcMoney");
			if(trim(RETURN_CODE)=="000000"){
				if(gFeeDescMoney=="0"||gFeeDescMoney==null||gFeeDescMoney=="N/A"||gFeeDescMoney==""){
					showDialog("该资费未配置资费月租，请联系管理员!",0);
					return false;
				}
				
			}else{
					showDialog("查询资费费用错误"+RETURN_CODE+RETURN_MSG,0);
					return false;
				
			}
			
		}
		function multiOffQry(codes){
			var myPacket = null;
			myPacket = new AJAXPacket("multiOffQry.jsp","请稍后...");
			myPacket.data.add("iLoginAccept","<%=orderId%>");
			myPacket.data.add("iChnSource","01");
			myPacket.data.add("iOpCode","g794");
			myPacket.data.add("iLoginNo","<%=loginNo%>");
			myPacket.data.add("iLoginPwd","<%=password%>");
			myPacket.data.add("iPhoneNo","<%=phoneNo%>");
			myPacket.data.add("iUserPwd","");
			myPacket.data.add("iOfferStr",codes+"#");
			core.ajax.sendPacket(myPacket,setMultiOffer);
			myPacket =null;
		}
		function setMultiOffer(packet){
			qryfee_code = packet.data.findValueByName("RETURN_CODE");
			qryfee_msg = packet.data.findValueByName("RETURN_MSG");
			var feeCodeStr = packet.data.findValueByName("feeCodeStr");
			var feeDescStr = packet.data.findValueByName("feeDescStr");
			/* if(trim(RETURN_CODE)!="000000"){
				showDialog(RETURN_MSG,0);
				return false;
			} */
			gFeeCodeStr = feeCodeStr;
			gFeeDescStr = feeDescStr;
		}
		
		function getGiftType(){
			var gift_type = $("#gift_type").val();
			if(gift_type == "1"){
				$("#hid_gift_code").attr("readonly",false);
			}else{
				$("#hid_gift_code").val("");
				$("#hid_gift_code").attr("readonly",true);
			}
			
		}
		function smsPush(){
			
			var gift_type = $("#gift_type").val();
			var hid_gift_code = $("#hid_gift_code").val();
			var hid_feevalue = $("#hid_feevalue_Str").val();
			if(gift_type == "0"){
				showDialog("请选择是否有码选项",1);
				return ;
			}
			if(gift_type == "1"){//有码
				if(hid_gift_code==""||null==hid_gift_code||"N/A"==hid_gift_code){
					showDialog("有码用户请出入串码",1);
					return ;
				}
			}

			var myPacket = null;
			myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","请稍后...");
			myPacket.data.add("SUM_MONEY",hid_feevalue);
			myPacket.data.add("PHONE_NO","<%=phoneNo%>");
			myPacket.data.add("GIFT_CODE",hid_gift_code);
			myPacket.data.add("OP_FLAG","0");//OP_FLAG操作状标示 0：只下发短信 1：校验执之前是否下发过短信
			myPacket.data.add("MEANS_ID","<%=meansId%>");
			myPacket.data.add("TEMPLET_TYPE","<%=TEMPLET_TYPE%>");
			core.ajax.sendPacket(myPacket,setSmsPush);
			myPacket =null;

		}
		

		function getSmsPush(){
			var myPacket = null;
			myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","请稍后...");
			myPacket.data.add("SUM_MONEY","");
			myPacket.data.add("PHONE_NO","<%=phoneNo%>");
			myPacket.data.add("GIFT_CODE","");
			myPacket.data.add("OP_FLAG","1");//OP_FLAG操作状标示 0：只下发短信 1：校验执之前是否下发过短信
			myPacket.data.add("MEANS_ID","<%=meansId%>");
			myPacket.data.add("selectMeansId","<%=selectMeansId%>");
			core.ajax.sendPacket(myPacket,checkSmsPush);
			myPacket.data.add("TEMPLET_TYPE","<%=TEMPLET_TYPE%>");
			myPacket =null;
		}
		
		function checkSmsPush(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			checkSmsCode = RETURN_CODE;
			checkSmsMsg = RETURN_MSG;
			//alert("<%=selectMeansId%>");
			//alert("gGiftCode======6666="+gGiftCode);
			if("<%=selectMeansId%>"!=null&&"<%=selectMeansId%>"!=""&&"<%=selectMeansId%>"!="null"&&"<%=selectMeansId%>"!="N/A"){
				var GIFTCODE = packet.data.findValueByName("GIFTCODE");
				var FLAG = packet.data.findValueByName("FLAG");
				gGiftCode = GIFTCODE;
				gFlag = FLAG;
			}
			
		}
		
		function setSmsPush(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var GIFTCODE = packet.data.findValueByName("GIFTCODE");
			var FLAG = packet.data.findValueByName("FLAG");
			 if(trim(RETURN_CODE)!="000000"){
				showDialog(RETURN_MSG,0);
				return false;
			}else{
				$("#sms_push").attr("disabled", "disabled");
			} 
			 //alert("setSmsPush() GIFTCODE:"+GIFTCODE);
			gGiftCode = GIFTCODE;
			gFlag = FLAG;
		}
		
		function closeWin(){
			closeDivWin();
		}
		

	</script>
</html>