<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>

<%
	String xml = request.getParameter("agreeFeeInfo");
	String assiFeeInfoXml = request.getParameter("assiFeeInfo");
	String meansId = request.getParameter("meansId").trim();
	String phoneNo = request.getParameter("svcNum").trim();
	String act_type = request.getParameter("act_type").trim();
	String reginCode = request.getParameter("reginCode").trim();
	String loginNo = request.getParameter("loginNo").trim();
	String password = request.getParameter("password").trim();
	String orderId = request.getParameter("orderId").trim();
	String brandId =request.getParameter("brandId").trim();//品牌
	String mode_code =request.getParameter("mode_code").trim();
	String powerRight=request.getParameter("powerRight").trim();//用户权限
	String belong_code=request.getParameter("belong_code").trim();//用户归属
	String id_no= request.getParameter("id_no").trim();//用户ID
	String groupid = (String)session.getAttribute("groupId");
	String contracttime = request.getParameter("contracttime"); //合约期
	String validMode = request.getParameter("validMode"); //合约期
	String selectvalidMode = request.getParameter("selectvalidMode"); //选择的生效方式
	String giftMoney = request.getParameter("giftMoney");
	if(!"".equals(giftMoney)&&null!=giftMoney){
		xml = xml+giftMoney;
	}
	System.out.println("act_type=AAAAAAAAAAAAAAAAAAAAAA====" + act_type);
	System.out.println("=++=======phoneNo=====" + phoneNo);	
	System.out.println("=++=======reginCode=====" + reginCode);	
	System.out.println("===++=====loginNo=====" + loginNo);	
	System.out.println("==++======password=====" + password);	
	System.out.println("=++=======orderId=====" + orderId);	
	System.out.println("=++=======act_type=====" + act_type);	
	
	System.out.println("===++=====brandId=====" + brandId);	
	System.out.println("==++======mode_code=====" + mode_code);	
	System.out.println("=++=======powerRight=====" + powerRight);	
	System.out.println("=++=======belong_code=====" + belong_code);	
	System.out.println("=++=======id_no=====" + id_no);
	System.out.println("agreeFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	System.out.println("=++=======contracttime=====" + contracttime);
	System.out.println("=++=======validMode=====" + validMode);
	System.out.println("=++=======selectvalidMode=====" + selectvalidMode);
	System.out.println("=++=======giftMoney=====" + giftMoney);
	
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List agreeFeeList = null;
    List agreeFeeLists = null;
	Iterator it =null;
	Iterator its =null;
	if(null!= mb){
		agreeFeeList = mb.getList("OUT_DATA.H05");
		if(null!=agreeFeeList)
			it =agreeFeeList.iterator();
	}
	
	if(null!= mb){
		agreeFeeLists = mb.getList("OUT_DATA.H05");
		if(null!=agreeFeeLists)
			its =agreeFeeLists.iterator();
	}
	
	String res_brand_code_c="";
	String res_res_code_c ="";
	String res_contract_type ="";
	
	if(null!=its){
		while(its.hasNext()){
		Map stMap = mb.isMap(its.next());
		if(null==stMap)continue;
		 res_res_code_c = (String)stMap.get("RES_RES_CODE_C") == null ? "" : (String)stMap.get("RES_RES_CODE_C");
		}
	}
		
	String gift_money = "";
	if(null!= mb){
		gift_money = mb.getString("OUT_DATA.H42.DEDUCT_MONEY");
	}
	if("N/A".equals(gift_money)||"".equals(gift_money)||null==gift_money||"null".equals(gift_money)){
		gift_money="0";
	}
	System.out.println("&&&&&&&&&&&&&&&&&&&&&&777777777777777777777"+gift_money);
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							终端详细信息
						</div>
					</div>
					<div class="input">
					<table>
					<%
						if(null!=it){
						while(it.hasNext()){
						Map stMap = mb.isMap(it.next());
						if(null==stMap)continue;
					
						 String res_brand_c = (String)stMap.get("RES_BRAND_C") == null?"":(String)stMap.get("RES_BRAND_C");
						 String res_model_c = (String)stMap.get("RES_MODEL_C") == null ? "" : (String)stMap.get("RES_MODEL_C");
						 String res_cost_price_c = (String)stMap.get("RES_COST_PRICE_C") == null ? "" : (String)stMap.get("RES_COST_PRICE_C");//采购价格
						 String res_contract_price = (String)stMap.get("RES_CONTRACT_PRICE") == null ? "" : (String)stMap.get("RES_CONTRACT_PRICE");
						 String resource_favors_rate = (String)stMap.get("RESOURCE_FAVORS_RATE") == null ? "" : (String)stMap.get("RESOURCE_FAVORS_RATE");
						 res_brand_code_c = (String)stMap.get("RES_BRAND_CODE_C") == null ? "" : (String)stMap.get("RES_BRAND_CODE_C");
						 res_res_code_c = (String)stMap.get("RES_RES_CODE_C") == null ? "" : (String)stMap.get("RES_RES_CODE_C");
						 res_contract_type = (String)stMap.get("RES_CONTRACT_TYPE") == null ? "" : (String)stMap.get("RES_CONTRACT_TYPE");
					 	 String taxPercent = (String)stMap.get("TAX_PERCENT") == null ? "0.17" : (String)stMap.get("TAX_PERCENT");//税率
						 System.out.println("----------=======================res_contract_type:"+res_contract_type);
						 System.out.println("----------=======================taxPercent:"+taxPercent);
					 %>
							<tr>
								<th>终端品牌</th>
								<td>
									<input type="text" name = "res_brand_c" id = "res_brand_c"  value="<%= res_brand_c%>" readonly/>
									<% if("".equals(res_brand_c)){%>
										<input type="button" class="b_text" name="verify" id="verify" onclick="chooseRes()" value="选择"/>
										<font style="color:red"><b>*</b></font>
									<% }%>
								</td>
								<th>终端型号</th>
								<td>
									<input type="text" name = "res_model_c" id="res_model_c" value="<%= res_model_c%>" readonly/>
								</td>
							</tr>
							<tr>
								<th>终端成本</th>
								<td>
									<input type="text" name = "res_cost_price_c" id = "res_cost_price_c" value="<%= res_cost_price_c%>"  readonly />
								</td>
								<% if("76".equals(act_type) || "95".equals(act_type) || "97".equals(act_type)  || "115".equals(act_type)){%>
								<th>主资费</th>
								<% }else{%>
								<th>底线资费</th>
								<% }%>
								<td>
									<input type="text" name = "prcName" id = "prcName" value="" readonly />
									<input type="button" class="b_text" name="verify" id="verify" onclick="chooseAddFee()" value="选择"/>
									<font style="color:red"><b>*</b></font>
									<input type="hidden" name="prcNo" id = "prcNo"/>
									<input type="hidden" name="prcMoney" id = "prcMoney"/>
									<input type="hidden" name="offSetType" id = "offSetType"/>
									<input type="hidden" name="offSetUnit" id = "offSetUnit"/>
									<input type="hidden" name="kx_code_bunch" id = "kx_code_bunch"/>
									<input type="hidden" name="kx_name_bunch" id = "kx_name_bunch"/>
									<input type="hidden" name="kx_habitus_bunch" id = "kx_habitus_bunch"/>
									<input type="hidden" name="kx_operation_bunch" id = "kx_operation_bunch"/>
									<input type="hidden" name="kx_stream_bunch" id = "kx_stream_bunch"/>
									<input type="hidden" name="kx_begintime_bunch" id = "kx_begintime_bunch"/>
									<input type="hidden" name="kx_endtime_bunch" id = "kx_endtime_bunch"/>
								</td>
							</tr>
							<% if(!"".equals(res_brand_c)){%>
							<tr>
								<th>合约价格</th>
								<td>
									<input type="text"  name = "res_contract_price" id = "res_contract_price"   value="<%= res_contract_price%>"  readonly />
								</td>
								<th>购机款</th>
								<td>
									<input type="text" name = "resourceCostPrice" id="resourceCostPrice" value="0" readonly />
								</td>
							</tr>
							<% }%>
							<tr>
								<th>税率</th>
								<td>
									<input type="text" name = "taxPercent" id="taxPercent" value="<%=taxPercent %>" readonly />
								</td>
								<% if(("148".equals(act_type)||"149".equals(act_type)||"154".equals(act_type)||"155".equals(act_type))&&"3".equals(validMode) ){ %>
										<th>生效方式</th>
										<%if("0".equals(selectvalidMode)){%>
										<td>
											<select id="validModes" name="validModes" >
												<option value="0" SELECTED >立即生效</option>
												<option value="1">预约生效</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%}else if("1".equals(selectvalidMode)){%>
										<td>
											<select id="validModes" name="validModes" >
												<option value="0" >立即生效</option>
												<option value="1" SELECTED>预约生效</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%}else{%>
										<td>
											<select id="validModes" name="validModes" >
											    <option value="">---请选择---</option>
												<option value="0">立即生效</option>
												<option value="1">预约生效</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%} %>
								<%}%>
							</tr>
							<tr>
								<th>优惠比例(0-100)</th>
								<td>
									<input type="text"  name = "resource_favors_rate" id = "resource_favors_rate"   value="<%= resource_favors_rate%>" readonly />
								</td>
								<th>消费期限</th>
								<td>
									<select id="consumeTime" name="consumeTime" onchange="autoChangeValue();">
										<option value="0">--请选择--</option>
										<%if("115".equals(act_type) ){%>
										<option value="12">12</option>
										<option value="24">24</option>
										<option value="36">36</option>
										<%}else{ %>
									    <%if("67".equals(act_type) || "73".equals(act_type)){ %>
									    <option value="3">3</option>
										<option value="6">6</option>
										<%} %>
										<%if("76".equals(act_type) || "95".equals(act_type) || "97".equals(act_type)){ %>
										<option value="6">6</option>
										<%} %>
										<%if(!"67".equals(act_type) && !"73".equals(act_type) && !"72".equals(act_type)){ %>
										<option value="12">12</option>
										<option value="18">18</option>
										<option value="24">24</option>
										<%}%>
										<%if("76".equals(act_type) || "95".equals(act_type) || "97".equals(act_type)){ %>
										<option value="36">36</option>
										<%} %>
										<%if("72".equals(act_type) ){%>
										<option value="3">3</option>
										<%}
										} %>
									</select>
									<font style="color:red"><b>*</b></font>
								</td>
							</tr>
							<% if(("1".equals(res_contract_type) &&(!"155".equals(act_type) ))|| "2".equals(res_contract_type) || "4".equals(res_contract_type)){%>
								<tr>
									<th>底线系统充值</th>
									<td>
										<input type="text"  name = "SYSTEM_PAY_TYPE" id = "SYSTEM_PAY_TYPE"   value="二码合一月送(DR)" readonly />
									</td>
									<th>返还类型</th>
									<td>
										<input type="text"  name = "SYSTEM_RETURN_CLASS" id = "SYSTEM_RETURN_CLASS"   value="拆包不累计" readonly />
									</td>
								</tr>
								<tr>
									<th>赠送话费总额</th>
									<td>
										<input type="text"  name = "SYSTEM_PAY_MONEY" id = "SYSTEM_PAY_MONEY"   value="0" readonly />
									</td>
									<th>每月赠送金额</th>
									<td>
										<input type="text"  name = "SYSTEM_ALLOW_PAY" id = "SYSTEM_ALLOW_PAY"   value="0" readonly />
									</td>
								</tr>
							<%}else if("0".equals(res_contract_type)||("1".equals(res_contract_type) &&("155".equals(act_type) )) ){%>
								<tr>
									<th>底线专款类型</th>
									<td>
										<input type="text"  name = "SPECIAL_PAY_TYPE" id = "SPECIAL_PAY_TYPE"   value="签约购机月返(CQ)" readonly />
									</td>
									<th>返还类型</th>
									<td>
										<input type="text"  name = "SPECIAL_RETURN_CLASS" id = "SPECIAL_RETURN_CLASS"   value="按月返还累计加拆包" readonly />
									</td>
								</tr>
								<tr>
									<th>返还总额</th>
									<td>
										<input type="text"  name = "SPECIAL_PAY_MONEY" id = "SPECIAL_PAY_MONEY"   value="0" readonly />
									</td>
									<th>月返金额</th>
									<td>
										<input type="text"  name = "SPECIAL_ALLOW_PAY" id = "SPECIAL_ALLOW_PAY"   value="0" readonly />
									</td>
								</tr>
							
							<%}%>
								<tr>
									<th>应收金额</th>
									<td>
										<input type="text"  name = "PAY_MONEYCOULD" id = "PAY_MONEYCOULD"   value="0" readonly />
									</td>
									<th>税额</th>
									<td>
										<input type="text"  name = "taxFee" id = "taxFee"   value="0" readonly />
									</td>
								</tr>
						<%  }
						}%>

						</table>
							<div class="title">
						<div class="text">
							必填选项
						</div>
						</div>
							<table>						
								<tr>
									<th>IMEI码</th>
									<td>	<input type="text" name="imei_code" id="imei_code" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
												<input type="button" class="b_text" name="verifyRes" id="verifyRes" onclick="chkrBrand()" value="验证"/>
												<font style="color:red"><b>*</b></font>
												<div id="td1" align="left">
									</td>
									<th>交付时间</th>
									<td>
										<input type="text" name="cmit_date" id="cmit_date"  class="required Wdate"  value=""
											readonly
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){validateElement(this)}})" />
										<font color="red"><b>*</b></font>
										<script type="text/javascript">
										var cmit_date = $("#cmit_date");
										var sys_time=new Date();
										var	year =	sys_time.getYear();
										var	month =	sys_time.getMonth()+1;
										var day = sys_time.getDate();
										if(month<10){
										month = "0"+month;
										}
										if(day<10){
										day = "0"+day;
										}
										if(""==cmit_date.value|| null == cmit_date.value || undefined== cmit_date.value){
										cmit_date.value = year+"-"+month+"-"+day;
										$("#cmit_date").val(cmit_date.value);
										
										}
										</script>
									</td>
								</tr>									
							</table>
							<input type="hidden" id="res_res_code_c" value="<%= res_res_code_c%>" />
							<input type="hidden" id="res_brand_code_c" value="<%= res_brand_code_c%>" />
							<input type="hidden" id="resourceDetail" value="" />
							<input type="hidden" id="costAllowance" value="0" />
							<input type="hidden" id="BillAllowance" value="0" />
						</div>
					<div id="operation_button"><!-- disabled="disabled" -->
						<input type="button" class="b_foot"  disabled="disabled" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	$(document).ready(function(){
		getTermInfoNew();
		var myPacket = null;
		if("<%=act_type%>" == "148" || "<%=act_type%>" == "149" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "155"){
			myPacket = new AJAXPacket("getEffectMoney.jsp","请稍后...");
			myPacket.data.add("ASSIFEEINFOXML","<%=assiFeeInfoXml%>");
			myPacket.data.add("CONTRACTTIME","<%=contracttime%>");
		}else{
			myPacket = new AJAXPacket("getPreFeeValue.jsp","请稍后...");
			myPacket.data.add("ORDER_ID","<%=orderId%>");
		}
		core.ajax.sendPacket(myPacket,doFeeCat);
		myPacket =null;
	});
	
	function doFeeCat(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var prcNo = packet.data.findValueByName("prcNo");
		var prcName = packet.data.findValueByName("prcName");
		var prcMoney = packet.data.findValueByName("prcMoney");
		var consumeTime = packet.data.findValueByName("consumeTime");
		if(trim(RETURN_CODE)=="000000"){
			$("#verify").attr("disabled","disabled");
			if(prcMoney=="0"||prcMoney==null||prcMoney=="N/A"||prcMoney==""){
				showDialog("该资费未配置资费月租，请联系管理员!",0);
				return false;
			}
			document.all("prcNo").value=trim(prcNo);
			document.all("prcName").value=trim(prcName);
			document.all("prcMoney").value=trim(prcMoney);
			
			var consumeTimeOp = $("#consumeTime option");
 			consumeTimeOp.remove();
 			var consumeTimeObj = $("#consumeTime");
			consumeTimeObj.append("<option value='"+consumeTime+"'>"+consumeTime+"</option>");
			autoChangeValue();
			
		}
		
	}
	
	
	var codes = "";
	var feeNames = "";
	var showNames = "";
	var feeScores = "";
	var orderStr = "";
	var gFeeCodeStr = "";
	var gFeeDescStr = "";
	var gFeeNoteStr = "";
	var qryfee_code = "";
	var qryfee_msg = "";
	
	function btnRsSubmit(){

		var prcName = $("#prcName").val();//底线资费
		var code = $.trim($("#prcNo").val());
		var cmit_date = $("#cmit_date").val();//交付时间
		var consumeTime = $("#consumeTime").val();//消费期限
		var resFee = $("#resourceCostPrice").val();//购机款   没有购机款的 undined的不限制了
		var resCostPrice = $("#res_cost_price_c").val();//终端成本（采购价格）
		var validModes = $("#validModes").val();//生效方式
		if(prcName==null||prcName=="null"||prcName==""){
			showDialog("请选择底线资费!",0);
		 	return false;		
		}
		if(("<%=act_type%>" == "148" || "<%=act_type%>" == "149" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "155")&& "<%=validMode%>" == "3" && validModes==""){
			showDialog("请选择生效方式!",0);
		 	return false;
		}

		//购机赠费自有的限制 购机款>=成本
		if("<%=res_contract_type%>" == "2" &&  "<%=act_type%>" == "73"){
		 	 if(parseFloat(resFee)<parseFloat(resCostPrice)){
			 	showDialog("购机赠费类营销案,终端购机款必须大于或等于终端成本，否则不能办理!",1);
				return false;
			} 
		}
		
		if(cmit_date==null||cmit_date=="null"||cmit_date==""){
			showDialog("请选择缴交付时间!",0);
		 	return false;		
		}
		if(consumeTime=="0"){
			showDialog("请选择消费期限!",0);
		 	return false;		
		}

		if("<%=act_type%>" == "67" || "<%=act_type%>" == "72"){
		
			if("<%=act_type%>" == "67" ){
				if(consumeTime =="3" && code !="47653"){
					showDialog("按业务要求，3月合约期，只能办理底线资费为：30元终端促销流量套餐。",0);
		 			return false;		
				}
				if((consumeTime=="6" && code!="48516" )){
					showDialog("按业务要求，6月合约期，只能办理底线资费为：10元终端促销流量套餐。",0);
		 			return false;		
				}
			}
		}

		var split = "";
		var split2 = "";
		var split3 = "";
		var iPhoneNoStr="";//手机号码串
		var iOprTypeStr="";//资费标识串
		var iDateTypeStr="";//资费类型串
		var iOfferTypeStr="";//资费类型串
		var iUnitStr="";//资费类型串
		for(var i=0; i<1; i++){
			var iOfferType = "1";//不是那三个小类，此处传的默认是附加资费“1”，否则传主资费“0”
			var iDateType = "0";//不是那三个小类，此处传的默认是立即生效“0”，否则传预约“2”
			var code = $.trim($("#prcNo").val());
			var name = $.trim($("#prcName").val());
			var score = $.trim($("#consumeTime").val());
			var offsetType = $.trim($("#offSetType").val());
			if(offsetType == "" || offsetType == "N/A"){
				offsetType = "6";
			}
			if("<%=act_type%>" == "76" || "<%=act_type%>" == "95"|| "<%=act_type%>" == "97"|| "<%=act_type%>" == "115"){
				iOfferType = "0";
				iDateType = "2";
			}
			//----------------------根据小类148,149特殊判断，生效方式由页面选择决定-----------------------------
			if(("<%=act_type%>" == "148" || "<%=act_type%>" == "149"|| "<%=act_type%>" == "154"|| "<%=act_type%>" == "155")&& "<%=validMode%>" == "3"){
			   if(validModes == "0"){
			   	  iDateType = "0";
			   }else{
			      iDateType = "2";
			   }
			}
			codes = codes + split + code;
			feeNames = feeNames + split + name;
			showNames = showNames + split2 + name;
			feeScores =  feeScores + split + score;
			orderStr = orderStr + split3 + "N";
			//=============================增加生效时间和失效时间调用接口==============================			
			iPhoneNoStr = iPhoneNoStr + split + "<%=phoneNo%>";
			iOprTypeStr = iOprTypeStr + split + "1";
			iDateTypeStr = iDateTypeStr + split + iDateType;
			iOfferTypeStr = iOfferTypeStr + split + iOfferType;
			iUnitStr = iUnitStr + split + "6";
			split = "#";
			split2 = "<br>";
			split3 = ",";
		}

		var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
		sPacket.data.add("iChnSource","<%=reginCode%>");
		sPacket.data.add("iLoginNo","<%=loginNo%>");
		sPacket.data.add("iLoginPWD","<%=password%>");
		sPacket.data.add("iPhoneNo","<%=phoneNo%>");
		sPacket.data.add("iOprAccept","<%=orderId%>");
		sPacket.data.add("iPhoneNoStr",iPhoneNoStr);
		sPacket.data.add("iOfferIdStr",codes);
		sPacket.data.add("iOprTypeStr",iOprTypeStr);
		sPacket.data.add("iUnitStr",iUnitStr);
		sPacket.data.add("iDateTypeStr",iDateTypeStr);
		sPacket.data.add("iOfferTypeStr",iOfferTypeStr);
		sPacket.data.add("iOffsetStr",feeScores);
		sPacket.data.add("meansId","<%=meansId%>");
		//==================================================
		core.ajax.sendPacket(sPacket,doserviceResCat);
		sPacket = null;
	}
	
	
	
	function doserviceResCat(packet){


		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		
		var effDateStr = packet.data.findValueByName("effDateStr");
		var expDateStr = packet.data.findValueByName("expDateStr");
		if(RETURN_CODE!="000000"){
			showDialog(RETURN_MSG,0);
			resetValues();
			return false;
		}
		
		var res_brand_c = $("#res_brand_c").val();//品牌
		var res_model_c = $("#res_model_c").val();//终端型号
		var res_cost_price_c = $("#res_cost_price_c").val();//终端成本（采购价格）
		var res_res_code_c = $("#res_res_code_c").val();
		var res_brand_code_c = $("#res_brand_code_c").val();
		var resourceCostPrice = $("#resourceCostPrice").val();//购机款
		var costAllowance = $("#costAllowance").val();//成本补贴
		var BillAllowance = $("#BillAllowance").val();//话费补贴
		var imei_code = $("#imei_code").val();//IMEI
		var cmit_date = $("#cmit_date").val();//交付时间
		var quality_limit=0;//保修时限
		var resourcePercent ="";//系数比例
		var resourceMonthPay = 0;//月底线消费额
		var consumeTime = $("#consumeTime").val();//消费期限
		var resourceDetail = $("#resourceDetail").val();//供货商名称/供货商编码/机型属性
		var pay_moneycould = $("#PAY_MONEYCOULD").val();//应收金额
		
		var taxFee_c = $("#taxFee").val();//税额
		var taxPercent_c = $("#taxPercent").val();//税率
		
		var kx_code_bunch = $("#kx_code_bunch").val();//退订必绑资费代码
		var kx_name_bunch = $("#kx_name_bunch").val();//退订必绑资费名称
		var kx_habitus_bunch = $("#kx_habitus_bunch").val();//退订必绑资费状态
		var kx_operation_bunch = $("#kx_operation_bunch").val();//退订必绑资费生效
		var kx_stream_bunch = $("#kx_stream_bunch").val();//退订必绑资费原开通流水串
		var kx_begintime_bunch = $("#kx_begintime_bunch").val();//退订必绑资费开始时间
		var kx_endtime_bunch = $("#kx_endtime_bunch").val();//退订必绑资费结束时间
		var validModes = $("#validModes").val();//生效方式
		
		var validFlag = "0";
		
		if("<%=act_type%>" == "76" || "<%=act_type%>" == "95"|| "<%=act_type%>" == "97"|| "<%=act_type%>" == "115"){//如果是这三个小类的，专款和系统充值的生效方式变为预约生效
			validFlag = "1";
		}
		var desc = "终端品牌："+res_brand_c+"，终端型号："+res_model_c+"，IMEI码："+imei_code;//描述
		//----------------------根据小类148,149特殊判断，生效方式由页面选择决定-----------------------------
		if(("<%=act_type%>" == "148" || "<%=act_type%>" == "149" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "155")&& "<%=validMode%>" == "3"){
		   	validFlag = validModes;
		   	if(validFlag == "0"){
		   		desc+="，生效方式：立即生效";
		   	}else{
		   		desc+="，生效方式：预约生效";
		   	}
		}
		
		if("<%=res_contract_type%>" == "1"|| "<%=res_contract_type%>" == "4"){//如果是购机赠费社会，则没有购机款，默认是0
			resourceCostPrice = 0;
		}
		//alert("33="+resourceCostPrice);
		//alert("22="+taxFee_c);
		//alert("aaa="+ Number(resourceCostPrice-Number(taxFee_c)));
		var marketPrice_c = Number(resourceCostPrice-taxFee_c).toFixed(2);//计税金额
		//alert("11="+marketPrice_c);

		var showDesc = "终端品牌："+res_brand_c+"，终端型号："+res_model_c+"，IMEI码："+imei_code;
		if("<%=res_contract_type%>" != "1"){
			desc+="，终端购机款："+resourceCostPrice+"元";
			showDesc+="，终端购机款："+resourceCostPrice+"元";
		}
		if(resourceCostPrice == undefined || resourceCostPrice ==""){//购机款未设置的默认传0
			resourceCostPrice = 0;
		}
		
		/*
		   以下小类增加套餐名称和套餐月费:
             97:预存购机-套餐合约 ;67:预存购机-流量合约;95:购机赠费-套餐合约（定制）; 76:购机赠费-套餐合约（公开）.
          add date:20150716
		*/
		if("<%=act_type%>" == "97" || "<%=act_type%>" == "67"|| "<%=act_type%>" == "95" || "<%=act_type%>" == "76"|| "<%=act_type%>" == "115"|| "<%=act_type%>" == "148"|| "<%=act_type%>" == "149"|| "<%=act_type%>" == "154"|| "<%=act_type%>" == "155"){
			var prcMoney = $("#prcMoney").val();//底线资费月租金额
			var prcName = $("#prcName").val();//底线资费
			if(prcName != undefined && prcName !="" && prcName!="N/A"){
				desc+="，套餐名称："+prcName+", 套餐月费："+prcMoney+"元";
				showDesc+="，套餐名称："+prcName+", 套餐月费："+prcMoney+"元";
			}
		}
             
       /*
                  以下小类新增资费描述，资费描述调用行业部接口获取：
            148-购机赠费-流量合约（新）、149-预存购机-流量合约（新）、95-购机赠费-套餐合约（定制）、
            97-预存购机-套餐合约、76-购机赠费-套餐合约（公开）、71-合约计划预存购机
            add  date:2015-10-10
            
            modify date:2016-03-28
                       将小类去掉，所有小类都掉用资费描述查询接口，展示资费描述及流量结转信息描述
       */
		multiOffQry();
		if(trim(qryfee_code)!="000000"){
			showDialog("调用服务sMultiOffQryWS_XML获取资费描述失败："+qryfee_msg,0);
			return false;
		}
		if(gFeeCodeStr!="" && gFeeDescStr !=""){
			desc+="，套餐描述："+gFeeDescStr;
			showDesc+="，套餐描述："+gFeeDescStr;
		}
		if(gFeeNoteStr!="" && gFeeNoteStr !=""){
			showDesc+="<br>";
			showDesc+=gFeeNoteStr;
			showDesc+="<br>";
			
		}
		
		<%-- if("<%=act_type%>" == "148" || "<%=act_type%>" == "149"|| "<%=act_type%>" == "95" || "<%=act_type%>" == "97"|| "<%=act_type%>" == "76"
			|| "<%=act_type%>" == "71"){

       } --%>
		
		//提交报文
		if("<%=res_contract_type%>" == "0"||("<%=res_contract_type%>" == "1"&&"<%=act_type%>"== "155")){
			var SPECIAL_PAY_TYPE = $("#SPECIAL_PAY_TYPE").val();//专款类型
			var SPECIAL_RETURN_CLASS = $("#SPECIAL_RETURN_CLASS").val();//返还类型
			var SPECIAL_PAY_MONEY = $("#SPECIAL_PAY_MONEY").val();//返还总额
			var SPECIAL_ALLOW_PAY = $("#SPECIAL_ALLOW_PAY").val();//月返金额
			desc+="，底线专款类型："+SPECIAL_PAY_TYPE+"，返还类型："+SPECIAL_RETURN_CLASS+"，返还总金额："+SPECIAL_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SPECIAL_ALLOW_PAY+"元";
			showDesc+="，底线专款类型："+SPECIAL_PAY_TYPE+"，返还类型："+SPECIAL_RETURN_CLASS+"，返还总金额："+SPECIAL_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SPECIAL_ALLOW_PAY+"元";

			parent.buildH05SPECIAL(SPECIAL_PAY_MONEY,consumeTime,SPECIAL_ALLOW_PAY,pay_moneycould,validFlag);
		}
		
		/*
		   95:购机赠费-套餐合约（定制）  76:购机赠费-套餐合约（公开）:
		      删除底线系统充值类型：二码合一月送（DR） 
		   add date：20150716
		*/
		if(("<%=res_contract_type%>" == "1"&&"<%=act_type%>"!= "155") || "<%=res_contract_type%>" == "2"){
			var SYSTEM_PAY_TYPE = $("#SYSTEM_PAY_TYPE").val();//系统充值类型
			var SYSTEM_RETURN_CLASS = $("#SYSTEM_RETURN_CLASS").val();//返还类型
			var SYSTEM_PAY_MONEY = $("#SYSTEM_PAY_MONEY").val();//返还总额
			var SYSTEM_ALLOW_PAY = $("#SYSTEM_ALLOW_PAY").val();//月返金额
			
			if("<%=act_type%>"== "95" || "<%=act_type%>" == "76" || "<%=act_type%>" == "115"){
				desc+="，返还类型："+SYSTEM_RETURN_CLASS+"，返还总金额："+SYSTEM_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SYSTEM_ALLOW_PAY+"元";
				showDesc+="，返还类型："+SYSTEM_RETURN_CLASS+"，返还总金额："+SYSTEM_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SYSTEM_ALLOW_PAY+"元";

			}else{
				desc+="，底线系统充值类型："+SYSTEM_PAY_TYPE+"，返还类型："+SYSTEM_RETURN_CLASS+"，返还总金额："+SYSTEM_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SYSTEM_ALLOW_PAY+"元";
				showDesc+="，底线系统充值类型："+SYSTEM_PAY_TYPE+"，返还类型："+SYSTEM_RETURN_CLASS+"，返还总金额："+SYSTEM_PAY_MONEY+"元，合约期："+consumeTime+"个月，每月返还金额："+SYSTEM_ALLOW_PAY+"元";

			}
			parent.buildH05SYSTEM(SYSTEM_PAY_MONEY,consumeTime,SYSTEM_ALLOW_PAY,pay_moneycould,validFlag);
		}
		//showDesc 前台展示的所有信息，desc 打印免填单上的信息 不包含 流转信息，gFeeNoteStr 打印免填单上的流转信息
		parent.document.getElementById("agreeFeeDetails<%=meansId%>").innerHTML = showDesc;
		//alert("desc="+desc);
		//alert("gFeeNoteStr="+gFeeNoteStr);
		parent.setAgreeFeeDesc(desc,gFeeNoteStr);
		parent.clientData(res_cost_price_c,resourceCostPrice,imei_code,cmit_date,quality_limit,res_brand_c,res_model_c,res_res_code_c,res_brand_code_c,
				"","",consumeTime,resourcePercent,resourceMonthPay,resourceDetail,"<%=res_contract_type%>",costAllowance,BillAllowance,gOptype,
				marketPrice_c,taxPercent_c,taxFee_c);
		if("<%=act_type%>" == "76" || "<%=act_type%>" == "95"|| "<%=act_type%>" == "97"|| "<%=act_type%>" == "115"){//如果是这三个小类的，拼主资费的报文，否则拼附加资费的报文
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
			parent.buildPriFeeXml(codes,feeNames,"2",effDateStr,expDateStr,"","",kx_code_bunch,kx_name_bunch,kx_habitus_bunch,kx_operation_bunch,kx_stream_bunch,kx_begintime,kx_endtime,"","");
		}else{
			parent.saveAssFee("<%=meansId%>", codes, feeNames, showNames, feeScores, orderStr,effDateStr,expDateStr,"","");
		}
		parent.changeContractTime(consumeTime); //合约期替换成选择的
		parent.changeValidMode(validFlag);//生效标示替换
		//展现
		parent.agreeMent_Checkfuc();
		var imei_code = $("#imei_code").val();//IMEI
		parent.putImeiCode(imei_code);
		closeDivWin();
	}
	
	var gOptype = "";
	function chkrBrand(){
		gOptype = "0";
		var buss_type="0";
		var imei_code = $("#imei_code").val();//IMEI
		var res_res_code_c = $("#res_res_code_c").val();//res_res_code_c
		var myPacket = null;
		//取optype
		getImeiOpType();
		myPacket = new AJAXPacket("checkResource.jsp","请稍后...");
		myPacket.data.add("imei_code",imei_code);
		myPacket.data.add("RESOURCE_RES_CODE",res_res_code_c);
		//xin
		myPacket.data.add("res_contract_type","<%=res_contract_type%>");
		if("<%=act_type%>" == "69"){//二码合一
			gOptype = "20";
		}else if("<%=act_type%>" == "115"){
			if(imei_code.length!=15){
				showDialog("自备机串码只能是15位！",2);
				return false;
			}
			gOptype = "4";
		}else if ("<%=act_type%>" == "72" || "<%=act_type%>" == "76" || "<%=act_type%>" == "95" || "<%=act_type%>" == "148"|| "<%=act_type%>" == "155"){//买断类终端:终端与套餐分离-购机赠费(社会)
			buss_type = "2";
		}
		myPacket.data.add("OP_TYPE",gOptype);
		myPacket.data.add("BUSS_TYPE",buss_type);
		myPacket.data.add("OP_ACCEPT","<%=orderId%>");
		myPacket.data.add("ACT_TYPE","<%=act_type%>");
		core.ajax.sendPacket(myPacket,doResourceCat);
		myPacket =null;
	}	

	function getImeiOpType(){
		var myPacket = null;
		myPacket = new AJAXPacket("getImeiOpType.jsp","请稍后...");
		myPacket.data.add("ORDER_ID","<%=orderId%>");
		myPacket.data.add("MEANS_ID","<%=meansId%>");
		myPacket.data.add("GROUP_ID","<%=groupid%>");
		core.ajax.sendPacket(myPacket,setOpType);
		myPacket =null;
	}
	function setOpType(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var op_type = packet.data.findValueByName("OP_TYPE");
		if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}
		gOptype = op_type;
	}	
	
	function doResourceCat(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var DETAIL_MSG = packet.data.findValueByName("DETAIL_MSG");
		if(trim(RETURN_CODE)=="000000"){
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(RETURN_MSG);
	 		$("#resourceDetail").val(DETAIL_MSG);
	 		$("#btnSubmit").attr("disabled",false);
	 		$("#imei_code").attr("readonly",true);
		}else if(trim(RETURN_CODE)!="000000"){
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(RETURN_MSG);
			$("#btnSubmit").attr("disabled",true);
		}
	}
	
	//底线资费
	function chooseAddFee(){
		window.open("<%=request.getContextPath()%>/npage/se112/addFeeList.jsp?actType=<%=act_type%>&brandId=<%=brandId%>&mode_code=<%=mode_code%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&id_no=<%=id_no%>",'底线资费','width=550px,height=620px');
	}
	
	//终端
	function chooseRes(){
		window.open("<%=request.getContextPath()%>/npage/se112/hljclientList.jsp",'选择终端','width=550px,height=620px');
	}
	
	function addAddFee(prodPrcId,prodPrcName,prcMoney,offSetType,offSetUnit,kx_code_bunch,kx_name_bunch,kx_habitus_bunch,kx_operation_bunch,kx_stream_bunch,kx_begintime_bunch,kx_endtime_bunch,xqFlag){
		var inValues="18,28,38,48,58,68,78,88,98,108,118,128,138,148,158,168,178,188,198,388,588";
		//alert("inValues:"+inValues);
		//alert("prcMoney:"+prcMoney);
		//alert("inValues.indexOf(prcMoney):"+inValues.indexOf(prcMoney));
		/*if(xqFlag == "Y"){
			showDialog("不能选择带有小区代码的底线资费:"+prodPrcName+"!",0);
			return false;
		}*/
		var consumeTime = $("#consumeTime").val();//消费期限
		if(consumeTime != "0"){
			var prcNo = trim($("#prcNo").val());
			if(trim(prcNo) != trim(prodPrcId) ){
				$("#consumeTime").find("option[value='0']").attr("selected",true);
				$("#SYSTEM_PAY_MONEY").val("0");
				$("#SYSTEM_ALLOW_PAY").val("0");
				$("#SPECIAL_PAY_MONEY").val("0");
				$("#SPECIAL_ALLOW_PAY").val("0");
				$("#PAY_MONEYCOULD").val("0");
				$("#resourceCostPrice").val("0");
				showDialog("请重新选择消费期限!",0);
			}
		}
		if("<%=res_contract_type%>" == "1" && inValues.indexOf(prcMoney)==-1 && "<%=act_type%>" != "76" && "<%=act_type%>" != "95" && "<%=act_type%>" != "97"&& "<%=act_type%>" != "72"&& "<%=act_type%>" != "115"){
			showDialog("选择资费不合理，只能选择档位"+inValues+",请重新选择！！",1);
			return false;
		}
		document.all("prcNo").value=trim(prodPrcId);
		document.all("prcName").value=trim(prodPrcName);
		document.all("prcMoney").value=trim(prcMoney);
		document.all("offSetType").value=trim(offSetType);
		document.all("offSetUnit").value=trim(offSetUnit);
		document.all("kx_code_bunch").value=trim(kx_code_bunch);
		document.all("kx_name_bunch").value=trim(kx_name_bunch);
		document.all("kx_habitus_bunch").value=trim(kx_habitus_bunch);
		document.all("kx_operation_bunch").value=trim(kx_operation_bunch);
		document.all("kx_stream_bunch").value=trim(kx_stream_bunch);
		document.all("kx_begintime_bunch").value=trim(kx_begintime_bunch);
		document.all("kx_endtime_bunch").value=trim(kx_endtime_bunch);
	}
	
	
	function addhljClient(clientList){
		var gift = clientList.split(";");
		for(i=0;i<gift.length-1;i++){
			var giftPar = gift[i].split(",");
			$("#res_brand_c").val(trim(giftPar[0]));
			$("#res_model_c").val(trim(giftPar[1]));
			$("#res_cost_price_c").val(trim(giftPar[2]));
			$("#res_res_code_c").val(trim(giftPar[3]));
			$("#res_brand_code_c").val(trim(giftPar[4]));
			$("#taxPercent").val("0.17");//税率固定为17% 
		}
	}
	
	function autoChangeValue(){
		
		var payMoney = 0;//底线预存
		var allowPay = 0;//每月返还金钱
		var resourceCostPrice = 0;//购机款
		var pay_moneycould = 0;//应收金额
		var costAllowance = 0;//成本补贴
		var BillAllowance = 0;//话费补贴
		var consumeTime = trim($("#consumeTime").val());//消费期限
		var prcName = trim($("#prcName").val());//底线资费名称
		var res_brand_c = trim($("#res_brand_c").val());//终端
		var prcMoney = trim($("#prcMoney").val());//底线月租
		var resource_favors_rate = trim($("#resource_favors_rate").val());//优惠比例
		var res_cost_price_c = trim($("#res_cost_price_c").val());//采购价格
		
		if(res_brand_c == ""){
			showDialog("请选择终端",1);
			$("#consumeTime").find("option[value='0']").attr("selected",true);
			return false;
		}
		if(prcName == ""){
			showDialog("请选择资费",1);
			$("#consumeTime").find("option[value='0']").attr("selected",true);
			return false;
		}
		if(consumeTime == "0"){
			showDialog("请选择消费期限",1);
			return false;
		}
		if(resource_favors_rate == ""){
			showDialog("请填写优惠比例",1);
			return false;
		}
		
		payMoney = parseFloat(parseFloat(prcMoney*resource_favors_rate/100).toFixed(0)*consumeTime);//市场部确认，先取整，再*合约期限
		allowPay = parseFloat((payMoney/consumeTime).toFixed(0));
		
		if("<%=res_contract_type%>" == "0" || "<%=res_contract_type%>" == "2"){
			var res_contract_price = trim($("#res_contract_price").val());//合约价格
			if(parseFloat(payMoney)>parseFloat(res_contract_price)){
				showDialog("赠送/返话费总额超过合约价格，请重新选择!!",1);
				$("#consumeTime").find("option[value='0']").attr("selected",true);
				document.all("prcNo").value="";
				document.all("prcName").value="";
				document.all("prcMoney").value="";
				$("#SYSTEM_PAY_MONEY").val("0");
				$("#SYSTEM_ALLOW_PAY").val("0");
				$("#SPECIAL_PAY_MONEY").val("0");
				$("#SPECIAL_ALLOW_PAY").val("0");
				$("#PAY_MONEYCOULD").val("0");
				$("#resourceCostPrice").val("0");
				return false;
			}
		}
		
		if("<%=res_contract_type%>" == "0"){
			var res_contract_price = trim($("#res_contract_price").val());//合约价格
			pay_moneycould = res_contract_price;//应付金额=合约价格
			if(res_contract_price > payMoney){
				resourceCostPrice = res_contract_price - payMoney;//购机款 = 合约价-底线预存
			}else{
				resourceCostPrice = "0";
			}
			if("<%=act_type%>"=="154"){//154小类
				// 底限预存=资费月租（资费月租是通过营销方式中配置的附加资费返回的）*优惠比例*合约期--此部分是原公式、未变 
				// 用户应付=合约价-电子券+预存款金额 
				// 购机款=用户应付-预存款金额=合约价-电子券金额
				var gift_money = "<%=gift_money%>";//电子券金额
				pay_moneycould = res_contract_price-gift_money+payMoney; //应付金额
				resourceCostPrice=res_contract_price-gift_money;//购机款
				
				var resFeeTemp = parseFloat(res_contract_price)-parseFloat(gift_money);
				if(resFeeTemp <= 0){
					showDialog("办理154业务小类，其中购机款=合约价-电子券金额，购机款必须大于0，否则不能办理!",0);
					$("#verifyRes").attr("disabled",true);
					return false;
				}
			}
			costAllowance = res_cost_price_c - resourceCostPrice;//成本补贴
			$("#resourceCostPrice").val(parseFloatTo(resourceCostPrice));
			$("#PAY_MONEYCOULD").val(parseFloatTo(pay_moneycould));
			$("#SPECIAL_PAY_MONEY").val(parseFloatTo(payMoney));
			$("#SPECIAL_ALLOW_PAY").val(parseFloatTo(allowPay));
			$("#costAllowance").val(parseFloatTo(costAllowance));
		}else if("<%=res_contract_type%>" == "1"){
			if("<%=act_type%>"=="155"){
				resourceCostPrice = "0";//购机款
				pay_moneycould = payMoney; //应付金额=底线预存
				costAllowance = res_cost_price_c - resourceCostPrice;//成本补贴
				$("#resourceCostPrice").val(parseFloatTo(resourceCostPrice));
				$("#PAY_MONEYCOULD").val(parseFloatTo(pay_moneycould));
				$("#SPECIAL_PAY_MONEY").val(parseFloatTo(payMoney)); //返还总金额
				$("#SPECIAL_ALLOW_PAY").val(parseFloatTo(allowPay));
				$("#costAllowance").val(parseFloatTo(costAllowance));
			}else{
				$("#SYSTEM_ALLOW_PAY").val(parseFloatTo(allowPay));
				$("#SYSTEM_PAY_MONEY").val(parseFloatTo(payMoney));
				$("#BillAllowance").val(parseFloatTo(payMoney));
			}
		}else if("<%=res_contract_type%>" == "2"){
			var res_contract_price = trim($("#res_contract_price").val());//合约价格
			$("#resourceCostPrice").val(parseFloatTo(res_contract_price));
			$("#PAY_MONEYCOULD").val(parseFloatTo(res_contract_price));
			$("#SYSTEM_PAY_MONEY").val(parseFloatTo(payMoney));
			$("#SYSTEM_ALLOW_PAY").val(parseFloatTo(allowPay));
			$("#BillAllowance").val(parseFloatTo(payMoney));//话费补贴
		}
		
		
		//计算税额
		var taxFee="";
		var taxPercent = trim($("#taxPercent").val());//税率
		var resourceCostPriceTemp = $("#resourceCostPrice").val();//购机款
		if(resourceCostPriceTemp == undefined || resourceCostPriceTemp ==""){//购机款未设置的默认传0
			resourceCostPriceTemp = 0;
		}else{
			resourceCostPriceTemp = trim(resourceCostPriceTemp);
		}

		var feeTemp = Number(resourceCostPriceTemp)/(1+Number(taxPercent))*Number(taxPercent);
		taxFee = feeTemp.toFixed(2);
		$("#taxFee").val((taxFee));//税额 
		//alert("taxPercent="+taxPercent+", resourceCostPriceTemp="+resourceCostPriceTemp+", taxFee="+taxFee+"feeTemp="+feeTemp);
	}
	
	function parseFloatTo(floatvar){  
	    var f_x = parseFloat(floatvar);  
	    if (isNaN(f_x)){  
	        return '0.00';  
	    }  
	    var f_x = Math.round(f_x*100)/100;  
	    var s_x = f_x.toString();  
	    var pos_decimal = s_x.indexOf('.');  
	    if (pos_decimal < 0){  
	        pos_decimal = s_x.length;  
	        s_x += '.';  
	    }  
	    while (s_x.length <= pos_decimal + 2){  
	        s_x += '0';  
	    }  
	    return s_x;  
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	function resetValues(){
		codes = "";
		feeNames = "";
		showNames = "";
		feeScores = "";
		orderStr = "";
	
	}
	
	
	function multiOffQry(){
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
		var feeNoteStr = packet.data.findValueByName("feeNoteStr");
		/* if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		} */
		gFeeCodeStr = feeCodeStr;
		gFeeDescStr = feeDescStr;
		gFeeNoteStr = feeNoteStr;
	}
	
	function getTermInfoNew(){
		var myPacket = null;
		myPacket = new AJAXPacket("getTermInfoNew.jsp","请稍后...");
		myPacket.data.add("res_value","<%=res_res_code_c%>");
		core.ajax.sendPacket(myPacket,putTermInfoNew);
		myPacket =null;
	}
	
	function putTermInfoNew(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var res_cost_fee = packet.data.findValueByName("res_cost_fee");
		if(trim(RETURN_CODE)=="000000"){
			$("#res_cost_price_c").val(trim(res_cost_fee));	
		}else{
			$("#verifyRes").attr("disabled","disabled");
			showDialog("查询终端成本价失败，请联系管理员",1);
			return false;
		}
		
		
	}
	
	
	</script>
</html>