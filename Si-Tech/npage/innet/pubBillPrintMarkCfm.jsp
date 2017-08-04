<%
/********************
 *开发商: si-tech
 *create by wanghfa @ 20110725
 ********************/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ include file="/npage/public/publicPrintBillNum.jsp" %>


<HTML>
<HEAD>
<%!
	/**将字符串按照tok分解取值**/
	String oneTok(String strIn,char tok,int locIn)throws Exception {
		String  temStr=strIn;
		try{
			if(strIn.charAt(0)==tok) {
				temStr=strIn.substring(1,strIn.length());
			}
			if(strIn.charAt(strIn.length()-1)==tok) {
				temStr=temStr.substring(0,temStr.length()-1);
			}
			int temLoc;
			int temLen;
			for(int ii=0;ii<locIn-1;ii++){
				temLen=temStr.length();
				temLoc=temStr.indexOf(tok);
				temStr=temStr.substring(temLoc+1,temLen);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	
		if(temStr.indexOf(tok)==-1){
			return temStr;
		}else{
			return temStr.substring(0,temStr.indexOf(tok));
		}
	}
	
	public String oneTok(String str,int loc){
		String temStr="";
		temStr=str;
		if(str.charAt(0)=='|') temStr=str.substring(1,str.length());
		if(str.charAt((str.length())-1)=='|')  temStr=temStr.substring(0,(temStr.length()-1));
		int temLoc;
		int temLen;
		for(int ii=0;ii<loc-1;ii++)  {
			temLen=temStr.length();
			temLoc=temStr.indexOf("|");
			temStr=temStr.substring(temLoc+1,temLen);
		}
		if(temStr.indexOf("|")==-1) {
			return temStr;
		} else {
			return temStr.substring(0,temStr.indexOf("|"));
		}
	}
	
	/**将字符串按照tok分解后,取得子字符串总数**/
	public int getTokNums(String str){
		String temStr="";
		temStr=str;
		if(str.charAt(0)=='~') temStr=str.substring(1,str.length());
		if(str.charAt((str.length())-1)=='~') temStr=temStr.substring(0,(temStr.length()-1));
		
		int temLen;
		int temNum=1;
		int temLoc;
		while(temStr.indexOf("~")!=-1) {	
			temLen=temStr.length();
			temLoc=temStr.indexOf("~");
			temStr=temStr.substring(temLoc+1,temLen);
			temNum++;
		}
		return temNum;
	}
%>

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
	//Billing提供取随机数规则
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int key = 99999;
	int realKey = 0;
	if (request.getParameter("realKey") == null) {
		realKey = ran ^ key;
	} else {
		realKey = Integer.parseInt(request.getParameter("realKey"));
	}
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== 随机取realKey = " + realKey);
	
	String billType    = "2";	//发票
	String workNo      = (String)session.getAttribute("workNo");
	String workName    = (String)session.getAttribute("workName");
	String regionCode  = ((String)session.getAttribute("orgCode")).substring(0,2);
	String printMethod = request.getParameter("printMethod") == null ? "1" : request.getParameter("printMethod");
	String feeName     = request.getParameter("feeName") == null ? "合计金额" : request.getParameter("feeName");
	System.out.println("------------------feeName--------------------------"+feeName);
	String dlgMsg      = request.getParameter("dlgMsg") == null ? "" : request.getParameter("dlgMsg");
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	String infoStr = request.getParameter("infoStr");
	String opCode = request.getParameter("opCode");
	String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));

	String loginAccept = request.getParameter("loginAccept");
	String pBillDate = new String();
	if (request.getParameter("pBillDate") == null) {
		pBillDate = oneTok(infoStr,4)+""+oneTok(infoStr,5)+""+oneTok(infoStr,6);
	} else {
		pBillDate = request.getParameter("pBillDate");
	}
	String pBillPhone = new String();
	if (request.getParameter("pBillPhone") == null) {
		pBillPhone = oneTok(infoStr,9);
	} else {
		pBillPhone = request.getParameter("pBillPhone");
	}
	

	
	
	String sqlIdNo ="select * from dcustmsg where phone_no ='"+pBillPhone+"'";
	String idNo="";
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sqlIdNo = " + sqlIdNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeIdNo" retmsg="retMsgIdNo">
		<wtc:sql><%=sqlIdNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultIdNo" scope="end"/>
<%
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== dlgMsg = " + dlgMsg);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== infoStr = " + infoStr);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== opCode = " + opCode);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== submitCfm = " + submitCfm);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== loginAccept = " + loginAccept);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== pBillDate = " + pBillDate);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== workNo = " + workNo);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== idNo = " + idNo);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== pBillPhone = " + pBillPhone);
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sPubSelect retCodeIdNo = " + retCodeIdNo);
	if(retCodeIdNo.equals("000000") && resultIdNo.length > 0){
		idNo=resultIdNo[0][0];
  }else {
	}
%>
<SCRIPT type=text/javascript>
	
	if("<%=bill_number%>"==""){//发票号码为空禁止打印
			window.close();
	}
		
	if ("<%=submitCfm%>" == "submit") {
		//doInDb();
	}
	
	function chineseNumber(num) {
		if(parseFloat(num)<=0.01) return "零圆整";
		if (isNaN(num) || num > Math.pow(10, 12)) return "";
		var cn = "零壹贰叁肆伍陆柒捌玖";
		var unit = new Array("拾佰仟", "分角");
		var unit1= new Array("万亿", "");
		var numArray = num.toString().split(".");
		var start = new Array(numArray[0].length-1, 2);
		
		function toChinese(num, index) {
			var num = num.replace(/\d/g, function ($1){return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1)})
			return num;
		}
		
		for (var i=0; i<numArray.length; i++)
		{
		var tmp = "";
		for (var j=0; j*4<numArray[i].length; j++)
		{
		var strIndex = numArray[i].length-(j+1)*4;
		var str = numArray[i].substring(strIndex, strIndex+4);
		var start = i ? 2 : str.length-1;
		var tmp1 = toChinese(str, i);
		tmp1 = tmp1.replace(/(零.)+/g, "零").replace(/零+$/, "");
		tmp1 = tmp1.replace(/^壹拾/, "拾");
		tmp = (tmp1+unit1[i].charAt(j-1)) + tmp;
		}
		numArray[i] = tmp ;
		}
		
		numArray[1] = numArray[1] ? numArray[1] : "";
		numArray[0] = numArray[0] ? numArray[0]+"圆" : numArray[0], numArray[1] = numArray[1].replace(/^零+/, "");
		numArray[1] = numArray[1].match(/分/) ? numArray[1] : numArray[1]+"整";
		return numArray[0]+numArray[1];
	}
	/**将字符串按照tok分解取值**/
	function oneTok(str,tok,loc){
		var temStr=str;
		if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
		var temLoc;
		var temLen;
		for (ii=0;ii<loc-1;ii++) {
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
		}
		if (temStr.indexOf(tok)==-1) {
			return temStr;
		} else {
			return temStr.substring(0,temStr.indexOf(tok));
		}
	}
	
	/**将字符串按照tok分解后,取得子字符串总数**/
	function getTokNums(str,tok){
		var temStr=str;
		if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
		var temLen;
		var temNum=1;
		while(temStr.indexOf(tok)!=-1) {	
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
			temNum++;
		}
		return temNum;
	}
	
	function doInDb() {
		var inDbPacket = new AJAXPacket("pubBillPrint_ajaxInDb.jsp","正在进行发票入库，请稍候......");
		inDbPacket.data.add("inParams0", "<%=realKey%>");							//随机码
		inDbPacket.data.add("inParams1", "<%=loginAccept%>");					//业务流水
		inDbPacket.data.add("inParams2", "<%=opCode%>");								//opCode
		inDbPacket.data.add("inParams3", "<%=workNo%>");								//工号
		inDbPacket.data.add("inParams4", "<%=pBillDate%>");	//年月日
		inDbPacket.data.add("inParams5", "<%=pBillPhone%>");		//移动号码
		inDbPacket.data.add("inParams6", "<%=idNo%>");									//用户idNo
		inDbPacket.data.add("inParams7", "0");		//单发票添加
		<%
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
			for (int num=1; num<=13; num++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== oneTok(infoStr,"+num+") = " + oneTok(infoStr, num));
				if (num == 12) {
				%>
					inDbPacket.data.add("inParams<%=num+7%>", chineseNumber("<%=oneTok(infoStr, num)%>"));
				<%
				} else {
				%>
					inDbPacket.data.add("inParams<%=num+7%>", "<%=oneTok(infoStr, num)%>");
				<%
				}
			}
			String busiStr = oneTok(infoStr,14);
			int posLength = getTokNums(busiStr);
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== posLength = " + posLength);
			for (int i=1;i<=posLength;i++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== oneTok(busiStr,"+i+") = " + oneTok(busiStr,'~',i));
			%>
				inDbPacket.data.add("inParams<%=20+i%>", "<%=oneTok(busiStr,'~',i)%>");	//循环打印信息
			<%
			}
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j < " + (infoStr.split("\\|").length - 14));
			for (int j = 1;j <= (infoStr.split("\\|").length - 14); j ++) {
				System.out.println("====wanghfa====pubBillPrintCfm.jsp==== " + oneTok(infoStr,14+j));
			%>
				inDbPacket.data.add("inParams<%=posLength+20+j%>", "<%=oneTok(infoStr,14+j)%>");
			<%
			}
		%>
		inDbPacket.data.add("inParamsNo", "<%=infoStr.split("\\|").length + posLength + 7%>");
		core.ajax.sendPacket(inDbPacket, doPrint);
		inDbPacket = null;
	}
	
	function doPrint(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		if ("<%=submitCfm%>" == "submit") {
			window.close();
			return;
		}
		
		if (retCode != "000000") {
			if (retCode == "") {
				rdShowMessageDialog("电子发票入库失败,s1300PrintInDB服务返回结果为空.",0);
			} else {
				rdShowMessageDialog("电子发票入库失败,营业员没有录入发票号码或者录入的发票号码已经打印完毕.", 0);
			}
			window.close();
			return false;
		} else if ("<%=printMethod%>" == "1") {
			normalPrint();
		} else if ("<%=printMethod%>" == "2") { 
			printAsParams();
		}
	}
	
	function normalPrint() {
		
		var infoStr="<%=infoStr%>";
		try {
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			<%
				if(printLogoFlag.equals("N"))
				{
					%>
						printctrl.DrawImage(localPath,8,10,40,18);//左上右下
					<%
				}
			%>
			var rowInit = Number('<%=rowInit%>');
			var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
			var fontType = "宋体";//字体
			var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
			var vR = 0;
			var lineSpace = 0;
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	 		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",4)+oneTok(infoStr,"|",5)+oneTok(infoStr,"|",6));
	 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "邮电通信业");
			printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "本次发票号码：<%=bill_number%>");
	 		
			printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "防伪码：<%=ran%>");	//发票防伪码

			printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"工    号："+oneTok(infoStr,"|",1));//工号
			printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"操作流水："+oneTok(infoStr,"|",2));//流水
			printctrl.PrintEx(100,rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"业务名称："+oneTok(infoStr,"|",3));//业务名称

			
			printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客户名称："+oneTok(infoStr,"|",7));//用户名称
			printctrl.PrintEx(100, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"卡    号："+oneTok(infoStr,"|",8));//卡号
			
			printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"手机号码："+oneTok(infoStr,"|",9));//移动号码
			printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"协议号码："+oneTok(infoStr,"|",10));//协议号码
			printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"支票号码："+oneTok(infoStr,"|",11));//支票号码
			
			printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"<%=feeName%>：(大写)"+oneTok(infoStr,"|",12));//合计金额(大写)
			printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(小写)"+oneTok(infoStr,"|",13));//金额(小写)
			
			printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(项目)");//项目
			
			var imei_temp = oneTok(infoStr,"|",17);
			if( imei_temp != null && imei_temp != "") {
			//	printctrl.print(20,17,9,0,imei_temp);//IMEINo
				printctrl.PrintEx(20, rowInit + 8, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,imei_temp);
			}
			var busiStr=oneTok(infoStr,"|",14);
			var row = 0;
			for(var i=0;i<getTokNums(busiStr,"~");i++) {
				if (i % 2 == 0) {
					printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
				//	printctrl.Print(20,18+row,9,0,oneTok(busiStr,"~",i+1));  //业务项目
				} else if (i % 2 == 1) {
					printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
				//	printctrl.Print(50,18+row,9,0,oneTok(busiStr,"~",i+1));  //业务项目
					row ++;
				}
			}
			
			
			
//		printctrl.Print(10,32,9,9,oneTok(infoStr,"|",15)); //操作员
//		printctrl.Print(35,32,9,9,oneTok(infoStr,"|",16));//收款员 
//		printctrl.Print(66,12,10,0,oneTok(infoStr,"|",17));//imei孙振兴添加
//		printctrl.Print(35,31,9,9,oneTok(infoStr,"|",18));//是否参与赠送礼品活动 

			/********tianyang add at 20090928 for POS缴费需求****start*****/
			var payType = oneTok(infoStr,"|",19);
			if (payType=="BX"||payType=="BY") {
				printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "商户名称（中英文)："+oneTok(infoStr,"|",20));
				
				printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "交易卡号（屏蔽）： "+oneTok(infoStr,"|",21));
				printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "商户编码："+oneTok(infoStr,"|",22));
				printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "批次号："+oneTok(infoStr,"|",23));
				
				printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "发卡行号："+oneTok(infoStr,"|",24));
				printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "终端编码："+oneTok(infoStr,"|",25));
				printctrl.PrintEx(100, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "授权号："+oneTok(infoStr,"|",26));
				
				printctrl.PrintEx(13, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "回应日期时间："+oneTok(infoStr,"|",27));
				printctrl.PrintEx(62, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "参考号："+oneTok(infoStr,"|",28));
				printctrl.PrintEx(100, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "流水号："+oneTok(infoStr,"|",29));
				
				printctrl.PrintEx(13, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "收单行号："+oneTok(infoStr,"|",30));
				printctrl.PrintEx(62, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "签字：");
			}
			/********tianyang add at 20090928 for POS缴费需求****end*******/
			printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票：" +　oneTok(infoStr,"|",15)); //操作员
			printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"收款：" +  oneTok(infoStr,"|",16)); //收款员 
			printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"复核：");
			 
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
	
	function printAsParams() {
		var chPos = -1;
		var chPos1 = -1;
		var tempObj = new Array(5);
		var tempObj1 = new Array(5);
		
		var strLen,strLen1,fontSize,fontStyle;
		var infoStr="<%=infoStr%>";
		var printFlag=false;

		strLen = infoStr.length;
		if(strLen>0) printFlag=true;
		
		try {
			printctrl.Setup(0);
			printctrl.StartPrint();
			if(printFlag==true) printctrl.PageStart();
			while(strLen > 0) {
				for(var i=0;i<5;i++) {
				chPos = infoStr.indexOf("|");
				tempObj[i] = infoStr.substring(0,chPos);
				infoStr = infoStr.substring(chPos + 1);
				}
				printctrl.Print(1*tempObj[0],1*tempObj[1],1*tempObj[2],1*tempObj[3],tempObj[4]);
				strLen = infoStr.length;
			}
			if(printFlag==true) {
				printctrl.PageEnd();
			}
			printctrl.StopPrint();
		} catch(e) {
			rdShowMessageDialog("发票打印错误,请使用补打发票功能打印发票!", 0);
		} finally {
			window.close();
		}
	}
</SCRIPT>
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
		  	<div class="popup_zi orange" id="message"><%=dlgMsg%></div>
		  </div>

	    <div align="center">
			<%
				if(!submitCfm.equals("Single")) {
				%>
					<input class="b_foot" name=commit onClick="doInDb()" type=button value="打印">
					<input class="b_foot" name=back onClick="window.close()" type=button value="下一步">
				<%
				} else {
				%>
					<input class="b_foot" name=commit onClick="doInDb()" type=button value="确定">&nbsp;
				<%
				}
			%>
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
