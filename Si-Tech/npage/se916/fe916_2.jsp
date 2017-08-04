<%
/********************
 version v2.0
 开发商: si-tech
 author: liujian at 2011.12.21
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String pageHref = request.getParameter("pageHref");
	String custName = request.getParameter("custNameText");
	String sysAccept = request.getParameter("sysAccept");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
	String loginNo = (String)session.getAttribute("workNo");
	String loginNoPass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String cfmLogin = request.getParameter("cfmLogin");//宽带账号
	String orgCode = request.getParameter("orgCode");//宽带账号
	String payFee = request.getParameter("payFee");//宽带账号
	String ipAddressOld = request.getParameter("ipAddressOld");
	String ipAddress = request.getParameter("ipAddress");
	String constructRequest = request.getParameter("constructRequest");
	constructRequest = "移机装机|" + constructRequest;
	System.out.println("-----liujian----constructRequest=" + constructRequest);
	String bookDate = request.getParameter("bookDate");
	String sys_note = request.getParameter("sys_note");
	String portCodeOld = request.getParameter("portCodeOld");
	String portCode = request.getParameter("portCode");
	String deviceCodeOld = request.getParameter("deviceCodeOld");
	String deviceCode = request.getParameter("deviceCode");
	String deviceInAddressOld = request.getParameter("deviceInAddressOld");
	String deviceInAddress = request.getParameter("deviceInAddress");
	String cctIdOld = request.getParameter("cctIdOld");
	String cctId = request.getParameter("cctId");
	String standAddress = request.getParameter("standAddress");
	String standAddressOld = request.getParameter("standAddressOld");
	String areaCode = request.getParameter("areaCode");
	/*2013/3/4 星期一 15:14:32 gaopeng FTTH需求 直接更换取值参数 如下*/
	String areaName = request.getParameter("areaAddr");
	String contactCustName = request.getParameter("contactCustName");
	String contactPhone = request.getParameter("contactPhone");
//	String sys_note = request.getParameter("sys_note");//终端类型
	String enterType = request.getParameter("enterType");
	String detailAddrOld = request.getParameter("detailAddrOld12");
	System.out.println("---gaopeng1111111111---" + detailAddrOld );
	String enter_addr = request.getParameter("enter_addr");
  	String  retFlag="",retMsg="";
  	String  iPartCodeOld  = request.getParameter("oPartnerCode");        
  	String  iPartCodeNew = request.getParameter("nPartnerCode");
  	//liujian 2012-9-18 10:09:43 
  	String  cctNameOld  = request.getParameter("cctNameOld");        
  	String  appointTimeOld = request.getParameter("appointTimeOld");
  	String  accessTypeOld  = request.getParameter("accessTypeOld");  
  	String  cctName = request.getParameter("cctName");
  	String  deviceNameOld  = request.getParameter("deviceNameOld");
  	String  deviceType = request.getParameter("deviceType");
  	/*获取前台品牌smcode*/
  	String pubSmCode = request.getParameter("pubSmCode");
  	/*2014/07/08 14:55:15 gaopeng 获取前台承载类型*/
  	String sbearType = request.getParameter("sbearType");
  	/*2014/12/05 17:26:37 gaopeng 小区建设性质*/
  	String propertyUnit = request.getParameter("propertyUnit");
  	
  	String isDoNoResource=WtcUtil.repNull((String)request.getParameter("isNeedHold"));//是否预占资源标识
  	
  	String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));
  	
  	String standardCode = WtcUtil.repNull(request.getParameter("standardCode"));
  	
  	String belongCategory = WtcUtil.repNull(request.getParameter("belongCategory"));
  	String bearType = WtcUtil.repNull(request.getParameter("bearType"));
  	String distKdCode = WtcUtil.repNull(request.getParameter("distKdCode"));
  	String nearInfo = WtcUtil.repNull(request.getParameter("nearInfo"));
  	
  	String kdZd =request.getParameter("kdZd");
  	String fysqfs = request.getParameter("fysqfs");
  	String kdZdFee = request.getParameter("kdZdFee");
  	String snNumber = request.getParameter("snNumber");
  	
  	/*
  	2014/07/08 14:56:58 gaopeng R_CMI_HLJ_xueyz_2014_1644996@自有农村无线宽带（WBS）业务系统支撑需求
  	如果宽带品牌为“移动宽带(kf)”时，承载方式为“1/无线”，移机也只可以选择“1/无线”；承载方式为“0/有线”，移机也只可以选择“0/有线”；承载方式为“1/无线”时施工单中的接入类型传“3/无线”。
  	*/
  	/*
  	if("kf".equals(pubSmCode) && "1".equals(sbearType)){
  		enterType = "3";
  	}*/
		/* 
     * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
     * 新增省广电kg，备用品牌kh
     * 当宽带品牌为“省广电(kg)”时，派单时接入类型传“4”。
     */
     /*
  	if("kg".equals(pubSmCode) || "kh".equals(pubSmCode)){
  		enterType = "4";
  	}*/
  	
	String  inputParsm [] = new String[50];
	inputParsm[0] = sysAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = cfmLogin;
	inputParsm[8] = "";
	inputParsm[9] = "";
	inputParsm[10] = orgCode;//组织机构
	inputParsm[11] = payFee;//手续费
	inputParsm[12] = "";//实收
	inputParsm[13] = ipAddressOld;//IP地址旧
	inputParsm[14] = ipAddress;//IP地址新
	inputParsm[15] = constructRequest;//施工要求
	inputParsm[16] = bookDate;//预约时间
	inputParsm[17] = loginNo +"对"+phoneNo+"进行宽带移机";//系统备注
	inputParsm[18] = portCodeOld;//端口编码旧
	inputParsm[19] = portCode;//端口编码新
	inputParsm[20] = deviceCodeOld;//设备编码旧
	inputParsm[21] = deviceCode;//设备编码新
	inputParsm[22] = deviceInAddressOld;//设备安装地址旧
	inputParsm[23] = deviceInAddress;//设备安装地址新
	inputParsm[24] = cctIdOld;//电信局编码旧
	inputParsm[25] = cctId;//电信局编码新
	inputParsm[26] = standAddress;//标准地址名称新
	inputParsm[27] = standAddressOld;//标准地址名称旧
	inputParsm[28] = areaCode;//小区代码新
	inputParsm[29] = areaName;//小区名称
	inputParsm[30] = contactCustName;//联系人名称
	inputParsm[31] = contactPhone;//联系人电话
	inputParsm[32] = "";//终端类型
	inputParsm[33] = enterType;//接入方式
	inputParsm[34] = detailAddrOld;//用户安装详细地址旧
	inputParsm[35] = enter_addr;//用户安装详细地址新
	inputParsm[36] = iPartCodeOld;//用户安装详细地址新
	inputParsm[37] = iPartCodeNew;//用户安装详细地址新
	//liujian 2012-9-18 10:11:24
	inputParsm[38] = cctNameOld;//电信局名称旧
	inputParsm[39] = cctName;//电信局名称新
	inputParsm[40] = deviceNameOld;//设备名称旧
	inputParsm[41] = deviceType;//设备名称新
	inputParsm[42] = accessTypeOld;//接入方式旧
	inputParsm[43] = appointTimeOld;//预约时间旧
	inputParsm[44] = propertyUnit;//小区建设性质
	
	inputParsm[45] = belongCategory;
	inputParsm[46] = bearType;
	inputParsm[47] = distKdCode;
	inputParsm[48] = nearInfo;
	if("999".equals(kdZd)&&"999".equals(fysqfs)&&"999".equals(kdZdFee)){
		inputParsm[49]="";
	}
	else{
		inputParsm[49] = kdZd+"|"+fysqfs+"|"+kdZdFee+"|"+snNumber;
	}
	
	
	for(int i=0;i<inputParsm.length;i++) {
		System.out.println("---liujian---[" + i + "]=" + inputParsm[i] );
	}
%>
	
	<wtc:service name="se916Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="42">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
		<wtc:param value="<%=inputParsm[8]%>"/>
		<wtc:param value="<%=inputParsm[9]%>"/>
		<wtc:param value="<%=inputParsm[10]%>"/>
		<wtc:param value="<%=inputParsm[11]%>"/>
		<wtc:param value="<%=inputParsm[12]%>"/>
		<wtc:param value="<%=inputParsm[13]%>"/>
		<wtc:param value="<%=inputParsm[14]%>"/>
		<wtc:param value="<%=inputParsm[15]%>"/>
		<wtc:param value="<%=inputParsm[16]%>"/>
		<wtc:param value="<%=inputParsm[17]%>"/>
		<wtc:param value="<%=inputParsm[18]%>"/>
		<wtc:param value="<%=inputParsm[19]%>"/>
		<wtc:param value="<%=inputParsm[20]%>"/>
		<wtc:param value="<%=inputParsm[21]%>"/>
		<wtc:param value="<%=inputParsm[22]%>"/>
		<wtc:param value="<%=inputParsm[23]%>"/>
		<wtc:param value="<%=inputParsm[24]%>"/>
		<wtc:param value="<%=inputParsm[25]%>"/>
		<wtc:param value="<%=inputParsm[26]%>"/>
		<wtc:param value="<%=inputParsm[27]%>"/>
		<wtc:param value="<%=inputParsm[28]%>"/>
		<wtc:param value="<%=inputParsm[29]%>"/>
		<wtc:param value="<%=inputParsm[30]%>"/>
		<wtc:param value="<%=inputParsm[31]%>"/>
		<wtc:param value="<%=inputParsm[32]%>"/>
		<wtc:param value="<%=inputParsm[33]%>"/>
		<wtc:param value="<%=inputParsm[34]%>"/>
		<wtc:param value="<%=inputParsm[35]%>"/>
		<wtc:param value="<%=inputParsm[36]%>"/>
		<wtc:param value="<%=inputParsm[37]%>"/>
		<wtc:param value="<%=inputParsm[38]%>"/>
		<wtc:param value="<%=inputParsm[39]%>"/>
		<wtc:param value="<%=inputParsm[40]%>"/>
		<wtc:param value="<%=inputParsm[41]%>"/>
		<wtc:param value="<%=inputParsm[42]%>"/>
		<wtc:param value="<%=inputParsm[43]%>"/>
		<wtc:param value="<%=inputParsm[44]%>"/>
		<wtc:param value="<%=inputParsm[45]%>"/>
		<wtc:param value="<%=inputParsm[46]%>"/>
		<wtc:param value="<%=inputParsm[47]%>"/>
		<wtc:param value="<%=inputParsm[48]%>"/>
		<wtc:param value="<%=inputParsm[49]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
	
	
<%
 
	String errCode = retCodeQry;
	String errMsg = retMsgQry;
	if(errCode.equals("000000")){
%>
	<script language="JavaScript">
		rdShowMessageDialog("操作成功！");
		var printInfo = "";
		var prtLoginAccept = '<%=sysAccept%>';
		var custName = '<%=custName%>';
		var payFee = "<%=payFee%>";
		var broadNo = '<%=cfmLogin%>';
		var printStr = "移机手续费";
		var opName = "宽带移机";
		printInfo += '<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		printInfo += '<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		printInfo += '<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>' + '|';
		
		printInfo += prtLoginAccept + "|";
		printInfo += custName + "|";
		printInfo += " " + "|";
		printInfo += " " + "|";
		printInfo += broadNo + "|";
		printInfo += " " + "|";
		printInfo += payFee + "|";
		printInfo += payFee + "|";
		printInfo += opName + "|";
		printInfo += printStr + "：" + payFee + "元" + "~";
		/* 
     * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
     * 新增省广电kg，备用品牌kh
     */
		if("<%=pubSmCode%>" == "kf" || "<%=pubSmCode%>" == "kg" || "<%=pubSmCode%>" == "kh" || "<%=pubSmCode%>" == "ki"){
			printInfo += "客服热线：10086" + "|";
		}else{
			printInfo += "客服热线：10050" + "~";
			printInfo += "网址：http://www.10050.net" + "|";
		}
		
	//	if(Number(payFee)==0){
			//0元不打印发票
	//		return;
	//	}
		
		var  billArgsObj = new Object();
	    $(billArgsObj).attr("10001","<%=loginNo%>");       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //客户名称
 		$(billArgsObj).attr("10006",opName); //业务类别
 		$(billArgsObj).attr("10008","<%=phoneNo%>"); //用户号码
		$(billArgsObj).attr("10015", payFee); //本次发票金额(小写)￥
		$(billArgsObj).attr("10016", payFee); //大写金额合计
		
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 		$(billArgsObj).attr("10021",payFee); //手续费
 		$(billArgsObj).attr("10030",prtLoginAccept); //流水号--业务流水
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码
 		
 		 var path = "";
 		/* 
     * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
     * 新增省广电kg，备用品牌kh
     */
 		if("<%=pubSmCode%>" == "kf" || "<%=pubSmCode%>" == "kg" || "<%=pubSmCode%>" == "kh" || "<%=pubSmCode%>" == "ki"){
 			//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "发票打印";
 					//发票项目修改为新路径
			 path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "发票打印";
	
		}else{
			path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "发票打印";
		}
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var loginAccept = prtLoginAccept;
		var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm&phoneNo=<%=phoneNo%>";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		location.href='<%=pageHref%>';
	</script>	
<%
	} else{%>
	 <script language="JavaScript">
	 	function realeaseResource()
{	
				var myPacket = new AJAXPacket("/npage/se276/ajax_yzResource.jsp", "正在校验，请稍候......");
				  	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
						myPacket.data.add("customerCode","<%=cfmLogin%>");/*用户编号*/
						myPacket.data.add("productType","12");/*产品类型*/
						myPacket.data.add("opCode", "<%=opCode%>");
						myPacket.data.add("yzFlag", "2");
						/*2013/3/1 星期五 9:09:16 gaopeng FTTH需求，增加参数 addressCode 地址编码*/
						myPacket.data.add("addressCode", "<%=standardCode%>");
				   core.ajax.sendPacket(myPacket,doRealeaseResource);
		       myPacket = null;			 	
} 
function doRealeaseResource(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
     if(retCode=="000000"){
      		rdShowMessageDialog("资源释放成功");
     }
     else{ 
         	rdShowMessageDialog("资源释放失败"); 
     }
}

		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
		if("<%=isDoNoResource%>" =="1"){
    	realeaseResource();//释放已预占的资源
    }
    
		location.href='<%=pageHref%>';
	 </script>
<%
	}
%>

