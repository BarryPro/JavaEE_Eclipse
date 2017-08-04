<%
/********************
 *开发商: si-tech
 *create by wanghfa @ 20110725
 ********************/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>




<HTML>
<HEAD>


<%


	
	String billType = "2";	//发票
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	//String password = (String)session.getAttribute("password");
	String printMethod = request.getParameter("printMethod") == null ? "1" : request.getParameter("printMethod");
	
	String dlgMsg = request.getParameter("dlgMsg") == null ? "" : request.getParameter("dlgMsg");
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	String infoStr = request.getParameter("infoStr");
	String opCode = request.getParameter("opCode");
	String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));

	String loginAccept = request.getParameter("loginAccept");


%>


</HEAD>
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>发票打印</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
			<div class="popup_ok" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message">是否打印？</div>
		  </div>

	    <div align="center">

					<input class="b_foot" name=fapiao onClick="doInDb()" type=button value="打印发票">
					<input class="b_foot" name=shouju onClick="doshouju()" type=button value="打印收据" >
					<input class="b_foot" name=querenfapiao onClick="cancelfapiao()" type=button value="确认发票" style="display:none">&nbsp;&nbsp;
					<input class="b_foot" name=quxiaodayin onClick="cancelfapiao()" type=button value="取消打印">

	    </div>
	    <br>   
	 </div>
</FORM>
</BODY>
<!-------引入打印控件---------->
<OBJECT
	classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
	codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>
</HTML>   
<%@ include file="/npage/public/publicPrintBillNumNew.jsp" %> 
<SCRIPT type=text/javascript>

	var rowInit = Number('<%=rowInit%>');
	if(parm10049=="BX" || parm10049=="BY") {
			rowInit= rowInit+1;
	}


	if ("<%=submitCfm%>" == "submit") {
		//doInDb();
	}
	
function	doshouju() {
		 if(billtypemode=="model12") {//手机主账户充值12
			   normalPrint12();
		 }
		 	if(billtypemode=="model4") {//开户收据4
		 	 cancelfapiao();
       normalPrint4sj();
		 }
		 if(billtypemode=="model8") {//宽带收据8
		   cancelfapiao();
		   normalPrint8sj();
		 }
		 if(billtypemode=="model6") {//终端类收据6--目前只有4977宽带开户中的kf开户并且宽带终端选择“ONT”时，并且“费用收取方式“为押金有收据
		   if(parm10085=="zsj" ) {
		   	if(parm10036=="m404"){
		   		normalPrint_m404();
		   	}else if(parm10036=="m414"){
		   		normalPrint_m414();
		   	}else if(parm10036=="m432"){
		   		normalPrint_m432();
		   	}else if(parm10036=="m447"){
		   		normalPrint_m447();
		   	}else if(parm10036=="m358"){
					normalPrint_m358();
				}else {
		   		normalPrint6sj();
		  	}
		   }else if(parm10085=="MBH"){
		   	normalPrintMBHsj();
		   }
		   cancelfapiao();
		 }			 
			 
}

function cancelfapiao() {

				if(billtypemode=="model12") {//手机主账户充值12
				window.close();
			  return false;
			   
			 }else {
			  var inDbPacketss = new AJAXPacket("<%=request.getContextPath()%>/npage/public/publicPrintBillCancel.jsp","正在取消预占，请稍候......");
				inDbPacketss.data.add("liushui", yzaccept);
				inDbPacketss.data.add("fapiaohao", fapiaohao);
				inDbPacketss.data.add("fapiaodai", fapiaodai);
				inDbPacketss.data.add("workno", parm10001);
				inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
				inDbPacketss.data.add("groupId", "<%=groupId%>");
				inDbPacketss.data.add("hongziflag", parm10072);
				core.ajax.sendPacket(inDbPacketss, cancelreturnrl);
				inDbPacketss = null;	
		   }
}

	function cancelreturnrl(packet) {

		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if (retCode != "000000") { 
				rdShowMessageDialog("发票取消预占失败,错误代码："+retCode+"，错误信息："+retMsg,0);

			window.close();
			return false;
		}else {
			window.close();
			return false;
		} 
		
		}
	

	 function doInDb() {
	 
	 			if(confirm('发票号码是'+fapiaohao+'，是否打印？')==1){
	 			
	 	var inDbPacketss = new AJAXPacket("<%=request.getContextPath()%>/npage/public/publicPrintBillSaveInDB.jsp","正在取发票信息，请稍候......");
		inDbPacketss.data.add("liushui", yzaccept);
		inDbPacketss.data.add("fapiaohao", fapiaohao);
		inDbPacketss.data.add("fapiaodai", fapiaodai);
		inDbPacketss.data.add("workno", parm10001);
		inDbPacketss.data.add("regionCode", "<%=regionCode_bill%>");
		inDbPacketss.data.add("groupId", "<%=groupId%>");
		//购机款发票打印时候最后一位传参要传5
		inDbPacketss.data.add("hongziflag",parm10081);	
		
		core.ajax.sendPacket(inDbPacketss, doPrint);
		inDbPacketss = null;

				}else {
				
				window.close();
				}

	}
	
	
	
	function doPrint(packet) {

		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if ("<%=submitCfm%>" == "submit") {
			window.close();
			return;
		}
		
		if (retCode != "000000") { //测试需 ==
				rdShowMessageDialog("电子发票入库失败,错误代码："+retCode+"，错误信息："+retMsg,0);

			window.close();
			return false;
		} else {
			//alert(billtypemode);
			 if(billtypemode=="model4") {//开户模板4
				 	
	       normalPrint4();
			 }
			 if(billtypemode=="model1") {//预存款发票模板1
			   normalPrint1();
			 }
			 	if(billtypemode=="model6") {//营销案—终端（赠送实物）销售发票6
			 	if(parm10036=="m408"||parm10036=="m409"){
			 		normalPrint6_m408();
			 	}else{
			   	normalPrint6();
			 	}
			 }
			 	if(billtypemode=="model7") {//SIM卡发票7
			   
			   if(parm10036=="m401"){
				   normalPrint7_m401();
			 	}else{
			 		normalPrint7();
			 	}
			 	
			 }
			 
			 if(billtypemode=="model8") {//宽带发票8
			 	if(parm10036=="m449"){
					normalPrint8_m449();//有价卡发票
				}else{
			   normalPrint8();
			  }
			 }
			 	if(billtypemode=="model12") {//手机主账户充值12
			   normalPrint12();
			 }
			 	if(billtypemode=="model13") {//合约套餐费发票13
			   normalPrint13();
			 }
		}
	}

	
	function normalPrint8_m449() {
	
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
		 
		 
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
			
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票日期："+parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));

	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		
	 		
	 		printctrl.PrintEx(20, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"业务类别：");	
	 		printctrl.PrintEx(55, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"充值卡种类："+parm10044+"元充值卡");
	 		printctrl.PrintEx(115, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量："+parm10043);
	 		
	 		 
	 		printctrl.PrintEx(27, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"卡号：");
	 		
	 		
	 		var initLine   = 8;
	 		var tempCardNo = "";
	 		if(parm10012.indexOf("、")!=-1){
	 			var tempArr = parm10012.split("、");
	 			
	 			for (var i=0 ;i<tempArr.length;i++){
	 				
	 				if(i%4==0&&i!=0){
	 						printctrl.PrintEx(27, rowInit + initLine,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,tempCardNo);
	 						initLine ++ ;
	 						tempCardNo = "";
	 				}
	 				
	 				tempCardNo += tempArr[i]+"、";
	 			}
	 			
	 			if(tempCardNo!=""){
	 				printctrl.PrintEx(27, rowInit + initLine,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,tempCardNo);
	 			}
	 			
	 		}
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 			 		
	 			 		 
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);

			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	
	
	 


	
	function normalPrint_m414() {
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			 
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
	 				
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 	 
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI码："+""+parm10087);
	 		
	 		
	 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名规格");	
	 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单位");
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量");
	 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单价");
	 			 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			
			
			var shulianghe=0;
			var jiagehe=0;
			 
			for(var smsd=0;smsd<sm.length;smsd++) {
				printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
				printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
				printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
				printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
				
				shulianghe+=Number(sm2[smsd]);
				jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
 			printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
	 		
	 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint_m432() {
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			 
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
	 				
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 	 
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI码："+""+parm10087);
	 		
	 		
	 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名规格");	
	 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单位");
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量");
	 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单价");
	 			 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			
			
			var shulianghe=0;
			var jiagehe=0;
			 
			for(var smsd=0;smsd<sm.length;smsd++) {
				printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
				printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
				printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
				printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
				
				shulianghe+=Number(sm2[smsd]);
				jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
 			printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
	 		
	 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint_m447() {
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			 
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
	 				
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 	 
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI码："+""+parm10087);
	 		
	 		
	 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名规格");	
	 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单位");
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量");
	 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单价");
	 			 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			
			
			var shulianghe=0;
			var jiagehe=0;
			 
			for(var smsd=0;smsd<sm.length;smsd++) {
				printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
				printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
				printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
				printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
				
				shulianghe+=Number(sm2[smsd]);
				jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		
	 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
 			printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
	 		
	 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint_m358() {
	try {
	
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		 
		var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
		var vR = 0;
		var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
    printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
 		
 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
 				
 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
 		
 	 
 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"IMEI码："+""+parm10087);
 		
 		
 		printctrl.PrintEx(25, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名规格");	
 		printctrl.PrintEx(65, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单位");
 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量");
 		printctrl.PrintEx(105, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单价");
 			 		
		var sm= new Array();
		var sm1= new Array();
		var sm2= new Array();
		var sm3= new Array();
		var sm4= new Array();
		sm=parm10041.split(",");
		sm1=parm10042.split(",");
		sm2=parm10043.split(",");
		sm3=parm10044.split(",");
		
		
		var shulianghe=0;
		var jiagehe=0;
		 
		for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(25, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(65, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(105, rowInit + 16+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
		}
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
 		printctrl.PrintEx(97, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
 		
 		printctrl.PrintEx(23, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
 		printctrl.PrintEx(85, rowInit + 17+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
 		
		printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
 		
 		printctrl.PrintEx(23, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
 		printctrl.PrintEx(60, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
 		printctrl.PrintEx(85, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
 		printctrl.PrintEx(110, rowInit + 21+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	


		 
		//打印结束
		printctrl.PageEnd();
		printctrl.StopPrint();
	} catch(e) {
		rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
		//alert(e.printstacktrace());	//wanghfa 调试修改
		

	
	} finally {
		var cfmInfo = "<%=submitCfm%>";
		var retValue = "";
		if(cfmInfo == "Yes")
		{	retValue = "confirm";	}
		window.returnValue= retValue;
		window.close();
	}
}
		
		
		
	function normalPrint6_m408(){
	
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
		 
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);		 		
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
 
	 		printctrl.PrintEx(25, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名");	
	 		printctrl.PrintEx(45, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"型号");
	 		printctrl.PrintEx(65, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单位");
	 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"数量");
	 		printctrl.PrintEx(105, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"单价");
	 		printctrl.PrintEx(125, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"MAC");
	 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			var sm5= new Array();
			
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			sm4=parm10045.split(",");
			sm5=parm10061.split(",");
			
			var shulianghe=0;
			var jiagehe=0;
		 
				for(var smsd=0;smsd<sm.length;smsd++) {
					printctrl.PrintEx(25, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
					printctrl.PrintEx(45, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm5[smsd]);	
					printctrl.PrintEx(65, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
					printctrl.PrintEx(85, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
					printctrl.PrintEx(105, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);
					printctrl.PrintEx(125, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
					
					shulianghe+=Number(sm2[smsd]);
					jiagehe+=Number(sm3[smsd]);
				}
				
		 		printctrl.PrintEx(25, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
		 		printctrl.PrintEx(105, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
		 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
		 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
		 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
		 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
		 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
		 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}  
		
	
		
		function normalPrint_m404() {
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
						//getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司移动城市通开卡代收费收据");
      //printctrl.PrintEx(140,rowInit+3, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+5,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(23, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 			 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额："+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		if(parm10086.length>55){
	 			printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,55));//备注
	 			printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10086.substring(55,parm10086.length));//备注
	 		}else{
	 			printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086);//备注
	 		}
	 		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}	
		
		function normalPrint4sj() {
	 
	
		try {
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
      //printctrl.PrintEx(126,rowInit-2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司预存款收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);	
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);

	 		
	 		}else {
	 		
	 		printctrl.PrintEx(30, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10020")+""+parm10020);		
	 		printctrl.PrintEx(65, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10021")+""+parm10021);	
	 		printctrl.PrintEx(100, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10022")+""+parm10022);	
	 		printctrl.PrintEx(125, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10023")+""+parm10023);	
	 		
	 		printctrl.PrintEx(30, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10024")+""+parm10024);		
	 		printctrl.PrintEx(65, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10025")+""+parm10025);	
	 		printctrl.PrintEx(100, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10026")+""+parm10026);	
	 		printctrl.PrintEx(125, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10027")+""+parm10027);		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("收据打印错误，请确认控件是否安装!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint4() {
	 
	
		try {
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
      //printctrl.PrintEx(126,rowInit-2, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);	
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);

	 		
	 		}else {
	 		
	 		printctrl.PrintEx(30, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10020")+""+parm10020);		
	 		printctrl.PrintEx(65, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10021")+""+parm10021);	
	 		printctrl.PrintEx(100, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10022")+""+parm10022);	
	 		printctrl.PrintEx(125, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10023")+""+parm10023);	
	 		
	 		printctrl.PrintEx(30, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10024")+""+parm10024);		
	 		printctrl.PrintEx(65, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10025")+""+parm10025);	
	 		printctrl.PrintEx(100, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10026")+""+parm10026);	
	 		printctrl.PrintEx(125, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10027")+""+parm10027);		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint8sj() {
	 
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
     // printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司宽带开户收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);
	 		printctrl.PrintEx(66, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);	
	 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 			 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"项目：");	
	 	  printctrl.PrintEx(40, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10066")+""+parm10066);	
	 		printctrl.PrintEx(83, rowInit + 17,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10067")+""+parm10067);
			
			

	 		if(parm10049=="BX" || parm10049=="BY") {
	 		

	 		
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 25,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 25,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
	 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 24,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
				/* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh
			   */
		 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
		 			printctrl.PrintEx(23, rowInit + 26,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客服热线：10086");
		 		}
		 		
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
	 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 20,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
		 		/* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh
			   */
		 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
		 			printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客服热线：10086");
		 		}
	 		}


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("收据打印错误，请确认控件是否安装!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint8() {
	 
	
		try {
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
     // printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	
	 		printctrl.PrintEx(66, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 			 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"项目：");	
	 	  printctrl.PrintEx(40, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10066")+""+parm10066);	
	 		printctrl.PrintEx(83, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10067")+""+parm10067);
	 		
	 		

	 		if(parm10049=="BX" || parm10049=="BY") {
	 		

	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 19,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
		 		/* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh
			   */
		 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
		 			printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客服热线：10086");
		 		}
	 		
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
	 		printctrl.PrintEx(100, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10047);
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 15,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
		 		/* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh
			   */
		 		if(parm10078 == "kf" || parm10078 == "kg" || parm10078 == "kh" || parm10078 == "ki"){
		 			printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客服热线：10086");
		 		}
	 		}


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	
	function normalPrint12() {
	 
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
						//getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司手机支付主账户现金充值收据");
      //printctrl.PrintEx(140,rowInit+3, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+5,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(23, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 			 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额："+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrintMBHsj() {
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		
	 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
	 				
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 			printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10087")+""+parm10087);
		 		
	 		}
	 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			
			
			var shulianghe=0;
			var jiagehe=0;
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(24, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(53, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(75, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(97, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		//printctrl.PrintEx(65, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		printctrl.PrintEx(97, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}

	 		 		if(parm10049=="BX" || parm10049=="BY") {
	 		 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		/*2016/4/7 16:16:04 gaopeng 10028 10029 不打印*/
	 		
	 			printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086.substring(0,43));
	 			printctrl.PrintEx(23, rowInit + 19+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,""+""+parm10086.substring(43,parm10086.length));
	 		
	 		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}

		function normalPrint6sj() {
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
      printctrl.PrintEx(50,rowInit, fontType, fontSizeInit+3,vR, fontStrongInit,lineSpace, "中国移动通信集团黑龙江有限公司终端类收据");
	 		printctrl.PrintEx(40, rowInit+7,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		
	 		//printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(66, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10065")+""+parm10065);	 
	 		printctrl.PrintEx(132, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 12,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);
	 		printctrl.PrintEx(23, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10083")+""+parm10083);
	 		printctrl.PrintEx(66, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10084")+""+parm10084);	
	 				
	 		printctrl.PrintEx(132, rowInit + 13,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
	 		printctrl.PrintEx(53, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
	 		printctrl.PrintEx(75, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
	 		printctrl.PrintEx(97, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
	 		if(parm10078 != "kf" && parm10078 != "ki"){
	 			printctrl.PrintEx(123, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
	 		}
	 		}
	 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			if(parm10078 != "kf" && parm10078 != "ki"){
				sm4=parm10045.split(",");
			}
			
			var shulianghe=0;
			var jiagehe=0;
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(24, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(53, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(75, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(97, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			if(parm10078 != "kf" && parm10078 != "ki"){
				printctrl.PrintEx(120, rowInit + 15+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
			}
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		//printctrl.PrintEx(65, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		printctrl.PrintEx(97, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}

	 		 		if(parm10049=="BX" || parm10049=="BY") {
	 		 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 16,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 20,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 21,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 22,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 23,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 24,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 23,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次金额：(小写)￥"+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		if(parm10078 != "kf" && parm10078 != "ki"){
		 		printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
		 		printctrl.PrintEx(100, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		}else {
	 			printctrl.PrintEx(23, rowInit + 18+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10086")+""+parm10086);
	 		}
	 		printctrl.PrintEx(23, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 20+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}

	function normalPrint6() {
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);		 		
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
	 		printctrl.PrintEx(53, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
	 		printctrl.PrintEx(75, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
	 		printctrl.PrintEx(97, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
	 		if(parm10078 != "kf" && parm10078 != "ki"){
	 			printctrl.PrintEx(123, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
	 		}
	 		}
	 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10042.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			if(parm10078 != "kf" && parm10078 != "ki"){
				sm4=parm10045.split(",");
			}
			
			var shulianghe=0;
			var jiagehe=0;
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(75, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(97, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			if(parm10078 != "kf" && parm10078 != "ki"){
				printctrl.PrintEx(120, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
			}
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		//printctrl.PrintEx(65, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}

	 		 		if(parm10049=="BX" || parm10049=="BY") {
	 		 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		
	 		if(parm10078 != "kf" && parm10078 != "ki"){
		 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
		 		printctrl.PrintEx(100, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		}
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	
	function normalPrint7() {
		 

		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
	 		printctrl.PrintEx(58, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10061"));
	 		printctrl.PrintEx(75, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
	 		printctrl.PrintEx(97, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
	 		printctrl.PrintEx(123, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
	 		}
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10061.split(",");
			sm2=parm10042.split(",");
			sm3=parm10043.split(",");
			sm4=parm10044.split(",");
			var shulianghe=0;
			var jiagehe=0;
			
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(75, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(97, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			printctrl.PrintEx(123, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
			shulianghe+=Number(sm3[smsd]);
			jiagehe+=Number(sm4[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		printctrl.PrintEx(123, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 			 		 		
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 			 		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		if(parm10036 != "m401"){
		 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
		 		printctrl.PrintEx(60, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		}
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

      }

			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function normalPrint7_m401() {
		 

		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10041"));	
	 		printctrl.PrintEx(58, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10061"));
	 		printctrl.PrintEx(85, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10042"));
	 		printctrl.PrintEx(107, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
	 		printctrl.PrintEx(133, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10044"));
	 		}
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10061.split(",");
			sm2=parm10042.split(",");
			sm3=parm10043.split(",");
			sm4=parm10044.split(",");
			var shulianghe=0;
			var jiagehe=0;
			
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(24, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(53, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(85, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			printctrl.PrintEx(107, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			printctrl.PrintEx(133, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
			shulianghe+=Number(sm3[smsd]);
			jiagehe+=Number(sm4[smsd]);
			}
	 		printctrl.PrintEx(23, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10046")+""+parm10046);
	 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		printctrl.PrintEx(123, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 			 		 		
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 			 		 		
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		if(parm10036 != "m401"){
		 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10028")+""+parm10028);		 		
		 		printctrl.PrintEx(60, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10047")+""+parm10029);	
	 		}
	 		printctrl.PrintEx(23, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 15+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

      }

			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			

		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	
	function normalPrint13() {
	 
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaodai);
      //printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(116, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"本次发票号码："+fapiaohao);
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		//printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 		//printctrl.PrintEx(101, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10012")+""+parm10012);
	 		printctrl.PrintEx(23, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"合约套餐费");
	 		printctrl.PrintEx(53, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"品名");	
	 		printctrl.PrintEx(73, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"机型");
	 		printctrl.PrintEx(95, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10043"));
	 		printctrl.PrintEx(127, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10045"));
	 		}
	 		
			var sm= new Array();
			var sm1= new Array();
			var sm2= new Array();
			var sm3= new Array();
			var sm4= new Array();
			var sm4= new Array();
			sm=parm10041.split(",");
			sm1=parm10061.split(",");
			sm2=parm10043.split(",");
			sm3=parm10044.split(",");
			sm4=parm10045.split(",");
			var shulianghe=0;
			var jiagehe=0;
			if(parm10049=="BX" || parm10049=="BY") {
	 		}else {
			for(var smsd=0;smsd<sm.length;smsd++) {
			printctrl.PrintEx(23, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
			printctrl.PrintEx(54, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm[smsd]);		
			printctrl.PrintEx(73, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm1[smsd]);	
			printctrl.PrintEx(95, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm2[smsd]);	
			//printctrl.PrintEx(117, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm3[smsd]);	
			printctrl.PrintEx(124, rowInit + 10+smsd,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,sm4[smsd]);
			shulianghe+=Number(sm2[smsd]);
			jiagehe+=Number(sm3[smsd]);
			}
	 		
	 		//printctrl.PrintEx(65, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,shulianghe);
	 		//printctrl.PrintEx(97, rowInit + 10+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10015);
	 		}

	 		 		if(parm10049=="BX" || parm10049=="BY") {
	 		 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		printctrl.PrintEx(140, rowInit + 11,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);
	
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {
	 		
	 			 		
	 		
	 		printctrl.PrintEx(23, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016)); 		
	 		printctrl.PrintEx(140, rowInit + 11+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);
	 		
	 		printctrl.PrintEx(23, rowInit + 13+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	 		printctrl.PrintEx(23, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10038")+""+parm10038);		
	 		printctrl.PrintEx(60, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10039")+""+parm10039);	
	 		printctrl.PrintEx(97, rowInit + 14+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10040")+""+parm10040);
	 		
	 		printctrl.PrintEx(23, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 16+sm.length,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	
      }


			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
	
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	
	
	function normalPrint1() {
	 
	
		try {
		
		
		
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
					//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
						//printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			//var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
       //printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, getBillPart("10033")+fapiaodai);
      printctrl.PrintEx(140,rowInit+1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,fapiaohao);
	 		printctrl.PrintEx(40, rowInit+2,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,parm10002+""+getBillPart("10002")+""+parm10003+""+getBillPart("10003")+""+parm10004+""+getBillPart("10004"));
	 		printctrl.PrintEx(23, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10005")+""+parm10005);	
	 		printctrl.PrintEx(66, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10006")+""+parm10006);
	 		printctrl.PrintEx(132, rowInit + 5,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10007")+smnamess);
	 		printctrl.PrintEx(23, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10008")+""+parm10008);	
	 		printctrl.PrintEx(66, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10009")+""+parm10009);
	 		printctrl.PrintEx(101, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10010")+""+parm10010);
	 		printctrl.PrintEx(132, rowInit + 6,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10011")+""+parm10011);	
	 	
	 		printctrl.PrintEx(132, rowInit + 7,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10013")+""+parm10013);	
	 		printctrl.PrintEx(132, rowInit + 8,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10014")+""+parm10014);
	 		printctrl.PrintEx(23, rowInit + 9,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10048")+""+parm10048);
	 			
	 		printctrl.PrintEx(23, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10015")+""+parm10015);	
	 		printctrl.PrintEx(85, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10016")+""+digit_uppercase(parm10016));
	 		printctrl.PrintEx(140, rowInit + 10,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10037")+""+parm10037);
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10017")+""+parm10017+"  "+getBillPart("10018")+""+parm10018+"  "+getBillPart("10019")+""+parm10019); 	
	 		
	
	 		if(parm10049=="BX" || parm10049=="BY") {
	 		
	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10050")+""+parm10050);	
	 			
	 		printctrl.PrintEx(23, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10051")+""+parm10051);	
	 		printctrl.PrintEx(80, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10052")+""+parm10052);
	 		printctrl.PrintEx(117, rowInit + 16,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10053")+""+parm10053);		
	 		printctrl.PrintEx(23, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10054")+""+parm10054);	
	 		printctrl.PrintEx(70, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10055")+""+parm10055);
	 		printctrl.PrintEx(117, rowInit + 17,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10056")+""+parm10056);	
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10057")+""+parm10057);	
	 		printctrl.PrintEx(80, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10058")+""+parm10058);
	 		printctrl.PrintEx(117, rowInit + 18,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10059")+""+parm10059);	
	 		printctrl.PrintEx(23, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10060")+""+parm10060);	
	 		printctrl.PrintEx(90, rowInit + 19,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10064")+""+parm10064);		 		
	 		
	 		
	 		printctrl.PrintEx(23, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 18,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);
	 			 			 		
	 		}else {

	 		printctrl.PrintEx(23, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10038")+""+parm10038);		
	 		printctrl.PrintEx(50, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10039")+""+parm10039);	
	 		printctrl.PrintEx(77, rowInit + 15,  fontType, fontSizeInit-1,vR, fontStrongInit,lineSpace,getBillPart("10040")+""+parm10040);	
	 		
	 		printctrl.PrintEx(23, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10030")+""+parm10030);		
	 		printctrl.PrintEx(60, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10031")+""+parm10031);	
	 		printctrl.PrintEx(85, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10001")+""+parm10001);	
	 		printctrl.PrintEx(110, rowInit + 14,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,getBillPart("10032")+""+groupnames);	

      }

			 
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
			//alert(e.printstacktrace());	//wanghfa 调试修改
			
		var inDbPacketss = new AJAXPacket("publicBillPrintYZ.jsp","正在进行发票占用，请稍候......");
		inDbPacketss.data.add("bat_id", "<%=bill_loginacce%>");						
		inDbPacketss.data.add("bat_opr", "1");					
		inDbPacketss.data.add("bill_no", "<%=bill_number%>");								
					
		inDbPacketss.data.add("bill_daima", "<%=bill_daima%>");
		core.ajax.sendPacket(inDbPacketss, doReturnmsg);
		inDbPacketss = null;		
		
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function doReturnmsg(packet)
{

	//liujian 2013-4-16 15:01:39 添加发票logo begin
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	 if(retCode=="000000") {
	 }else {
	 rdShowMessageDialog("发票号码占用失败,失败原因："+retMsg,0);
   window.close();
	 }
}
	
</SCRIPT>