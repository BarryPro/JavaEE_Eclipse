<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
version v3.0
开发商: si-tech
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
	/*调用产品库查询服务*/
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
		/* 先页面数据初始化 */
		getProductConMsg(0,"","","");
		/* 然后再页面样式初始化 */
		styleInit();
	}
	function styleInit(){

		/* 用户资源量下面的展开收起按钮事件 */
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
		/* 产品库选择部分初始化 */
		productStyleInit();
		/* 加浮动 */
		tooltipInit();
		bindSeachClick();
		/**/
		canChooseAInit();
		/*操作备注入默认值*/
		$("#opNote").val("营业员<%=workNo%>为<%=phoneNo%>用户办理新产品订购");
	}
	function canChooseAInit(){
		/*查询条件部分，初始化*/
		$(".product-search-item dl").each(function(){
			if($(this).attr("id") == "productList"){
				var seachSpanA1 = $(this).find("a:lt(4)");
				var seachSpanA2 = $(this).find("a:gt(3)");
				if(seachSpanA2.length > 0){
					seachSpanA2.hide();
					$(this).find("dd").append("<a atype='moreBtn' style='cursor:hand;' onclick='openSeach(this)'>[更多...]</a>");
				}
			}else{
				var seachSpanA1 = $(this).find("a:visible:lt(8)");
				var seachSpanA2 = $(this).find("a:visible:gt(7)");
				if(seachSpanA2.length > 0){
					seachSpanA2.hide();
					$(this).find("dd").append("<a atype='moreBtn' style='cursor:hand;' onclick='openSeach(this)'>[更多...]</a>");
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
		var getdataPacket = new AJAXPacket("fe759PubPriceRevoMsg.jsp","请稍后...");
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
		/* 用户资源量，当前使用、下月预约 点击触发的事件 */
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
		/* 产品库选择部分样式初始化 */
		$(".product-search-item a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
		});
	}
	function tooltipInit(){
		/* 加浮动 */
		var objs = $(".product-search-item a");
		objs.css("cursor","hand").tooltip();
	}
	function getProductConMsg(queryType,productType,productCode,effDate){
		//alert(queryType+"|"+productType+"|"+productCode+"|"+effDate);
		/*获取产品信息  queryType查询类型   productType产品标识*/
		/* 0代表查询产品分类 1代表查询分类条件  2失效时间 */
		var getdataPacket = new AJAXPacket("fe759_getProduct.jsp","请稍后...");
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
				/*查询产品分类，展示到页面的产品分类处*/
				var insertStr = "<a class='on' atype='unlimited'>不限</a>";
				$("#productList dd").append(insertStr);
				for(var i = 0; i < result.length; i++){
					prodTypeArr[i] = new Array(result[i][0],result[i][1]);
					insertStr = "<a value='" + result[i][0] + "' titleMsg='" + result[i][2] + "'>" + result[i][1] + "</a>";
					$("#productList dd").append(insertStr);
				}
				/* 绑定一下点击事件 */
				bindProdClick();
			}else if(queryType == "1"){
				//$(".product-search-item dl").eq(1).remove();
				$(".conditions").remove();
				var insertStr = "";
				insertStr = "<dl class='conditions'>";
				insertStr += "<dt>" + result[0][1] + "：</dt>";
				insertStr += "<dd>";
				insertStr += "<a style='CURSOR: hand' class='on' value='BX' atype='unlimited'>不限</a>";
				for(var i = 0; i < result.length; i++){
					insertStr += "<a style='CURSOR: hand' value='" + result[i][2] + "'>" + result[i][3] + "</a>";
				}
				insertStr += "</dd>";
				insertStr += "</dl>";
				$(".product-search-item dl").eq(0).after(insertStr);
				bindConditionClick();
			}else if(queryType == "2"){
				/*修改失效时间*/
				$("#pubExpDateHide").val(result[0][0]);
				var detailId = $("#pubDetailIdHide").val();
				$("#expDate_"+detailId).text(result[0][0]);
				changeEffDate(detailId,$("#pubEffDateHide").val(),result[0][0]);
			}
			
			productStyleInit();
			
		}
	}
	function getProdIns(){
		var getdataPacket = new AJAXPacket("fe759PubProdIns.jsp","请稍后...");
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
		/* 产品分类点击事件 */
		$("#productList a").click(function(){
			/** 点击产品分类事件 
					1、刷下下面的详细列表
					2、刷新可选购产品列表
			**/
			/*1、刷下下面的详细列表*/
			var clickVal = $(this).attr("value");
			/*标准库和促销库的链接集合*/
			var allShowLinkObj = $(".product-search-item a[prodLibCode]");
			var allBZKObj = $(".bzk a");
			var allCPKObj = $(".cpk a");
			$(".prodComment").remove();
			if(typeof(clickVal) != "undefined"){
				/* 判断是否是重复点击 */
				if($("#prodTypeHide").val() != clickVal){
					//$("#prodTypeHide").val(clickVal);
					getProductConMsg(1,clickVal,"","");
				}
				/***与选择的产品类型相同展示**/
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
				insertStr += "<dt>产品说明：</dt>";
				insertStr += "<dd>";
				insertStr += $(this).attr("titleMsg");
				insertStr += "</dd>";
				insertStr += "</dl>";
				$(".product-search-item dl").eq(0).after(insertStr);
			}else{
				/*点击的是不限*/
				//$("#prodTypeHide").val("");
				$(".conditions").remove();
				/**控制下面的展示，如果是不限，就都展示*/
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
		/*绑定搜索事件*/
		var aObj = $(".conditions").find("a");
		aObj.click(function(){
			getPage(1);
		});
	}
	function bindSeachClick(){
		/*绑定搜索事件*/
		var aObj = $(".product-search-item a");
		aObj.click(function(){
			getPage(1);
		});
	}

	function getPage(pageNum,sortClick){
		/* 获取产品库标识。 */
		//alert("getPage");
		var prodLibMarkObj = $(".cpk a[class='on']");
		var prodLibId = prodLibMarkObj.attr("prodLibId");
		if(typeof(prodLibId) == "undefined"){
			/*选择的是不限，要把所有的产品库代码拼串
				格式：#A#B#
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
		
		/* 获取产品分类标识 */
		var prodTypeObj = $("#productList a[class='on']");
		var prodTypeId = prodTypeObj.attr("value");
		if(typeof(prodTypeId) == "undefined"){
			/*选择的是不限，要把所有的产品分类代码拼串
				格式：#A#B#
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
		/* 获取查询条件标识 */
		var prodConditionObj = $(".conditions").find("a[class='on']");
		var prodConditionId = "";
		/* 产品选择了，可以继续查询产品分类的代码 */
		if(prodConditionObj.length == 0){
			/* 产品分类选择的不限 */
			prodConditionId = "BX";
		}else{
			prodConditionId = prodConditionObj.attr("value");
		}

		/* 获取排序标识 */
		var sortFlagVal = $("#sortHide").val();
		/* 获取标准库的offerName */
		var normOfferIdObj = $(".bzk a[class='on']");
		var normOfferId = normOfferIdObj.attr("prodCode");
		if(typeof(normOfferId) == "undefined"){
			normOfferId = "";
		}
		
		/*
			判断是否是重复点击
			如果都是重复点击，就不进行翻页查询了
			产品库、产品分类、条件标识、排序标识、页码
			注意也得判断排序标识、页码一样不。
			新增标准库，也需要判断
		*/
		var doubleClickFlag = true;
		if(prodLibId != $("#prodLibHide").val()){
			//alert("产品库新点击");
			doubleClickFlag = false;
		}
		if(prodTypeId != $("#prodTypeHide").val()){
			//alert("产品分类新点击");
			doubleClickFlag = false;
		}
		if(prodConditionObj.length > 0){
			/* 产品分类选择的不限 */
			if(prodConditionId != $("#prodConditionHide").val()){
				//alert("产品查询条件新点击");
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
			//alert("产品库新点击");
			doubleClickFlag = false;
		}
		
		/*
			记录查询条件，为了下次判断是否重复点击用
		*/
		$("#prodLibHide").val(prodLibId);
		$("#prodTypeHide").val(prodTypeId);
		$("#prodConditionHide").val(prodConditionId);
		$("#normOfferIdHide").val(normOfferId);
		if(doubleClickFlag == false){
			/*如果不是重复点击*/
		
			
			//alert("得刷新啊");
			/*
			alert(prodLibId);
			alert(prodTypeId);
			alert(prodConditionId);
			alert(sortFlagVal);
			alert(pageNum);
			*/
			var getdataPacket = new AJAXPacket("fe759_page.jsp","请稍后...");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			/* 产品库标识 */
			getdataPacket.data.add("productLib",prodLibId);
			/* 产品分类 */
			getdataPacket.data.add("productType",prodTypeId);
			/* 条件标识 */
			getdataPacket.data.add("condition",prodConditionId);
			/* 排序标识 */
			getdataPacket.data.add("sortFlag",sortFlagVal);
			/* 页码 */
			getdataPacket.data.add("pageNum",pageNum);
			/* 每页条数 */
			getdataPacket.data.add("recordNum","20");
			/* 标准库名称 */
			getdataPacket.data.add("normOfferId",normOfferId);
			
			core.ajax.sendPacketHtml(getdataPacket,doGetPageHtml);
			getdataPacket =null;
		}else{
			//alert("就不刷新了");
		}
	}
	function doGetPageHtml(data){
		$("#productSeachTable").empty();
		$("#productSeachTable").append(data);
		/* 加浮动 */
		$("#tableSelect22 span").tooltip();
		
		doCheckboxSelected();
	}
	function doCheckboxSelected(){
		var checkBoxObj = $("#tableSelect22 input[id^='seachProdCheck_']");
		$.each(checkBoxObj,function(i,n){
			var indexVal = getIndexProdMsg(n.value);
			if(indexVal != "-1"){
				/*这个已经选过了，让他挑中吧*/
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
		/*获取用户信息*/
		var getdataPacket = new AJAXPacket("/npage/public/pubGetUserBaseInfo.jsp","正在获得数据，请稍候......");
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
		/*可用预存*/
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
		/*还有下面的可用预存*/
		$("#prepayFee").text(now_prepayFee);
		$("#limitOwe").text(limitOwe);
		$("#stPMcard_name").text(stPMcard_name);
		$("#show1270V2").text(show1270V2);
		$("#stPMid_name").text(stPMid_name);
		/*四项费用项*/
		$("#nobillpay").text(nobillpay);
		$("#now_prepayFee").text(now_prepayFee);
		//$("#zx_yc_fee").text(zx_yc_fee);
		//$("#pt_yc_fee").text(pt_yc_fee);
	}
	function checkProd(detailId,clickType){
		/* 选择产品事件，可能是点击复选框，也可能是点击取消触发 */
		/* clickType    1点的是复选框   0点的是取消按钮 */
		/* 获取这个checkbox的选中状态，判断是添加还是取消 */
		var checkboxObj = $("#seachProdCheck_" + detailId);
		if(clickType == "1" && typeof(checkboxObj.attr("checked")) != "undefined" && checkboxObj.attr("checked") == true){
			/*是选中，即添加*/
			/*取值*/
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
			/*单价*/
			var prodDiscountPrice = $("#seachProdDiscountPrice_"+detailId).text();
			var minPrice = Number(prodOfferMin) * Number(prodDiscountPrice);
			/*单个的资源量*/
			var prodSumRes = $("#seachProdSumRes_"+detailId).text();
			var minSumRes = Number(prodOfferMin) * Number(prodSumRes);
			var prodType = $("#seachProdType_"+detailId).val();
			//alert(prodofferName + "," + prodLibMark + ","+ prodLibName + ","+ prodOfferMin + ","+ prodOfferMax + ","+ prodStock + ","+ prodBeginDate + ","+ prodEndDate + ","+ prodDiscountPrice + ",");
			/*判断一下剩余量和最小办理量*/
			if(Number(prodStock) < Number(prodOfferMin)){
				rdShowMessageDialog("该产品剩余量小于一次最小办理数量，请选择其他产品！",0);
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
				/*立即生效 和 预约生效（下月1号） 就不允许改生效日期了*/
				insertStr += "<td>" + "<input type=\"text\" name=\"startTime\" id=\"startTime_"+detailId+"\" readonly=\"readOnly\" class=\"InputGrey\" value='"+prodBeginDate+"' />" + "</td>";
			}else{
				insertStr += "<td>" + "<input type=\"text\" name=\"startTime\" id=\"startTime_"+detailId+"\" readonly=\"readOnly\" v_must=\"1\" onClick=\"WdatePicker({startDate:'"+prodBeginDate+"',dateFmt:'yyyyMMdd',minDate:'"+minDate97+"',maxDate:'"+maxDate97+"',readOnly:true,alwaysUseStartDate:true})\" value='"+prodBeginDate+"' onchange='getExpDate("+detailId+","+prodOfferId+",this.value)'/>" + "</td>";
			}
			getExpDate(detailId,prodOfferId,prodBeginDate);
			insertStr += "<td><span id='expDate_"+detailId+"'>" + $("#pubExpDateHide").val() + "</span></td>";
			
			/*
			可购买数量
			介于最小值和（最大值 和 剩余量的最小值）之间
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
			
			insertStr += "<td><span id='prodDiscountPrice_"+detailId+"'>" + prodDiscountPrice + "</span>元</td>";
			insertStr += "<td><span id='prodSumRes_"+detailId+"'>" + prodSumRes + "</span>" + prodResUnit + "</td>";
			insertStr += "<td><span id='prodTotalPrice_"+detailId+"'>" + minPrice + "</span>元</td>";
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
			/*取消*/
			$("#tableSelect22 input[id='seachProdCheck_"+detailId+"']").removeAttr("checked");
			$("#row_"+detailId).remove();
			/*还得更新对象*/
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
		/*修改某个产品的可购买数量*/
		/*修改本产品的总资源量，修改价格总计*/
		//alert(detailId);
		/*获取选择了多少个产品*/
		var selectNum = $("#prodOrderNum_"+detailId).val();
		var selectProdDiscountPrice = $("#prodDiscountPrice_"+detailId).text();
		var selectProdSumRes = $("#prodSumRes_"+detailId).text();
		var prodTypeId = $("#prodType_"+detailId).val();
		var prodTypeName = "";
		var totalPrice = Number(selectNum) * Number(selectProdDiscountPrice);
		var totalSumRes = Number(selectNum) * Number(selectProdSumRes);
		$("#prodTotalPrice_"+detailId).text(totalPrice);
		$("#prodTotalSumRes_"+detailId).text(totalSumRes);
		/*修改下面的总资源量，总消费金额*/
		
		var indexVal = getIndexProdMsg(detailId);
		var prodMsg = prodRevolution.getProd_msg(indexVal);
		prodMsg.setProdOrder_amount(""+selectNum);
		prodMsg.setTotal_price(""+totalPrice);
		prodMsg.setSource_amount(""+totalSumRes);
		updateProd(detailId,prodMsg);
	}
	function changeEffDate(detailId,effDate,expDate){
		/*修改某个产品的生效时间*/
		/*修改本产品的生效时间、失效时间*/
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
		/*刷新下面的总合计*/
		//alert("总计");
		var insertStr = "";
		for(var i = 0; i < prodRevolution.getSumResLength(); i++){
			var totalSumRes = prodRevolution.getTotalSumRes(i);
			var prodTypeName = totalSumRes.getProdTypeName();
			var prodSumRes = totalSumRes.getProdSumRes();
			var prodResUnit = totalSumRes.getProdResUnit();
			insertStr += prodTypeName + "：" + prodSumRes +" " + prodResUnit + "  ";
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
		/*增加了一个节点，已选购产品*/
		prodRevolution.addProd_msg(prodMsg);
		/*在节点增加的同时，还得更新总资源量*/
		refreshSumRes();
	}
	function removeProd(detailId){
		var flag = 0;
		for(var i = 0; i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			if(prodMsg.getProdLib_DetailId() == detailId){
				/*找到了，删除*/
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
		/*在节点改变的同时，还得更新总资源量*/
		refreshSumRes();
	}
	
	function refreshSumRes(){
		/*根据现在的宜选购产品信息列表，计算总资源量*/
		/*因为是重新计算，得清空一下*/
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
				/*是一个新的*/
				var prodTotalSumRes = new TotalSumRes();
				prodTotalSumRes.setProdTypeId(prodTypeId);
				prodTotalSumRes.setProdTypeName(prodTypeName);
				prodTotalSumRes.setProdSumRes(""+prodSumRes);
				prodTotalSumRes.setProdResUnit(prodResUnit);
				prodRevolution.addTotalSumRes(prodTotalSumRes);
			}else{
				/*已经有一个了，把现在的加进去*/
				var prodTotalSumRes = prodRevolution.getTotalSumRes(indexVal);
				var totalProdSumRes = Number(prodSumRes) + Number(prodTotalSumRes.getProdSumRes());
				prodRevolution.getTotalSumRes(indexVal).setProdSumRes(""+totalProdSumRes);
			}
		}
		prodRevolution.setPay_money(""+totalPay);
		changeBottomTotalRes();
	}
	
	function getIndexSumRes(prodTypeId){
		/* 在已选购的总资源量中，根据prodtypeid 获取索引值 */
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
		/* 在已选购的产品中，根据 detailId 获取索引值 */
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
			/*以前是降序，变升序*/
			$("#sale").find("s").css("background","url(images/icon-uparr.gif)");
			$("#sortHide").val("1");
		}else{
			/*以前是升序，变降序*/
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
			/*以前是升序，变降序*/
			$("#price").find("s").css("background","url(images/icon-downarr.gif)");
			$("#sortHide").val("2");
		}else{
			/*以前是降序，变升序*/
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
			rdShowMessageDialog("请至少选择一项产品！",0);
		  return false;
		}
		if(Number(prodRevolution.getProdLength()) > 50){
			rdShowMessageDialog("一次最多只允许订购50个产品，请删除一些！",0);
		  return false;
		}
		if(Number(prodRevolution.getPay_money()) > Number($("#prepayFee").text())){
			rdShowMessageDialog("选择的产品总消费金额大于用户预存，请先缴足预存款后，点击下方“刷新可用预存”按钮再提交订购信息。",0);
		  return false;
		}
		if(getByteLen($("#opNote").val()) > 60){
			rdShowMessageDialog("操作备注最多只能输入60字节",0);
		  return false;
		}
		
		
		return true;
	}
	function doNext(subButton){
		
		if(!checkPage()){
			return false;
		}
		
		/* 按钮延迟 */
		controlButt(subButton);

		/*拼接公共信息*/
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
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		
		if(rdShowConfirmDialog("请确认是否进行新产品办理")==1){	
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
		//得到该业务工单需要的参数
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		/********基本信息类**********/
		cust_info += "客户姓名：	"+$("#stPMcust_name").text()+"|";
		cust_info += "手机号码：	"+"<%=phoneNo%>"+"|";
		/********受理类**********/
    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"  " 
    		+ "用户品牌: "+$("#stPMsm_name").text()+ "|";
    opr_info += "办理业务：<%=opName%>"+"  "+"操作流水: "+"<%=printAccept%>" +"    总消费金额："+$("#totalFee").text()+"元"+"|";
    opr_info += "本次订购总资源量：" + $("#totalSumResBottom").text() + "|";
    /********备注区**********/
    note_info1 += "订购明细：" + "|";
    note_info1 += getProdListInfo();
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	}
	function getProdListInfo(){
		/*为免填单打印，从对象中获取详细信息*/
		var returnStr = "";
		for(var i = 0 ;i < prodRevolution.getProdLength(); i++){
			var prodMsg = prodRevolution.getProd_msg(i);
			returnStr +=  prodMsg.getOffer_name() 
									+ " 购买" + prodMsg.getProdOrder_amount() + "个"
									+ " 单价" + prodMsg.getDiscount_price() + "元"
									+ " 单资源量" + prodMsg.getDiscount_amount() + prodMsg.getResUnit()
									+ " 总价" + prodMsg.getTotal_price() + "元"
									+ " 总资源量" + prodMsg.getSource_amount() + prodMsg.getResUnit()
									+ "|";
		}
		return returnStr;
	}
</script>
<body class="second">
<form name="frm" method="post">
	<div id="Operation_Title">
	<div class="icon"></div>
		<B><font face="Arial"><%=WtcUtil.repNull(opCode)%></font>·<%=WtcUtil.repNull(opName)%></B>
	</div>
	<div class="prodContent">
	 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
	 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	 		<div class="m-box">
				<div class="m-box1-top">
					用户信息
				</div>
				<div class="m-box-txt2">
					<table class="cust-detail">
						<tr>
							<td>
								移动号码：
								<font class="cust-font" id="stPMvPhoneNo"></font>
							</td>
							<td>
								客户ID ：
								<font class="cust-font" id="stPMcust_id"></font>
							</td>
							<td>
								客户名称：
								<font class="cust-font" id="stPMcust_name"></font>
							</td>
							<td>
								业务品牌：
								<font class="cust-font" id="stPMsm_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								开户时间：
								<font class="cust-font" id="openTime"></font>
							</td>
							<td>
								运行状态：
								<font class="cust-font" id="stPMrun_name"></font>
							</td>
							<td>
								用户积分/M值：
								<font class="cust-font" id="show1270V2"></font>
							</td>
							<td>
								证件类型：
								<font class="cust-font" id="stPMid_name"></font>
							</td>
						</tr>
						<tr>
							<td>
								信誉度：
								<font class="cust-font" id="limitOwe"></font>
							</td>
							<td>
								大客户类别：
								<font class="cust-font" id="stPMcard_name"></font></font>
							</td>
							<td>
								本月消费金额：
								<font class="cust-font" id="nobillpay"></font>
							</td>
							<td>
								预存款余额：
								<font class="cust-font" id="now_prepayFee"></font>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="m-box">
				<div class="m-box1-top">
					用户资源量
				</div>
				<div class="m-box-txt2" id="stockTab">
					
				</div>
				<table>
					<tr><td>
						<div class="bottom-btn">
							<input type="button" id="fold" class="btn-style01" value="收 起" style="display: none"/>
							<input type="button" id="unfold" class="btn-style02" value="展 开" />
						</div>
				</td></tr>
				</table>
			</div>
	<!----- 已订购产品部分 ----->
	<div class="m-box">
		<div class="m-box1-top">
			近六个月记录
		</div>
		<div class="m-box-txt2" id="prodInsDiv">
			
		</div>
		<table>
			<tr><td>
				<div class="bottom-btn">
					<input type="button" id="prodFold" class="btn-style01" value="收 起" style="display: none"/>
					<input type="button" id="prodUnfold" class="btn-style02" value="展 开" />
				</div>
		</td></tr>
		</table>
	</div>
	<!----- 已订购产品部分  end ----->
	<!-- 选购产品部分 -->
		<div class="m-box">
			<div class="m-box1-top">
				可选购产品
			</div>
			<div class="m-box-txt2">
				<!-- 搜索条件部分 -->
				<div class="product-search">
					<div class="product-search-item">
						<dl class="prodConditions" id="productList">
							<dt>
								产&nbsp;&nbsp;&nbsp;&nbsp;品：
							</dt>
							<dd>
							</dd>
						</dl>
						<dl class="bzk" >
							<dt>
								标准产品：
							</dt>
							<dd>
								<a class="on">不限</a><%
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
								促销活动：
							</dt>
							<dd>
								<a class="on">不限</a><%
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
				<!-- 搜索条件部分 end......... -->
				<!---查询结果 start.....---->
				<div class="product-list" id="productSeachList">
					<div class="product-list-top">
						<dl class="plt-1">
						查询结果
						</dl>
						<dl class="plt-2">
							<a>
								<div id="sale" divval="down" class="sortbg" onclick="sortBySale()">按销量<s></s></div>
							</a>
							<a>
								<div id="price" divval="down" onclick="sortByPrice()">按价格</div>
							</a>
						</dl>
					</div>
					<div class="m-box-txt2" id="productSeachTable">
					</div>
				</div>
				<!---查询结果 end......--->
			</div>
		</div>
		<div class="m-box">
			<div class="m-box1-top">
				购物车
			</div>
			<div class="m-box-txt2">
				<table class="table-wrap" id="orderProdTab">
				<tr>
					<th>
						产品名称
					</th>
					<th>
						生效时间
					</th>
					<th>
						失效时间
					</th>
					<th>
						可购买数量
					</th>
					<th>
						单价
					</th>
					<th>
						资源量
					</th>
					<th>
						总价
					</th>
					<th>
						总资源量
					</th>
					<th>
						取消
					</th>		
				</tr>
			</table>
			</div>
		</div>
		<!---最下面--->
		<table cellspacing="0" class="bottom-tab">
			<tr>
				<td>
					总资源量：
					<span id="totalSumResBottom"></span>
				</td>
			</tr>
			<tr>
				<td>
					可用预存：
					<b id="prepayFee"></b>元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="刷新可用预存" class="b_text" onclick="refreshPrepay()"/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					总消费金额：
					<b id="totalFee"></b>元
				</td>
			</tr>
			<tr>
				<td>
					操作备注：
					&nbsp;&nbsp;
					<input type="text" id="opNote" value="" maxlength="60" size="100" />
				</td>
			</tr>
		</table>
		<table cellspacing="0">
			<tr id="footer"> 
				<td> 
					<div align="center"> 
					<input name="confirm" type="button" class="b_foot" value="确认提交" onClick="doNext(this)" />
					&nbsp; 
					<input name="clear" type="button" class="b_foot" value="清除" onClick="clearPage()" />
					&nbsp; 
					<input name="goBack" type="button" class="b_foot" value="返回" onClick="doBack()" />
					&nbsp; 
					<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
					&nbsp; 
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- 当前选中产品库标识，判断是否重复点击 -->
	<input type="hidden" id="prodLibHide"  />
	<!-- 当前选中产品标识，判断是否重复点击 -->
	<input type="hidden" id="prodTypeHide"  />
	<!-- 当前选中产品查询条件标识，判断是否重复点击 -->
	<input type="hidden" id="prodConditionHide"  />
	<!-- 当前选中标准库标识，判断是否重复点击 -->
	<input type="hidden" id="normOfferIdHide"  />
	
	<input type="hidden" id="sortHide" value="0" />
	<input type="hidden" id="pubDetailIdHide" />
	<input type="hidden" id="pubEffDateHide" />
	<input type="hidden" id="pubExpDateHide" />
	<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" id="myJSONText" name="myJSONText" />
	<!-- 用户资源量，判断是否加载 -->
	<input type="hidden" id="pubPriceRevoMsg" name="pubPriceRevoMsg" />
	<!-- 近六个月记录，判断是否加载 -->
	<input type="hidden" id="pubProdIns" name="pubProdIns" />
</form>
</body>
</html>
