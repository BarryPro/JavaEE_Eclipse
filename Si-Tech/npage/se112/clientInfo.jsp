<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>

<%
	String xml = request.getParameter("clientInfo");
	String meansId = request.getParameter("meansId");
	String svcNum = request.getParameter("svcNum");
	String orderId = request.getParameter("orderId");
	String groupid = (String)session.getAttribute("groupId"); 
	String act_type = request.getParameter("act_type").trim();
	String resFeeTemp = request.getParameter("resFeeTemp").trim();
	String scoreFeeTemp = request.getParameter("scoreFeeTemp").trim();
	System.out.println("clientInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	System.out.println("clientInfo=orderId===AAAAAAAAAAAAAAAAAAAAAA====" + orderId);
	System.out.println("clientInfo=act_type===AAAAAAAAAAAAAAAAAAAAAA====" + act_type);
	System.out.println("clientInfo=resFeeTemp===AAAAAAAAAAAAAAAAAAAAAA====" + resFeeTemp);
	System.out.println("clientInfo=scoreFeeTemp===AAAAAAAAAAAAAAAAAAAAAA====" + scoreFeeTemp);
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List clientList = null;
	Iterator it =null;
    List agreeFeeLists = null;
	Iterator its =null;
	if(null!= mb){
		clientList = mb.getList("OUT_DATA.H09");
		if(null!=clientList)
			it =clientList.iterator();
	}
	
	if(null!= mb){
		agreeFeeLists = mb.getList("OUT_DATA.H09");
		if(null!=agreeFeeLists)
			its =agreeFeeLists.iterator();
	}

	String RESOURCE_RES_CODE="";
	String RESOURCE_BRAND_CODE="";
	String RESOURCE_COST_PREF="";
	String RESOURCE_COST_TOTAL="";
	String RESOURCE_COST_RAT="";
	String RESOURCE_UNDEADLINE="";
	String RESOURCE_BUYTYPE = "";
	String OP_TYPE = "0";
	String BUSS_TYPE = "0";
	String marketPrice = "";
	String taxPercent = "";
	String taxFee = "";
	String FOURG_FLAG = "";
	String CUSTOM_FLAG = "";
	String VOLTE_FLAG= "";
	String RESOUCE_CUSTOM_FLAG= "";
	if("117".equals(act_type)|| "177".equals(act_type)|| "119".equals(act_type)){//ģ��С�� ��B2B
		BUSS_TYPE="2";
	}
	
	if(null!=its){
		while(its.hasNext()){
		Map stMap = mb.isMap(its.next());
		if(null==stMap)continue;
		RESOURCE_RES_CODE = (String)stMap.get("RESOURCE_RES_CODE") == null ? "" : (String)stMap.get("RESOURCE_RES_CODE");
		//�������� 0-��������;1-�Ա���
	 	RESOURCE_BUYTYPE = (String)stMap.get("RESOURCE_BUYTYPE") == null ? "" : (String)stMap.get("RESOURCE_BUYTYPE");
		if("4".equals(RESOURCE_BUYTYPE)){
			FOURG_FLAG = (String)stMap.get("FOURG_FLAG") == null ? "" : (String)stMap.get("FOURG_FLAG");
		 	CUSTOM_FLAG = (String)stMap.get("CUSTOM_FLAG") == null ? "" : (String)stMap.get("CUSTOM_FLAG");
		 	VOLTE_FLAG = (String)stMap.get("VOLTE_FLAG") == null ? "" : (String)stMap.get("VOLTE_FLAG");
		 	RESOUCE_CUSTOM_FLAG= (String)stMap.get("RESOUCE_CUSTOM_FLAG") == null ? "" : (String)stMap.get("RESOUCE_CUSTOM_FLAG");
		 	System.out.println("+++++++++++++++++++++++++�������� RESOUCE_CUSTOM_FLAG = "+RESOUCE_CUSTOM_FLAG);
		 	System.out.println("+++++++++++++++++++++++++�������� RESOURCE_BUYTYPE = "+RESOURCE_BUYTYPE);
		}
	 	 
		}
	}
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm1147" action="">
				<%
						if(null!=it){
						while(it.hasNext()){
						Map stMap = mb.isMap(it.next());
						if(null==stMap)continue;
					 	 System.out.println("+++++++++++++++++++++++++stMap = "+stMap);
						 String resourceBrand = (String)stMap.get("RESOURCE_BRAND") == null?"":(String)stMap.get("RESOURCE_BRAND");
						 String resourceModel = (String)stMap.get("RESOURCE_MODEL") == null ? "" : (String)stMap.get("RESOURCE_MODEL");
						 String resourceCostPrice = (String)stMap.get("RESOURCE_COST_PRICE") == null ? "" : (String)stMap.get("RESOURCE_COST_PRICE");
						 String resourceFee = (String)stMap.get("RESOURCE_FEE") == null ? "" : (String)stMap.get("RESOURCE_FEE");
						 System.out.println("clientInfo=resourceFee1===AAAAAAAAAAAAAAAAAAAAAA====" + resourceFee);
						 if("140".equals(act_type)||"141".equals(act_type)){
							 resourceFee = resFeeTemp;
						 }
						 if("".equals(resourceFee)){
							 resourceFee = "0";
						 }else{	 
						 	resourceFee = String.valueOf(Float.parseFloat(resourceFee)- Float.parseFloat(scoreFeeTemp));
						 }
						 System.out.println("clientInfo=resourceFee2===AAAAAAAAAAAAAAAAAAAAAA====" + resourceFee);
						 RESOURCE_BRAND_CODE = (String)stMap.get("RESOURCE_BRAND_CODE") == null ? "" : (String)stMap.get("RESOURCE_BRAND_CODE");
						 RESOURCE_RES_CODE = (String)stMap.get("RESOURCE_RES_CODE") == null ? "" : (String)stMap.get("RESOURCE_RES_CODE");
					 	 RESOURCE_COST_PREF = (String)stMap.get("RESOURCE_COST_PREF") == null ? "" : (String)stMap.get("RESOURCE_COST_PREF");
						 RESOURCE_COST_TOTAL = (String)stMap.get("RESOURCE_COST_TOTAL") == null ? "" : (String)stMap.get("RESOURCE_COST_TOTAL");
						 RESOURCE_COST_RAT = (String)stMap.get("RESOURCE_COST_RAT") == null ? "" : (String)stMap.get("RESOURCE_COST_RAT");
					 	 RESOURCE_UNDEADLINE = (String)stMap.get("RESOURCE_UNDEADLINE") == null ? "" : (String)stMap.get("RESOURCE_UNDEADLINE");
					 	 String resourcePercent = (String)stMap.get("RESOURCE_PERCENT") == null ? "" : (String)stMap.get("RESOURCE_PERCENT");
					 	 String resourceMonthPay = (String)stMap.get("RESOURCE_MONTH_PAY") == null ? "" : (String)stMap.get("RESOURCE_MONTH_PAY");
					 	
					 	 if("1".equals(RESOURCE_BUYTYPE)){
					 		OP_TYPE = "4";//�Ա���У��
					 	 }
					 	taxPercent = (String)stMap.get("TAX_PERCENT") == null ? "0.17" : (String)stMap.get("TAX_PERCENT");//˰��
						String fee = "";
					 	if(taxPercent != null){
						 	fee = Double.parseDouble(resourceFee)/(1+ Double.parseDouble(taxPercent))*Double.parseDouble(taxPercent) +"";
						 	taxFee = Math.rint(Double.parseDouble(fee)*Math.pow(10, 2))/Math.pow(10, 2)+"";
						 	marketPrice = Float.parseFloat(resourceFee)-Float.parseFloat(taxFee)+"";
					 	}
					 	System.out.println("+++++++++++++++++++++++++˰�� taxPercent = "+taxPercent);
						System.out.println("+++++++++++++++++++++++++˰�� ���� fee = "+fee);
					 	System.out.println("+++++++++++++++++++++++++˰�� ���� taxFee = "+taxFee);
					 	System.out.println("+++++++++++++++++++++++++��˰���  marketPrice = "+marketPrice);
					 %>
				
				<div id="operation_table">
					<%if("4".equals(RESOURCE_BUYTYPE)){ %>
						<div class="title">
						<div class="text">
							�ն˲�ѯ
						</div>
						</div>
							<div class="input">
							<table>						
								<tr>
									<th>IMEI��</th>
									<td>	
									<input type="text" name="input_imei" id="input_imei" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
									<input type="button" class="b_text" name="verifyRes" onclick="imeiQuery()" value="��ѯ"/>
									</td>
								</tr>
							</table>
							</div>
						<%} %>
					 <div class="title">
						<div class="text">
							�ն���ϸ��Ϣ
						</div>
					</div>
					<div class="input">
					<table>
							<tr>
								<th>
									�ն�Ʒ��
								</th>
								<td>
								<%if("4".equals(RESOURCE_BUYTYPE)){ %>
									<input  name = resourceBrand id = "resourceBrand"  readonly value=""></input>
									<input  name = resCode id = "resCode"  readonly type = "hidden" value=""></input>
								<%}else{ %>
									<%= resourceBrand%>
									<input  name = resourceBrand id = "resourceBrand"  readonly type="hidden" value="<%= resourceBrand%>"></input>
									<input type="hidden" id="resourceModel" value="<%= resourceModel%>">
								<%} %>
								</td>
								<th>�ն��ͺ�</th>
								<td>
									<%if("4".equals(RESOURCE_BUYTYPE)){ %>
										<input id="resourceModel" value="">
									<%}else{ %>
										<%= resourceModel%>
									<%} %>
								</td>
							</tr>
							<tr>
								<th>
									�ն˳ɱ�
								</th>
								<td>
									<%if("4".equals(RESOURCE_BUYTYPE)){ %>
										<input type="text" name = "res_cost_price_c" id = "res_cost_price_c" value="" readonly />
										<input  name = "resourceCostPrice" id = "resourceCostPrice" readonly type="hidden"  value="0"></input>
										<input type="hidden" id="resourceFee" value="0">
									<%}else{ %>
										<input type="text" name = "res_cost_price_c" id = "res_cost_price_c" value="" readonly />
										<input  name = "resourceCostPrice" id = "resourceCostPrice" readonly type="hidden"  value="<%= resourceCostPrice%>"></input>
										<input type="hidden" id="resourceFee" value="<%= resourceFee%>">
									<%} %>
								</td>
								<th>������</th>
								<td>
								<input type="text" name = "" id = "" value="<%= resourceFee%>" readonly />
								</td>
							</tr>
							<tr>
								<th>
									�������
								</th>
								<td>
									<%= RESOURCE_UNDEADLINE%>
									<input type="hidden"  name = "resourceUndeadline" id = "resourceUndeadline"  readonly  value="<%= RESOURCE_UNDEADLINE%>"></input>
								</td>
								<th>
									ϵ������
								</th>
								<td>
								<%= resourcePercent%>
								<input type="hidden" id="resourcePercent" value="<%= resourcePercent%>">
								</td>
							</tr>
							<tr>
								<th>
									�µ������Ѷ�
								</th>
								<td>
								<%= resourceMonthPay%>
								<input  name = "resourceMonthPay" id = "resourceMonthPay"   type="hidden"  value="<%= resourceMonthPay%>"></input>
								</td>
								<th>
									˰��
								</th>
								<td>
								<%= taxPercent%>
								<input  name = "taxPercent" id = "taxPercent"   type="hidden"  value="<%= taxPercent%>"></input>
								</td>
							</tr>
							<tr>
								<th>
									˰��
								</th>
								<td>
								<%= taxFee%>
								<input type="hidden" id="taxFee" value="<%= taxFee%>">
								</td>
								<th>
									��˰���
								</th>
								<td>
								<%= marketPrice%>
								<input type="hidden" id="marketPrice" value="<%= marketPrice%>">
								</td>
							</tr>
						<%if("Y".equals(RESOURCE_COST_PREF)){ %>
								<tr>
									<th>
										���Żݶ��
									</th>
									<td>
										<%= RESOURCE_COST_TOTAL%>
									</td>
									<th>�Żݱ���</th>
									<td>
										<%= RESOURCE_COST_RAT%>
									</td>
								</tr>
						<%   }
						  }
						}%>

						</table>
							<div class="title">
						<div class="text">
							����ѡ��
						</div>
						</div>
							<table>						
								<tr>
									<%if("4".equals(RESOURCE_BUYTYPE)){ %>
										<th>IMEI��</th>
									<td>	<input type="text" name="imei_code" id="imei_code" readonly value=""/>
												<div id="td1" align="left">
									</td>
									<%} else{%>
								
									<th>IMEI��</th>
									<td>	<input type="text" name="imei_code" id="imei_code" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
												<input type="button" class="b_text" name="verifyRes" id="verifyRes" onclick="chkrBrand()" value="��֤"/>
												<font style="color:red"><b>*</b></font>
												<div id="td1" align="left">
									</td>
									<%} %>
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
								<tr>
									<th>����ʱ��(�·�)</th>
									<td><input type="text" name="quality_limit" id="quality_limit" value="12"/></td>
									<th>&nbsp;</th><td>&nbsp;</td>
								</tr>
							</table>
							<input type="hidden" id="resourceDetail" value="" />
							<input type="hidden" id="opType" value="<%= OP_TYPE %>" />
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
	});
	
	function closeWin(){
		closeDivWin();
	}
	
	function btnRsSubmit(){
	
		var resourceBrand = $("#resourceBrand").val();//Ʒ��
		var resourceModel = $("#resourceModel").val();//�ն��ͺ�
		var resourceCostPrice = $("#resourceCostPrice").val();//�ն˳ɱ�
		var resourceFee = $("#resourceFee").val();//������
		var imei_code = $("#imei_code").val();//IMEI
		var cmit_date = $("#cmit_date").val();//
		var quality_limit=$("#quality_limit").val();//
		var resourcePercent = $("#resourcePercent").val();
		var resourceMonthPay = $("#resourceMonthPay").val();
		var resourceUndeadline = $("#resourceUndeadline").val();//�������
		var resourceDetail = $("#resourceDetail").val();//����������/�����̱���/��������
		var opType = $("#opType").val();//�ն˴���Ʒ��Ŀ����opType
		
		if(parseFloat(resourceFee) < 0){
			showDialog("������С��0����ȷ���ն�������Ϣ��������ѡ�����ȯ���ն�!",0);
		 	return false;		
		}
		
		if(cmit_date==null||cmit_date=="null"||cmit_date==""){
			showDialog("��ѡ��ɽ���ʱ��!",0);
		 	return false;		
		}
	    if (quality_limit != "" && !(/(^[1-9]\d*$)/.test(quality_limit)))
        {
	       showDialog("��д����ʱ�޲���������������������!",0);
	       return false;	
        }
		desc = "�ն�Ʒ�ƣ�"+resourceBrand+"���ն��ͺţ�"+resourceModel+"��������";
		desc+=resourceFee+"Ԫ";
		
		/* if(resourceUndeadline!="" && resourceUndeadline!=null){
			desc+="���������"+resourceUndeadline+"����";
		} */
		if(quality_limit!="" && quality_limit!=null){
			desc+="������ʱ��"+quality_limit+"����";
		}
		if(resourcePercent!="" && resourcePercent!=null){
			desc+="��ϵ��������"+resourcePercent;
		}
		if(resourceMonthPay!="" && resourceMonthPay!=null){
			desc+="���µ������Ѷ"+resourceMonthPay+"Ԫ";
		}
		//�ύ����
		var money = parent.document.getElementById("pay_moneycouldhid").value;
		var resourceResCode = "0";
		var resbuyType = <%=RESOURCE_BUYTYPE%>;
	    if("4" == resbuyType){
		    resourceResCode = $("#resCode").val();

		}else{
			resourceResCode = "<%=RESOURCE_RES_CODE%>";
		}
		if("<%=scoreFeeTemp%>"!="0"){
			parent.document.getElementById("pay_moneycould").value=parseFloat(money)-parseFloat("<%=scoreFeeTemp%>");
		}
			
		parent.document.getElementById("resourceDetails<%=meansId%>").innerHTML = desc;
		parent.clientData(resourceCostPrice,resourceFee,imei_code,cmit_date,quality_limit,resourceBrand,resourceModel,
				resourceResCode,"<%=RESOURCE_BRAND_CODE%>","<%=RESOURCE_COST_TOTAL%>","<%=RESOURCE_COST_RAT%>",
				"<%=RESOURCE_UNDEADLINE%>",resourcePercent,resourceMonthPay,resourceDetail,"","","",opType,
				"<%=marketPrice%>","<%=taxPercent%>","<%=taxFee%>");
		parent.terminal_Checkfuc();
		closeDivWin();
	}
	function chkrBrand(){
		var imei_code = $("#imei_code").val();//IMEI
		var myPacket = null;
		if("<%=RESOURCE_BUYTYPE%>"=="1"){
			if(imei_code.length!=15){
				showDialog("�Ա�������ֻ����15λ��",2);
				return false;
			}
		}
		
		if("<%=OP_TYPE%>" != "4"){
			getImeiOpType();
		}
		var op_type = $("#opType").val();
		myPacket = new AJAXPacket("checkResource.jsp","���Ժ�...");
		myPacket.data.add("imei_code",imei_code);
		myPacket.data.add("RESOURCE_RES_CODE","<%=RESOURCE_RES_CODE%>");
		myPacket.data.add("OP_TYPE",op_type);
		myPacket.data.add("BUSS_TYPE","<%=BUSS_TYPE%>");
		myPacket.data.add("OP_ACCEPT","<%=orderId%>");
		myPacket.data.add("ACT_TYPE","<%=act_type%>");
		core.ajax.sendPacket(myPacket,doResourceCat);
		myPacket =null;
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
	
	function getImeiOpType(){
		var myPacket = null;
		myPacket = new AJAXPacket("getImeiOpType.jsp","���Ժ�...");
		myPacket.data.add("ORDER_ID","<%=orderId%>");
		myPacket.data.add("MEANS_ID","<%=meansId%>");
		myPacket.data.add("GROUP_ID","<%=groupid%>");
		core.ajax.sendPacket(myPacket,doResourceCats);
		myPacket =null;
	}	
	
	function doResourceCats(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var op_type = packet.data.findValueByName("OP_TYPE");
		if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}
		$("#opType").val(op_type);
	}
	
	function getTermInfoNew(){
	     var resbuyType = <%=RESOURCE_BUYTYPE%>;
	     if("4" != resbuyType){
			var myPacket = null;
			myPacket = new AJAXPacket("getTermInfoNew.jsp","���Ժ�...");
			myPacket.data.add("res_value","<%=RESOURCE_RES_CODE%>");
			core.ajax.sendPacket(myPacket,putTermInfoNew);
			myPacket =null;
		}	
	}
	
	function putTermInfoNew(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var res_cost_fee = packet.data.findValueByName("res_cost_fee");
		if(trim(RETURN_CODE)=="000000"){
			$("#resourceCostPrice").val(trim(res_cost_fee));	
			$("#res_cost_price_c").val(trim(res_cost_fee));	
		}else{
			$("#verifyRes").attr("disabled","disabled");
			showDialog("��ѯ�ն˳ɱ���ʧ�ܣ�����ϵ����Ա",1);
			return false;
		}
	}
	
	function imeiQuery(){
		var imeiNo = $("#input_imei").val();
		if(null == imeiNo || "" == imeiNo){
			showDialog("������imei�Ž��в�ѯ��",1);
			return;
		}
		var groupId = <%=groupid %>;
		var IS_4G = "<%=FOURG_FLAG %>";
		var CUSTOM_FLAG = "<%=CUSTOM_FLAG %>";
		var VOLTE_FLAG = "<%=VOLTE_FLAG %>";
		var VOLTE_FLAG = "<%=VOLTE_FLAG %>";
		var RESOUCE_CUSTOM_FLAG= "<%=RESOUCE_CUSTOM_FLAG %>";
		var myPacket = null;
		myPacket = new AJAXPacket("queryImei.jsp","���Ժ�...");
		myPacket.data.add("IS_4G",IS_4G);
		myPacket.data.add("CUSTOM_FLAG",CUSTOM_FLAG);
		myPacket.data.add("VOLTE_FLAG",VOLTE_FLAG);
		myPacket.data.add("RESOUCE_CUSTOM_FLAG",RESOUCE_CUSTOM_FLAG);
		myPacket.data.add("groupId",groupId);
		myPacket.data.add("imeiNo",imeiNo);
		core.ajax.sendPacket(myPacket,getTermiInfo);
		myPacket =null;
	}
	
	function  getTermiInfo(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var BRAND_NAME = packet.data.findValueByName("BRAND_NAME");	
		var BRAND_CODE = packet.data.findValueByName("BRAND_CODE");	
		var RES_NAME = packet.data.findValueByName("RES_NAME");	
		var RES_CODE = packet.data.findValueByName("RES_CODE");	
		var PRICE_VALUE = packet.data.findValueByName("PRICE_VALUE");
		var IS_4G = packet.data.findValueByName("IS_4G");
		var RES_TYPE = packet.data.findValueByName("RES_TYPE");
		var IS_VOLTE = packet.data.findValueByName("IS_VOLTE");
		var RESOUCE_CUSTOM_FLAG = packet.data.findValueByName("RESOUCE_CUSTOM_FLAG");
		$("#resCode").val(RES_CODE);
		var IS_4G_2 = "<%=FOURG_FLAG %>";
		var CUSTOM_FLAG_2 = "<%=CUSTOM_FLAG %>";
		var VOLTE_FLAG_2 = "<%=VOLTE_FLAG %>";
		var RESOUCE_CUSTOM_FLAG_2 = "<%=RESOUCE_CUSTOM_FLAG %>";
		if(trim(RETURN_CODE)=="000000"){
	 		$("#btnSubmit").attr("disabled",false);
		}else if(trim(RETURN_CODE) == "000002"){
			showDialog(RETURN_MSG,1);
			$("#btnSubmit").attr("disabled",true);
			return;
		}else if(trim(RETURN_CODE) != "000002" && trim(RETURN_CODE) != "000000"){
			var str1 = "";
			var str2 = "";
			var str3 = "";
			var str5 = "";
			if("0"==IS_4G_2){
				str1 = "������4G����,";
			}
			if("1"==IS_4G_2){
				str1 = "��������4G����,";
			}
			if("2"==IS_4G_2){
				str1 = "";
			}
			if("4"==RESOUCE_CUSTOM_FLAG_2){
				str1 = "ս����,";
			}
			if("1"==RESOUCE_CUSTOM_FLAG_2){
				str5 = "��Ⱥ�����,";
			}
			if("3"==RESOUCE_CUSTOM_FLAG_2){
				str5 = "������,";
			}
			if("2"==RESOUCE_CUSTOM_FLAG_2){
				str5 = "";
			}
			if("0"==VOLTE_FLAG_2){
				str2 = "������VOLTE,";
			}
			if("1"==VOLTE_FLAG_2){
				str2 = "��������VOLTE,";
			}
			if("2"==VOLTE_FLAG_2){
				str2 = "";
			}
			if("0"==CUSTOM_FLAG_2){
				str3 = "�����Ƕ���,";
			}
			if("1"==CUSTOM_FLAG_2){
				str3 = "�������Ƕ���,";
			}
			if("2"==CUSTOM_FLAG_2){
				str3 = "";
			}
			var str4="";
			if(IS_4G!=IS_4G_2 && IS_4G_2!="2"){
				str4 ="4GУ�鲻ͨ����";
			}
			if(IS_VOLTE!=VOLTE_FLAG_2 && VOLTE_FLAG_2!="2"){
				str4 ="�Ƿ�VOLTEУ�鲻ͨ����";
			}
			if(RES_TYPE!=CUSTOM_FLAG_2 && CUSTOM_FLAG_2!="2"){
				str4 ="�Ƿ���У�鲻ͨ����";
			}
			if(RESOUCE_CUSTOM_FLAG!=RESOUCE_CUSTOM_FLAG_2 && RESOUCE_CUSTOM_FLAG_2!="2"){
				str4 ="�ն˶�������У�鲻ͨ����";
			}
			alert(str5);
			var msg = RETURN_MSG+"! ������õ�����Ϊ��"+str1+str2+str3+str5+" ���������imeiУ����Ϊ��"+BRAND_NAME+RES_NAME+"Ʒ�ƻ��� ("+RES_CODE+") "+str4;

			showDialog(msg,1);
			$("#btnSubmit").attr("disabled",true);
			return;
		}else {
			showDialog(RETURN_MSG,1);
			$("#btnSubmit").attr("disabled",true);
			return;		
		}
		
		var imeiNo = $("#input_imei").val();
		$("#resourceBrand").val(BRAND_NAME);
		$("#resourceModel").val(BRAND_CODE);
		$("#res_cost_price_c").val(PRICE_VALUE);
		$("#imei_code").val(imeiNo);
	}
	
	</script>
</html>