   <%
	/**
	 * Title: 宽带移机
	 * Description: 宽带移机展示页面
	 * Copyright: 2012-7-9 9:20:38
	 * Company: SI-TECH
	 * author：liujian
	 * version 1.0 
	 */
%>
<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	System.out.println("---liujian---opCode=" + opCode);
%>
<%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/s1104/ignoreIn.jsp" %>
<%@ include file="/npage/common/qcommon/print_include1.jsp"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%
	
	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
	String broadPhone = WtcUtil.repNull(request.getParameter("broadPhone"));
	String workNo = (String) session.getAttribute("workNo");
    String password = (String) session.getAttribute("password");
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println("---liujian---activePhone=" +phoneNo + "----broadPhone=" +broadPhone);
	String oprDate =  new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String servBusiId = "";
	String userRegionName = "";
	String offerName = "";
	String smCode ="";
	String orgCode = (String) session.getAttribute("orgCode");
	System.out.println(orgCode+"e916ssss");
	String c0="",c1="",c2="",c3="",c4="",c5="",c6="",c7="",c8="",c9="",c10="",c11="",c12="",c13="",c21="",c22="";
	boolean runFlag = false;
	String[][] rstParams = new String[][]{};
	String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String sql = "select * from Service_Offer where  function_code = 'e916'";
	String ifKe = "";
	/*2014/07/08 14:31:05 gaopeng R_CMI_HLJ_xueyz_2014_1644996@自有农村无线宽带（WBS）业务系统支撑需求 承载方式*/
	String sbearType = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=sql%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />
<%
	servBusiId = result2[0][0];
	System.out.println("--------liujian--------servBusiId=" + servBusiId);
%>	
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

	<%
		String[] inputParams = new String[8];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = password;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = broadPhone;
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("---liujian---inputParams[" + i + "]=" + inputParams[i]);
		}
	%>
	<wtc:service name="se916Qry" routerKey="reg	ion" routerValue="<%=regionCode%>"
			retcode="retCode" retmsg="retMsg" outnum="23">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
		<%
			if(retCode.equals("000000")) {
				runFlag = true;
				System.out.println("------e916---tempArr.length=" + tempArr.length);
				System.out.println("------e916---tempArr[0].length=" + tempArr[0].length);
				offerName = tempArr[0][7];
				smCode = tempArr[0][8];
				userRegionName = tempArr[0][9];
				c0=tempArr[0][0];
				c1=tempArr[0][1];
				c2=tempArr[0][2];
				c3=tempArr[0][3];
				c4=tempArr[0][4];
				c5=tempArr[0][5];
				c6=tempArr[0][6];
				c7=tempArr[0][7];
				c8=tempArr[0][12];
				c9=tempArr[0][11];
				//liujian 2012-9-18 9:56:45 添加出参
				c10=tempArr[0][13];
				c11=tempArr[0][14];
				c12=tempArr[0][15];
				//gaopeng 20121031 增加一个品牌
				ifKe=tempArr[0][8].trim();
				/*2014/07/08 14:29:13 gaopeng R_CMI_HLJ_xueyz_2014_1644996@自有农村无线宽带（WBS）业务系统支撑需求 新增出参,下标16第17个参数 返回承载方式*/
				sbearType = tempArr[0][16].trim();
				c13 = tempArr[0][17];
				c21=tempArr[0][21];
				c22=tempArr[0][22];
				System.out.println("gaopengSeeLog=========sbearType="+sbearType);
				/* kd：铁通；ke：广电；kf：移动宽带*/
			}else {
		%>
				<script>
					rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
					removeCurrentTab();
				</script>
		<%		
			}
			
			

	String isNeedHold = "1";
	/* 
   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
   * 新增省广电kg，备用品牌kh
   * houxuefeng要求kf  kg只输入数字，kh保持不变。2014/11/4 13:36:10
   */
	if("kf".equals(ifKe) || "kg".equals(ifKe) || "ki".equals(ifKe)){
		isNeedHold = "1";
		/*5的不需要预占*/
		if("5".equals(c13)){
			//isNeedHold = "0";
		}
	}
	/*2014/11/21 10:32:26 gaopeng kh品牌改为铁通自建 与kd一样的玩法*/
	else if("kh".equals(ifKe)){
		/*kh的全是5 不需要预占*/
		isNeedHold = "0";
	}
	else if("ke".equals(ifKe)){
  		isNeedHold = "0";
  }
			
System.out.println("-----liujian---------isNeedHold----------------->"+isNeedHold);			


		%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
			routerValue="<%=regionCode%>"  id="sysAccept" /> 	
<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<script>
			$(function() {
				$('#pageHref').val(window.location.href);
				if(<%=runFlag%>) {
					$('#cfmLoginNew').text('<%=c0%>');
					$('#custName').text('<%=c1%>');
					$('#detailAddr').text('<%=c2%>');
					$('#detailAddrOld12').val('<%=c2%>');
					$('#contactPhoneNo').text('<%=c3%>');
					$('#idIccid').text('<%=c4%>');
					$('#runState').text('<%=c5%>');
					$('#curFee').text('<%=c7%>');
					$('#prepayFee').text('<%=c6%>');
					$('#custNameText').val('<%=c1%>');
					$('#curPart').text('<%=c8%>');
					$('#oPartnerCode').val('<%=c9%>');
					//liujian 2012-9-18 10:08:55 
					$('#cctNameOld').val('<%=c10%>');
					$('#appointTimeOld').val('<%=c11%>');
					$('#accessTypeOld').val('<%=c12%>');
					$('#propertyUnitOld').val('<%=c13%>');
					if('<%=ifKe%>' == 'kd') {
						getOldResByCfmLogin();
					}
					buttonShow();
		/*如果是哈！宽带（ke）不用资源预占，并且提示*/
		if("<%=ifKe%>" == "ke"){
			$("#yz_resource").attr("disabled","disabled");
			$("#sf_resource").attr("disabled","disabled");
			$("#keShowSpan").show();
		}
		
				}else {
					rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
				}
				
				<% if("kf".equals(ifKe)&&"0".equals(c22)){%>
					kdzdchange();
					go_checkSNShow();
				<%}%>
				FEEsqfs();
			});
			
			function setGetAreaResource(val) {
				$('#isGetAreaResource').val(val);
				
			}
			function setYzResource(val) {
				$('#isYzResource').val(val);
				if(val == '0') {
					//$('#yz_resource').val('资源预占');
				}else if(val == '1') {
					//$('#yz_resource').val('取消预占');
				}	
			}
			function setNoPort(val) {
				$('#noPort').val(val);
			}
			function setInputsReadOnly(flag) {
				$('#contactPhone').css("readonly",flag);
				$('#contactCustName').css("readonly",flag);
				$('#enter_addr').css("readonly",flag);
			}
			/*宽带小区查询*/
			function queryResource() { 
				idleResInfo();
				if($('#isYzResource').val() != "1"){
				
				 var smcodess="<%=smCode%>";			   
					var path ="../se276/queryResource.jsp?opCode="+"<%=opCode%>"+"&smCode="+smcodess;
					window.open(path,'小区资源查询','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
				}else{	 
					yzResource();//释放资源 	
				}
			} 
			
			//制空"资源信息"的表单
			function idleResInfo() {
				$('#cctId').val('');
				$('#cctName').val('');
				$('#ipAddress').val('');
				$('#portCode').val('');
				$('#deviceType').val('');
				$('#portType').val('');
				$('#deviceCode').val('');
				$('#deviceInAddress').val('');
				$('#areaCode').val('');
				$('#areaName').val('');
				$('#standAddress').val('');
				$('#enterType').val('');
			}
			function oneTok(str,tok,loc)
			{
			 var temStr=str;
			 var temLoc;
			 var temLen;
			 for(ii=0;ii<loc-1;ii++)
			 {
			     temLen=temStr.length;
			     temLoc=temStr.indexOf(tok);
			     temStr=temStr.substring(temLoc+1,temLen);
			 }
			 if(temStr.indexOf(tok)==-1)
			    return temStr;
			 else
			    return temStr.substring(0,temStr.indexOf(tok));
			}
			// 小区资源查询反馈的函数
			function returnResBack(retInfo) {
			//alert(retInfo);
			//alert(262);
				var resPre=retInfo.substr(0,2);
				var resContent=retInfo.substr(2,retInfo.length-1);
				//alert(resContent);
				document.all.enter_type.value=  oneTok(resContent, "|", 5);
				//alert(266);
				var sbearType = oneTok(resContent, "|", 19);
				
				var propertyUnit = oneTok(resContent, "|", 20);
				$("#propertyUnit").val(propertyUnit);
				/*2014/07/08 14:38:50 gaopeng R_CMI_HLJ_xueyz_2014_1644996@自有农村无线宽带（WBS）业务系统支撑需求 校验方法
					虽然写的罗嗦点，但是还是比较严谨
				*/
				if("<%=ifKe%>" == "kf" || "<%=ifKe%>" == "ki"){
					/*无线*/
					if("<%=sbearType%>" == "1"){
						if(sbearType == "0"){
							/*
							rdShowMessageDialog("该宽带承载类型为1/无线，请选择1/无线的小区资源！");
							$("#cfmBtn").attr("disabled","disabled");
							return false;
							*/
							$("#cfmBtn").attr("disabled","");
						}else if(sbearType == "1"){
							$("#cfmBtn").attr("disabled","");
						}
					}
					/*有线*/
					if("<%=sbearType%>" == "0"){
						if(sbearType == "1"){
							rdShowMessageDialog("该宽带承载类型为0/有线，请选择0/有线的小区资源！");
							$("#cfmBtn").attr("disabled","disabled");
							return false;
						}else if(sbearType == "0"){
							$("#cfmBtn").attr("disabled","");
						}
					}
				}
				
	/* 4977宽带开户小区资费查询增加广电限制：接入类型为移动宽带，且小区建设性质为广电，则不需进行资源预占@2014/5/29 16:39:50 */
	/*2014/11/19 10:52:43 铁通融合项目 gaopeng 修改 只用小区建设性质判断即可，kg和ke和kh均不用预占
		kg=3 ke=4 kh=5
		2015/01/08 11:11:09 gaopeng 3 4 5 6(三方)的时候 不进行资源预占
	*/
	if( document.all.propertyUnit.value.trim() == "3" || document.all.propertyUnit.value.trim() == "4" ){
		$("#isNeedHold").val("0");
		document.all.yz_resource.disabled=true;
	}
	/*2016/5/31 10:22:02 gaopeng 关于铁通宽带客户迁移支撑系统改造补充需求的函 
		小区建设性质 为5 5-铁通（铁通自有）  6 6-三方(移动自建)
		接入类型为 “2/FTTH”和“3/FTTB”时 需要预占
		其他情况不需要预占
	*/
	if(document.all.propertyUnit.value.trim() == "5" || document.all.propertyUnit.value.trim() == "6"){
		/*接入类型为 “2/FTTH”和“3/FTTB”时 需要预占*/
		if(document.all.enter_type.value == "2" || document.all.enter_type.value == "3"){
			$("#isNeedHold").val("1");
			document.all.yz_resource.disabled=false;
		}else{
			$("#isNeedHold").val("0");
			document.all.yz_resource.disabled=true;
		}
	}
				
				
				//alert(resContent);
				$('#areaName').val(oneTok(resContent, "|", 3));
				$('#areaCode').val(oneTok(resContent, "|", 2));
				/*2013/3/4 星期一 15:19:56 gaopeng 增加了一个隐藏域，用来存放参数。*/
				$('#areaAddr').val(oneTok(resContent, "|", 3));
				$('#standardCode').val(oneTok(resContent, "|", 6));//addressCode地址编码
				$('#enterType').val(oneTok(resContent, "|", 5));
				$('#standAddress').val(oneTok(resContent, "|", 7));
				$('#deviceType').val(oneTok(resContent, "|", 8));
				$('#deviceCode').val(oneTok(resContent, "|", 9));
				$('#ipAddress').val(oneTok(resContent, "|", 12));
				$('#deviceInAddress').val(oneTok(resContent, "|", 13));
				$('#portType').val(oneTok(resContent, "|", 14));
				$('#portCode').val(oneTok(resContent, "|", 15));
				$('#cctId').val(oneTok(resContent, "|", 16));
				document.all.nPartnerCode.value=oneTok(resContent, "|", 17);
				
				document.all.belongCategory.value=oneTok(resContent, "|", 18);
				document.all.bearType.value=oneTok(resContent, "|", 19);
				document.all.distKdCode.value=oneTok(resContent, "|", 21);
				document.all.nearInfo.value=oneTok(resContent, "|", 22);
	
				
				/*2014/07/08 14:53:03 gaopeng 赋值，传到后面*/
				$('#sbearType').val(sbearType);
				/*
				2015/12/29 9:41:46 gaopeng 
				R_CMI_HLJ_guanjg_2015_2521975@关于修改宽带移机规则的需求
				去掉该限制
				原要求同品牌可以移机，由于原逻辑就是通过品牌的转换为建设性质来查询
				所以不需要另外判断。
				if($.trim($("#propertyUnitOld").val()) != $.trim($("#propertyUnit").val())){
					rdShowMessageDialog("新旧小区建设性质不一致，不允许移机！");
					return false;
				}
				*/
				
				var pkt = new AJAXPacket("ajaxGetPartnerName.jsp","请稍后...");
				pkt.data.add("partnerCode",document.all.nPartnerCode.value);
				pkt.data.add("iSmCode","<%=smCode%>");
				core.ajax.sendPacket(pkt,doPartnertName);
				pkt = null;	
					
				var cctIdVal = $('#cctId').val();
				if(cctIdVal != ""){
					var packet = new AJAXPacket("../s4977/ajaxGetCctName.jsp","请稍后...");
					packet.data.add("cctId",cctIdVal);
					core.ajax.sendPacket(packet,doAjaxGetCctName);
					packet = null;
				} 
				//设置小区资源状态位
				setGetAreaResource('1');
				if (resPre =="3%"){
				//rdShowMessageDialog("该资源有设备没有端口，不能预占！");
					setNoPort('1');
					//buttonShow();
				}else if (resPre =="4%"){
					setNoPort('0');
					buttonShow();
				}
				
			}
			function doPartnertName(packet)
			{
				var retCode = packet.data.findValueByName("ptRtCode");
				var retMsg = packet.data.findValueByName("ptRtMsg");
				
				if(retCode == "000000")
				{
					var ptName = packet.data.findValueByName("ptName");
					document.all.nPartnerName.value=ptName;	
				}
				else
				{
					rdShowMessageDialog(retMsg,0);
					removeCurrentTab();
				}
			}			
			
			//设置“小区资源查询”和“资源预占”按钮的显示状态
function buttonShow() {

	if(document.all.isYzResource.value=="0")
	{	
		
    if(document.all.isGetAreaResource.value=="1")
		{
			document.all.yz_resource.disabled=false;
		}else if (document.all.isDoNoResource.value=="1")
		{
			document.all.yz_resource.disabled=true;
		}else if ((document.all.isDoNoResource.value !="1") && (document.all.isGetAreaResource.value!="1") )
		{
			document.all.query_res.disabled=false;
			document.all.yz_resource.disabled=true;
		}
		
		if($("#isNeedHold").val() == "1"){
			/*需要预占的*/
			document.all.yz_resource.disabled=false;
			document.all.sf_resource.disabled=true;
		}else{
			document.all.yz_resource.disabled=true;
			document.all.sf_resource.disabled=true;
		}
		
	}
	else{
			document.all.query_res.disabled=true;
      document.all.yz_resource.disabled=true;
      document.all.sf_resource.disabled=false;
	}

}
			
			//生成电信局名称
			function doAjaxGetCctName(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMessage");
				var cctName = packet.data.findValueByName("cctName");
				if(retCode == "000000") {
					$('#cctName').val(cctName);	
				}else {
					rdShowMessageDialog(retMsg,0);
				}
			}
			
			/*获取旧资源信息*/
			function getOldResByCfmLogin() {
					document.all.deviceNameOld.value="";
						//liujian 2012-9-18 10:16:44 end
						document.all.deviceCodeOld.value="";
						document.all.ipAddressOld.value="";
						document.all.deviceInAddressOld.value= "";
						document.all.portCodeOld.value= "";
						document.all.cctIdOld.value = "";       
			}
			
			/*资源预占*/
			function yzResource() {
				if($('#isGetAreaResource').val() == "0") {
				       rdShowMessageDialog("没有选择资源，请选择资源");
				       return false;
				}
				if(!$('#cfmLogin').val()) {
						rdShowMessageDialog("没有宽带登陆账号不可以预占资源",0);
						return false;
				}
				var contactCustName = $('#contactCustName').val();
				if(!contactCustName && contactCustName != "0"){
				  	rdShowMessageDialog("联系人不可以为空，请输入");
				  	$('#contactCustName').focus();
				  	return false;
				}
				var contactPhone = $('#contactPhone').val();
				if(!contactPhone && contactPhone != "0"){
				  	rdShowMessageDialog("联系号码不可以为空，请输入");
				  	$('#contactPhone').focus();
				  	return false;
				}
				var enter_addr = $('#enter_addr').val();
				if(!enter_addr){
					rdShowMessageDialog("安装地址不可以为空，请输入");
					$('#enter_addr').focus();
					return false;
				}
				
				var zhengze = /[\~\`\^\,\=]+/g;
			    if(zhengze.test($('#enter_addr').val())){
		         	rdShowMessageDialog("安装地址不可以包括~`^,=等特殊字符请修改!");
		         	$('#enter_addr').focus();
		         	return false;
			    }
				
				 
				var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "正在校验，请稍候......");
				myPacket.data.add("serviceOrder","<%=servBusiId%>" );
				myPacket.data.add("addressCode", $('#standardCode').val());
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*业务所属区域*/
				myPacket.data.add("businessDemand","");/*业务需求描述*/
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*申请系统主工单号*/
				myPacket.data.add("productName", "<%=offerName%>");
				myPacket.data.add("productCode", $('#cfmLogin').val());
				myPacket.data.add("productType","12");/*产品类型*/
				myPacket.data.add("productState","");/*产品业务状态*/
				myPacket.data.add("validateTime","");/*拟生效时间*/
				myPacket.data.add("relatedProductCode","");/*关联产品*/
				myPacket.data.add("account", $('#cfmLogin').val());
				myPacket.data.add("password","null");/*密码*/
				myPacket.data.add("customerName", $('#custName').text());/*liujian 2012-12-18 15:10:30 和 chenlin 沟通   修改成 客户姓名*/
				myPacket.data.add("customerAddress", $('#detailAddr').text());/*liujian 2012-12-18 15:10:30 和 chenlin 沟通   修改成 安装地址*/
				myPacket.data.add("customerGrade","");/*用户级别*/
				myPacket.data.add("customerLinkMan",$('#contactCustName').val());/*用户联系人*/
				myPacket.data.add("customerPhone", $('#contactPhone').val());
				myPacket.data.add("customerMail","");/*联系邮箱*/
				myPacket.data.add("customerCode",$('#cfmLogin').val());/*用户编号*/
				myPacket.data.add("newCustomerName",$('#contactCustName').val());/*liujian 2012-12-18 15:10:30 和 chenlin 沟通   修改成 联系人名称*/
				myPacket.data.add("newCustomerAddress",$('#enter_addr').val());/* liujian 2012-12-18 15:10:30 和 chenlin 沟通  修改成 联系人地址*/
				myPacket.data.add("newCustomerPhone",$('#contactPhone').val());/* liujian 2012-12-18 15:10:30 和 chenlin 沟通  修改成 联系人电话*/
				myPacket.data.add("stdAddress",$('#standAddress').val());/*用户标准地址*/
				myPacket.data.add("newRate","");/*新宽带速率*/
				myPacket.data.add("oldRate","");/*旧宽带速率*/
				myPacket.data.add("serviceType","17");/*服务类型*/	
				myPacket.data.add("deviceName", $('#deviceType').val());
				myPacket.data.add("deviceId", $('#deviceCode').val());
				myPacket.data.add("portName", $('#portType').val());
				myPacket.data.add("portId", $('#portCode').val());
				myPacket.data.add("collType","");/*合作类型*/
				myPacket.data.add("broadBandObject","");/*宽带对象*/
				myPacket.data.add("opCode", "<%=opCode%>");
				myPacket.data.add("enterType", $("#enterType").val());
				myPacket.data.add("propertyUnit", $("#propertyUnit").val());
				if($('#isYzResource').val() == "1"){
					rdShowMessageDialog("该用户已预占资源,如果要重新预占，确定要释放原先资源？",1); 
					myPacket.data.add("yzFlag", "2" );
					myPacket.data.add("productApplyUses","宽带移机资源释放");/*用途*/
					myPacket.data.add("opNote", "资源释放");/*备注*/
					core.ajax.sendPacket(myPacket,doYzResource);
					myPacket = null;
				}else if($('#isYzResource').val() == "0"){
					myPacket.data.add("yzFlag", "0" );//liujian 2012-12-18 15:07:40 预占0；归档1；释放2
					myPacket.data.add("productApplyUses","宽带移机资源预占");/*用途*/
					myPacket.data.add("opNote", "资源预占");/*备注*/
					core.ajax.sendPacket(myPacket,doYzResource);
					myPacket = null;
				}
			} 
			function doYzResource(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var retContent = packet.data.findValueByName("retContent");
				var iType = packet.data.findValueByName("iType");
				if(iType=="0"){
					if(retCode=="000000"){	//表示调用服务成功
						var retValue=retContent.split(",");
						var retContent=retValue[2].split("=");
						if(retContent[1]=="0"){//判断是否预占成功
							//有些输入框不可编辑
							setInputsReadOnly(true);
							setYzResource("1");
							//setYzResource("0");
							rdShowMessageDialog("资源预占成功",2);
							buttonShow();
							var myPacket = new AJAXPacket("../sm462/ajax_getAreaInfo1.jsp", "正在获取，请稍候......");
							myPacket.data.add("kuandaiNum", $("#cfmLoginNew").text());
							myPacket.data.add("iObjectType", "03");
							myPacket.data.add("smCode", "<%=smCode%>" );
							core.ajax.sendPacket(myPacket,doGetAreaInfo);
							myPacket = null;
							
					//document.all.query_res.disabled=true;
					//document.all.yz_resource.disabled=true;
					//document.all.isfouyuzhan.value="yes";
							
						}else{
							rdShowMessageDialog("资源预占失败",0);
							return false;
						}     
					}
					else {                                       
						rdShowMessageDialog(retMsg,0); 
						setYzResource("0");
						return false;
					}
				}else if(iType=="2"){
			        if(retCode=="000000" ){	 
						var retValue=retContent.split(",");
						var retContent=retValue[2].split("=");
						if(retContent[1]=="0"){   
							idleResInfo();
							//有些输入框可编辑
							setInputsReadOnly(false);       	 
							setGetAreaResource("0");
							setYzResource("0");
							rdShowMessageDialog("资源释放成功",1);
							buttonShow();
						}else{
							rdShowMessageDialog("资源释放失败",0); 
						} 
			        }else{ 
						rdShowMessageDialog(retMsg,0);  
						//setYzResource("1");
						setYzResource("0");
			        }
				}
			}
			var returnStr="";
			function doGetAreaInfo(packet)
			{
				var retCode = packet.data.findValueByName("retCode");
			  	var retMsg = packet.data.findValueByName("retMessage");
			  
				if(retCode=="000000"){	
					var result1= packet.data.findValueByName("result1");
					returnStr=result1;
				//	alert(oneTok(returnStr, "|", 24));
					$('#areaAddr').val($('#areaAddr').val()+"|"+oneTok(returnStr, "|", 24));
				}else if(retCode=="202" || retCode=="203"){
					rdShowMessageDialog("对不起，您输入的查询条件范围太大，请精确关键词后查询");	
					return false;
				}else{   
				   		rdShowMessageDialog(retMsg);
				   		return false;
				}
			}
			
			function doSubmit() {
				getAfterPrompt(); 
				
				if(!check(document.prodCfm)){
					return false;
				}
				if(!checkElement($("#kdZdFee")[0])){
					return false;
				}
				if(!forDate(document.all.bookDate)){
					rdShowMessageDialog("预约上门时间格式不正确！");
					document.all.bookDate.focus();
					return false;
				}
				if(forDate(document.all.bookDate)){
					if($(document.getElementById("bookDate")).val() < "<%=dateStr2%>")
					{
						rdShowMessageDialog("预约上门时间不能小于当前时间！");
						return false;
					}
				}
				
				    if( ($("#noPort").val() != "1") && 
        (document.all.isYzResource.value!="1") && 
        (document.all.isDoNoResource.value !="1")
        &&($("#isNeedHold").val() == "1")){
      rdShowMessageDialog("没有预占资源或不允许不预占资源办理!");
      return false;  
    }
				
				
				var path = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
				if("<%=ifKe%>" == "kf"&&"0" == "<%=c22%>"){
					if($("#kdZd").val()=="ONT"&&$("#fysqfs").val()=="0"){
						showBroadKdZdBill("Bill","确实要进行宽带终端发票打印吗？","Yes");
					}
				//	if($("#kdZd").val()=="CPE"){
				//		showBroadKdZdBill("Bill","确实要进行宽带终端发票打印吗？","Yes");
				//	}
				}
				if(rdShowConfirmDialog("请确认是否进行宽带移机？")==1) {	
					document.prodCfm.action="fe916_2.jsp";
					document.prodCfm.submit();
				}
			}
			function doReset(){
				location = $('#pageHref').val();
			}

			/*电子免填单打印*/
			function showPrtDlg(printType,DlgMessage,submitCfm) {   
				var h=210;
				var w=400;
			    var t = screen.availHeight / 2 - h / 2;
			    var l = screen.availWidth / 2 - w / 2;
			    var opCode=$("#opCode").val();
				var pType="subprint";
				var billType="1";
				var mode_code=null;
				var fav_code=null;
				var area_code=null;
				var sysAccept = $('#sysAccept').val();
			    var printStr = printInfo(printType);
			    var iRetrun = 0;
			    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
			    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			    var ret = window.showModalDialog(path, printStr, prop);
			}
			/*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
			function getPubSmCode(kdNo){
					var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("phoneNo","");
					getdataPacket.data.add("kdNo",kdNo);
					core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
					getdataPacket = null;
			}
			function doPubSmCodeBack(packet){
				retCode = packet.data.findValueByName("retcode");
				retMsg = packet.data.findValueByName("retmsg");
				smCode = packet.data.findValueByName("smCode");
				if(retCode == "000000"){
					$("#pubSmCode").val(smCode);
				}
			}
			/*打印信息*/
			function printInfo(printType) {
				getPubSmCode($("#cfmLogin").val());
				var pubSmCode = $("#pubSmCode").val();
				
				var retInfo = "";
			    if (printType == "Detail"){					
					var cust_info="";
					var opr_info="";
					var note_info1="";
					var note_info2="";
					var note_info3="";
					var note_info4="";        
					cust_info += "宽带帐号：" + $("#cfmLogin").val() + "|";
					cust_info += "客户姓名：" + $('#custName').text() + "|";
					cust_info += "客户原地址：" + $('#detailAddr').text() + "|";
					cust_info += "客户新地址：" + $('#enter_addr').val() + "|";
					
					opr_info += "业务受理时间：<%=oprDate%>|";
					opr_info += "业务办理名称：宽带移机" + "               ";
					opr_info += "操作流水：" + $('#sysAccept').val() + "|";
					opr_info += "移机手续费：" + $("#payFee").val() + "元 |";
					if(printSN){
						opr_info+= "S/N码："+$("#snNumber").val()+"|";
					}
					
					note_info1 += "备注："+"|";
				  /* 
			     * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			     * 新增省广电kg，备用品牌kh
			     */
					if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						note_info1 += "1、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时收到通知。"+"|";
						note_info1 += "2、如需帮助，请拨打服务热线：10086。"+"|";
					}
					/*
					note_info2 += "1、宽带移机，需要将用户原来的宽带业务安装到用户新的接入地址，最多5个工作日完成移机工作，在移机过程中原有宽带使用中断。" + "|";
					note_info2 += "2、在移机过程中宽带业务包年费用照收，上网功能暂停，包年期限不延后。移机按照标准收取移机费用。" + "|";
					*/
					retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
					retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				}
			    return retInfo;
			}
			 
			//showBroadKdZdBill("Bill","确实要进行宽带终端发票打印吗？","Yes");
			function showBroadKdZdBill(printType,DlgMessage,submitCfm){
				var printInfo = "";
				var prtLoginAccept = "<%=loginAccept%>";
				var zhengjianType = ["身份证","军官证","户口簿","港澳通行证","警官证","台湾通行证","外国公民护照","其它","营业执照","护照"];
				zhengjianType["A"]="组织机构代码";
				zhengjianType["B"]="单位法人证书";
				zhengjianType["C"]="单位证明";
				var idType = "<%=c21%>";
				var iccidtypess=zhengjianType[idType];
				var iccidnoss=$('#idIccid').text();
				var fysqfss=$("#fysqfs").val();
				var  billArgsObj = new Object();
				
				var custName = $("#custNameText").val();
				var phoneNo = "<%=activePhone%>";
				var feeName = "宽带移机";
			  
		 		/*2014/09/11 15:18:07 gaopeng 宽带资费展现及终端管理等七项系统支撑优化需求
			  		加入 宽带设备终端款 
			  	*/
		  		var kdZdFee = $("#kdZdFee").val();
				$(billArgsObj).attr("10001","<%=workNo%>");     //工号
				$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
				$(billArgsObj).attr("10005",custName);   //客户名称
				$(billArgsObj).attr("10006","宽带移机");    //业务类别
				$(billArgsObj).attr("10008",phoneNo);    //用户号码
				$(billArgsObj).attr("10015", kdZdFee+"");   //本次发票金额
				$(billArgsObj).attr("10016", kdZdFee+"");   //大写金额合计
				$(billArgsObj).attr("10017","*");        //本次缴费：现金
				/*10028 10029 不打印*/
			  	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
				$(billArgsObj).attr("10029","");	 //营销代码	
				$(billArgsObj).attr("10030",prtLoginAccept);   //流水号：--业务流水
				$(billArgsObj).attr("10036","e916");   //操作代码
				$(billArgsObj).attr("10042","台");                   //单位
				$(billArgsObj).attr("10043","1");	                   //数量
				$(billArgsObj).attr("10044",kdZdFee+"");	                //单价
				/*10045不打印*/
				$(billArgsObj).attr("10045","");	       //IMEI
				/*型号不打*/
				$(billArgsObj).attr("10061","");	       //型号
	 			$(billArgsObj).attr("10078", "<%=ifKe%>"); //宽带品牌		
	 			$(billArgsObj).attr("10071","6");
	 			
	 			$(billArgsObj).attr("10083", iccidtypess); //证件类型
	 			$(billArgsObj).attr("10084", iccidnoss); //证件号码
	 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式
	 			$(billArgsObj).attr("10086", "尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票、有效证件，到移动指定自有营业厅办理返还押金。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。"); //备注
	 			$(billArgsObj).attr("10041", "宽带终端押金费用");           //品名规格 实际是宽带终端类型
	 			$(billArgsObj).attr("10065", $("#cfmLoginNew").text()); //宽带账号
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
				var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？"+"&feeName="+feeName;
				var loginAccept = prtLoginAccept;
				var path = path +"&loginAccept="+loginAccept+"&opCode=e916"+"&submitCfm=submitCfm";
				var ret = window.showModalDialog(path,billArgsObj,prop);		

			}
			
			function sfResource(){
	var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "正在校验，请稍候......");
	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
	myPacket.data.add("customerCode",document.all.cfmLogin.value);/*用户编号*/
	myPacket.data.add("productType","12");/*产品类型*/
	myPacket.data.add("opCode", "<%=opCode%>");
	myPacket.data.add("yzFlag", "2");
	/*2013/3/1 星期五 9:09:16 gaopeng FTTH需求，增加参数 addressCode 地址编码*/
	myPacket.data.add("addressCode", document.all.standardCode.value);
	core.ajax.sendPacket(myPacket,doSfResource);
	myPacket = null;
}
function doSfResource(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retContent = packet.data.findValueByName("retContent");
	var iType = packet.data.findValueByName("iType");
	if(retCode=="000000"){
		//有些输入框可编辑
    setInputsReadOnly(false); 
		//有些按钮能用
		document.all.isYzResource.value="0";
		rdShowMessageDialog("资源释放成功",2);
		buttonShow();
	}else{
		rdShowMessageDialog("资源释放失败",0);
		return false;
	}
}
function kdzdchange(){
	var kdzdtypes = $("#kdZd").val();
	if(kdzdtypes=="ONT") {		    
	    $("#fysqfsdisplay1").show();
	    $("#fysqfsdisplay2").show();
	    $("#kdzdfydisplay").removeAttr("colSpan");
	    FEEsqfs();
	}else {
	    $("#fysqfsdisplay1").hide();
	    $("#fysqfsdisplay2").hide();
	    $("#kdzdfydisplay").attr("colSpan","3");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").hide();
	}
}
var snShow="0";
var printSN=false;
function showSN(){
	var kdZd = $("#kdZd").val();
	var fysqfs = $("#fysqfs").val();
	if(snShow=="2"&&kdZd=="ONT"&&(fysqfs=="0"||fysqfs=="1")){
		$("#sntitletd").show();
		$("#sntexttd").show();
		$("#snNumber").attr("v_must","1");
		printSN=true;
	}
	else{
		$("#sntitletd").hide();
		$("#sntexttd").hide();
		$("#snNumber").attr("v_must","0");
		printSN=false;
	}
}
function FEEsqfs() {
	var fysqfs = $("#fysqfs").val();
	if(fysqfs=="0") {//押金
		$("#kdZdFee").attr("v_minvalue","50");
		$("#kdZdFee").attr("v_maxvalue","200");
		$("#kdZdFee").attr("v_must","1");
		$("#kdZdFee").val("");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").show();
	}
	else if(fysqfs=="999"){
		}
	else {//自备
		$("#kdZdFee").removeAttr("v_minvalue");
		$("#kdZdFee").removeAttr("v_maxvalue");
		$("#kdZdFee").removeAttr("v_must");
		$("#kdZdFee").val("0");
		$("#kdZdFee").attr("readonly","readonly");
		$("#kdZdFee").attr("class","InputGrey");
		$("#yjfwxianshi").hide();
	}
}

function go_checkSNShow(){
	var packet = new AJAXPacket("/npage/s4977/ajaxCheckSnShow.jsp","请稍后...");
	packet.data.add("iLognAccept","<%=loginAccept%>");
	packet.data.add("iChnSource","01");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iLoginNo","<%=workNo%>");
	packet.data.add("iLoginPwd","<%=password%>");
	packet.data.add("iPhoneNo","<%=ifKe%>");
	packet.data.add("iUserPwd","");
	core.ajax.sendPacket(packet,do_checkSNShow);
	packet =null;
}

function do_checkSNShow(packet){
	var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code=="000000"){
    	snShow=packet.data.findValueByName("vFlag");
    	showSN();
		return;
    }else{//操作失败
    	snShow="1";
    	showSN();
    	return false;
    }
}
		</script>
	</HEAD>
<BODY>
<DIV id=operation>
<FORM name="prodCfm" action="" method="post" width="100%">
	
	<%@ include file="/npage/include/header.jsp" %>	
	<div id="Operation_table">
		<div class="title">
			<div id="title_zi">基本信息</div>
	</div>
	<div id="custInfo">
		<table>
			<tr>
				<td class="blue">宽带账号</td>
				<td><font id="cfmLoginNew"></font></td>
				<td class="blue">客户姓名</td>
				<td><font id="custName"></font></td>
			</tr>	
			<tr>
				<td class="blue">安装地址</td>
				<td><font id="detailAddr"></font></td>
				<td class="blue">联系电话</td>
				<td><font id="contactPhoneNo"></font></td>
			</tr>	
			<tr>
				<td class="blue">证件号码</td>
				<td><font id="idIccid"></font></td>
				<td class="blue">运行状态</td>
				<td><font id="runState"></font></td>
			</tr>	
			<tr>
				<td class="blue">当前资费</td>
				<td><font id="curFee"></font></td>
				<td class="blue">当前可用预存款</td>
				<td><font id="prepayFee"></font></td>
			</tr>	
			<tr>
				<td class="blue">当前合作方</td>
				<td><font id="curPart"></font></td>
			</tr>				
		</table>
	</div>
	
	<div id="Operation_table">
		<div class="title">
			<div id="title_zi">资源信息</div>
	</div>
	<table cellSpacing=0 id="serviceNoInfo">	
		<tr>
			<td colspan=6 align="center">     
				<input type="button" class="b_text" id="query_res" name="query_res" value="小区资源查询" onClick="queryResource()" >
				<input type="button" class="b_text" id="yz_resource" name="yz_resource" value="资源预占" disabled onClick="yzResource()">
				<input type="button" class="b_text" name="sf_resource" id="sf_resource" value="资源释放" onClick="sfResource()">
							 <span id="keShowSpan" style="color:red;display:none;">广电宽带无需资源预占和资源释放</span>
			          <%if("1".equals(isNeedHold)) {%>
			          <span  style="color:red;">如果点击“资源预占”，不进行宽带移机请点击“资源释放”，不要直接关闭界面</span>
			          <%}%>
			</td>   
		</tr>
			
		<tr>  
			<td class="blue">联系人</td>
			<td>
				<input type="text" name="contactCustName" id="contactCustName" v_must="1" class="required" maxlength="15" value=""> 
				<font class="orange">*</font>
			</td>
			<td class="blue">联系电话</td>
			<td>
				<input type="text" name="contactPhone" id="contactPhone" v_must="1"  class="required andCellphone" value="" />
				<font class="orange">*</font>
			</td>
			<td class="blue">小区名称</td>
			<td>
				<input type="text" name="areaName" id="areaName" readonly />
			</td>
		</tr>  
		<tr>  
			<td class="blue">安装地址</td>
			<td colspan=3>
				<input type="text" name="enter_addr" id="enter_addr" size="80" v_must="1"  value="" maxlength="100" />
				<font class="orange">*</font>
			</td>
			<td class="blue">电信局名称</td>
			<td >
				<input type="text" name="cctName" id="cctName" readonly />
			</td>
		</tr> 
		<tr>  	
			<td class="blue">施工要求</td>
			<td colspan="3">
				<input type="text" name="constructRequest" id="constructRequest" size="80" />
			</td>
			<td class="blue">合作方</td>
			<td >
				<input type="text" name="nPartnerName" id="nPartnerName" size="20" />
			</td>
		</tr>
		<tr>
			<td class="blue">接入方式</td>
			<td> 
				<input type="text" name="enterType" id="enterType" class="InputGrey" maxlength="25" size="20" readonly />
			</td>
			<td class="blue">预约时间</td>
			<td> 
				<input type="text" name="bookDate"  id="bookDate"  v_must="1"  v_format="yyyyMMdd" class="required" value=""/>
				<font class="orange">*(格式YYYYMMDD)</font>
			</td>
			<td class="blue">移机手续费</td>
			<td> 
				<select name="payFee" id="payFee" style="width:80px">
					<option value="0">0</option>	
					<option value="10">10</option>	
					<option value="20">20</option>	
					<option value="30">30</option>	
					<option value="40">40</option>	
					<option value="50" selected>50</option>	
				</select>
			</td>
		</tr>
		<% if("kf".equals(ifKe)&&"0".equals(c22)){%>
			     	<tr>
								<td class="blue">宽带终端</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        			<!-- <option value="CPE">CPE</option> -->
			        		<select>
			        		<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">费用收取方式</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">押金</option>
			        			<option value="2">自备</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue">宽带终端费用</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" v_minvalue="50" v_maxvalue="200" class='forMoney required'/>
			        		<font class="orange">*</font><span id="yjfwxianshi">押金范围50-200元</span>       
			        	</td> 
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N码</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			     	</tr>
		<%}else{%>
			<input type="hidden" id="kdZd" name="kdZd" value="999"/>
			<input type="hidden" id="fysqfs" name="fysqfs" value="999"/>
			<input type="hidden" id="kdZdFee" name="kdZdFee" value="999"/>
		<%} %>
	</table>
	<%@ include file="/npage/common/qcommon/bd_0007.jsp" %>	<!--sys_note op_note-->
		<input type="hidden"  id="opCode" name="opCode"  value="<%=opCode%>" />
		<input type="hidden"  id="phoneNo" name="phoneNo"  value="<%=phoneNo%>" />
		<input type="hidden"  id="sysAccept" name="sysAccept"  value="<%=sysAccept%>" />
		<input type="hidden"  id="custNameText" name="custNameText"  value="" />
		<input type="hidden"  id="pageHref" name="pageHref"  value="" />
		
	<!-- 隐藏表单 begin -->
		<!-- 资源预占状态位 0未预占、1已预占 -->
		<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" />
		<!-- 是否已经选择小区资源状态位 0未选择、1已选择-->
		<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" />
		<!-- 宽带登陆账号状态位 不懂 -->
		<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" />
		<!-- 宽带登陆账号 -->
		<input type="hidden" name="cfmLogin"  id="cfmLogin"  value="<%=broadPhone%>" />
		<!-- 不懂 -->
		<input type="hidden"  id="noPort" name="noPort"  value="0" >
		<!-- 组织机构 -->
		<input type="hidden"  id="orgCode" name="orgCode"  value="<%=orgCode%>" >
		
		
			<!-- 老资源信息 begin-->
				<!--iIpAddrOldIP        IP地址旧-->
				<input type="hidden" name="ipAddressOld" id="ipAddressOld" value="" >
				<!--iPortCodeOld 		端口编码旧-->
				<input type="hidden" name="portCodeOld" id="portCodeOld" value="" >
				<!--iDeviceCodeOld 		设备编码旧-->
				<input type="hidden" name="deviceCodeOld" id="deviceCodeOld" value="" >
				<!--iDeviceInAddressOld	设备安装地址旧-->
				<input type="hidden" name="deviceInAddressOld" id="deviceInAddressOld" value="" >
				<!--iCctIdOld			电信局编码旧-->
				<input type="hidden" name="cctIdOld" id="cctIdOld" value="" >
				<!--partnerCode			原合作方编码-->
				<input type="hidden" name="oPartnerCode" id="oPartnerCode" value="" >
				<!--partnerCode			新合作方编码-->
				<input type="hidden" name="nPartnerCode" id="nPartnerCode" value="" >
				<!--iStandAddressOld	标准地址名称旧-->
				<input type="hidden" name="standAddressOld" id="standAddressOld" value="" >
			<!-- 老资源信息 end-->
		
			<!-- 新资源信息 begin-->
				<!--iCctIdNew 		电信局编码新-->
				<input type="hidden" name="cctId" id="cctId" value="" >
				<!--iIpAddrNewIP 	IP地址新-->
				<input type="hidden" name="ipAddress" id="ipAddress" value="" >
				<!--iPortCodeNew	端口编码新-->
				<input type="hidden" name="portCode" id="portCode" value="" >
				<!--iDeviceCodeNew	设备编码新-->
				<input type="hidden" name="deviceCode" id="deviceCode" value="" >
				<!--iDeviceInAddressNew	设备安装地址新-->
				<input type="hidden" name="deviceInAddress" id="deviceInAddress" value="" >
				<!--iAreaCodeNew		小区代码新-->
				<input type="hidden" name="areaCode" id="areaCode" value="" >
				<!--iAreaNameNew		小区名称新-->
				<input type="hidden" name="areaName" id="areaName" value="" >
				<input type="hidden" name="areaAddr" id="areaAddr" value="" >
				<!--iStandAddress		标准地址名称新-->
				<input type="hidden" name="standAddress" id="standAddress" value="" >
				<input type="hidden"  name="standardCode" id="standardCode" value="" >
				<!--detailAddrOld		用户地址名称新-->
				<input type="hidden" name="detailAddrOld12" id="detailAddrOld12" value="" >
				<!--deviceType		-->
				<input type="hidden" name="deviceType" id="deviceType" value="" >
				<!--portType		-->
				<input type="hidden" name="portType" id="portType" value="" >
			<!-- 新资源信息 end-->
			<input type="hidden" name="isfouyuzhan" id="isfouyuzhan" value="no" >
		 
		 	<!-- 2012-9-18 10:00:02 新增 begin-->
		 		<!--cctNameOld		电信局名称旧-->
				<input type="hidden" name="cctNameOld" id="cctNameOld" value="" >
				<!--appointTimeOld	预约时间旧  -->
				<input type="hidden" name="appointTimeOld" id="appointTimeOld" value="" >
				<!--accessTypeOld     接入类型旧  -->
				<input type="hidden" name="accessTypeOld" id="accessTypeOld" value="" >
				<!--propertyUnitOld     小区建设性质旧  -->
				<input type="hidden" name="propertyUnitOld" id="propertyUnitOld" value="" >
				
				<!--deviceNameOld     设备名称旧  -->
				<input type="hidden" name="deviceNameOld" id="deviceNameOld" value="" >
				<!--deviceName     deviceType 设备名称新  -->
		 	<!-- 2012-9-18 10:00:02 新增 end-->
		 	
		 	<!-- 2014/04/04 11:15:23 gaopeng 品牌sm_code -->
			<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
			<!-- 2014/07/09 9:00:26 gaopeng 承载类型 -->
			<input type="hidden" name="sbearType" id="sbearType" value="" />
			<!-- 2014/12/05 17:25:57 gaopeng 小区建设性质 -->
			<input type="hidden" name="propertyUnit" id="propertyUnit" value="" />
			<!---- 是否需要预占    0不需要     1需要 --->
      <input type="hidden"  id="isNeedHold" name="isNeedHold"  value="<%=isNeedHold%>" >
      
      <input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
      <input type="hidden" name="servBusiId" value="<%=servBusiId%>"/>
			<input type="hidden" name="enter_type" value=""/>
			
			<input type="hidden" name="belongCategory" value=""/><!-- 归属类别 -->
			<input type="hidden" name="bearType" value=""/> <!-- 承载方式 -->
			<input type="hidden" name="distKdCode" value=""/> <!-- 小区编码 -->
			<input type="hidden" name="nearInfo" value=""/> <!-- 小区接入情况 -->
			
			
		<!-- 隐藏表单 end -->
		
	<table cellSpacing=0>
		<tr id="footer">
			<td align="center"> 
				<INPUT class="b_foot_long" id="cfmBtn" onClick="doSubmit()" type="button" value="确定&打印" />
				<INPUT class="b_foot" onclick="doReset()" type="button" value="重置"> 
				<INPUT class="b_foot" onclick="removeCurrentTab()" type="button" value="关闭"> 
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
</DIV>
</BODY>
</HTML>
