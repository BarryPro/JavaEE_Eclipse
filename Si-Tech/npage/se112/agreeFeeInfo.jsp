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
	String brandId =request.getParameter("brandId").trim();//Ʒ��
	String mode_code =request.getParameter("mode_code").trim();
	String powerRight=request.getParameter("powerRight").trim();//�û�Ȩ��
	String belong_code=request.getParameter("belong_code").trim();//�û�����
	String id_no= request.getParameter("id_no").trim();//�û�ID
	String groupid = (String)session.getAttribute("groupId");
	String contracttime = request.getParameter("contracttime"); //��Լ��
	String validMode = request.getParameter("validMode"); //��Լ��
	String selectvalidMode = request.getParameter("selectvalidMode"); //ѡ�����Ч��ʽ
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
							�ն���ϸ��Ϣ
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
						 String res_cost_price_c = (String)stMap.get("RES_COST_PRICE_C") == null ? "" : (String)stMap.get("RES_COST_PRICE_C");//�ɹ��۸�
						 String res_contract_price = (String)stMap.get("RES_CONTRACT_PRICE") == null ? "" : (String)stMap.get("RES_CONTRACT_PRICE");
						 String resource_favors_rate = (String)stMap.get("RESOURCE_FAVORS_RATE") == null ? "" : (String)stMap.get("RESOURCE_FAVORS_RATE");
						 res_brand_code_c = (String)stMap.get("RES_BRAND_CODE_C") == null ? "" : (String)stMap.get("RES_BRAND_CODE_C");
						 res_res_code_c = (String)stMap.get("RES_RES_CODE_C") == null ? "" : (String)stMap.get("RES_RES_CODE_C");
						 res_contract_type = (String)stMap.get("RES_CONTRACT_TYPE") == null ? "" : (String)stMap.get("RES_CONTRACT_TYPE");
					 	 String taxPercent = (String)stMap.get("TAX_PERCENT") == null ? "0.17" : (String)stMap.get("TAX_PERCENT");//˰��
						 System.out.println("----------=======================res_contract_type:"+res_contract_type);
						 System.out.println("----------=======================taxPercent:"+taxPercent);
					 %>
							<tr>
								<th>�ն�Ʒ��</th>
								<td>
									<input type="text" name = "res_brand_c" id = "res_brand_c"  value="<%= res_brand_c%>" readonly/>
									<% if("".equals(res_brand_c)){%>
										<input type="button" class="b_text" name="verify" id="verify" onclick="chooseRes()" value="ѡ��"/>
										<font style="color:red"><b>*</b></font>
									<% }%>
								</td>
								<th>�ն��ͺ�</th>
								<td>
									<input type="text" name = "res_model_c" id="res_model_c" value="<%= res_model_c%>" readonly/>
								</td>
							</tr>
							<tr>
								<th>�ն˳ɱ�</th>
								<td>
									<input type="text" name = "res_cost_price_c" id = "res_cost_price_c" value="<%= res_cost_price_c%>"  readonly />
								</td>
								<% if("76".equals(act_type) || "95".equals(act_type) || "97".equals(act_type)  || "115".equals(act_type)){%>
								<th>���ʷ�</th>
								<% }else{%>
								<th>�����ʷ�</th>
								<% }%>
								<td>
									<input type="text" name = "prcName" id = "prcName" value="" readonly />
									<input type="button" class="b_text" name="verify" id="verify" onclick="chooseAddFee()" value="ѡ��"/>
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
								<th>��Լ�۸�</th>
								<td>
									<input type="text"  name = "res_contract_price" id = "res_contract_price"   value="<%= res_contract_price%>"  readonly />
								</td>
								<th>������</th>
								<td>
									<input type="text" name = "resourceCostPrice" id="resourceCostPrice" value="0" readonly />
								</td>
							</tr>
							<% }%>
							<tr>
								<th>˰��</th>
								<td>
									<input type="text" name = "taxPercent" id="taxPercent" value="<%=taxPercent %>" readonly />
								</td>
								<% if(("148".equals(act_type)||"149".equals(act_type)||"154".equals(act_type)||"155".equals(act_type))&&"3".equals(validMode) ){ %>
										<th>��Ч��ʽ</th>
										<%if("0".equals(selectvalidMode)){%>
										<td>
											<select id="validModes" name="validModes" >
												<option value="0" SELECTED >������Ч</option>
												<option value="1">ԤԼ��Ч</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%}else if("1".equals(selectvalidMode)){%>
										<td>
											<select id="validModes" name="validModes" >
												<option value="0" >������Ч</option>
												<option value="1" SELECTED>ԤԼ��Ч</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%}else{%>
										<td>
											<select id="validModes" name="validModes" >
											    <option value="">---��ѡ��---</option>
												<option value="0">������Ч</option>
												<option value="1">ԤԼ��Ч</option>
											</select>
											<font style="color:red"><b>*</b></font>
										</td>
										<%} %>
								<%}%>
							</tr>
							<tr>
								<th>�Żݱ���(0-100)</th>
								<td>
									<input type="text"  name = "resource_favors_rate" id = "resource_favors_rate"   value="<%= resource_favors_rate%>" readonly />
								</td>
								<th>��������</th>
								<td>
									<select id="consumeTime" name="consumeTime" onchange="autoChangeValue();">
										<option value="0">--��ѡ��--</option>
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
									<th>����ϵͳ��ֵ</th>
									<td>
										<input type="text"  name = "SYSTEM_PAY_TYPE" id = "SYSTEM_PAY_TYPE"   value="�����һ����(DR)" readonly />
									</td>
									<th>��������</th>
									<td>
										<input type="text"  name = "SYSTEM_RETURN_CLASS" id = "SYSTEM_RETURN_CLASS"   value="������ۼ�" readonly />
									</td>
								</tr>
								<tr>
									<th>���ͻ����ܶ�</th>
									<td>
										<input type="text"  name = "SYSTEM_PAY_MONEY" id = "SYSTEM_PAY_MONEY"   value="0" readonly />
									</td>
									<th>ÿ�����ͽ��</th>
									<td>
										<input type="text"  name = "SYSTEM_ALLOW_PAY" id = "SYSTEM_ALLOW_PAY"   value="0" readonly />
									</td>
								</tr>
							<%}else if("0".equals(res_contract_type)||("1".equals(res_contract_type) &&("155".equals(act_type) )) ){%>
								<tr>
									<th>����ר������</th>
									<td>
										<input type="text"  name = "SPECIAL_PAY_TYPE" id = "SPECIAL_PAY_TYPE"   value="ǩԼ�����·�(CQ)" readonly />
									</td>
									<th>��������</th>
									<td>
										<input type="text"  name = "SPECIAL_RETURN_CLASS" id = "SPECIAL_RETURN_CLASS"   value="���·����ۼƼӲ��" readonly />
									</td>
								</tr>
								<tr>
									<th>�����ܶ�</th>
									<td>
										<input type="text"  name = "SPECIAL_PAY_MONEY" id = "SPECIAL_PAY_MONEY"   value="0" readonly />
									</td>
									<th>�·����</th>
									<td>
										<input type="text"  name = "SPECIAL_ALLOW_PAY" id = "SPECIAL_ALLOW_PAY"   value="0" readonly />
									</td>
								</tr>
							
							<%}%>
								<tr>
									<th>Ӧ�ս��</th>
									<td>
										<input type="text"  name = "PAY_MONEYCOULD" id = "PAY_MONEYCOULD"   value="0" readonly />
									</td>
									<th>˰��</th>
									<td>
										<input type="text"  name = "taxFee" id = "taxFee"   value="0" readonly />
									</td>
								</tr>
						<%  }
						}%>

						</table>
							<div class="title">
						<div class="text">
							����ѡ��
						</div>
						</div>
							<table>						
								<tr>
									<th>IMEI��</th>
									<td>	<input type="text" name="imei_code" id="imei_code" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
												<input type="button" class="b_text" name="verifyRes" id="verifyRes" onclick="chkrBrand()" value="��֤"/>
												<font style="color:red"><b>*</b></font>
												<div id="td1" align="left">
									</td>
									<th>����ʱ��</th>
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
						<input type="button" class="b_foot"  disabled="disabled" value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
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
			myPacket = new AJAXPacket("getEffectMoney.jsp","���Ժ�...");
			myPacket.data.add("ASSIFEEINFOXML","<%=assiFeeInfoXml%>");
			myPacket.data.add("CONTRACTTIME","<%=contracttime%>");
		}else{
			myPacket = new AJAXPacket("getPreFeeValue.jsp","���Ժ�...");
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
				showDialog("���ʷ�δ�����ʷ����⣬����ϵ����Ա!",0);
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

		var prcName = $("#prcName").val();//�����ʷ�
		var code = $.trim($("#prcNo").val());
		var cmit_date = $("#cmit_date").val();//����ʱ��
		var consumeTime = $("#consumeTime").val();//��������
		var resFee = $("#resourceCostPrice").val();//������   û�й������ undined�Ĳ�������
		var resCostPrice = $("#res_cost_price_c").val();//�ն˳ɱ����ɹ��۸�
		var validModes = $("#validModes").val();//��Ч��ʽ
		if(prcName==null||prcName=="null"||prcName==""){
			showDialog("��ѡ������ʷ�!",0);
		 	return false;		
		}
		if(("<%=act_type%>" == "148" || "<%=act_type%>" == "149" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "155")&& "<%=validMode%>" == "3" && validModes==""){
			showDialog("��ѡ����Ч��ʽ!",0);
		 	return false;
		}

		//�����������е����� ������>=�ɱ�
		if("<%=res_contract_type%>" == "2" &&  "<%=act_type%>" == "73"){
		 	 if(parseFloat(resFee)<parseFloat(resCostPrice)){
			 	showDialog("����������Ӫ����,�ն˹����������ڻ�����ն˳ɱ��������ܰ���!",1);
				return false;
			} 
		}
		
		if(cmit_date==null||cmit_date=="null"||cmit_date==""){
			showDialog("��ѡ��ɽ���ʱ��!",0);
		 	return false;		
		}
		if(consumeTime=="0"){
			showDialog("��ѡ����������!",0);
		 	return false;		
		}

		if("<%=act_type%>" == "67" || "<%=act_type%>" == "72"){
		
			if("<%=act_type%>" == "67" ){
				if(consumeTime =="3" && code !="47653"){
					showDialog("��ҵ��Ҫ��3�º�Լ�ڣ�ֻ�ܰ�������ʷ�Ϊ��30Ԫ�ն˴��������ײ͡�",0);
		 			return false;		
				}
				if((consumeTime=="6" && code!="48516" )){
					showDialog("��ҵ��Ҫ��6�º�Լ�ڣ�ֻ�ܰ�������ʷ�Ϊ��10Ԫ�ն˴��������ײ͡�",0);
		 			return false;		
				}
			}
		}

		var split = "";
		var split2 = "";
		var split3 = "";
		var iPhoneNoStr="";//�ֻ����봮
		var iOprTypeStr="";//�ʷѱ�ʶ��
		var iDateTypeStr="";//�ʷ����ʹ�
		var iOfferTypeStr="";//�ʷ����ʹ�
		var iUnitStr="";//�ʷ����ʹ�
		for(var i=0; i<1; i++){
			var iOfferType = "1";//����������С�࣬�˴�����Ĭ���Ǹ����ʷѡ�1�����������ʷѡ�0��
			var iDateType = "0";//����������С�࣬�˴�����Ĭ����������Ч��0��������ԤԼ��2��
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
			//----------------------����С��148,149�����жϣ���Ч��ʽ��ҳ��ѡ�����-----------------------------
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
			//=============================������Чʱ���ʧЧʱ����ýӿ�==============================			
			iPhoneNoStr = iPhoneNoStr + split + "<%=phoneNo%>";
			iOprTypeStr = iOprTypeStr + split + "1";
			iDateTypeStr = iDateTypeStr + split + iDateType;
			iOfferTypeStr = iOfferTypeStr + split + iOfferType;
			iUnitStr = iUnitStr + split + "6";
			split = "#";
			split2 = "<br>";
			split3 = ",";
		}

		var sPacket = new AJAXPacket("getEffectTime.jsp","���Ժ�......");
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
		
		var res_brand_c = $("#res_brand_c").val();//Ʒ��
		var res_model_c = $("#res_model_c").val();//�ն��ͺ�
		var res_cost_price_c = $("#res_cost_price_c").val();//�ն˳ɱ����ɹ��۸�
		var res_res_code_c = $("#res_res_code_c").val();
		var res_brand_code_c = $("#res_brand_code_c").val();
		var resourceCostPrice = $("#resourceCostPrice").val();//������
		var costAllowance = $("#costAllowance").val();//�ɱ�����
		var BillAllowance = $("#BillAllowance").val();//���Ѳ���
		var imei_code = $("#imei_code").val();//IMEI
		var cmit_date = $("#cmit_date").val();//����ʱ��
		var quality_limit=0;//����ʱ��
		var resourcePercent ="";//ϵ������
		var resourceMonthPay = 0;//�µ������Ѷ�
		var consumeTime = $("#consumeTime").val();//��������
		var resourceDetail = $("#resourceDetail").val();//����������/�����̱���/��������
		var pay_moneycould = $("#PAY_MONEYCOULD").val();//Ӧ�ս��
		
		var taxFee_c = $("#taxFee").val();//˰��
		var taxPercent_c = $("#taxPercent").val();//˰��
		
		var kx_code_bunch = $("#kx_code_bunch").val();//�˶��ذ��ʷѴ���
		var kx_name_bunch = $("#kx_name_bunch").val();//�˶��ذ��ʷ�����
		var kx_habitus_bunch = $("#kx_habitus_bunch").val();//�˶��ذ��ʷ�״̬
		var kx_operation_bunch = $("#kx_operation_bunch").val();//�˶��ذ��ʷ���Ч
		var kx_stream_bunch = $("#kx_stream_bunch").val();//�˶��ذ��ʷ�ԭ��ͨ��ˮ��
		var kx_begintime_bunch = $("#kx_begintime_bunch").val();//�˶��ذ��ʷѿ�ʼʱ��
		var kx_endtime_bunch = $("#kx_endtime_bunch").val();//�˶��ذ��ʷѽ���ʱ��
		var validModes = $("#validModes").val();//��Ч��ʽ
		
		var validFlag = "0";
		
		if("<%=act_type%>" == "76" || "<%=act_type%>" == "95"|| "<%=act_type%>" == "97"|| "<%=act_type%>" == "115"){//�����������С��ģ�ר���ϵͳ��ֵ����Ч��ʽ��ΪԤԼ��Ч
			validFlag = "1";
		}
		var desc = "�ն�Ʒ�ƣ�"+res_brand_c+"���ն��ͺţ�"+res_model_c+"��IMEI�룺"+imei_code;//����
		//----------------------����С��148,149�����жϣ���Ч��ʽ��ҳ��ѡ�����-----------------------------
		if(("<%=act_type%>" == "148" || "<%=act_type%>" == "149" || "<%=act_type%>" == "154"|| "<%=act_type%>" == "155")&& "<%=validMode%>" == "3"){
		   	validFlag = validModes;
		   	if(validFlag == "0"){
		   		desc+="����Ч��ʽ��������Ч";
		   	}else{
		   		desc+="����Ч��ʽ��ԤԼ��Ч";
		   	}
		}
		
		if("<%=res_contract_type%>" == "1"|| "<%=res_contract_type%>" == "4"){//����ǹ���������ᣬ��û�й����Ĭ����0
			resourceCostPrice = 0;
		}
		//alert("33="+resourceCostPrice);
		//alert("22="+taxFee_c);
		//alert("aaa="+ Number(resourceCostPrice-Number(taxFee_c)));
		var marketPrice_c = Number(resourceCostPrice-taxFee_c).toFixed(2);//��˰���
		//alert("11="+marketPrice_c);

		var showDesc = "�ն�Ʒ�ƣ�"+res_brand_c+"���ն��ͺţ�"+res_model_c+"��IMEI�룺"+imei_code;
		if("<%=res_contract_type%>" != "1"){
			desc+="���ն˹����"+resourceCostPrice+"Ԫ";
			showDesc+="���ն˹����"+resourceCostPrice+"Ԫ";
		}
		if(resourceCostPrice == undefined || resourceCostPrice ==""){//������δ���õ�Ĭ�ϴ�0
			resourceCostPrice = 0;
		}
		
		/*
		   ����С�������ײ����ƺ��ײ��·�:
             97:Ԥ�湺��-�ײͺ�Լ ;67:Ԥ�湺��-������Լ;95:��������-�ײͺ�Լ�����ƣ�; 76:��������-�ײͺ�Լ��������.
          add date:20150716
		*/
		if("<%=act_type%>" == "97" || "<%=act_type%>" == "67"|| "<%=act_type%>" == "95" || "<%=act_type%>" == "76"|| "<%=act_type%>" == "115"|| "<%=act_type%>" == "148"|| "<%=act_type%>" == "149"|| "<%=act_type%>" == "154"|| "<%=act_type%>" == "155"){
			var prcMoney = $("#prcMoney").val();//�����ʷ�������
			var prcName = $("#prcName").val();//�����ʷ�
			if(prcName != undefined && prcName !="" && prcName!="N/A"){
				desc+="���ײ����ƣ�"+prcName+", �ײ��·ѣ�"+prcMoney+"Ԫ";
				showDesc+="���ײ����ƣ�"+prcName+", �ײ��·ѣ�"+prcMoney+"Ԫ";
			}
		}
             
       /*
                  ����С�������ʷ��������ʷ�����������ҵ���ӿڻ�ȡ��
            148-��������-������Լ���£���149-Ԥ�湺��-������Լ���£���95-��������-�ײͺ�Լ�����ƣ���
            97-Ԥ�湺��-�ײͺ�Լ��76-��������-�ײͺ�Լ����������71-��Լ�ƻ�Ԥ�湺��
            add  date:2015-10-10
            
            modify date:2016-03-28
                       ��С��ȥ��������С�඼�����ʷ�������ѯ�ӿڣ�չʾ�ʷ�������������ת��Ϣ����
       */
		multiOffQry();
		if(trim(qryfee_code)!="000000"){
			showDialog("���÷���sMultiOffQryWS_XML��ȡ�ʷ�����ʧ�ܣ�"+qryfee_msg,0);
			return false;
		}
		if(gFeeCodeStr!="" && gFeeDescStr !=""){
			desc+="���ײ�������"+gFeeDescStr;
			showDesc+="���ײ�������"+gFeeDescStr;
		}
		if(gFeeNoteStr!="" && gFeeNoteStr !=""){
			showDesc+="<br>";
			showDesc+=gFeeNoteStr;
			showDesc+="<br>";
			
		}
		
		<%-- if("<%=act_type%>" == "148" || "<%=act_type%>" == "149"|| "<%=act_type%>" == "95" || "<%=act_type%>" == "97"|| "<%=act_type%>" == "76"
			|| "<%=act_type%>" == "71"){

       } --%>
		
		//�ύ����
		if("<%=res_contract_type%>" == "0"||("<%=res_contract_type%>" == "1"&&"<%=act_type%>"== "155")){
			var SPECIAL_PAY_TYPE = $("#SPECIAL_PAY_TYPE").val();//ר������
			var SPECIAL_RETURN_CLASS = $("#SPECIAL_RETURN_CLASS").val();//��������
			var SPECIAL_PAY_MONEY = $("#SPECIAL_PAY_MONEY").val();//�����ܶ�
			var SPECIAL_ALLOW_PAY = $("#SPECIAL_ALLOW_PAY").val();//�·����
			desc+="������ר�����ͣ�"+SPECIAL_PAY_TYPE+"���������ͣ�"+SPECIAL_RETURN_CLASS+"�������ܽ�"+SPECIAL_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SPECIAL_ALLOW_PAY+"Ԫ";
			showDesc+="������ר�����ͣ�"+SPECIAL_PAY_TYPE+"���������ͣ�"+SPECIAL_RETURN_CLASS+"�������ܽ�"+SPECIAL_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SPECIAL_ALLOW_PAY+"Ԫ";

			parent.buildH05SPECIAL(SPECIAL_PAY_MONEY,consumeTime,SPECIAL_ALLOW_PAY,pay_moneycould,validFlag);
		}
		
		/*
		   95:��������-�ײͺ�Լ�����ƣ�  76:��������-�ײͺ�Լ��������:
		      ɾ������ϵͳ��ֵ���ͣ������һ���ͣ�DR�� 
		   add date��20150716
		*/
		if(("<%=res_contract_type%>" == "1"&&"<%=act_type%>"!= "155") || "<%=res_contract_type%>" == "2"){
			var SYSTEM_PAY_TYPE = $("#SYSTEM_PAY_TYPE").val();//ϵͳ��ֵ����
			var SYSTEM_RETURN_CLASS = $("#SYSTEM_RETURN_CLASS").val();//��������
			var SYSTEM_PAY_MONEY = $("#SYSTEM_PAY_MONEY").val();//�����ܶ�
			var SYSTEM_ALLOW_PAY = $("#SYSTEM_ALLOW_PAY").val();//�·����
			
			if("<%=act_type%>"== "95" || "<%=act_type%>" == "76" || "<%=act_type%>" == "115"){
				desc+="���������ͣ�"+SYSTEM_RETURN_CLASS+"�������ܽ�"+SYSTEM_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SYSTEM_ALLOW_PAY+"Ԫ";
				showDesc+="���������ͣ�"+SYSTEM_RETURN_CLASS+"�������ܽ�"+SYSTEM_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SYSTEM_ALLOW_PAY+"Ԫ";

			}else{
				desc+="������ϵͳ��ֵ���ͣ�"+SYSTEM_PAY_TYPE+"���������ͣ�"+SYSTEM_RETURN_CLASS+"�������ܽ�"+SYSTEM_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SYSTEM_ALLOW_PAY+"Ԫ";
				showDesc+="������ϵͳ��ֵ���ͣ�"+SYSTEM_PAY_TYPE+"���������ͣ�"+SYSTEM_RETURN_CLASS+"�������ܽ�"+SYSTEM_PAY_MONEY+"Ԫ����Լ�ڣ�"+consumeTime+"���£�ÿ�·�����"+SYSTEM_ALLOW_PAY+"Ԫ";

			}
			parent.buildH05SYSTEM(SYSTEM_PAY_MONEY,consumeTime,SYSTEM_ALLOW_PAY,pay_moneycould,validFlag);
		}
		//showDesc ǰ̨չʾ��������Ϣ��desc ��ӡ����ϵ���Ϣ ������ ��ת��Ϣ��gFeeNoteStr ��ӡ����ϵ���ת��Ϣ
		parent.document.getElementById("agreeFeeDetails<%=meansId%>").innerHTML = showDesc;
		//alert("desc="+desc);
		//alert("gFeeNoteStr="+gFeeNoteStr);
		parent.setAgreeFeeDesc(desc,gFeeNoteStr);
		parent.clientData(res_cost_price_c,resourceCostPrice,imei_code,cmit_date,quality_limit,res_brand_c,res_model_c,res_res_code_c,res_brand_code_c,
				"","",consumeTime,resourcePercent,resourceMonthPay,resourceDetail,"<%=res_contract_type%>",costAllowance,BillAllowance,gOptype,
				marketPrice_c,taxPercent_c,taxFee_c);
		if("<%=act_type%>" == "76" || "<%=act_type%>" == "95"|| "<%=act_type%>" == "97"|| "<%=act_type%>" == "115"){//�����������С��ģ�ƴ���ʷѵı��ģ�����ƴ�����ʷѵı���
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
		parent.changeContractTime(consumeTime); //��Լ���滻��ѡ���
		parent.changeValidMode(validFlag);//��Ч��ʾ�滻
		//չ��
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
		//ȡoptype
		getImeiOpType();
		myPacket = new AJAXPacket("checkResource.jsp","���Ժ�...");
		myPacket.data.add("imei_code",imei_code);
		myPacket.data.add("RESOURCE_RES_CODE",res_res_code_c);
		//xin
		myPacket.data.add("res_contract_type","<%=res_contract_type%>");
		if("<%=act_type%>" == "69"){//�����һ
			gOptype = "20";
		}else if("<%=act_type%>" == "115"){
			if(imei_code.length!=15){
				showDialog("�Ա�������ֻ����15λ��",2);
				return false;
			}
			gOptype = "4";
		}else if ("<%=act_type%>" == "72" || "<%=act_type%>" == "76" || "<%=act_type%>" == "95" || "<%=act_type%>" == "148"|| "<%=act_type%>" == "155"){//������ն�:�ն����ײͷ���-��������(���)
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
		myPacket = new AJAXPacket("getImeiOpType.jsp","���Ժ�...");
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
	
	//�����ʷ�
	function chooseAddFee(){
		window.open("<%=request.getContextPath()%>/npage/se112/addFeeList.jsp?actType=<%=act_type%>&brandId=<%=brandId%>&mode_code=<%=mode_code%>&powerRight=<%=powerRight%>&belong_code=<%=belong_code%>&id_no=<%=id_no%>",'�����ʷ�','width=550px,height=620px');
	}
	
	//�ն�
	function chooseRes(){
		window.open("<%=request.getContextPath()%>/npage/se112/hljclientList.jsp",'ѡ���ն�','width=550px,height=620px');
	}
	
	function addAddFee(prodPrcId,prodPrcName,prcMoney,offSetType,offSetUnit,kx_code_bunch,kx_name_bunch,kx_habitus_bunch,kx_operation_bunch,kx_stream_bunch,kx_begintime_bunch,kx_endtime_bunch,xqFlag){
		var inValues="18,28,38,48,58,68,78,88,98,108,118,128,138,148,158,168,178,188,198,388,588";
		//alert("inValues:"+inValues);
		//alert("prcMoney:"+prcMoney);
		//alert("inValues.indexOf(prcMoney):"+inValues.indexOf(prcMoney));
		/*if(xqFlag == "Y"){
			showDialog("����ѡ�����С������ĵ����ʷ�:"+prodPrcName+"!",0);
			return false;
		}*/
		var consumeTime = $("#consumeTime").val();//��������
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
				showDialog("������ѡ����������!",0);
			}
		}
		if("<%=res_contract_type%>" == "1" && inValues.indexOf(prcMoney)==-1 && "<%=act_type%>" != "76" && "<%=act_type%>" != "95" && "<%=act_type%>" != "97"&& "<%=act_type%>" != "72"&& "<%=act_type%>" != "115"){
			showDialog("ѡ���ʷѲ�����ֻ��ѡ��λ"+inValues+",������ѡ�񣡣�",1);
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
			$("#taxPercent").val("0.17");//˰�ʹ̶�Ϊ17% 
		}
	}
	
	function autoChangeValue(){
		
		var payMoney = 0;//����Ԥ��
		var allowPay = 0;//ÿ�·�����Ǯ
		var resourceCostPrice = 0;//������
		var pay_moneycould = 0;//Ӧ�ս��
		var costAllowance = 0;//�ɱ�����
		var BillAllowance = 0;//���Ѳ���
		var consumeTime = trim($("#consumeTime").val());//��������
		var prcName = trim($("#prcName").val());//�����ʷ�����
		var res_brand_c = trim($("#res_brand_c").val());//�ն�
		var prcMoney = trim($("#prcMoney").val());//��������
		var resource_favors_rate = trim($("#resource_favors_rate").val());//�Żݱ���
		var res_cost_price_c = trim($("#res_cost_price_c").val());//�ɹ��۸�
		
		if(res_brand_c == ""){
			showDialog("��ѡ���ն�",1);
			$("#consumeTime").find("option[value='0']").attr("selected",true);
			return false;
		}
		if(prcName == ""){
			showDialog("��ѡ���ʷ�",1);
			$("#consumeTime").find("option[value='0']").attr("selected",true);
			return false;
		}
		if(consumeTime == "0"){
			showDialog("��ѡ����������",1);
			return false;
		}
		if(resource_favors_rate == ""){
			showDialog("����д�Żݱ���",1);
			return false;
		}
		
		payMoney = parseFloat(parseFloat(prcMoney*resource_favors_rate/100).toFixed(0)*consumeTime);//�г���ȷ�ϣ���ȡ������*��Լ����
		allowPay = parseFloat((payMoney/consumeTime).toFixed(0));
		
		if("<%=res_contract_type%>" == "0" || "<%=res_contract_type%>" == "2"){
			var res_contract_price = trim($("#res_contract_price").val());//��Լ�۸�
			if(parseFloat(payMoney)>parseFloat(res_contract_price)){
				showDialog("����/�������ܶ����Լ�۸�������ѡ��!!",1);
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
			var res_contract_price = trim($("#res_contract_price").val());//��Լ�۸�
			pay_moneycould = res_contract_price;//Ӧ�����=��Լ�۸�
			if(res_contract_price > payMoney){
				resourceCostPrice = res_contract_price - payMoney;//������ = ��Լ��-����Ԥ��
			}else{
				resourceCostPrice = "0";
			}
			if("<%=act_type%>"=="154"){//154С��
				// ����Ԥ��=�ʷ����⣨�ʷ�������ͨ��Ӫ����ʽ�����õĸ����ʷѷ��صģ�*�Żݱ���*��Լ��--�˲�����ԭ��ʽ��δ�� 
				// �û�Ӧ��=��Լ��-����ȯ+Ԥ����� 
				// ������=�û�Ӧ��-Ԥ�����=��Լ��-����ȯ���
				var gift_money = "<%=gift_money%>";//����ȯ���
				pay_moneycould = res_contract_price-gift_money+payMoney; //Ӧ�����
				resourceCostPrice=res_contract_price-gift_money;//������
				
				var resFeeTemp = parseFloat(res_contract_price)-parseFloat(gift_money);
				if(resFeeTemp <= 0){
					showDialog("����154ҵ��С�࣬���й�����=��Լ��-����ȯ��������������0�������ܰ���!",0);
					$("#verifyRes").attr("disabled",true);
					return false;
				}
			}
			costAllowance = res_cost_price_c - resourceCostPrice;//�ɱ�����
			$("#resourceCostPrice").val(parseFloatTo(resourceCostPrice));
			$("#PAY_MONEYCOULD").val(parseFloatTo(pay_moneycould));
			$("#SPECIAL_PAY_MONEY").val(parseFloatTo(payMoney));
			$("#SPECIAL_ALLOW_PAY").val(parseFloatTo(allowPay));
			$("#costAllowance").val(parseFloatTo(costAllowance));
		}else if("<%=res_contract_type%>" == "1"){
			if("<%=act_type%>"=="155"){
				resourceCostPrice = "0";//������
				pay_moneycould = payMoney; //Ӧ�����=����Ԥ��
				costAllowance = res_cost_price_c - resourceCostPrice;//�ɱ�����
				$("#resourceCostPrice").val(parseFloatTo(resourceCostPrice));
				$("#PAY_MONEYCOULD").val(parseFloatTo(pay_moneycould));
				$("#SPECIAL_PAY_MONEY").val(parseFloatTo(payMoney)); //�����ܽ��
				$("#SPECIAL_ALLOW_PAY").val(parseFloatTo(allowPay));
				$("#costAllowance").val(parseFloatTo(costAllowance));
			}else{
				$("#SYSTEM_ALLOW_PAY").val(parseFloatTo(allowPay));
				$("#SYSTEM_PAY_MONEY").val(parseFloatTo(payMoney));
				$("#BillAllowance").val(parseFloatTo(payMoney));
			}
		}else if("<%=res_contract_type%>" == "2"){
			var res_contract_price = trim($("#res_contract_price").val());//��Լ�۸�
			$("#resourceCostPrice").val(parseFloatTo(res_contract_price));
			$("#PAY_MONEYCOULD").val(parseFloatTo(res_contract_price));
			$("#SYSTEM_PAY_MONEY").val(parseFloatTo(payMoney));
			$("#SYSTEM_ALLOW_PAY").val(parseFloatTo(allowPay));
			$("#BillAllowance").val(parseFloatTo(payMoney));//���Ѳ���
		}
		
		
		//����˰��
		var taxFee="";
		var taxPercent = trim($("#taxPercent").val());//˰��
		var resourceCostPriceTemp = $("#resourceCostPrice").val();//������
		if(resourceCostPriceTemp == undefined || resourceCostPriceTemp ==""){//������δ���õ�Ĭ�ϴ�0
			resourceCostPriceTemp = 0;
		}else{
			resourceCostPriceTemp = trim(resourceCostPriceTemp);
		}

		var feeTemp = Number(resourceCostPriceTemp)/(1+Number(taxPercent))*Number(taxPercent);
		taxFee = feeTemp.toFixed(2);
		$("#taxFee").val((taxFee));//˰�� 
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
		myPacket = new AJAXPacket("multiOffQry.jsp","���Ժ�...");
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
		myPacket = new AJAXPacket("getTermInfoNew.jsp","���Ժ�...");
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
			showDialog("��ѯ�ն˳ɱ���ʧ�ܣ�����ϵ����Ա",1);
			return false;
		}
		
		
	}
	
	
	</script>
</html>