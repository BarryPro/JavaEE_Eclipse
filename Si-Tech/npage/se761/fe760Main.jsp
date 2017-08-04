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

<link href="css/prodRevoStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="pubProdScript.js"></script>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>
<script language="javascript">
	var prodRevolution = new Prod_Revolution();
	$(document).ready(function(){
		getUserBaseInfo();
		getProdIns();
		/*操作备注入默认值*/
		$("#opNote").val("营业员<%=workNo%>为<%=phoneNo%>用户办理新产品取消");
		bindChooseAll();
	});
	function bindChooseAll(){
		/*绑定上全选事件*/
		$("#chooseAll").click(function(){
			var checkedVal = $(this).attr("checked");
			if(typeof(checkedVal) == "undefined"){
				$(":checkbox").removeAttr("checked");
			}else if(checkedVal == true){
				/*全选*/
				$(":checkbox").attr("checked",true);
			}
		});
		$(":checkbox[id^='pubProdLibInsId_']").click(function(){
			var prodCheckboxVal = $(this).attr("checked");
			if(typeof(prodCheckboxVal) == "undefined"){
				$("#chooseAll").removeAttr("checked");
			}else{
				var allCheckFlag = true;
				$(":checkbox[id^='pubProdLibInsId_']").each(function(){
					if(typeof($(this).attr("checked")) == "undefined"){
						allCheckFlag = false;
					}
				});
				if(allCheckFlag){
					$("#chooseAll").attr("checked",true);
				}
			}
		});
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
		//$("#prepayFee").text(stPMtotalPrepay);
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
	function getProdIns(){
		var getdataPacket = new AJAXPacket("fe759PubProdIns.jsp","请稍后...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("opName","<%=opName%>");
		getdataPacket.data.add("phoneNo","<%=phoneNo%>");
		getdataPacket.data.add("qryType","0");
		
		core.ajax.sendPacketHtml(getdataPacket,doProdInsHtml);
		getdataPacket =null;
	}
	function doProdInsHtml(data){
		$("#productSeachTable").empty();
		$("#productSeachTable").append(data);
	}
	function clearPage(){
		location = "/npage/se761/fe760Main.jsp?phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
	}
	function doBack(){
		window.location.href="fe759Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
	}
	function checkPage(){
		var checkboxObj = $(":checkbox[id^='pubProdLibInsId_'][@checked]");
		if(checkboxObj.length == 0){
			rdShowMessageDialog("请至少选择一条产品后操作",0);
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
		prodRevolution = new Prod_Revolution();
		createPord();
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
		
		if(rdShowConfirmDialog("请确认是否进行新产品取消")==1){	
			showLightBox();
			frm.action="fe759Cfm.jsp";
			frm.submit();
		}
	}
	function createPord(){
		var checkboxObj = $(":checkbox[id^='pubProdLibInsId_'][@checked]");
		$.each(checkboxObj,function(i,n){
			var prodMsg = new Prod_msg();
			prodMsg.setProdOrder_amount($("#pubProdOffAmount_"+n.value).text());
			prodMsg.setSource_amount(""+$("#pubProdSumRes_"+n.value).text());
			prodMsg.setResUnit(""+$("#pubProdResUtil_"+n.value).text());
			prodMsg.setNewofferid($("#pubProdOfferId_"+n.value).val());
			prodMsg.setOffer_name($("#pubProdOfferName_"+n.value).text());
			prodMsg.setTotal_price($("#pubProdSumPrice_"+n.value).text());
			/*服务，取JSON串，不能带冒号，数字还得有双引号*/
			var beginTime = $("#pubProdEffDate_"+n.value).text();
			var endTime = $("#pubProdExpDate_"+n.value).text();
			beginTime = replaceAllSign(beginTime);
			endTime = replaceAllSign(endTime);
			prodMsg.setBegin_time(beginTime);
			prodMsg.setEnd_time(endTime);
			prodMsg.setOper("3");
			prodMsg.setProd_instId(n.value);
			prodMsg.setOld_accept($("#pubProdOldAccept_"+n.value).val());
			prodMsg.setProdLib_DetailId($("#pubProdLibDetalId_"+n.value).val());
			var firstTime = $("#pubProdFirstTime_"+n.value).val();
			firstTime = replaceAllSign(firstTime);
			prodMsg.setTable_date(firstTime.substring(0,6));
			prodRevolution.addProd_msg(prodMsg);
		});
	}
	function replaceAllSign(str){
		/*服务，取JSON串，不能带冒号，数字还得有双引号*/
		str = str.replace(/\//g,"");
		str = str.replace(/\:/g,"");
		str = str.replace(/\-/g,"");
		return str;
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
    opr_info += "办理业务：<%=opName%>"+"  "+"操作流水: "+"<%=printAccept%>" + "|";
    /********备注区**********/
    note_info1 += "取消明细：" + "|";
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
									+ " 取消" + prodMsg.getProdOrder_amount() + "个"
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
			<!---查询结果--->
			<div class="product-list" id="productSeachList">
				<div class="product-list-top">
					<dl class="plt-1">
					查询结果
					</dl>
				</div>
				<div class="m-box-txt2" id="productSeachTable">
					
				</div>
			</div>
			<!---查询结果--->

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
		<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
		<input type="hidden" id="opNote" value="" maxlength="60" size="100" />
		<input type="hidden" id="myJSONText" name="myJSONText" />
	</form>
</body>
