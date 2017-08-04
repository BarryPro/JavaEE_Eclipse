<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%	
	int totalMoney = 0;
	String reginCode = (String) session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");
	String password =(String)session.getAttribute("password");
	String actType = request.getParameter("actType");
	String svcNum = request.getParameter("svcNum");
	String orderId = request.getParameter("orderId");
	String meansId = request.getParameter("meansId");
	String netCode = request.getParameter("netCode");
	String memNo = request.getParameter("memNo");
	String memFee = request.getParameter("memFee");
	String memAddFee = request.getParameter("memAddFee");
	String memFund = request.getParameter("memFund");
	String memSysFee = request.getParameter("memSysFee");
	String familyLowType = request.getParameter("familyLowType");
	String netScoreMoney = request.getParameter("netScoreMoney");
	String spNetFlag = request.getParameter("spNetFlag");
	
	System.out.println("netCode========================="+netCode);
	System.out.println("memNo=========================\n"+memNo);
	System.out.println("memFee=========================\n"+memFee);
	System.out.println("memAddFee=========================\n"+memAddFee);
	System.out.println("memFund=========================\n"+memFund);
	System.out.println("memSysFee=========================\n"+memSysFee);
	System.out.println("familyLowType=========================\n"+familyLowType);
	System.out.println("netScoreMoney=========================\n"+netScoreMoney);
	System.out.println("spNetFlag=========================\n"+spNetFlag);
	
	/**
	   getMemberData.jsp中sQryBroadInfoWS_XML 服务的入参：oper_type,默认为0，如果是魔百和SP业务，则oper_type=2
	*/
	
	String operType = "0";
	if("Y".equals(spNetFlag) && "16".equals(actType)){
		operType = "2";
	}else if("Y".equals(spNetFlag) && "19".equals(actType)){
		operType = "4";
	}
	System.out.println("operType=========================\n"+operType);

	String xml = memNo + memFee + memAddFee + memFund + memSysFee+familyLowType;
	MapBean mb = new MapBean();	
%>
<%@ include file="getMapBean.jsp"%>
<%
//modify 2014-3-13 19:12:58 start
	String lowType = "";
	String lowFee = "";
	String lowTypec = "";
	List lowTypeList =  mb.getList("OUT_DATA.H47");
	if(lowTypeList != null && lowTypeList.size() >0){
		lowType = mb.getString("OUT_DATA.H47.LOW_TYPE");//
		if("0".equals(lowType)){
			lowTypec="成员合计抵消方式";
		}else if("1".equals(lowType)){
			lowTypec="仅家长设置低消";
		}
		lowFee = mb.getString("OUT_DATA.H47.LOW_FEE");//
	}
	
//modify 2014-3-13 19:12:58 end	
	List memMapList = mb.getList("OUT_DATA.H15.MEMBER_LIST.MEMBER_INFO");
	List fundMapList = mb.getList("OUT_DATA.H18.FUND_LIST.FUND_INFO");
	if("N/A".equals(fundMapList.get(0)))fundMapList = new ArrayList();
	List sysPayMapList = mb.getList("OUT_DATA.H19.SYSPAY_LIST.SYSPAY_INFO");
	if("N/A".equals(sysPayMapList.get(0)))sysPayMapList = new ArrayList();
	List memList = new ArrayList();
	List freeMemList = new ArrayList();
	System.out.println("memMapList size=========================="+memMapList.size());
	for(int i=0; i<memMapList.size(); i++){
		System.out.println("i=========================="+i);
		Map memMap = (Map)memMapList.get(i);
		String memberType = (String)memMap.get("MEMBER_TYPE");
		String memberNumType = (String)memMap.get("MEMBER_NUM_TYPE");
		String payValue = (String)memMap.get("PAY_VALUE");
		String sysPayValue = (String)memMap.get("SYSPAY_VALUE");
		String memberTypeStr = "";
		int iPayValue = Integer.parseInt(payValue);
		totalMoney += iPayValue;
		if("P".equals(memberType)){
			memberTypeStr = "手机成员";
		}
		if("T".equals(memberType)){
			memberTypeStr = "TD固话成员";
		}
		if("B".equals(memberType)){
			memberTypeStr = "宽带成员";
		}
		System.out.println("|||||||||||||||||||||||||||||||||||MEMBER_TYPE="+memberType+"|||MEMBER_NUM_TYPE"+memberNumType);
		if("1".equals(memberNumType)){
			memList.add(new String[]{memberType, payValue, sysPayValue, memberTypeStr});
		}
		//新增 成员数量类型 不固定（公式）
		if("0".equals(memberNumType) || "2".equals(memberNumType)  ){
			freeMemList.add(new String[]{memberType, memberTypeStr,memberNumType});
		}
	}
	//成员专款
	String fundFree = "0";
	if(fundMapList.size() > 0){
		Map fundValue = (Map)fundMapList.get(0);
		fundFree = (String)fundValue.get("FUNDS_FREE");
		int iPayValue = Integer.parseInt(fundFree);
		totalMoney += iPayValue;
	}
	//成员系统充值
	String sysPayFree = "0";
	if(sysPayMapList.size() > 0){
		Map sysPayValue = (Map)sysPayMapList.get(0);
		sysPayFree = (String)sysPayValue.get("SYS_FREE");
	}
%>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation"><div id="operation_table">
			<div class="title">
				<div class = "text" onclick = "showMemberList('fixed')">
					固定成员列表
				</div>
			</div>
			<div class="input" id="member_list_fixed">
				<table id='table_member'>
					<tr>
						<th>分配状态</th>
						<th>成员类型</th>
						<th>专款金额</th>
						<th>系统充值金额</th>
						<th>操作</th>
					</tr>
					<%
					for(int i=0; i<memList.size(); i++){ 
						String[] member = (String[])memList.get(i);%>
						<tr id="tr_member_<%=i%>">
							<td id="td_member_statue_<%=i %>">未分配</td>
							<td><%=member[3] %></td>
							<td><%=member[1] %></td>
							<td><%=member[2] %></td>
							<td>
								<input type="button" class="b_text" id="b_member_choose_<%=i %>" value="分配" 
									onclick="addMember('<%=i %>','<%=member[0]%>', '<%=member[1]%>', '<%=member[2]%>')"/>
								<input type="button" style="display : none" class="b_text" id="b_member_reset_<%=i %>" value="重置" onclick="resetMember('<%=i%>')"/>
								<input type="hidden" name="member_value" id="hid_member_value_<%=i %>" />
								<input type="hidden" name="member_print" id="hid_member_print_<%=i %>" />
								<input type="hidden" id="member_fund_value_<%=i %>" value="<%=member[1]%>"/>
								<input type="hidden" id="member_sysPay_value_<%=i %>" value="<%=member[2]%>"/>
							</td>
						</tr>
					<%} %>
				</table>
			</div>
			<div class="title">
				<div class = "text" onclick = "showMemberList('free')">
					自由分配成员列表
				</div>
			</div>
			<div class="input" id="member_list_free" style="display : none">
				<table id='table_free_info'>
					<tr><th>可分配专款</th><th>已经分配专款</th><th>可分配系统充值</th><th>已分配系统充值</th></tr>
					<tr><td><%=fundFree %></td><td id="used_fund">0</td><td><%=sysPayFree %></td><td id="used_sysPay">0</td></tr>
					<tr><th colspan='3'>成员类型</th><th>操作</th></tr>
					<%
					for(int i=0; i<freeMemList.size(); i++) {
						String[] member = (String[])freeMemList.get(i);%>
						<tr><td colspan='3'><%=member[1] %></td>
						<td><input value="分配" type="button" class="b_text" onclick="addFreeMember('<%=member[0]%>','<%=member[2]%>')"></td></tr>
					<%} %>
				</table>
				<table id='table_free_member'>
					<tr><th>成员号码</th><th>成员类型</th><th>专款金额</th><th>系统充值金额</th><th>操作</th></tr>
				</table>
			</div>
		</div></div>
		<div id="order_info" style="display:none">
		<div id="operation_table">
			<div class="title">
				<div class = "text">
					成员订购信息
				</div>
			</div>
			<div class="input" id="order_html">
			</div>
		</div>
		</div>
	<%if (!"".equals(lowTypec) && !"".equals(lowType) ){ %>
		<div id="operation_table">
			<div class="title">
				<div class = "text">
					家庭低消信息
				</div>
			</div>
			<div class="input" id="lowTypediv">
				<th>低消类型：  <%=lowTypec %></th>  
				<th>低消金额：  <%=lowFee %>  </th>  
			</div>
		</div>
	<%} %>
		<div id="operation_button">
			<input type="button" class="b_foot" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="submitAll()" />
			<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
		</div>
	</body>
	<script type="text/javascript">
		var gFreeId = 100;//自由分配成员ID
		
		//--------------------------选中行改变背景色-------------------------------------
		function chooseTr(memberNo){
			var trs = $("#table_member tr");
			for(var i=1; i<trs.size(); i++){
				var trId = $(trs[i]).attr("id");
				if("tr_member_"+memberNo == trId){
					$(trs[i]).css({background : "#20cccc"});
				}else{
					$(trs[i]).css({background : "#ffffff"});
				}
			}
		}
		//--------------------------新增成员-------------------------------------
		function addMember(memberNo, type, funds, sysPay){
			$("#order_html").html("");
			chooseTr(memberNo);
			var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/memberOrderInfo.jsp","请稍后...");
			packet.data.add("memberNo",memberNo);
			packet.data.add("xml","<%=xml %>");
			packet.data.add("type", type);
			packet.data.add("funds", funds);
			packet.data.add("sysPay", sysPay);
			packet.data.add("netCode", "<%=netCode %>");
			core.ajax.sendPacketHtml(packet,renderOrderInfo,true);
			packet = null;
		}
		function addFreeMember(type,memberNumType){
			var usedFund = $("#used_fund").text();
			var usedSysPay = $("#used_sysPay").text();
			if(usedFund == "<%=fundFree%>" && usedSysPay == "<%=sysPayFree%>"){
				showDialog("已经没有可供分配的专款和系统充值余额",1);
				return;
			}
			addMember("-1", type, "", "");
		}
		function renderOrderInfo(renderHtml){
			$("#order_info").css("display","block");
			$("#order_html").html(renderHtml);
			//家庭类处理逻辑 屏蔽所有专款和系统充值的选项
			limitFamilyMoney();
		}
		
		function limitFamilyMoney(){
			var hid_coefficientSys = $("#hid_coefficientSys").val();
			var hid_CoefficientFun = $("#hid_CoefficientFun").val();
			if(hid_CoefficientFun){
				$("#fund_value_0").attr("readonly","readonly");
				$("#fund_value_1").attr("readonly","readonly");
			}
			if(hid_coefficientSys){
				$("#sysPay_value_0").attr("readonly","readonly");
				$("#sysPay_value_1").attr("readonly","readonly");
			}
		}
		
		function familyMoneyfund(){
			//家庭专款计算
			var fund_value = $("#fund_value").val();
			if(!isInt(fund_value)){
				alert("总额必须是正整数！");
				$("#fund_value").val("");
				return;
			}
			if(fund_value%60!=0){
				showDialog("专款金额必须为60的倍数，请修改！",1);
				$("#fund_value").val("");
				return;
			}
			var hid_CoefficientFun = $("#hid_CoefficientFun").val();
			if(hid_CoefficientFun == '1' || hid_CoefficientFun == '2' || hid_CoefficientFun == '3'){
			//底线预存=（总预存款/60向下取整-活动预存调整系数）*60；如果这个公式算出来的底线预存为负值，则底线预存直接变为0！
				var fund_value_1 = "0";
				if(Math.floor(fund_value/60) > hid_CoefficientFun){
					fund_value_1 =  (Math.floor(fund_value/60)-hid_CoefficientFun)*60;//底线
				}
				var fund_value_0 = fund_value - fund_value_1;//活动
				$("#fund_value_0").val(fund_value_0);
				$("#fund_value_1").val(fund_value_1);
			}else{
				$("#fund_value").val("");
				alert("活动配置错误，请联系活动配置人员");
			}
		}
		function familyMoneySysPay(){
			//家庭系统充值计算
			var sysPay_value = $("#sysPay_value").val();
			if(!isInt(sysPay_value)){
				alert("总额必须是正整数！");
				$("#fund_value").val("");
				return;
			}
			if(sysPay_value%60!=0){
				showDialog("专款金额必须为60的倍数，请修改！",1);
				$("#sysPay_value").val("");
				return;
			}
			var hid_coefficientSys = $("#hid_coefficientSys").val();
			
			if(hid_coefficientSys =='1' || hid_coefficientSys == '2' || hid_coefficientSys == '3'){
				familyTypePhone = true ;
			//底线预存=（总预存款/60向下取整-活动预存调整系数）*60；如果这个公式算出来的底线预存为负值，则底线预存直接变为0！
				var sysPay_value_1 = "0";
				if(Math.floor(sysPay_value/60) > hid_coefficientSys){
					sysPay_value_1 = (Math.floor(sysPay_value/60)-hid_coefficientSys)*60;//底线
				}
				var sysPay_value_0 = sysPay_value - sysPay_value_1;//活动
				$("#sysPay_value_0").val(sysPay_value_0);
				$("#sysPay_value_1").val(sysPay_value_1);
			}else{
				$("#sysPay_value").val("");
				alert("活动配置错误，请联系活动配置人员");
			}
			
		}
		
		//--------------------------新增成员 END-------------------------------------
		//--------------------------成员分配-------------------------------------
		/**分配成员全局变量组 20130726 sunzj	
		 *因为资费要调用异步方法，只有等所有异步方法全部返回之后才可以继续处理
		 *因此使用全局变量储存全部的数据，等阻塞消失之后保存分配成员信息
		 *每当点击"分配"时初始化所有全局变量
		*/
		//号码信息参数组
		var gFreeFlag = "";
		var gMemNo = "";
		var gMemberId = "";//手机号
		var gPassword = "";
		var gIdNo = "";
		var gCustId = "";
		var gGroupId = "";
		var gSmCode = "";
		var gModeCode = "";//当前主资费
		var gMemType = "";//成员类型
		var gPrintInfo = "";//打印信息
		
		//主方法参数组
		var gMainPass = false;
		var gMemFee = "";//主资费 
		var gMemFeeValid = "";//主资费生效方式
		var gPreNetFlag = "";//续签宽带资费转换类型 5包年转包年 4包月转包年
		var gMemAddFee = "";//附加资费
		//--附加资费生效时间服务参数
		var gMemberIdStr = "";
		var gAddFeeOperType = "";
		var gAddFeeDateType = "";
		var gAddFeeOfferType = "";
		var gAddFeeUnit = "";
		var gAddFeeOffset = "";
		var gMemFund = "";//专款
		var gMemFundVal = "";//专款金额
		var gMemSysPay = "";//系统充值
		var gMemSysPayVal = "";//系统充值金额
		var gNetCode = "";//宽带账号
		//-主资费附带可选资费
		var gFeeExtCode = "";//可选套餐编码
		var gFeeExtName = "";//可选套餐名称
		var gFeeExtStatus = "";//可选套餐状态
		var gFeeExtFlag = "";//可选套餐生效标示
		var gFeeExtInst = "";//可选套餐实例(取消用 订购0)
		var gFeeExtStart = "";//可选资费开始时间
		var gFeeExtEnd = "";//可选资费结束时间
		//主资费参数组
		var gPriFeePass = false;
		var gPriFeeStartTime = "";
		var gPriFeeEndTime = "";
		//主资费必绑附加资费
		var gFeeExtPass = false;
		//附加资费参数组
		var gAddFeePass = false;
		var gAddFeeStartTime = "";
		var gAddFeeEndTime = "";
		//家庭类专款和系统充值
		var familyTypefund = "";
		var familyTypeSysPay = "";
		
		var gNetSmCode = "";
		var gNetFlag = "";
		
		//重置成员信息
		function resetMemberData(){
			gFreeFlag = "";
			gMemNo = "";
			gMemberId = "";
			gPassword = "";
			gIdNo = "";
			gCustId = "";
			gGroupId = "";
			gSmCode = "";
			gMemType = "";
			gModeCode = "";
			gPrintInfo = "";
			gFeeExtPass = false;
			resetCheckGParams();
		}
		//重置全局变量
		function resetCheckGParams(){
			gMainPass = false;
			gMemFee = "";
			gMemFeeValid = "";
			gPreNetFlag = "";
			gMemAddFee = "";
			gMemberIdStr = "";
			gAddFeeOperType = "";
			gAddFeeDateType = "";
			gAddFeeOfferType = "";
			gAddFeeUnit = "";
			gAddFeeOffset = "";
			gMemFund = "";
			gMemFundVal = "";
			gMemSysPay = "";
			gMemSysPayVal = "";
			gFeeExtCode = "";
			gFeeExtName = "";
			gFeeExtStatus = "";
			gFeeExtFlag = "";
			gFeeExtInst = "";
			gFeeExtStart = "";
			gFeeExtEnd = "";
			
			gPriFeePass = false;
			gPriFeeStartTime = "";
			gPriFeeEndTime = "";
			
			gAddFeePass = false;
			gAddFeeStartTime = "";
			gAddFeeEndTime = "";
			familyTypefund = "";
			familyTypeSysPay = "";
		}
		//--------------------------发送请求-------------------------------------
		//续签宽带校验服务
		function sendNetPreAjax(){
			var sPacket = new AJAXPacket("memberCheckPreNet.jsp","请稍候......");
			sPacket.data.add("svcNum","<%=svcNum%>");
			sPacket.data.add("netCode",gNetCode);
			sPacket.data.add("actType","<%=actType%>");
			sPacket.data.add("netFee", gMemFee);
			sPacket.data.add("netScoreMoney", "<%=netScoreMoney%>");
			core.ajax.sendPacket(sPacket,checkNetPre);
			sPacket = null;
		}
		//发送获取资费生效时间请求
		function sendPriFeeAjax(){
			var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo",gMemberId);
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",gMemberId);
			sPacket.data.add("iOfferIdStr",gMemFee);
			sPacket.data.add("iOprTypeStr","1");
			if(gMemFeeValid == "5"){//续签类,代表生效方式由资费的配置决定		
				sPacket.data.add("iDateTypeStr","x");		
			}else{
				sPacket.data.add("iDateTypeStr",gMemFeeValid);	
			}
			sPacket.data.add("iOfferTypeStr","0");
			sPacket.data.add("iOffsetStr","x");
			sPacket.data.add("iUnitStr","x");
			sPacket.data.add("meansId","<%=meansId%>");
			
			core.ajax.sendPacket(sPacket,getPriFeeTime);
			sPacket = null;
		}
		//发送获取附加资费生效时间请求
		function sendAddFreeAjax(){
			var sPacket = new AJAXPacket("getEffectTime.jsp","请稍候......");
			sPacket.data.add("iChnSource","<%=reginCode%>");
			sPacket.data.add("iLoginNo","<%=loginNo%>");
			sPacket.data.add("iLoginPWD","<%=password%>");
			sPacket.data.add("iPhoneNo", gMemberId);
			sPacket.data.add("iOprAccept","<%=orderId%>");
			sPacket.data.add("iPhoneNoStr",gMemberIdStr);
			sPacket.data.add("iOfferIdStr",gMemAddFee);
			sPacket.data.add("iOprTypeStr",gAddFeeOperType);
			sPacket.data.add("iUnitStr",gAddFeeUnit);
			sPacket.data.add("iDateTypeStr",gAddFeeDateType);
			sPacket.data.add("iOfferTypeStr",gAddFeeOperType);
			sPacket.data.add("iOffsetStr",gAddFeeOffset);
			sPacket.data.add("meansId","<%=meansId%>");
			core.ajax.sendPacket(sPacket,getAddFeeTime);
			sPacket = null;
		}
		//获得成员信息
		function sendMemberDataAjax(){
			var sPacket = new AJAXPacket("getMemberData.jsp","请稍候......");
			sPacket.data.add("memberNo", gMemberId);
			sPacket.data.add("memType", gMemType);
			sPacket.data.add("operType", "<%=operType%>");
			core.ajax.sendPacket(sPacket,getMemberData);
		}
		//校验成员密码
		function sendCheckPasswordAjax(){
			var sPacket = new AJAXPacket("checkPassword.jsp","请稍候......");
			sPacket.data.add("phoneNo", gMemberId);
			sPacket.data.add("password", gPassword);
			core.ajax.sendPacket(sPacket,checkPassword);
		}
		//校验TD固话
		function sendCheckTDAjax(){
			var sPacket = new AJAXPacket("checkTD.jsp","请稍候......");
			sPacket.data.add("phoneNo", gMemberId);
			core.ajax.sendPacket(sPacket,checkTD);
		}
		//获得主资费绑定可选套餐
		function sendFeeExtAjax(feeCode){
			if(gMemType != "B"){
				var sPacket = new AJAXPacket("getFeeExt.jsp","请稍候......");
				sPacket.data.add("idNo", gIdNo);
				sPacket.data.add("modeCode", gModeCode);
				sPacket.data.add("feeCode", feeCode);
				sPacket.data.add("belongCode", gGroupId);
				core.ajax.sendPacket(sPacket,showFeeExt);
				sPacket = null;
			}else{
				gFeeExtPass = true;
			}
		}
		//--------------------------处理请求-------------------------------------
		function checkNetPre(packet){
			var retCode = packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if( retCode=="w00006"){
				showDialog(retMsg+";      提示:若本营销案存在积分抵消元素，请先进行积分的填写再做后续操作!", 1);
				return;
			}
			if(retCode != "000000" && retCode!="w00006"){
				showDialog(retMsg, 1);
				return ;
			}
			gPreNetFlag = packet.data.findValueByName("netFlag");//续签宽带资费转换类型 5包年转包年 4包月转包年
			gNetFlag = packet.data.findValueByName("netFlag");
			//document.getElementById("global_netFlag").value = gPreNetFlag;
			gPriFeeStartTime = packet.data.findValueByName("effDate");
			gPriFeeEndTime = packet.data.findValueByName("expDate");
			sendPriFeeAjax();
		}
		function getPriFeeTime(packet){
			var retCode = packet.data.findValueByName("RETURN_CODE");
			var retMsg = packet.data.findValueByName("RETURN_MSG");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			gPriFeePass = true;
			if(gMemFeeValid != "5" || gPreNetFlag == "4"){//不是续签类的或者包月转包年
				gPriFeeStartTime = packet.data.findValueByName("effDateStr");
				gPriFeeEndTime = packet.data.findValueByName("expDateStr");
			}
			buildFeeExtInfo();
			createMemberStr();
		}
		function buildFeeExtInfo(){
			//主资费附加资费
			var feeExts = $("#table_feeExt :checkbox");
			var feeExtSplit = "#";
			for(var i=0; i<feeExts.length; i++){
				var feeExtDatas = $(feeExts[i]).val();
				var feeExtData = feeExtDatas.split("@");
				
				var newStatus = ""; 
				var instId = "";
				var start = "";
				var end = "";
				if($(feeExts[i]).attr("checked")){
					newStatus = "N";//订购
					instId = "0";
					start = gPriFeeStartTime;
					end = gPriFeeEndTime;
				}else{
					newStatus = "Y";//取消
					instId = feeExtData[4];
					start = feeExtData[5];
					end = gPriFeeStartTime;
				}
				var oldStatus = feeExtData[3];
				//如果原状态为订购 则old = Y 取消之后需要传Y 所以判断新旧状态不等
				if(newStatus != oldStatus){
					continue;
				}
				gFeeExtCode += feeExtData[0] + feeExtSplit;
				gFeeExtName += feeExtData[1] + feeExtSplit;
				gFeeExtStatus += newStatus + feeExtSplit;	
				gFeeExtFlag += feeExtData[2] + feeExtSplit;
				gFeeExtInst += instId + feeExtSplit;
				gFeeExtStart += start + feeExtSplit;
				gFeeExtEnd += end + feeExtSplit;
			}
		}
		function getAddFeeTime(packet){
			var retCode = packet.data.findValueByName("RETURN_CODE");
			var retMsg = packet.data.findValueByName("RETURN_MSG");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			gAddFeePass = true;
			gAddFeeStartTime = packet.data.findValueByName("effDateStr");
			gAddFeeEndTime = packet.data.findValueByName("expDateStr");
			createMemberStr();
		}
		function getMemberData(packet){
			var retCode =  packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			if(gMemType == "B"){
				gNetCode = gMemberId;
				gMemberId = packet.data.findValueByName("memberNo");
				gSmCode = packet.data.findValueByName("smCode");
				gNetSmCode = packet.data.findValueByName("smCode");
				//document.getElementById("global_netSmCode").value = gSmCode;
			}else{
				gNetCode = "#";//占位
			}
			gIdNo = packet.data.findValueByName("idNo");
			gCustId = packet.data.findValueByName("custId");
			gGroupId = packet.data.findValueByName("belongCode");
			gSmCode = packet.data.findValueByName("smCode");
			gModeCode = packet.data.findValueByName("modeCode");
			$("#memberNo").attr("disabled", "disabled");
			if(gMemType != "B"){
				$("#memberPsd").attr("disabled", "disabled");
			}
			$("#button_mem_check").attr("disabled", "disabled");
			$("#button_mem_save").attr("disabled", "");
			$('#table_fee').css("display", "block");
			$('#table_addFee').css("display", "block");
			$('#table_fund').css("display", "block");
			$('#table_syspay').css("display", "block");
		}
		function showFeeExt(packet){
			$('#table_feeExt').html("");
			var retCode = packet.data.findValueByName("returnCode");
			var retMsg = packet.data.findValueByName("returnMsg");
			if(retCode != "000000"){
				gFeeExtPass = false;
				showDialog(retMsg, 1);
				return ;
			}
			var feeExtCodes = packet.data.findValueByName("feeExtCodes");
			var feeExtNames = packet.data.findValueByName("feeExtNames");
			var feeExtChoiceds = packet.data.findValueByName("feeExtChoiced");
			var feeExtSendFlags = packet.data.findValueByName("feeExtSendFlags");
			var feeExtSendFlagStrs = packet.data.findValueByName("feeExtSendFlagStrs");
			var feeExtStatusStrs = packet.data.findValueByName("feeExtStatusStrs");
			var feeExtInstStrs = packet.data.findValueByName("feeExtInstStrs");
			var feeExtStartStrs = packet.data.findValueByName("feeExtStartStrs");
			$('#table_feeExt').css("display", "block");
			if(feeExtCodes != ""){
				var feeExtCode = feeExtCodes.split("@");
				var feeExtName = feeExtNames.split("@");
				var feeExtChoiced = feeExtChoiceds.split("@");
				var feeExtSendFlag = feeExtSendFlags.split("@");
				var feeExtSendFlagStr = feeExtSendFlagStrs.split("@");
				var feeExtStatusStr = feeExtStatusStrs.split("@");
				var feeExtInstStr = feeExtInstStrs.split("@");
				var feeExtStartStr = feeExtStartStrs.split("@");
				var statusStr;
				$('#table_feeExt').append("<tr><th>选择可选套餐</th><th>可选套餐代码</th><th>可选套餐名称</th><th>生效方式</th><th>状态</th></tr>");
				for(var i=0; i<feeExtCode.length; i++){
					if(feeExtStatusStr[i] == ("Y")){
						statusStr = "已开通";
					}else{
						statusStr = "未开通";
					}
					var innerHtml = "<tr><td><input type = 'checkbox' name='feeExt' ";
					innerHtml += "value='"+feeExtCode[i]+"@"+feeExtName[i]+"@"+feeExtSendFlag[i]+"@"+feeExtStatusStr[i]+"@"+feeExtInstStr[i]+"@"+feeExtStartStr[i]+"' ";
					if(feeExtChoiced[i] == "0"||feeExtChoiced[i] == "1"||feeExtChoiced[i] == "4"){
						innerHtml += "checked ";
					}
					if(feeExtChoiced[i] == "2"||feeExtChoiced[i] == "9"){
						innerHtml += "checked onclick='return false' ";
					}
					if(feeExtChoiced[i] == "a"||feeExtChoiced[i] == "b"||feeExtChoiced[i] == "d"){
						innerHtml += "onclick='return false' ";
					}
					innerHtml +="></td>";
					innerHtml +="<td>"+feeExtCode[i]+"</td>";
					innerHtml +="<td>"+feeExtName[i]+"</td>";
					innerHtml +="<td>"+feeExtSendFlagStr[i]+"</td>";
					innerHtml +="<td>"+statusStr+"</td></tr>";
					$('#table_feeExt').append(innerHtml);
				}
			}
			gFeeExtPass = true;
		}
		function checkPassword(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			sendMemberDataAjax();
		}
		function checkTD(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode != "000000"){
				showDialog(retMsg, 1);
				return ;
			}
			sendCheckPasswordAjax();
		}
		//--------------------------校验号码-------------------------------------
		function checkMember(freeFlag){
			resetMemberData();
			gMemNo = $("#memNo").val();
			gMemberId = $("#memberNo").val();//用户号码
			gMemType = $("#memType").val();//成员类型
			if(gMemType != "B"){
				gPassword = $("#memberPsd").val();
				if(gPassword == ""){
					showDialog("请输入号码密码！",1);
					return;
				}
			}
			gFreeFlag = freeFlag;
			if(gMemType == "B"){
				gPrintInfo += "宽带成员:" + gMemberId;
				sendMemberDataAjax();
			}
			if(gMemType == "P"){
				gPrintInfo += "手机成员:" + gMemberId;
				sendCheckPasswordAjax();
			}
			if(gMemType == "T"){
				gPrintInfo += "TD固话成员:" + gMemberId;
				//sendCheckPasswordAjax();
				sendCheckTDAjax();
			}
		}
		//--------------------------保存成员-------------------------------------
		function saveMember(){	
			resetCheckGParams();
			//主资费
			var feeNum = $("#feeNum").val();//主资费数量
			if(feeNum > 0){
				if($("#table_fee input:checked").size() == 0){
					showDialog("请选择主资费",1);
					return ;
				}
				gMemFee = $("#table_fee input:checked").val();
				gPrintInfo += " 办理主资费"+gMemFee;
				gMemFeeValid = $("#hid_fee_"+gMemFee).val();
				if(gMemType == "B" && gMemFeeValid == "5"){
					sendNetPreAjax();
				}else{
					sendPriFeeAjax();
				}
			}else{
				gPriFeePass = true;
				gFeeExtPass = true;
			}
			//附加资费
			var addFeeNum = $("#addFeeNum").val();
			var chooseNum = 0;
			if(addFeeNum > 0){
				var checkedAddFee = $("#table_addFee input:checked");
				var split = "";
				if(checkedAddFee.length > 0){
					gPrintInfo += " 办理附加资费";
				}
				for(var i=0; i<checkedAddFee.length; i++){
					chooseNum ++;
					var addFee = $(checkedAddFee[i]).val();
					var addFeeTime = $("#hid_addfee_time_"+addFee).val();
					gMemberIdStr += split + gMemberId;
					gMemAddFee += split + addFee;
					gAddFeeOperType += split + "1";
					gAddFeeDateType += split + "0";
					gAddFeeOfferType += split + "1";
					gAddFeeUnit += split + "6";
					gAddFeeOffset += split + addFeeTime;
					gPrintInfo += " "+addFee;
					split = "#";
				}
				sendAddFreeAjax();
			}else{
				gAddFeePass = true;
			}
			//专款
			
			var fundNum = $("#fundNum").val();
			gMemFundVal = $("#member_fund_value_"+gMemNo).val();
			var memFundStr = "";
			if(fundNum > 0){
				var fund_value_0 = $("#fund_value_0").val();
				var fund_value_1 = $("#fund_value_1").val();
				
				if( !fund_value_0  && !fund_value_1){
					var memFundStr1 = $("#hid_fund_0").val();
					var memFundStr2 = $("#hid_fund_1").val();
					var end='';
					var start ='';
					if(memFundStr1){
						var start = memFundStr1.indexOf("(");
						var end = memFundStr1.indexOf(")");
						gMemFund=memFundStr1.substring(start+1, end);
					}else if(memFundStr2) {
						start = memFundStr2.indexOf("(");
						end = memFundStr2.indexOf(")");	
						gMemFund=memFundStr2.substring(start+1, end);
					}
				}else if(fund_value_0 =="" || fund_value_0 == "0"){
					var memFundStr2 = $("#hid_fund_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemFund = memFundStr2.substring(start2+1, end2);
				}else if(fund_value_1 =="" || fund_value_1 == "0") {
					var memFundStr1 = $("#hid_fund_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					gMemFund = memFundStr1.substring(start1+1, end1);
				}else{
					var memFundStr1 = $("#hid_fund_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					var memFundStr2 = $("#hid_fund_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemFund = memFundStr1.substring(start1+1, end1)+'#'+memFundStr2.substring(start2+1, end2);
					familyTypefund=fund_value_0+'#'+fund_value_1;
				}
			}
			
			//系统充值
			var sysPayNum = $("#sysPayNum").val();
			gMemSysPayVal = $("#member_sysPay_value_"+gMemNo).val();
			var memSysPayStr = "";
			if(sysPayNum > 0){
				var sysPay_value_0 = $("#sysPay_value_0").val();
				var sysPay_value_1 = $("#sysPay_value_1").val();
				if(sysPay_value_0 =="" || sysPay_value_0 == "0"){
					var memFundStr2 = $("#hid_sysPay_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemSysPay = memFundStr2.substring(start2+1, end2);
				}else if(sysPay_value_1 =="" || sysPay_value_1 == "0") {
					var memFundStr1 = $("#hid_sysPay_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					gMemSysPay = memFundStr1.substring(start1+1, end1);
				}else {
					var memFundStr1 = $("#hid_sysPay_0").val();
					var start1 = memFundStr1.indexOf("(");
					var end1 = memFundStr1.indexOf(")");
					var memFundStr2 = $("#hid_sysPay_1").val();
					var start2 = memFundStr2.indexOf("(");
					var end2 = memFundStr2.indexOf(")");
					gMemSysPay = memFundStr1.substring(start1+1, end1)+'#'+memFundStr2.substring(start2+1, end2);
					familyTypeSysPay=sysPay_value_0+'#'+sysPay_value_1;
				}
			}
			
			if(gFreeFlag == "-1"){
				gMemFundVal = Number($("#fund_value_0").val())+Number($("#fund_value_1").val());
				var usedFund = $("#used_fund").text();
				if(Number("<%=fundFree%>")>0){
					if(!isInt(gMemFundVal)){
						showDialog("专款分配金额请输入整数", 1);
						return;
					}
					if(Number("<%=fundFree%>") < Number(gMemFundVal) + Number(usedFund)){
						showDialog("已经分配的专款总额大于可以分配的专款总额，请重新分配！",1);
						return ;
					}
					if(gMemFundVal%60!=0){
						showDialog("专款金额必须为60的倍数，请修改！",1);
						return;
					}
				}else{
					gMemFundVal = "0";
					usedFund = "0";
				}
				
				gMemSysPayVal = Number($("#sysPay_value_0").val())+Number($("#sysPay_value_1").val());;
				var usedSysPay = $("#used_sysPay").text();
				if(Number("<%=sysPayFree%>")>0 ){
					if(!isInt(gMemSysPayVal)){
						showDialog("系统充值分配金额请输入整数", 1);
						return;
					}
					if(Number("<%=sysPayFree%>") < Number(gMemSysPayVal) + Number(usedSysPay)){
						showDialog("已经分配的系统充值总额大于可以分配的系统充值总额，请重新分配！",1);
						return ;
					}
					if(gMemSysPayVal%60!=0){
						showDialog("系统充值金额必须为60的倍数，请修改！",1);
						return;
					}
				}else{
					gMemSysPayVal = "0";
					usedSysPay = "0";
				}
				
				$("#used_fund").text(Number(gMemFundVal) + Number(usedFund));
				$("#used_sysPay").text(Number(gMemSysPayVal) + Number(usedSysPay));
			}
			if(Number(gMemFundVal) > 0){
				gPrintInfo += " 办理专款 "+ memFundStr + gMemFundVal + "元";
			}
			if(Number(gMemSysPayVal) > 0){
				gPrintInfo += " 办理系统充值 "+ memFundStr + gMemSysPayVal + "元";	
			}
			gMainPass = true;
			createMemberStr();
		}
		function createMemberStr(){
			if(!gPriFeePass || !gAddFeePass || !gMainPass ||!gFeeExtPass){
				return;
			}
			//添加家庭模式的专款计算公式校验和处理
			var gMemFundValTem = gMemFundVal;
			var gMemSysPayValTem = gMemSysPayVal;
			if(familyTypefund != ""){
				gMemFundVal=familyTypefund;
			}
			if(familyTypeSysPay != ""){
				gMemSysPayVal=familyTypeSysPay;
			}
			var memberValue = gMemberId+"|"+gMemType+"|"
				+gIdNo+"|"+gCustId+"|"+gGroupId+"|"+gSmCode+"|"
				+gMemFee+"|"+gPriFeeStartTime+"|"+gPriFeeEndTime+"|"
				+gMemAddFee+"|"+gAddFeeStartTime+"|"+gAddFeeEndTime+"|"
				+gMemFund+"|"+gMemSysPay+"|"+gMemFundVal+"|"+gMemSysPayVal+"|"
				+gNetCode+"|"
				+gFeeExtCode+"|"+gFeeExtName+"|"+gFeeExtStatus+"|"+gFeeExtFlag+"|"
				+gFeeExtInst+"|"+gFeeExtStart+"|"+gFeeExtEnd+"|"
				+gPrintInfo;
			gMemFundVal=gMemFundValTem;
			gMemSysPayVal=gMemSysPayValTem;
			$("#order_html").html("");
			if(gMemNo != "-1"){
				$("#hid_member_value_"+gMemNo).val(memberValue);
				$("#td_member_statue_"+gMemNo).html("<font color='red'>已分配"+gMemberId+"</font>");
				$("#b_member_choose_"+gMemNo).css("display","none");
				$("#b_member_reset_"+gMemNo).css("display","block");
			}else{
				var appendHtml = "<tr id='free_tr_"+gFreeId+"'><td>" + gMemberId + "</td>";
				var memTypeStr = "";
				if(gMemType == "T")memTypeStr ="TD固话成员";
				if(gMemType == "B")memTypeStr ="宽带成员";
				if(gMemType == "P")memTypeStr ="手机成员";
				appendHtml += "<td>"+memTypeStr+"</td>";
				appendHtml += "<td id='free_td_fund_"+gFreeId+"'>"+gMemFundVal+"</td>";
				appendHtml += "<td id='free_td_sysPay_"+gFreeId+"'>"+gMemSysPayVal+"</td>";
				appendHtml += "<td><input type='button' class='b_text' value='删除' onclick = 'removeTr("+gFreeId+")' />";
				appendHtml += "<input type='hidden' name='member_value' value='"+memberValue+"' /></td></tr>";
				$("#table_free_member").append(appendHtml);
				gFreeId ++;
			}
		}
		function resetMember(memNo){
			$("#td_member_statue_"+memNo).html("未分配");
			$("#b_member_choose_"+memNo).css("display","block");
			$("#b_member_reset_"+memNo).css("display","none");
			$("#hid_member_value_"+memNo).val("");
		}
		
		function submitAll(){
			var allMemberInfo = "";
			var memberValues = $("input[name = member_value]");
			var split = "";
			for(var i=0; i<memberValues.size(); i++){
				if($(memberValues[i]).val() == ""){
					showDialog("还有没有分配的成员",1);
					return;
				}
				allMemberInfo += split + $(memberValues[i]).val();
				split = "@@";
			}
			var usedFund = $("#used_fund").text();
			var usedSysPay = $("#used_sysPay").text();
			if("<%=fundFree %>"!=usedFund || "<%=sysPayFree%>"!=usedSysPay){
				showDialog("还有可以自由分配的专款或系统充值",1);
				return;
			}
			parent.buildGlobalNetInfo(gNetSmCode,gNetFlag);
			parent.addH11NetBindingFun(gPriFeeStartTime);
			parent.buildH15XML(allMemberInfo, "<%=totalMoney %>", gPreNetFlag);
			closeWin();
		}
		function showMemberList(listType){
			if(listType == 'fixed'){
				$("#member_list_fixed").css("display","block");
				$("#member_list_free").css("display","none");
			}
			if(listType == 'free'){
				$("#member_list_fixed").css("display","none");
				$("#member_list_free").css("display","block");
			}
			$("#order_html").html("");
		}
		function removeTr(trId){
			var memFundVal = $("#free_td_fund_"+trId).text();
			var usedFund = $("#used_fund").text();
			$("#used_fund").text(Number(usedFund) - Number(memFundVal));
			var memSysPayVal = $("#free_td_sysPay_"+trId).text();
			var usedSysPay = $("#used_sysPay").text();
			$("#used_sysPay").text(Number(usedSysPay) - Number(memSysPayVal));
			$("#free_tr_"+trId).remove();
		}
		function closeWin(){
			closeDivWin();
		}
		function isInt(v){
			var Int = /^-?\d+$/;
			if(Int.exec(v)) {
				return true;
			} else {
				return false;
			}
		}
		function isTel(v){
			var mobilePatrn = /^((\(\d{3}\))|(\d{3}\-))?1[3,5,8]\d{9}$/;
			if(mobilePatrn.exec(v)) {
				return true;
			} else {
				return false;
			}
		}
		function showReNumberDialog(obj) {
		    var path = "/npage/common/ReNumberDialog.jsp";
		    var h=170;
		    var w=470;
		    var t=screen.availHeight/2-h/2;
		    var l=screen.availWidth/2-w/2;
		    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
		    
			returnValue = window.showModalDialog(path,"",prop);
		    
			if (returnValue != '') {
			   obj.value = returnValue;
			}
		}
		

	</script>
</html>