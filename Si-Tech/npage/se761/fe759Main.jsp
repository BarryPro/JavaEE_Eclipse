<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
������: si-tech
ningtn 2012-4-9 09:29:41
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String phoneNo = request.getParameter("phoneNo");
  String cccTime=new java.text.SimpleDateFormat("yyyyMMdd HHmmss", Locale.getDefault()).format(new java.util.Date());
 	String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
<%
	/*���ò�Ʒ���ѯ����*/
%>
		<wtc:service name="sProdLibQry" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode" retmsg="retMsg" outnum="8">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="BC"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		<wtc:service name="sProdTypeConQry" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode2" retmsg="retMsg2" outnum="6">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="4"/>
		</wtc:service>
		<wtc:array id="result2" scope="end"/>
<%
	if(retCode.equals("000000")){
		System.out.println("ningtn fe759Main sProdLibQry ===" + result.length + " lll " + result2.length);
	}
%>

<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="pubProdScript.js"></script>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
<script language="javascript">
	var prodTypeArr = new Array();
	var prodRevolution = new Prod_Revolution();
	$(document).ready(function(){
		getUserBaseInfo();
		pageInit();
		getPage(1);
	});
	function pageInit(){
		/* ��ҳ�����ݳ�ʼ�� */
		getProductConMsg(0,"","","");
		/* Ȼ����ҳ����ʽ��ʼ�� */
		styleInit();
	}
	function styleInit(){

		/* �û���Դ�������չ������ť�¼� */
		$("#stockTab").hide();
		$("#fold").click(function(){
			$("#stockTab").hide("slow");
			$("#unfold").show();
			$("#fold").hide()
		});
		$("#unfold").click(function(){
			if($("#pubPriceRevoMsg").val() != "1"){
				getPriceRevoMsg();
			}
			$("#stockTab").show("slow");
			$("#unfold").hide();
			$("#fold").show();
		});
		$("#prodInsDiv").hide();
		$("#prodFold").click(function(){
			$("#prodInsDiv").hide("slow");
			$("#prodUnfold").show();
			$("#prodFold").hide()
		});
		$("#prodUnfold").click(function(){
			if($("#pubProdIns").val() != "1"){
				getProdIns();
			}
			$("#prodInsDiv").show("slow");
			$("#prodUnfold").hide();
			$("#prodFold").show();
		});
		/* ��Ʒ��ѡ�񲿷ֳ�ʼ�� */
		productStyleInit();
		/* �Ӹ��� */
		tooltipInit();
		bindSeachClick();
		/**/
		canChooseAInit();
		/*������ע��Ĭ��ֵ*/
		$("#opNote").val("ӪҵԱ<%=workNo%>Ϊ<%=phoneNo%>�û������²�Ʒ����");
	}
	function canChooseAInit(){
		/*��ѯ�������֣���ʼ��*/
		$(".product-search-item dl").each(function(){
			if($(this).attr("id") == "productList"){
				var seachSpanA1 = $(this).find("a:lt(4)");
				var seachSpanA2 = $(this).find("a:gt(3)");
				if(seachSpanA2.length > 0){
					seachSpanA2.hide();
					$(this).find("dd").append("<a atype='moreBtn' style='cursor:hand;' onclick='openSeach(this)'>[����...]</a>");
				}
			}else{
				var seachSpanA1 = $(this).find("a:visible:lt(8)");
				var seachSpanA2 = $(this).find("a:visible:gt(7)");
				if(seachSpanA2.length > 0){
					seachSpanA2.hide();
					$(this).find("dd").append("<a atype='moreBtn' style='cursor:hand;' onclick='openSeach(this)'>[����...]</a>");
				}
			}
			autoHeight();
		});
	}
	function openSeach(obj){
		$(obj).parent().find("a").show();
		$(obj).parent().find("a[atype='moreBtn']").remove();
		autoHeight();
	}
	function autoHeight(){
		$.each($(".product-search-item dl"),function(){
			$(this).css("height",$(this).find("dd")[0].clientHeight);
		});
	}
	function getPriceRevoMsg(){
		var getdataPacket = new AJAXPacket("fe759PubPriceRevoMsg.jsp","���Ժ�...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("qryType","3");
		getdataPacket.data.add("flag","0");
		core.ajax.sendPacketHtml(getdataPacket,doGetPriceRevoMsgHtml);
		getdataPacket =null;
	}
	function doGetPriceRevoMsgHtml(data){
		$("#stockTab").empty();
		$("#stockTab").append(data);
		$("#pubPriceRevoMsg").val("1");
		/* �û���Դ������ǰʹ�á�����ԤԼ ����������¼� */
		$(".cust-tab3-link a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
			num = $(".cust-tab3-link a").index($(this)[0]);
			$(".m-box-txt2 .tab-con").eq(num).show().siblings(".tab-con").hide();
		});
		
		$(".pubPriceProdType").css("cursor","hand").css("text-decoration","underline").click(function(){
			var typeId = $(this).attr("typeId");
			$.each($("#productList a"),function(i,n){
				if(typeId == $(this).attr("value")){
					$(this).click();
				}
			});
		});
	}
	function productStyleInit(){
		/* ��Ʒ��ѡ�񲿷���ʽ��ʼ�� */
		$(".product-search-item a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
		});
	}
	function tooltipInit(){
		/* �Ӹ��� */
		var objs = $(".product-search-item a");
		objs.css("cursor","hand").tooltip();
	}
	function getProductConMsg(queryType,productType,productCode,effDate){
		//alert(queryType+"|"+productType+"|"+productCode+"|"+effDate);
		/*��ȡ��Ʒ��Ϣ  queryType��ѯ����   productType��Ʒ��ʶ*/
		/* 0�����ѯ��Ʒ���� 1�����ѯ��������  2ʧЧʱ�� */
		var getdataPacket = new AJAXPacket("fe759_getProduct.jsp","���Ժ�...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("queryType",queryType);
		getdataPacket.data.add("productType",productType);
		getdataPacket.data.add("productCode",productCode);
		getdataPacket.data.add("effDate",effDate);
		core.ajax.sendPacket(getdataPacket,doProductConMsgBack);
		getdataPacket = null;
	}
	function doProductConMsgBack(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if(retCode == "000000"){
			var result = packet.data.findValueByName("result");
			var queryType = packet.data.findValueByName("queryType");
			//alert(queryType);
			if(queryType == "0"){
				/*��ѯ��Ʒ���࣬չʾ��ҳ��Ĳ�Ʒ���ദ*/
				var insertStr = "<a class='on' atype='unlimited'>����</a>";
				$("#productList dd").append(insertStr);
				for(var i = 0; i < result.length; i++){
					prodTypeArr[i] = new Array(result[i][0],result[i][1]);
					insertStr = "<a value='" + result[i][0] + "' titleMsg='" + result[i][2] + "'>" + result[i][1] + "</a>";
					$("#productList dd").append(insertStr);
				}
				/* ��һ�µ���¼� */
				bindProdClick();
			}else if(queryType == "1"){
				//$(".product-search-item dl").eq(1).remove();
				$(".conditions").remove();
				var insertStr = "";
				insertStr = "<dl class='conditions'>";
				insertStr += "<dt>" + result[0][1] + "��</dt>";
				insertStr += "<dd>";
				insertStr += "<a style='CURSOR: hand' class='on' value='BX' atype='unlimited'>����</a>";
				for(var i = 0; i < result.length; i++){
					insertStr += "<a style='CURSOR: hand' value='" + result[i][2] + "'>" + result[i][3] + "</a>";
				}
				insertStr += "</dd>";
				insertStr += "</dl>";
				$(".product-search-item dl").eq(0).after(insertStr);
				bindConditionClick();
			}else if(queryType == "2"){
				/*�޸�ʧЧʱ��*/
				$("#pubExpDateHide").val(result[0][0]);
				var detailId = $("#pubDetailIdHide").val();
				$("#expDate_"+detailId).text(result[0][0]);
				changeEffDate(detailId,$("#pubEffDateHide").val(),result[0][0]);
			}
			
			productStyleInit();
			
		}
	}
	function getProdIns(){
		var getdataPacket = new AJAXPacket("fe759PubProdIns.jsp","���Ժ�...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("opName","<%=opName%>");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("qryType","1");
		
		core.ajax.sendPacketHtml(getdataPacket,doProdInsHtml);
		getdataPacket =null;
	}
	function doProdInsHtml(data){
		$("#prodInsDiv").empty();
		$("#prodInsDiv").append(data);
		$("#pubProdIns").val("1");
	}
	function bindProdClick(){
		/* ��Ʒ�������¼� */
		$("#productList a").click(function(){
			/** �����Ʒ�����¼� 
					1��ˢ���������ϸ�б�
					2��ˢ�¿�ѡ����Ʒ�б�
			**/
			/*1��ˢ���������ϸ�б�*/
			var clickVal = $(this).attr("value");
			/*��׼��ʹ���������Ӽ���*/
			var allShowLinkObj = $(".product-search-item a[prodLibCode]");
			var allBZKObj = $(".bzk a");
			var allCPKObj = $(".cpk a");
			$(".prodComment").remove();
			if(typeof(clickVal) != "undefined"){
				/* �ж��Ƿ����ظ���� */
				if($("#prodTypeHide").val() != clickVal){
					//$("#prodTypeHide").val(clickVal);
					getProductConMsg(1,clickVal,"","");
				}
				/***��ѡ��Ĳ�Ʒ������ͬչʾ**/
				$.each(allShowLinkObj,function(i,n){
					if(typeof($(this).attr("prodLibType")) == "undefined" || $(this).attr("prodLibType") != 'B'){
						if($(this).attr("prodLibCode").indexOf(clickVal) != -1){
							$(this).show();
						}else{
							$(this).hide();
						}
					}
				});
				$(".product-search-item a[atype='moreBtn']").hide();
				var insertStr = "";
				insertStr = "<dl class='prodComment'>";
				insertStr += "<dt>��Ʒ˵����</dt>";
				insertStr += "<dd>";
				insertStr += $(this).attr("titleMsg");
				insertStr += "</dd>";
				insertStr += "</dl>";
				$(".product-search-item dl").eq(0).after(insertStr);
			}else{
				/*������ǲ���*/
				//$("#prodTypeHide").val("");
				$(".conditions").remove();
				/**���������չʾ������ǲ��ޣ��Ͷ�չʾ*/
				$.each(allShowLinkObj,function(i,n){
					if(typeof($(this).attr("prodLibType")) == "undefined" || $(this).attr("prodLibType") != 'B'){
						$(this).show();
					}
				});
				
			}
			allBZKObj.eq("0").click();
			allCPKObj.eq("0").click();
			canChooseAInit();
		});
	}
	function bindConditionClick(){
		$(".product-search-item a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
		});
		/*�������¼�*/
		var aObj = $(".conditions").find("a");
		aObj.click(function(){
			getPage(1);
		});
	}
	function bindSeachClick(){
		/*�������¼�*/
		var aObj = $(".product-search-item a");
		aObj.click(function(){
			getPage(1);
		});
	}

	function getPage(pageNum,sortClick){
		/* ��ȡ��Ʒ���ʶ�� */
		//alert("getPage");
		var prodLibMarkObj = $(".cpk a[class='on']");
		var prodLibId = prodLibMarkObj.attr("prodLibId");
		if(typeof(prodLibId) == "undefined"){
			/*ѡ����ǲ��ޣ�Ҫ�����еĲ�Ʒ�����ƴ��
				��ʽ��#A#B#
			*/
			prodLibId = "#";
			$.each($(".cpk a"),function(i,n){
				if(typeof($(n).attr("prodLibId")) != "undefined"){
					prodLibId += $(n).attr("prodLibId") + "#";
				}
			});
		}else{
			prodLibId = "#"+prodLibId+"#";
		}
		
		/* ��ȡ��Ʒ�����ʶ */
		var prodTypeObj = $("#productList a[class='on']");
		var prodTypeId = prodTypeObj.attr("value");
		if(typeof(prodTypeId) == "undefined"){
			/*ѡ����ǲ��ޣ�Ҫ�����еĲ�Ʒ�������ƴ��
				��ʽ��#A#B#
			*/
			prodTypeId = "#";
			$.each($("#productList a"),function(i,n){
				if(typeof($(n).attr("value")) != "undefined"){
					prodTypeId += $(n).attr("value") + "#";
				}
			});
		}else{
			prodTypeId = "#"+prodTypeId+"#";
		}
		/* ��ȡ��ѯ������ʶ */
		var prodConditionObj = $(".conditions").find("a[class='on']");
		var prodConditionId = "";
		/* ��Ʒѡ���ˣ����Լ�����ѯ��Ʒ����Ĵ��� */
		if(prodConditionObj.length == 0){
			/* ��Ʒ����ѡ��Ĳ��� */
			prodConditionId = "BX";
		}else{
			prodConditionId = prodConditionObj.attr("value");
		}

		/* ��ȡ�����ʶ */
		var sortFlagVal = $("#sortHide").val();
		/* ��ȡ��׼���offerName */
		var normOfferIdObj = $(".bzk a[class='on']");
		var normOfferId = normOfferIdObj.attr("prodCode");
		if(typeof(normOfferId) == "undefined"){
			normOfferId = "";
		}
		
		/*
			�ж��Ƿ����ظ����
			��������ظ�������Ͳ����з�ҳ��ѯ��
			��Ʒ�⡢��Ʒ���ࡢ������ʶ�������ʶ��ҳ��
			ע��Ҳ���ж������ʶ��ҳ��һ������
			������׼�⣬Ҳ��Ҫ�ж�
		*/
		var doubleClickFlag = true;
		if(prodLibId != $("#prodLibHide").val()){
			//alert("��Ʒ���µ��");
			doubleClickFlag = false;
		}
		if(prodTypeId != $("#prodTypeHide").val()){
			//alert("��Ʒ�����µ��");
			doubleClickFlag = false;
		}
		if(prodConditionObj.length > 0){
			/* ��Ʒ����ѡ��Ĳ��� */
			if(prodConditionId != $("#prodConditionHide").val()){
				//alert("��Ʒ��ѯ�����µ��");
				doubleClickFlag = false;
			}
		}
		if(sortClick == 1){
			doubleClickFlag = false;
		}
		if(pageNum != $("#nowPageHide").val()){
			doubleClickFlag = false;
		}
		
		if(normOfferId != $("#normOfferIdHide").val()){
			//alert("��Ʒ���µ��");
			doubleClickFlag = false;
		}
		
		/*
			��¼��ѯ������Ϊ���´��ж��Ƿ��ظ������
		*/
		$("#prodLibHide").val(prodLibId);
		$("#prodTypeHide").val(prodTypeId);
		$("#prodConditionHide").val(prodConditionId);
		$("#normOfferIdHide").val(normOfferId);
		if(doubleClickFlag == false){
			/*��������ظ����*/
		
			
			//alert("��ˢ�°�");
			/*
			alert(prodLibId);
			alert(prodTypeId);
			alert(prodConditionId);
			alert(sortFlagVal);
			alert(pageNum);
			*/
			var getdataPacket = new AJAXPacket("fe759_page.jsp","���Ժ�...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			/* ��Ʒ���ʶ */
			getdataPacket.data.add("productLib",prodLibId);
			/* ��Ʒ���� */
			getdataPacket.data.add("productType",prodTypeId);
			/* ������ʶ */
			getdataPacket.data.add("condition",prodConditionId);
			/* �����ʶ */
			getdataPacket.data.add("sortFlag",sortFlagVal);
			/* ҳ�� */
			getdataPacket.data.add("pageNum",pageNum);
			/* ÿҳ���� */
			getdataPacket.data.add("recordNum","20");
			/* ��׼������ */
			getdataPacket.data.add("normOfferId",normOfferId);
			
			core.ajax.sendPacketHtml(getdataPacket,doGetPageHtml);
			getdataPacket =null;
		}else{
			//alert("�Ͳ�ˢ����");
		}
	}
	function doGetPageHtml(data){
		$("#productSeachTable").empty();
		$("#productSeachTable").append(data);
		/* �Ӹ��� */
		$("#tableSelect22 span").tooltip();
		
		doCheckboxSelected();
	}
	function doCheckboxSelected(){
		var checkBoxObj = $("#tableSelect22 input[id^='seachProdCheck_']");
		$.each(checkBoxObj,function(i,n){
			var indexVal = getIndexProdMsg(n.value);
			if(indexVal != "-1"){
				/*����Ѿ�ѡ���ˣ��������а�*/
				$(n).attr("checked","checked");
			}
		});
		
	}
	function goPage(pageNum){
		if(pageNum == 0){
			pageNum = $("#pageText").val().trim();
			if(pageNum == ""){
				return false;
			}
			if(!checkElement($("#pageText")[0])){
				return false;
			}
		}
		if(Number(pageNum) > Number($("#allPageHide").val())){
			return false;
		}
		if(Number(pageNum) == 0){
			return false;
		}
		getPage(pageNum);
	}
	function getUserBaseInfo(){
		/*��ȡ�û���Ϣ*/
		var getdataPacket = new AJAXPacket("/npage/public/pubGetUserBaseInfo.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(getdataPacket,doGetPrypayBack);
		getdataPacket = null;
	}
	function doGetPrypayBack(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var stPMvPhoneNo = packet.data.findValueByName("stPMvPhoneNo");
		var stPMcust_id = packet.data.findValueByName("stPMcust_id");
		var stPMcust_name = packet.data.findValueByName("stPMcust_name");
		var stPMsm_name = packet.data.findValueByName("stPMsm_name");
		var openTime = packet.data.findValueByName("openTime");
		var stPMrun_name = packet.data.findValueByName("stPMrun_name");
		var unbillFee = packet.data.findValueByName("unbillFee");
		/*����Ԥ��*/
		var stPMtotalPrepay = packet.data.findValueByName("stPMtotalPrepay");
		var stPMgrpbig_name = packet.data.findValueByName("stPMgrpbig_name");
		var stPMcard_name = packet.data.findValueByName("stPMcard_name");
		var show1270V2 = packet.data.findValueByName("show1270V2");
		var stPMid_name = packet.data.findValueByName("stPMid_name");
		var nobillpay = packet.data.findValueByName("nobillpay").trim();
		var now_prepayFee = packet.data.findValueByName("now_prepayFee").trim();
		var zx_yc_fee = packet.data.findValueByName("zx_yc_fee").trim();
		var pt_yc_fee = packet.data.findValueByName("pt_yc_fee").trim();
		var limitOwe = packet.data.findValueByName("limitOwe").trim();
		$("#stPMvPhoneNo").text(stPMvPhoneNo);
		$("#stPMcust_id").text(stPMcust_id);
		$("#stPMcust_name").text(stPMcust_name);
		$("#stPMsm_name").text(stPMsm_name);
		$("#openTime").text(openTime);
		$("#stPMrun_name").text(stPMrun_name);
		$("#unbillFee").text(unbillFee);
		/*��������Ŀ���Ԥ��*/
		$("#prepayFee").text(now_prepayFee);
		$("#limitOwe").text(limitOwe);
		$("#stPMcard_name").text(stPMcard_name);
		$("#show1270V2").text(show1270V2);
		$("#stPMid_name").text(stPMid_name);
		/*���������*/
		$("#nobillpay").text(nobillpay);
		$("#now_prepayFee").text(now_prepayFee);
		//$("#zx_yc_fee").text(zx_yc_fee);
		//$("#pt_yc_fee").text(pt_yc_fee);
	}
	function checkProd(detailId,clickType){
		/* ѡ���Ʒ�¼��������ǵ����ѡ��Ҳ�����ǵ��ȡ������ */
		/* clickType    1����Ǹ�ѡ��   0�����ȡ����ť */
		/* ��ȡ���checkbox��ѡ��״̬���ж�����ӻ���ȡ�� */
		var checkboxObj = $("#seachProdCheck_" + detailId);
		if(clickType == "1" && typeof(checkboxObj.attr("checked")) != "undefined" && checkboxObj.attr("checked") == true){
			/*��ѡ�У������*/
			/*ȡֵ*/
			var prodOfferId = $("#seachProdOfferId_"+detailId).val();
			var prodofferName = $("#seachProdOfferName_"+detailId).text();
			var prodLibMark = $("#seachProdLib_"+detailId).val();
			var prodLibName = $("#seachProdLibName_"+detailId).val();
			var prodResUnit = $("#seachProdResUnit_"+detailId).text();
			var prodOfferMin = $("#seachProdOfferMin_"+detailId).val();
			var prodOfferMax = $("#seachProdOfferMax_"+detailId).val();
			var prodStock = $("#seachProdStock_"+detailId).text();
			var prodBeginDate = $("#seachProdBeginDate_"+detailId).text().substring(0,8);
			var minDate97 = prodBeginDate.substring(0,4)+"-"+prodBeginDate.substring(4,6)+"-"+prodBeginDate.substring(6,8);
			var maxDate97 = prodBeginDate.substring(0,4)+"-{"+(Number(prodBeginDate.substring(4,6))+3)+"}-"+prodBeginDate.substring(6,8);
			var prodEndDate = $("#seachProdEndDate_"+detailId).text();
			var prodEffWay = $("#seachProdEffWay_"+detailId).val();
			/*����*/
			var prodDiscountPrice = $("#seachProdDiscountPrice_"+detailId).text();
			var minPrice = Number(prodOfferMin) * Number(prodDiscountPrice);
			/*��������Դ��*/
			var prodSumRes = $("#seachProdSumRes_"+detailId).text();
			var minSumRes = Number(prodOfferMin) * Number(prodSumRes);
			var prodType = $("#seachProdType_"+detailId).val();
			//alert(prodofferName + "," + prodLibMark + ","+ prodLibName + ","+ prodOfferMin + ","+ prodOfferMax + ","+ prodStock + ","+ prodBeginDate + ","+ prodEndDate + ","+ prodDiscountPrice + ",");
			/*�ж�һ��ʣ��������С������*/
			if(Number(prodStock) < Number(prodOfferMin)){
				rdShowMessageDialog("�ò�Ʒʣ����С��һ����С������������ѡ��������Ʒ��",0);
				$("#tableSelect22 input[id='seachProdCheck_"+detailId+"']").removeAttr("checked");
		  	return false;
			}
			var insertStr = "<tr id='row_"+detailId+"'>";
			insertStr += "<td>" + prodofferName;
			insertStr += "<input type='hidden' id='prodOfferId_"+detailId+"' value='"+prodOfferId+"' />";
			insertStr += "<input type='hidden' id='prodofferName_"+detailId+"' value='"+prodofferName+"' />";
			insertStr += "<input type='hidden' id='prodType_"+detailId+"' value='"+prodType+"' />";
			insertStr += "</td>";
			if(prodEffWay == "0" || prodEffWay == "2"){
				/*������Ч �� ԤԼ��Ч������1�ţ� �Ͳ��������Ч������*/
				insertStr += "<td>" + "<input type=\"text\" name=\"startTime\" id=\"startTime_"+detailId+"\" readonly=\"readOnly\" class=\"InputGrey\" value='"+prodBeginDate+"' />" + "</td>";
			}else{
				insertStr += "<td>" + "<input type=\"text\" name=\"startTime\" id=\"startTime_"+detailId+"\" readonly=\"readOnly\" v_must=\"1\" onClick=\"WdatePicker({startDate:'"+prodBeginDate+"',dateFmt:'yyyyMMdd',minDate:'"+minDate97+"',maxDate:'"+maxDate97+"',readOnly:true,alwaysUseStartDate:true})\" value='"+prodBeginDate+"' onchange='getExpDate("+detailId+","+prodOfferId+",this.value)'/>" + "</td>";
			}
			getExpDate(detailId,prodOfferId,prodBeginDate);
			insertStr += "<td><span id='expDate_"+detailId+"'>" + $("#pubExpDateHide").val() + "</span></td>";
			
			/*
			�ɹ�������
			������Сֵ�ͣ����ֵ �� ʣ��������Сֵ��֮��
			*/
			var prodMax = prodOfferMax;
			if(Number(prodStock) < Number(prodOfferMax)){
				prodMax = prodStock
			}
			insertStr += "<td><select style='width:45px;' id='prodOrderNum_"+detailId+"' onchange='changeOrderNum("+detailId+")'>";
			for(var i = Number(prodOfferMin); i <= Number(prodMax); i++){
				insertStr += "<option value='"+i+"'>"+i+"</option>";
			}
			insertStr += "</select></td>";
			
			insertStr += "<td><span id='prodDiscountPrice_"+detailId+"'>" + prodDiscountPrice + "</span>Ԫ</td>";
			insertStr += "<td><span id='prodSumRes_"+detailId+"'>" + prodSumRes + "</span>" + prodResUnit + "</td>";
			insertStr += "<td><span id='prodTotalPrice_"+detailId+"'>" + minPrice + "</span>Ԫ</td>";
			insertStr += "<td><span id='prodTotalSumRes_"+detailId+"'>" + minSumRes + "</span>" + prodResUnit + "</td>";
			insertStr += "<td><img src='images/task-item-close1.gif' style='cursor:hand;' onClick='checkProd(\""+detailId+"\",\"0\")'/></td>";
			insertStr += "</tr>";
			$("#orderProdTab").append(insertStr);
			var prodMsg = new Prod_msg();
			prodMsg.setProdTypeId(prodType);
			prodMsg.setProdOrder_amount(prodOfferMin);
			prodMsg.setDiscount_amount(""+prodSumRes);
			prodMsg.setSource_amount(""+minSumRes);
			prodMsg.setResUnit(prodResUnit);
			prodMsg.setProdLib_DetailId(detailId);
			prodMsg.setNewofferid(prodOfferId);
			prodMsg.setOffer_name(prodofferName);
			prodMsg.setDiscount_price(prodDiscountPrice);
			prodMsg.setTotal_price(""+minPrice);
			prodMsg.setBegin_time(prodBeginDate);
			prodMsg.setEnd_time($("#pubExpDateHide").val());
			prodMsg.setOper("1");
			prodMsg.setProd_instId("");
			addProd(prodMsg);
		}else{
			/*ȡ��*/
			$("#tableSelect22 input[id='seachProdCheck_"+detailId+"']").removeAttr("checked");
			$("#row_"+detailId).remove();
			/*���ø��¶���*/
			removeProd(detailId);
		}
	}
	
	function getExpDate(detailId,prodOfferId,effDate){
		//alert(prodOfferId + "," + effDate);
		$("#pubDetailIdHide").val(detailId);
		$("#pubEffDateHide").val(effDate)
		//alert("getExpDate" + detailId +","+prodOfferId+","+effDate);
		getProductConMsg(2,"",prodOfferId,effDate)
	}
	
	function changeOrderNum(detailId){
		/*�޸�ĳ����Ʒ�Ŀɹ�������*/
		/*�޸ı���Ʒ������Դ�����޸ļ۸��ܼ�*/
		//alert(detailId);
		/*��ȡѡ���˶��ٸ���Ʒ*/
		var selectNum = $("#prodOrderNum_"+detailId).val();
		var selectProdDiscountPrice = $("#prodDiscountPrice_"+detailId).text();
		var selectProdSumRes = $("#prodSumRes_"+detailId).text();
		var prodTypeId = $("#prodType_"+detailId).val();
		var prodTypeName = "";
		var totalPrice = Number(selectNum) * Number(selectProdDiscountPrice);
		var totalSumRes = Number(selectNum) * Number(selectProdSumRes);
		$("#prodTotalPrice_"+detailId).text(totalPrice);
		$("#prodTotalSumRes_"+detailId).text(totalSumRes);
		/*�޸����������Դ���������ѽ��*/
		
		var indexVal = getIndexProdMsg(detailId);
		var prodMsg = prodRevolution.getProd_msg(indexVal);
		prodMsg.setProdOrder_amount(""+selectNum);
		prodMsg.setTotal_price(""+totalPrice);
		prodMsg.setSource_amount(""+totalSumRes);
		updateProd(detailId,prodMsg);
	}
	function changeEffDate(detailId,effDate,expDate){
		/*�޸�ĳ����Ʒ����Чʱ��*/
		/*�޸ı���Ʒ����Чʱ�䡢ʧЧʱ��*/
		//alert("changeEffDate:" + detailId+","+effDate+","+expDate);
		
		var indexVal = getIndexProdMsg(detailId);
		if(indexVal != -1){
			var prodMsg = prodRevolution.getProd_msg(indexVal);
			prodMsg.setBegin_time(""+effDate);
			prodMsg.setEnd_time(""+expDate);
			updateProd(detailId,prodMsg);
		}
	}
	
	function changeBottomTotalRes(){
		/*ˢ��������ܺϼ�*/
		//alert("�ܼ�");
		var insertStr = "";
		for(var i = 0; i < prodRevolution.getSumResLength(); i++){
			var totalSumRes = prodRevolution.getTotalSumRes(i);
			var prodTypeName = totalSumRes.getProdTypeName();
			var prodSumRes = totalSumRes.getProdSumRes();
			var prodResUnit = totalSumRes.getProdResUnit();
			insertStr += prodTypeName + "��" + prodSumRes +" " + prodResUnit + "  ";
		}
		
		$("#totalSumResBottom").text(insertStr);
		$("#totalFee").text(prodRevolution.getPay_money());
	}
	
	function getProdNameById(prodTypeId){
		var returnProdName = "";
		$.each(prodTypeArr,function(i,n){
			if(prodTypeId == n[0]){
				returnProdName = n[1];
			}
		});
		return returnProdName;
	}
	
	function addProd(prodMsg){
		/*������һ���ڵ㣬��ѡ����Ʒ*/
		prodRevolution.addProd_msg(prodMsg);
		/*�ڽڵ����ӵ�ͬʱ�����ø�������Դ��*/
		refreshSumRes();
	}
	function removeProd(detailId){
		var flag = 0;
		for(var i = 0; i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			if(prodMsg.getProdLib_DetailId() == detailId){
				/*�ҵ��ˣ�ɾ��*/
				flag = 1;
			}
			if(flag == 1){
				prodRevolution.setProd_msg(i,prodRevolution.getProd_msg(i+1));
			}
		}
		prodRevolution.prodLength = Number(prodRevolution.getProdLength())-1;
		prodRevolution.prod_msgs.length = Number(prodRevolution.getProdLength());
		refreshSumRes();
	}
	function updateProd(detailId,prodMsg){
		var indexVal = getIndexProdMsg(detailId);
		prodRevolution.setProd_msg(indexVal,prodMsg);
		/*�ڽڵ�ı��ͬʱ�����ø�������Դ��*/
		refreshSumRes();
	}
	
	function refreshSumRes(){
		/*�������ڵ���ѡ����Ʒ��Ϣ�б���������Դ��*/
		/*��Ϊ�����¼��㣬�����һ��*/
		prodRevolution.sumResLength = 0;
		prodRevolution.totalSumReses = [];
		var totalPay = 0;
		for(var i = 0; i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			var prodTypeId = prodMsg.getProdTypeId();
			var prodTypeName = getProdNameById(prodTypeId);
			var prodSumRes = prodMsg.getSource_amount();
			var prodResUnit = prodMsg.getResUnit();
			var indexVal = getIndexSumRes(prodTypeId);
			totalPay += Number(prodMsg.getTotal_price());
			if(indexVal == -1){
				/*��һ���µ�*/
				var prodTotalSumRes = new TotalSumRes();
				prodTotalSumRes.setProdTypeId(prodTypeId);
				prodTotalSumRes.setProdTypeName(prodTypeName);
				prodTotalSumRes.setProdSumRes(""+prodSumRes);
				prodTotalSumRes.setProdResUnit(prodResUnit);
				prodRevolution.addTotalSumRes(prodTotalSumRes);
			}else{
				/*�Ѿ���һ���ˣ������ڵļӽ�ȥ*/
				var prodTotalSumRes = prodRevolution.getTotalSumRes(indexVal);
				var totalProdSumRes = Number(prodSumRes) + Number(prodTotalSumRes.getProdSumRes());
				prodRevolution.getTotalSumRes(indexVal).setProdSumRes(""+totalProdSumRes);
			}
		}
		prodRevolution.setPay_money(""+totalPay);
		changeBottomTotalRes();
	}
	
	function getIndexSumRes(prodTypeId){
		/* ����ѡ��������Դ���У�����prodtypeid ��ȡ����ֵ */
		var indexVal = -1;
		for(var i = 0; i < prodRevolution.getSumResLength(); i++){
			var prodTotalSumRes = prodRevolution.getTotalSumRes(i);
			if(prodTotalSumRes.getProdTypeId() == prodTypeId){
				indexVal = i;
			}
		}
		return indexVal;
	}
	function getIndexProdMsg(detailId){
		/* ����ѡ���Ĳ�Ʒ�У����� detailId ��ȡ����ֵ */
		var indexVal = -1;
		for(var i = 0; i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			if(prodMsg.getProdLib_DetailId() == detailId){
				indexVal = i;
			}
		}
		return indexVal;
	}
	
	function sortBySale(){
		if($("#sale").find("s").length == 0){
			$("#sale").append("<s></s>");
			$("#price").removeClass();
			$("#price").find("s").remove();
		}
		$("#sale").removeClass().addClass("sortbg");
		if($("#sortHide").val() == "0"){
			/*��ǰ�ǽ��򣬱�����*/
			$("#sale").find("s").css("background","url(images/icon-uparr.gif)");
			$("#sortHide").val("1");
		}else{
			/*��ǰ�����򣬱併��*/
			$("#sale").find("s").css("background","url(images/icon-downarr.gif)");
			$("#sortHide").val("0");
		}
		getPage(1,1);
	}
	function sortByPrice(){
		if($("#price").find("s").length == 0){
			$("#price").append("<s></s>");
			$("#sale").removeClass();
			$("#sale").find("s").remove();
		}
		$("#price").removeClass().addClass("sortbg");
		if($("#sortHide").val() == "3"){
			/*��ǰ�����򣬱併��*/
			$("#price").find("s").css("background","url(images/icon-downarr.gif)");
			$("#sortHide").val("2");
		}else{
			/*��ǰ�ǽ��򣬱�����*/
			$("#price").find("s").css("background","url(images/icon-uparr.gif)");
			$("#sortHide").val("3");
		}
		getPage(1,1);
	}
	function refreshPrepay(){
		getUserBaseInfo();
	}
	function getByteLen(str){ 
		var byteLen=0,len=str.length; 
		if(str){ 
			for(var i=0; i<len; i++){ 
				if(str.charCodeAt(i)>255){ 
					byteLen += 2; 
				} 
				else{ 
					byteLen++; 
				} 
			} 
			return byteLen; 
		} 
		else{ 
			return 0; 
		} 
	}
	function checkPage(){
		if(prodRevolution.getProdLength() == 0){
			rdShowMessageDialog("������ѡ��һ���Ʒ��",0);
		  return false;
		}
		if(Number(prodRevolution.getProdLength()) > 50){
			rdShowMessageDialog("һ�����ֻ������50����Ʒ����ɾ��һЩ��",0);
		  return false;
		}
		if(Number(prodRevolution.getPay_money()) > Number($("#prepayFee").text())){
			rdShowMessageDialog("ѡ��Ĳ�Ʒ�����ѽ������û�Ԥ�棬���Ƚ���Ԥ���󣬵���·���ˢ�¿���Ԥ�桱��ť���ύ������Ϣ��",0);
		  return false;
		}
		if(getByteLen($("#opNote").val()) > 60){
			rdShowMessageDialog("������ע���ֻ������60�ֽ�",0);
		  return false;
		}
		
		
		return true;
	}
	function doNext(subButton){
		
		if(!checkPage()){
			return false;
		}
		
		/* ��ť�ӳ� */
		controlButt(subButton);

		/*ƴ�ӹ�����Ϣ*/
		prodRevolution.setCreate_accept($("#printAccept").val());
		prodRevolution.setChnsource("01");
		prodRevolution.setOpCode("<%=opCode%>");
		prodRevolution.setLoginNo("<%=workNo%>");
		prodRevolution.setPassword("<%=password%>");
		prodRevolution.setPhone_no("<%=phoneNo%>");
		prodRevolution.setPass_word("");
		prodRevolution.setOp_note($("#opNote").val());
		prodRevolution.setIpAddr("<%=ipAddr%>");
		var myJSONText = JSON.stringify(prodRevolution,function(key,value){
				return value;
				});
		//alert(myJSONText);
		$("#myJSONText").val(myJSONText);
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		if(rdShowConfirmDialog("��ȷ���Ƿ�����²�Ʒ����")==1){	
			showLightBox();
			frm.action="fe759Cfm.jsp";
			frm.submit();
		}	
	}
	function clearPage(){
		location = "/npage/se761/fe759Main.jsp?phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function doBack(){
		window.location.href="fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
	}
	function showPrtDlg(printType,DlgMessage,submitCfm){   
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1";
		var sysAccept = "<%=printAccept%>";
		var phone_no = "<%=phoneNo%>";
		var fav_code = null;
		var area_code = null;
		var mode_code = null;
		var printStr = printInfo(printType);
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		
		return ret;
	}
	function printInfo(){
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		/********������Ϣ��**********/
		cust_info += "�ͻ�������	"+$("#stPMcust_name").text()+"|";
		cust_info += "�ֻ����룺	"+"<%=phoneNo%>"+"|";
		/********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"  " 
    		+ "�û�Ʒ��: "+$("#stPMsm_name").text()+ "|";
    opr_info += "����ҵ��<%=opName%>"+"  "+"������ˮ: "+"<%=printAccept%>" +"    �����ѽ�"+$("#totalFee").text()+"Ԫ"+"|";
    opr_info += "���ζ�������Դ����" + $("#totalSumResBottom").text() + "|";
    /********��ע��**********/
    note_info1 += "������ϸ��" + "|";
    note_info1 += getProdListInfo();
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	}
	function getProdListInfo(){
		/*Ϊ�����ӡ���Ӷ����л�ȡ��ϸ��Ϣ*/
		var returnStr = "";
		for(var i = 0 ;i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			returnStr +=  prodMsg.getOffer_name() 
									+ " ����" + prodMsg.getProdOrder_amount() + "��"
									+ " ����" + prodMsg.getDiscount_price() + "Ԫ"
									+ " ����Դ��" + prodMsg.getDiscount_amount() + prodMsg.getResUnit()
									+ " �ܼ�" + prodMsg.getTotal_price() + "Ԫ"
									+ " ����Դ��" + prodMsg.getSource_amount() + prodMsg.getResUnit()
									+ "|";
		}
		return returnStr;
	}
</script>
<body class="second">
<form name="frm" method="post">
	<div id="Operation_Title">
	<div class="icon"></div>
		<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>��<%=WtcUtil.repNull(opName)%></B>
	</div>
	<div class="prodContent">
	 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
	 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	 		<div class="m-box">
				<div class="m-box1-top">
					�û���Ϣ
				</div>
				<div class="m-box-txt2">
					<table class="cust-detail">
						<tr>
							<td>
								�ƶ����룺
								<font class="cust-font" id="stPMvPhoneNo"></font>
							</td>
							<td>
								�ͻ�ID ��
								<font class="cust-font" id="stPMcust_id"></font>
							</td>
							<td>
								�ͻ����ƣ�
								<font class="cust-font" id="stPMcust_name"></font>
							</td>
							<td>
								ҵ��Ʒ�ƣ�
								<font class="cust-font" id="stPMsm_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								����ʱ�䣺
								<font class="cust-font" id="openTime"></font>
							</td>
							<td>
								����״̬��
								<font class="cust-font" id="stPMrun_name"></font>
							</td>
							<td>
								�û�����/Mֵ��
								<font class="cust-font" id="show1270V2"></font>
							</td>
							<td>
								֤�����ͣ�
								<font class="cust-font" id="stPMid_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								�����ȣ�
								<font class="cust-font" id="limitOwe"></font>
							</td>
							<td>
								��ͻ����
								<font class="cust-font" id="stPMcard_name"></font></font>
							</td>
							<td>
								�������ѽ�
								<font class="cust-font" id="nobillpay"></font>
							</td>
							<td>
								Ԥ�����
								<font class="cust-font" id="now_prepayFee"></font>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="m-box">
				<div class="m-box1-top">
					�û���Դ��
				</div>
				<div class="m-box-txt2" id="stockTab">
					
				</div>
				<table>
					<tr><td>
						<div class="bottom-btn">
							<input type="button" id="fold" class="btn-style01" value="�� ��" style="display: none"/>
							<input type="button" id="unfold" class="btn-style02" value="չ ��" />
						</div>
				</td></tr>
				</table>
			</div>
	<!----- �Ѷ�����Ʒ���� ----->
	<div class="m-box">
		<div class="m-box1-top">
			�������¼�¼
		</div>
		<div class="m-box-txt2" id="prodInsDiv">
			
		</div>
		<table>
			<tr><td>
				<div class="bottom-btn">
					<input type="button" id="prodFold" class="btn-style01" value="�� ��" style="display: none"/>
					<input type="button" id="prodUnfold" class="btn-style02" value="չ ��" />
				</div>
		</td></tr>
		</table>
	</div>
	<!----- �Ѷ�����Ʒ����  end ----->
	<!-- ѡ����Ʒ���� -->
		<div class="m-box">
			<div class="m-box1-top">
				��ѡ����Ʒ
			</div>
			<div class="m-box-txt2">
				<!-- ������������ -->
				<div class="product-search">
					<div class="product-search-item">
						<dl class="prodConditions" id="productList">
							<dt>
								��&nbsp;&nbsp;&nbsp;&nbsp;Ʒ��
							</dt>
							<dd>
							</dd>
						</dl>
						<dl class="bzk" >
							<dt>
								��׼��Ʒ��
							</dt>
							<dd>
								<a class="on">����</a><%
								if(result2 != null && result2.length > 0){
									for(int i = 0; i < result2.length; i++){
								%><a title="<%=result2[i][2]%>" prodCode="<%=result2[i][0]%>" prodLibCode="<%=result2[i][5]%>"><%=result2[i][1]%></a><%
									}
								}
								%>
							</dd>
						</dl>
						<dl class="cpk" >
							<dt>
								�������
							</dt>
							<dd>
								<a class="on">����</a><%
								if(result != null && result.length > 0){
									for(int i = 0; i < result.length; i++){
								%><a title="<%=result[i][4]%>" prodLibId="<%=result[i][0]%>" prodLibFlack="<%=result[i][5]%>" prodLibCode="<%=result[i][7]%>" prodLibType="<%=result[i][6]%>" <%if("B".equals(result[i][6])){%>style="display:none;"<%}%>><%=result[i][1]%></a><%
									}
								}
								%>
							</dd>
						</dl>
						
					</div>
				</div>
				<!-- ������������ end......... -->
				<!---��ѯ��� start.....---->
				<div class="product-list" id="productSeachList">
					<div class="product-list-top">
						<dl class="plt-1">
						��ѯ���
						</dl>
						<dl class="plt-2">
							<a>
								<div id="sale" divval="down" class="sortbg" onclick="sortBySale()">������<s></s></div>
							</a>
							<a>
								<div id="price" divval="down" onclick="sortByPrice()">���۸�</div>
							</a>
						</dl>
					</div>
					<div class="m-box-txt2" id="productSeachTable">
					</div>
				</div>
				<!---��ѯ��� end......--->
			</div>
		</div>
		<div class="m-box">
			<div class="m-box1-top">
				���ﳵ
			</div>
			<div class="m-box-txt2">
				<table class="table-wrap" id="orderProdTab">
				<tr>
					<th>
						��Ʒ����
					</th>
					<th>
						��Чʱ��
					</th>
					<th>
						ʧЧʱ��
					</th>
					<th>
						�ɹ�������
					</th>
					<th>
						����
					</th>
					<th>
						��Դ��
					</th>
					<th>
						�ܼ�
					</th>
					<th>
						����Դ��
					</th>
					<th>
						ȡ��
					</th>		
				</tr>
			</table>
			</div>
		</div>
		<!---������--->
		<table cellspacing="0" class="bottom-tab">
			<tr>
				<td>
					����Դ����
					<span id="totalSumResBottom"></span>
				</td>
			</tr>
			<tr>
				<td>
					����Ԥ�棺
					<b id="prepayFee"></b>Ԫ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="ˢ�¿���Ԥ��" class="b_text" onclick="refreshPrepay()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					�����ѽ�
					<b id="totalFee"></b>Ԫ
				</td>
			</tr>
			<tr>
				<td>
					������ע��
					&nbsp;&nbsp;
					<input type="text" id="opNote" value="" maxlength="60" size="100" />
				</td>
			</tr>
		</table>
		<table cellspacing="0">
			<tr id="footer"> 
				<td> 
					<div align="center"> 
					<input name="confirm" type="button" class="b_foot" value="ȷ���ύ" onClick="doNext(this)" />
					&nbsp; 
					<input name="clear" type="button" class="b_foot" value="���" onClick="clearPage()" />
					&nbsp; 
					<input name="goBack" type="button" class="b_foot" value="����" onClick="doBack()" />
					&nbsp; 
					<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
					&nbsp; 
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- ��ǰѡ�в�Ʒ���ʶ���ж��Ƿ��ظ���� -->
	<input type="hidden" id="prodLibHide"  />
	<!-- ��ǰѡ�в�Ʒ��ʶ���ж��Ƿ��ظ���� -->
	<input type="hidden" id="prodTypeHide"  />
	<!-- ��ǰѡ�в�Ʒ��ѯ������ʶ���ж��Ƿ��ظ���� -->
	<input type="hidden" id="prodConditionHide"  />
	<!-- ��ǰѡ�б�׼���ʶ���ж��Ƿ��ظ���� -->
	<input type="hidden" id="normOfferIdHide"  />
	
	<input type="hidden" id="sortHide" value="0" />
	<input type="hidden" id="pubDetailIdHide" />
	<input type="hidden" id="pubEffDateHide" />
	<input type="hidden" id="pubExpDateHide" />
	<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" id="myJSONText" name="myJSONText" />
	<!-- �û���Դ�����ж��Ƿ���� -->
	<input type="hidden" id="pubPriceRevoMsg" name="pubPriceRevoMsg" />
	<!-- �������¼�¼���ж��Ƿ���� -->
	<input type="hidden" id="pubProdIns" name="pubProdIns" />
</form>
</body>
</html>
