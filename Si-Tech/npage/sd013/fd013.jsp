<%
  /*
   * 功能: 两城一家
   * 版本: 2.0
   * 日期: 2010/12/22
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<title>两城一家/非常假期</title>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = "";
	if(opCode.equals("d908") || opCode.equals("d909") || opCode.equals("d910")){
	    opName = "定向国内长途";
	}else{
	    opName = "两城一家/非常假期";
	}
	String phoneNo = request.getParameter("activePhone");
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String loginPwd    = (String)session.getAttribute("password"); //工号密码
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String custName = "";
	//String getCustInfo = "select cust_name from dcustdoc where cust_id = (select cust_id from dcustmsg where phone_no = :phoneNo)";
	//lj. 绑定参数
	String sql_select1 = "select cust_name from dcustdoc where cust_id = (select cust_id from dcustmsg where phone_no = :phoneNo)";
	String srv_params1 = "phoneNo=" + phoneNo;
	System.out.println("进入两城一家/非常假期");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<wtc:service name="sCustNameQry" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value=" "/>
		<wtc:param value=" "/>
			<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=loginPwd%>"/>
						<wtc:param value="<%=phoneNo%>"/>
							<wtc:param value=" "/>
</wtc:service>
<wtc:array id="result" scope="end" />
	<%
	if(!result[0][0].equals("0")&&!result[0][0].equals("000000")){
%>
<script type="text/javascript">
		rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
</script>
<%
}else {

	custName = result[0][2];
	System.out.println("wsdf"+custName);
	System.out.println(result.length);
	}
	String iChnSource = "01";
	String iQrytype = "0";
	String iSaleType = "";
	if(opCode.equals("d908") || opCode.equals("d909") || opCode.equals("d910")){
	   iSaleType = "2";
	}
	String iOfferType = "";
	String userPwd = "";
	System.out.println("-----"+loginAccept+"-----");
	System.out.println("-----"+iChnSource+"-----");
	System.out.println("-----"+opCode+"-----");
	System.out.println("-----"+workNo+"-----");
	System.out.println("-----"+loginPwd+"-----");
	System.out.println("-----"+phoneNo+"-----");
	System.out.println("-----"+userPwd+"-----");
	System.out.println("-----"+iQrytype+"-----");
	System.out.println("-----"+iSaleType+"-----");
	System.out.println("-----"+iOfferType+"-----");
	//String getBandNameSql = "select band_name from band where sm_code = (select sm_code from dcustmsg where phone_no = '"+phoneNo+"')";
		//lj. 绑定参数
	String sql_select2 = "select band_name from band where sm_code = (select sm_code from dcustmsg where phone_no = :phoneNo)";
	String srv_params2 = "phoneNo=" + phoneNo;
	String bandName = "";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:param value="<%=sql_select2%>"/>
	<wtc:param value="<%=srv_params2%>"/>
</wtc:service>
<wtc:array id="result2" scope="end" />
<%

	bandName = result2[0][0];
%>
<wtc:service name="sB997Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=loginAccept%>"/>
  <wtc:param value="<%=iChnSource%>"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=loginPwd%>"/>
  <wtc:param value="<%=phoneNo%>"/>
  <wtc:param value="<%=userPwd%>"/>
  <wtc:param value="<%=iQrytype%>"/>
  <wtc:param value="<%=iSaleType%>"/>
  <wtc:param value="<%=iOfferType%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	if(!retCode1.equals("0")&&!retCode1.equals("000000")){
%>
<script type="text/javascript">
		rdShowMessageDialog("错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>",0);
</script>
<%
	}
%>
<script type="text/javascript">
	var offer = new Array();
	var effDate = new Array();
	var expDate = new Array();
	var comments;
	
<%
	for(int i=0 ;i<result1.length;i++){
%>
		offer[<%=i%>] = "<%=result1[i][0]+ '-' + result1[i][1]%>";
		effDate[<%=i%>] = "<%=result1[i][2]%>";
		expDate[<%=i%>] = "<%=result1[i][3]%>";
<%
	}
%>

	$(document).ready(function(){
		
		//opCode对应展示
		if("<%=opCode%>" == "b997"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=1]").attr("checked",true);
		}
		if("<%=opCode%>" == "b998"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=2]").attr("checked",true);
		}
		if("<%=opCode%>" == "b999"){
			$("input[@name=opType][@value=0]").attr("checked",true);
			//$("input[@name=opFlag][@value=3]").attr("checked",true);
		}
		if("<%=opCode%>" == "d014"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=2]").attr("checked",true);
		}
		if("<%=opCode%>" == "d013"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=1]").attr("checked",true);
		}
		if("<%=opCode%>" == "d046"){
			$("input[@name=opType][@value=1]").attr("checked",true);
			//$("input[@name=opFlag][@value=3]").attr("checked",true);
		}
		//add by wanglma 20110610 增加定向国内长途资费配置的函需求
		if("<%=opCode%>" == "d908"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		if("<%=opCode%>" == "d909"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		if("<%=opCode%>" == "d910"){
			$("input[@name=opType][@value=2]").attr("checked",true);
			$("#offerType").val("YnDa");
		}
		
		
		if("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999"){
			$("#opType1").hide();
			$("#opType2").hide();
		}
		if("<%=opCode%>" == "d014" || "<%=opCode%>" == "d046" || "<%=opCode%>" == "d013"){
			$("#opType0").hide();
			$("#opType2").hide();
		}
		if("<%=opCode%>" == "d908" || "<%=opCode%>" == "d909" || "<%=opCode%>" == "d910"){
			$("#opType1").hide();
			$("#opType0").hide();
		}
		//add by wanglma 20110610 增加定向国内长途资费配置的函需求
		/*
		//如果是取消业务套餐不可用
		if($("input[@name=opFlag][@value=2]").attr("checked")){
			$("#offerType").attr("disabled",true);
		}
		//如果不是变更业务  变更号不可见
		if($("input[@name=opFlag][@value=3]").attr("checked")){
			$("#newTig").css("display","block");
			$("#newOfferCode").css("display","block");
			
		}else{
			$("#newTig").css("display","none");	
			$("#newOfferCode").css("display","none");
		}
		*/
		$("input[@name=opType]").click(function(){
			$("input[@name=opFlag]")[0].checked = false;
			$("input[@name=opFlag]")[1].checked = false;
			$("input[@name=opFlag]")[2].checked = false;
		});
		//取消业务是套餐类型不可用
		$("input[@name=opFlag]").click(function(){
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			if($("input[@name=opType]:checked").val() == "2"){
				if($("#offerType option[value='YnDa']").val() == undefined){
					$("#offerType").append("<option value='YnDa'>定向国内长途</option>");
				}
			   	$("#offerType").val("YnDa");
			   	var iQrytype = $("input[@name=opFlag]:checked").val();
				var iSaleType = $("input[@name=opType]:checked").val();
				var iOfferType = $("#offerType").val();
				if(iOfferType != "0" && iQrytype != "2"){
					getOfferType(iQrytype,iSaleType,iOfferType);
				}
				$("#offerType").attr("disabled",true);
		    }else{
			    $("#offerType")[0].options(0).selected = true;//选中请选择
			    $("#offerType").attr("disabled",false);
			    $("#offerType option[value='YnDa']").remove();
		    }
			$("#oldOfferCode").empty();//选中请选择;
			$("#oldOfferCode").append("<option value=''>请选择</option>");
			$("#newOfferCode").empty();
			$("#newOfferCode").append("<option value=''>请选择</option>");
			//如果是取消业务套餐不可用
			if($(this).val() == "2"){
				$("#offerType")[0].options(0).selected = true;//选中请选择
				$("#offerType").attr("disabled",true);	
				var iSaleType = $("input[@name=opType]:checked").val();
				getOfferType("2",iSaleType,"");
			}else{
				if($("input[@name=opType]:checked").val() == "2"){
					//$("#offerType").attr("disabled",true);
				}else{
					$("#offerType").attr("disabled",false);	
				}
			}
			//如果不是变更业务  变更号不可见
			if($(this).val() == "3"){
				$("#newTig").css("display","block");	
				$("#newOfferCode").css("display","block");	
			}else{
				$("#newTig").css("display","none");	
				$("#newOfferCode").css("display","none");
			}
		});
		
		//表单提交
		$("#submitB").click(function(){
			/*
				1.动态生成opCode
				b997    两城一家 申请
				b998	两城一家 取消
				b999	两城一家 变更
				d013	非常假期 申请
				d014	非常假期 取消
				d046	非常假期 变更
				d908	定向国内长途 申请
				d909	定向国内长途 取消
				d910	定向国内长途 变更
			*/
			var flag1 = $("input[@name=opType]:checked").val();//opType
			var flag2 = $("input[@name=opFlag]:checked").val();//opFlag
			if(flag1 == 0 && flag2 == 1){
				$("#opCode").val("b997");
				$("#opName").val("两城一家 申请");
			}else if(flag1 == 0 && flag2 == 2){
				$("#opCode").val("b998");
				$("#opName").val("两城一家 取消");
			}else if(flag1 == 0 && flag2 == 3){
				$("#opCode").val("b999");
				$("#opName").val("两城一家 变更");
			}else if(flag1 == 1 && flag2 == 1){
				$("#opCode").val("d013");
				$("#opName").val("非常假期 申请");
			}else if(flag1 == 1 && flag2 == 2){
				$("#opCode").val("d014");
				$("#opName").val("非常假期 取消");
			}else if(flag1 == 1 && flag2 == 3){
				$("#opCode").val("d046");
				$("#opName").val("非常假期 变更");
			}else if(flag1 == 2 && flag2 == 1){
				$("#opCode").val("d908");
				$("#opName").val("定向国内长途 申请");
			}else if(flag1 == 2 && flag2 == 2){
				$("#opCode").val("d909");
				$("#opName").val("定向国内长途 取消");
			}else if(flag1 == 2 && flag2 == 3){
				$("#opCode").val("d910");
				$("#opName").val("定向国内长途 变更");
			}
			//2.操作类型必选
			var item = $("input[@name=opFlag]:checked");
			var len=item.length;
			if((len<=0) ){
				rdShowMessageDialog("操作类型必选！",1);
				return ;
			}
			//3.套餐类型必选
			if(flag2 != 2){
				if($("#offerType").val() == "0"){
					rdShowMessageDialog("套餐类型必选！",1);
					return ;
				}
			}
			//4.资费代码必选
			if (item.val() == "1" && $("#offerType").val() == "YnDz" && ($("input[@name=oldOfferCodeMulti]:checked").length < 1 || $("input[@name=oldOfferCodeMulti]:checked").length > (2 - parseInt(document.getElementById("offerNum").value)))) {
				var tip = "您已经办理了" + parseInt(document.getElementById("offerNum").value) + "个省际套餐，";
				if (parseInt(document.getElementById("offerNum").value) >= 2) {
					tip += "不能再办理。";
				} else {
					tip += "本次最少办理1个，最多办理"+(2 - parseInt(document.getElementById("offerNum").value))+"个。";
				}
				rdShowMessageDialog(tip, 1);
				return ;
			}	else if (item.val() == "1" && $("#offerType").val() == "YnDy" && ($("input[@name=oldOfferCodeMulti]:checked").length < 1 || $("input[@name=oldOfferCodeMulti]:checked").length > (3 - parseInt(document.getElementById("offerNum").value)))) {
				var tip = "您已经办理了" + parseInt(document.getElementById("offerNum").value) + "个省内套餐，";
				if (parseInt(document.getElementById("offerNum").value) >= 3) {
					tip += "不能再办理。";
				} else {
					tip += "本次最少办理1个，最多办理"+(3 - parseInt(document.getElementById("offerNum").value))+"个。";
				}
				rdShowMessageDialog(tip, 1);
				return ;
			} else if(item.val() == "3" && ("0" == $("#oldOfferCode").val() || $("#oldOfferCode").val() == "" | $("#oldOfferCode").val() == null)){
				rdShowMessageDialog("请选择资费代码！",1);
				return ;
			}
			//写操作日志 xxxx为xxxx办理xxxx业务
			var note = "<%=workNo%>为<%=phoneNo%>办理"+$("#opName").val();
			$("#iOpNOte").val(note);
			//打印免填单

			var productIdObj = document.getElementById("productId");
			var getOfferCmtsPacket = new AJAXPacket("fb013_ajaxGetOfferCmts.jsp", "正在获取办理资费描述，请稍后......");
			if ($("input[@name=opFlag]:checked").val() == "3") {
				getOfferCmtsPacket.data.add("offerId", document.getElementById("newOfferCode").value.split("-")[0]);
			} else if ($("input[@name=opFlag]:checked").val() == "1") {
				var offerId;
				if ($("#offerType").val() == "YnDa") {
					offerId = document.getElementById("oldOfferCode").value.split("-")[0];
				} else {
					$("input[@name=oldOfferCodeMulti]:checked").each(function() {
						offerId = this.value;
					});
				}
				getOfferCmtsPacket.data.add("offerId", offerId);
			} else {
				var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	
				if(typeof(ret) != "undefined"){
					if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
						frm.submit();
					}
				} else {
					if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
						frm.submit();
					}
				}
				return;
			}
			
			core.ajax.sendPacket(getOfferCmtsPacket, doGetCmts);
		});
		//级联查询
		$("#offerType").change(function(){
			//首先选择操作类型
			var flag1 = $("input[@name=opType]:checked").val();//opType
			var item = $("input[@name=opFlag]:checked");
			var len=item.length;
			if(len<=0 && flag1!=2){
				$("#offerType")[0].options(0).selected = true;//选中请选择
				rdShowMessageDialog("操作类型必选！",1);
				return ;
			}
			var iQrytype = $("input[@name=opFlag]:checked").val();
			var iSaleType = $("input[@name=opType]:checked").val();
			var iOfferType = $(this).val();
			if($(this).val() != "0"){
				getOfferType(iQrytype,iSaleType,iOfferType);
			}
		});
	});	
	

	
	function doGetCmts(packet) {
		var retResult = packet.data.findValueByName("retResult");
		if (retResult == "000000") {
			comments = packet.data.findValueByName("comments");
		} else {
			comments = "取资费描述失败。";
		}

		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.submit();
			}
		} else {
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.submit();
			}
		}
	}
	
	function getOfferType(iQrytype,iSaleType,iOfferType){
		var packet = new AJAXPacket("ajaxGetOfferType.jsp");
		packet.data.add("loginAccept", "<%=loginAccept%>");
	    packet.data.add("iChnSource", "<%=iChnSource%>");
	    packet.data.add("opCode", "<%=opCode%>");
	    packet.data.add("workNo", "<%=workNo%>");
	    packet.data.add("loginPwd", "<%=loginPwd%>");
	    packet.data.add("phoneNo", "<%=phoneNo%>");
	    packet.data.add("userPwd", "<%=userPwd%>");
	    packet.data.add("iQrytype", iQrytype);
	    packet.data.add("iSaleType", iSaleType);
	    packet.data.add("iOfferType", iOfferType);
	    core.ajax.sendPacket(packet, doShowOffer, true);
	    packet = null;
	}
	
	function doShowOffer(packet){
		var retCode = packet.data.findValueByName("retCode"); 
  	var retMsg = packet.data.findValueByName("retMsg"); 
  	var flag = packet.data.findValueByName("flag");
  	var offerData = packet.data.findValueByName("offerData");
  	var offerNum = packet.data.findValueByName("offerNum");
  	var offerExpDate = packet.data.findValueByName("offerExpDate");
  	var iOfferType = packet.data.findValueByName("iOfferType");
  	document.getElementById("offerNum").value = offerNum;
  	document.getElementById("offerExpDate").value = offerExpDate.substr(0,8);
  	var offerObj = eval("("+offerData+")");//json
  	
  	if(((iOfferType == "YnDz" || iOfferType == "YnDy") && flag == "new") || (flag == "cancel" && "<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910")){	//2011/11/21 wanghfa修改
  	//if(((iOfferType == "YnDz" || iOfferType == "YnDy") && (flag == "new" || flag == "cancel"))){	//2011/11/21 wanghfa修改
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			$("#oldOfferCode").hide();
  		$("#oldOfferCodeMulti").show();
  		if(offerObj.offerArr.length <= 0){
  			rdShowMessageDialog("没有相应资费！",1);
  		}
			for(var i =0;i<offerObj.offerArr.length;i++){
				$("#oldOfferCodeMulti").append("<input type='checkbox' name='oldOfferCodeMulti' value="+offerObj.offerArr[i].offerId+" v_name='"+offerObj.offerArr[i].offerName+"'>"+offerObj.offerArr[i].offerId+"-"+offerObj.offerArr[i].offerName+"&nbsp;");
			}
  	} else if (iOfferType != "YnDz" && iOfferType != "YnDy") {
			if(flag == "new" || flag == "cancel"){
				$("#oldOfferCode").empty();
	  		$("#oldOfferCodeMulti").empty();
				$("#oldOfferCode").show();
	  		$("#oldOfferCodeMulti").hide();
				if(offerObj.offerArr.length <= 0){
					rdShowMessageDialog("没有相应资费！",1);
				}
				for(var i =0;i<offerObj.offerArr.length;i++){
					$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].offerId+">"+offerObj.offerArr[i].offerId+"-"+offerObj.offerArr[i].offerName+"</option>");
				}
			}else if(flag == "change"){
	  		$("#oldOfferCodeMulti").empty();
	  		$("#oldOfferCodeMulti").hide();
				var newOfferData = packet.data.findValueByName("newOfferData");
				var newOfferObj = eval("("+newOfferData+")");//json
				$("#oldOfferCode").empty();
				if(offerObj.offerArr.length <= 0){
					rdShowMessageDialog("没有相应资费！",1); 
					$("#oldOfferCode").append("<option value='0'>请选择</option>");
					return;
				}
				for(var i =0;i<offerObj.offerArr.length;i++){
					$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].oldOfferId+">"+offerObj.offerArr[i].oldOfferId+"-"+offerObj.offerArr[i].oldOfferName+"</option>");
				}
				$("#newOfferCode").empty();
				for(var i =0;i<newOfferObj.newOfferArr.length;i++){
					$("#newOfferCode").append("<option value="+newOfferObj.newOfferArr[i].newOfferId+">"+newOfferObj.newOfferArr[i].newOfferId+"-"+newOfferObj.newOfferArr[i].newOfferName+"</option>");
				}
			}
  	} else {
  		$("#oldOfferCode").empty();
  		$("#oldOfferCodeMulti").empty();
			$("#oldOfferCode").show();
  		$("#oldOfferCodeMulti").hide();
  		var newOfferData = packet.data.findValueByName("newOfferData");
  		var newOfferObj = eval("("+newOfferData+")");//json
  		if(offerObj.offerArr.length <= 0){
  			rdShowMessageDialog("没有相应资费！",1); 
  			$("#oldOfferCode").append("<option value='0'>请选择</option>");
  			return;
  		}
			for(var i =0;i<offerObj.offerArr.length;i++){
				$("#oldOfferCode").append("<option value="+offerObj.offerArr[i].oldOfferId+">"+offerObj.offerArr[i].oldOfferId+"-"+offerObj.offerArr[i].oldOfferName+"</option>");
			}
			$("#newOfferCode").empty();
			for(var i =0;i<newOfferObj.newOfferArr.length;i++){
				$("#newOfferCode").append("<option value="+newOfferObj.newOfferArr[i].newOfferId+">"+newOfferObj.newOfferArr[i].newOfferId+"-"+newOfferObj.newOfferArr[i].newOfferName+"</option>");
			}
  	}
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm){  //显示打印对话框
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=loginAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = $("#userPhone").val();
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType){
		
		
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="手机号码：" + $("#userPhone").val() + "|";
		cust_info+="客户姓名：" + $("#custName").val() + "|";
		
		opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"用户品牌 ："+"<%=bandName%>"+ "|";
		opr_info += "办理业务："+$("#opName").val()+"  操作流水："+"<%=loginAccept%>"+"|";
		
		opr_info += "|";
		if ($("input[@name=opFlag]:checked").val() == "1") { //申请
			
			if (document.getElementById("offerType").value == "YnDz") {
				opr_info += "业务生效时间：24小时之内      失效时间："+document.getElementById("offerExpDate").value+"|";
				opr_info += "套餐类别：" + $("#offerType").find("option:selected").text() + "|";
				//2011/11/22 wanghfa修改
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "-" + this.v_name + "  ";
				});
				opr_info += "申请资费：" + oldOfferCode + "|";
				//opr_info += "申请资费：" + $("#oldOfferCode").find("option:selected").text() + "|";
			} else if (document.getElementById("offerType").value == "YnDy") {
				opr_info += "业务生效时间：24小时之内      失效时间："+document.getElementById("offerExpDate").value+"|";
				opr_info += "套餐类别：" + $("#offerType").find("option:selected").text() + "|";
				//2011/11/22 wanghfa修改
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "-" + this.v_name + "  ";
				});
				opr_info += "申请资费：" + oldOfferCode + "|";
				//opr_info += "申请资费：" + $("#oldOfferCode").find("option:selected").text() + "|";
			}else if (document.getElementById("offerType").value == "YnDa") {
				opr_info += "申请资费：" + $("#oldOfferCode").find("option:selected").text() + "|";
				opr_info += "月使用费：3元 "+"|";
				opr_info += "业务生效时间：24小时之内      失效时间："+document.getElementById("offerExpDate").value+"|";
			}
			if(document.getElementById("offerType").value == "YnDa"){
				note_info1 += "资费描述："+"|";
				note_info1 += comments + "|";
				//note_info1 += "套餐月使用费3元/省，在号码归属地直拨指定省份0.19元/分钟。"+ "|";
				//note_info1 += "说明：指定黑龙江作为定向国内长途指定省份时，套餐月使用费3元，在号码归属地直拨除号码归属城市的黑龙江省内城市0.19元/分钟。"+"|";
			}else{
			note_info1 += "资费描述："+"|";
			note_info1 += comments + "|";
			note_info1 += "说明：发生集团V网内部通话，资费按集团V网资费标准收取。"+"|";
			}
			
		} else if ($("input[@name=opFlag]:checked").val() == "2"){ //取消
			//2011/11/22 wanghfa修改
			if ("<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910") {
				var oldOfferCode = "";
				$("input[@name=oldOfferCodeMulti]:checked").each(function() {
					oldOfferCode += this.value + "  ";
				});
				opr_info += "取消资费：" + oldOfferCode + "|";
			} else {
				opr_info += "取消资费：" + $("#oldOfferCode").val() + "|";
			}
			
			if($("input[@name=opType]:checked").val() == "2"){
				opr_info += "资费失效时间：次月失效|";
	    }else{
				for (var a = 0; a < <%=result1.length%>; a  ++) {
					if (offer[a] == $("#oldOfferCode").find("option:selected").text()) {
						if (effDate[a].substring(0,8) == '<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>') {
							opr_info += "资费失效时间：24小时之内|";
							break;
						} else {
							var eff = '<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>';
							if (eff.substring(4,6) == "12") {
								eff = (parseInt(eff.substring(0,4)) + 1) + "0101";
							} else {
								eff = (parseInt(eff) + 1) + "01";
							}
							opr_info += "资费失效时间："+eff+"|";
							break;
						}
					}
				}
			}
		} else { //变更
			
			if($("input[@name=opType]:checked").val() == "2"){
				opr_info += "原套餐代码：" + $("#oldOfferCode").find("option:selected").text() + "    变更为："+ $("#newOfferCode").find("option:selected").text() + "|";	
				opr_info += "业务生效时间：次月生效|";
		    }else{
		    	opr_info += "套餐类别：" + $("#offerType").find("option:selected").text() + "|";
			opr_info += "原套餐代码：" + $("#oldOfferCode").find("option:selected").text() + "    变更为："+ $("#newOfferCode").find("option:selected").text() + "|";	
			for (var a = 0; a < <%=result1.length%>; a  ++) {
				if (offer[a] == $("#oldOfferCode").find("option:selected").text()) {
					if (effDate[a].substring(0,8) == '<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>') {
						opr_info += "业务生效时间：24小时之内|";
						break;
					} else {
						var eff = '<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>';
						if (eff.substring(4,6) == "12") {
							eff = (parseInt(eff.substring(0,4)) + 1) + "0101";
						} else {
							eff = (parseInt(eff) + 1) + "01";
						}
						opr_info += "业务生效时间："+eff+"|";
						break;
					}
				}
			}
		}
			note_info1 += "资费描述："+"|";
			note_info1 += comments + "|";
			if($("input[@name=opType]:checked").val() == "2"){
				//note_info1 += "套餐月使用费3元/省，在号码归属地直拨指定省份0.19元/分钟。" + "|";
				//note_info1 += "说明：指定黑龙江作为定向国内长途指定省份时，套餐月使用费3元，在号码归属地直拨除号码归属城市的黑龙江省内城市0.19元/分钟。"+"|";
		    }else{
		    	//note_info1 += comments + "|";
		    	note_info1 += "说明：发生集团V网内部通话，资费按集团V网资费标准收取。"+"|";
		    }
			
		}
		if (($("input[@name=opType]:checked").val() == "2") && ($("input[@name=opFlag]:checked").val() != "2")) {
			
		}else{
			/* add 两城一家+申请、变更、取消+省际，不展示这句话 for 关于长途漫游资费上线需求的函@2014/12/18 */
			if(($("input[@name=opType]:checked").val() == "0") && ($("#offerType").val() == "YnDz")){ 
				if ("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999") {
				
				}else{
					note_info1 += "资费失效后优惠自动取消。"+"|";	
				}
			}else{
				note_info1 += "资费失效后优惠自动取消。"+"|";
			}
		}
		
		if (($("input[@name=opFlag]:checked").val() == "1" || $("input[@name=opFlag]:checked").val() == "2") && "<%=opCode%>" != "d908" && "<%=opCode%>" != "d909" && "<%=opCode%>" != "d910") {
			var oldOfferCode = "";
			$("input[@name=oldOfferCodeMulti]:checked").each(function() {
				oldOfferCode += this.value + "  ";
			});
			note_info1 += '备注：'+$("#opName").val()+'       资费代码：'+ oldOfferCode + "|";
		} else {
			note_info1 += '备注：'+$("#opName").val()+'       资费代码：'+$("#oldOfferCode").val()+ "|";
		}

		if ("<%=opCode%>" == "b997" || "<%=opCode%>" == "b998" || "<%=opCode%>" == "b999") {
			
			/* add 两城一家申请+变更+取消中，省际 备注信息有调整 for 关于长途漫游资费上线需求的函@2014/12/18  */
			if($("input[@name=opType]:checked").val() == "0"){ //两城一家
				
				if($("#offerType").val() == "YnDz"){ //省际
					note_info2 += "两城一家是为满足客户漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠，变更漫游城市和取消套餐均为下月1日生效。欢迎您参加活动！" + "|";
				/* add 两城一家申请+变更+取消中，省内 备注信息有调整 for 省内两城一家常态化优化需求@2014/12/29  */
				}else if($("#offerType").val() == "YnDy"){ //省内
					note_info2 += "两城一家是为满足客户新春期间漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠。变更漫游城市和取消套餐均为下月1日生效。业务有效期36个月。" + "|";
				}else{
					
					if($("input[@name=opFlag]:checked").val() == "2") {
						
						 note_info2 += "两城一家是为满足客户漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠，取消套餐下月1日生效。欢迎您参加活动！"+"|";
					}else {
						
						var dayintime="";
					  if($("#offerType").val() == "YnDz") {
					  			dayintime="2014年7月1日-2014年8月31日";
					  }else {
					  			dayintime="2014年1月1日零时至2014年12月31日24时";
					  }
						note_info2 += "两城一家是为满足客户新春期间漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠，并可获赠归属地和漫游申请地直拨12582热线免费通话分钟数共30分钟和免费务工信息服务，获取最新务工政策、招聘会和招工岗位信息。变更漫游城市和取消套餐均为下月1日生效。活动时间为"+dayintime+"，取消赠送可回复“QXWGYT”。欢迎您参加活动！"+"|";
				  }
				}
				
			}else{
				
				if($("input[@name=opFlag]:checked").val() == "2") {
					 note_info2 += "两城一家是为满足客户新春期间漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠，并可获赠归属地和漫游申请地直拨12582热线免费通话分钟数共30分钟和免费务工信息服务，获取最新务工政策、招聘会和招工岗位信息。变更漫游城市和取消套餐均为下月1日生效。活动时间为:省内2014年1月1日零时至2014年12月31日24时，省际2014年7月1日-2014年8月31日，取消赠送可回复“QXWGYT”。欢迎您参加活动！"+"|";
				}else {
					var dayintime="";
				  if($("#offerType").val() == "YnDz") {
				  			dayintime="2014年7月1日-2014年8月31日";
				  }else {
				  			dayintime="2014年1月1日零时至2014年12月31日24时";
				  }
					note_info2 += "两城一家是为满足客户新春期间漫游通信需要而提供的定点漫游优惠服务。在指定城市漫游被叫通话免费，主叫通话享受优惠，并可获赠归属地和漫游申请地直拨12582热线免费通话分钟数共30分钟和免费务工信息服务，获取最新务工政策、招聘会和招工岗位信息。变更漫游城市和取消套餐均为下月1日生效。活动时间为"+dayintime+"，取消赠送可回复“QXWGYT”。欢迎您参加活动！"+"|";
			  }
			}
		}

		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
	
	
	
	
function FixWidth(selectObj)
{
	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}
</script>
</head>
<body>

<form name="frm" method="POST" action="fd013Cfm.jsp">

<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="custName" id="custName" value="<%=custName%>">
<input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>">
<input type="hidden" name="offerNum" id="offerNum" value="">
<input type="hidden" name="offerExpDate" id="offerExpDate" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=request.getParameter("opName")%></div>
</div>
<table cellspacing="0">
	<tr>
		<td width="20%" class="blue">营销方案</td>	
		<td width="80%" class="blue" colspan="3">
			<div id="opType0"><input type="radio" name="opType" value="0"  />两城一家</div>
			<div id="opType1"><input type="radio" name="opType" value="1"  />非常假期</div>	
			<div id="opType2"><input type="radio" name="opType" value="2"  />定向国内长途</div>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">操作类型</td>	
		<td width="80%" class="blue" colspan="3">
			<input type="radio" name="opFlag" value="1" />申请
			<input type="radio" name="opFlag" value="2" />取消
			<input type="radio" name="opFlag" value="3" />变更
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">用户号码</td>		
		<td width="80%" class="blue" colspan="3">
			<input type="text" name="userPhone" id="userPhone" Class="InputGrey" value="<%=phoneNo%>" readonly/>	
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">客户姓名</td>		
		<td width="80%" class="blue" colspan="3">
			<input type="text" name="kehuname" id="kehuname" Class="InputGrey" value="<%=custName%>" readonly/>	
		</td>
	</tr>	
	<tr>
		<td width="20%" class="blue">套餐类型</td>
		<td width="80%" class="blue" colspan="3">
			<select name="offerType" id="offerType">
				<option value="0">请选择</option>
				<option value="YnDz">省际</option>	
				<option value="YnDy">省内</option>	
				<option value="YnDa">定向国内长途</option>
			</select>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">套餐代码</td>
		<td width="80%" class="blue">
			<select name="oldOfferCode" id="oldOfferCode" style="width:400px">
				<option>请选择</option>
			</select>
			<div name="oldOfferCodeMulti" id="oldOfferCodeMulti"></div>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue"><span id="newTig" style="display:none">变更为</span></td>
		<td width="80%" class="blue">
			<select name="newOfferCode" id="newOfferCode" style="display:none" style="width:400px">
				<option>请选择</option>
			</select>
		</td>
	</tr>
	<tr>
		<td width="20%" class="blue">备注</td>	
		<td width="80%" class="blue" colspan="3">
			<input name="iOpNOte" id="iOpNOte" class="button" size="60" maxlength="60" index="38"  v_must="0" v_maxlength="60" readonly/>
		</td>
	</tr>
</table>
<div class="title">
	<div name="title_zi" id="title_zi">用户当前订购信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">用户号码</td>
		<td class="blue">套餐类型</td>
		<td class="blue">套餐名称</td>
		<td class="blue">生效时间</td>
		<td class="blue">失效时间</td>
	</tr>
<%
	for(int i=0 ;i<result1.length;i++){
%>
	<tr>
		<td class="blue"><%=phoneNo%></td>
		<td class="blue"><%=result1[i][4]%></td>
		<td class="blue"><%=result1[i][0]+ '-' + result1[i][1]%></td>
		<td class="blue"><%=result1[i][2]%></td>
		<td class="blue"><%=result1[i][3]%></td>	
	</tr>
<%
	}
%>
</table>
<table cellspacing="0">
	<tr>
	    <td colspan="2" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" value="确定">
	      <input class="b_foot" type=button name="closeTab" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	    </td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>