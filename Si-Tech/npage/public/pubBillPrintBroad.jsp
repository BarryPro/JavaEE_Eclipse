<%
/********************
 *开发商: si-tech
 *铁通发票
 *create by ningtn @ 20111026
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String org_code =(String)session.getAttribute("orgCode");
	    String regionCode = org_code.substring(0,2);
	    String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	    String infoStr = request.getParameter("infoStr");
	    String opCode = request.getParameter("opCode");
	    String submitCfm = WtcUtil.repNull(request.getParameter("submitCfm"));
	    String sql_select_bill = "";
	    String broad_no = oneTok(infoStr,8);
	    if(broad_no.indexOf("yd")==0){  //判断前两位是否为yd 如果为yd 从移动发票表取发票号码
	    	sql_select_bill = "select to_char(S_INVOICE_NUMBER) from WLOGININVOICE where LOGIN_NO = :workNo";
	    }else{
	  		sql_select_bill = "select to_char(S_INVOICE_NUMBER) from tt_WLOGININVOICE where LOGIN_NO = :workNo";
	  	}
	    System.out.println("sql_select_bill==="+sql_select_bill);
		//liujian 2012-8-17 13:51:18 增加发票编号
		//String sql_select_bill = "select to_char(S_INVOICE_NUMBER) from tt_WLOGININVOICE where LOGIN_NO = :workNo";
		String srv_params_bill = "workNo=" + work_no_bill;
		String bill_number = "";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_bill%>"  
			retcode="retBillNumCode" retmsg="retBillNumMsg" outnum="2">
		<wtc:param value="<%=sql_select_bill%>"/>
		<wtc:param value="<%=srv_params_bill%>"/>
	</wtc:service>
	<wtc:array id="billNumRst" scope="end" />
<%
	if(retBillNumCode.equals("000000")) {
		if(billNumRst.length>0){
		
			bill_number = billNumRst[0][0];
			System.out.println(" bill_number="+bill_number);
%>
		<script>
			var wlHref = window.location.href;
			$(function(){
				if(confirm('发票号码是<%=billNumRst[0][0]%>，是否打印收据？')==1){
					doPrint();
				}else {
					if(wlHref.indexOf('f9130_print.jsp')!=-1) {
						if(parent.g_activateTab == undefined){
							var l_activateTab = "";
							var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
							for(var i=0; i<lis.length; i++){
								if(lis[i].className == "current"){
									l_activateTab = lis[i].id;
									break;		        
								} 
							}
							parent.removeTab(l_activateTab);
					     }else{
							parent.removeTab(parent.g_activateTab); 
					     }
					}else {
						window.close();
					}
					
				}
			});
		</script>
<%
		}			
	else
		{
			System.out.println(" 获取[bill_number]失败");
		}
	}else {
%>
		<script>
			alert("获取发票号码失败！");
			if(parent.g_activateTab == undefined){
				var l_activateTab = "";
				var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
				for(var i=0; i<lis.length; i++){
					if(lis[i].className == "current"){
						l_activateTab = lis[i].id;
						break;		        
					} 
				}
				parent.removeTab(l_activateTab);
		     }else{
				parent.removeTab(parent.g_activateTab); 
		     }
		</script>
<%
	}
%>	
<html>
	<head>
<%
	
    System.out.println("---liujian---opCode="+ opCode);
	System.out.println("----------- pubBillPrintBroad.jsp --------- start -----");
	System.out.println("----------- liujian --------- phoneNo= -----" + phoneNo);
	int ran=0;
	java.util.Random r = new java.util.Random();
	ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if((ran+"").length()<4){
		ran = ran+ran1;
	}
	int key = 99999;
	int realKey = ran ^ key;
	
	String sqlss ="";
	if(opCode!=null && !opCode.equals("") && opCode.equals("e083") && opCode.equals("b544")) {
		sqlss = " select * from dcustmsghis where phone_no ='"+phoneNo+"'";
	} else {
	    sqlss = " select * from dcustmsg where phone_no ='"+phoneNo+"'";
	}
	String id_no="";
	if(phoneNo != null && phoneNo != "") {
	

	
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
				<wtc:sql><%=sqlss%></wtc:sql>
	  	</wtc:pubselect>
	  	<wtc:array id="result1111" scope="end"/>
	<%
			  if(retCode11.equals("000000")){
			  	if(result1111 != null && result1111.length > 0){
						id_no=result1111[0][0];
					}
			  }else {
			  	//out.println("去id失败了啊啊");
			  }
	}
	 String money = oneTok(infoStr,10);
	  double d = Double.parseDouble(money);
	  String moneyRMB = toRMB(d);
	//发票电子化添加入库服务
	String[] inParas0 = new String[40];
	inParas0[0] = realKey+"";  
	inParas0[1] = loginAccept; //流水
	inParas0[2] = opCode; //opCode
	inParas0[3] = workNo; // 操作员
	inParas0[4] = oneTok(infoStr,1)+""+oneTok(infoStr,2)+""+oneTok(infoStr,3); // 日期
	inParas0[5] = phoneNo;//phoneNo
	inParas0[6] = id_no;//id_no 
	inParas0[7] = "";//sm_name
	inParas0[8] = realKey+"";  
	inParas0[9] = loginAccept; //流水
	inParas0[10] = opCode; //opCode
	inParas0[11] = workNo; // 操作员
	inParas0[12] = oneTok(infoStr,1)+""+oneTok(infoStr,2)+""+oneTok(infoStr,3); // 日期
	inParas0[13] = oneTok(infoStr,12); //业务名称
	inParas0[14] = oneTok(infoStr,5); //客户名称 
	inParas0[15] = oneTok(infoStr,8); //宽带账号
	inParas0[16] = oneTok(infoStr,9); //支票号码 
	inParas0[17] = moneyRMB;//合计金额(大写)
	inParas0[18] = oneTok(infoStr,11);//小写 
	String busiStr=oneTok(infoStr,13);//项目
	int numCount = getTokNums(busiStr);
	for(int i=0;i<numCount;i++) {
	   inParas0[19+i] = oneTok(busiStr,'~',i+1);  //业务项目
	}
	String _temp = oneTok(infoStr,14);
	if( _temp != null && !_temp.equals("") && (oneTok(infoStr,13).equals("BX") || oneTok(infoStr,13).equals("BY"))) {
		inParas0[26] = oneTok(infoStr,15);
		inParas0[27] = oneTok(infoStr,16);
		inParas0[28] = oneTok(infoStr,17);
		inParas0[29] = oneTok(infoStr,18);
		inParas0[30] = oneTok(infoStr,19);
		inParas0[31] = oneTok(infoStr,20);
		inParas0[32] = oneTok(infoStr,21);
		inParas0[33] = oneTok(infoStr,22);
		inParas0[34] = oneTok(infoStr,23);
		inParas0[35] = oneTok(infoStr,24);
		inParas0[36] = oneTok(infoStr,25);
		inParas0[37] = oneTok(infoStr,26);
	}
%>

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
	
	public String toRMB(double money) {
		char[] s1 = { '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' };
		char[] s4 = { '分', '角', '元', '拾', '佰', '仟', '万', '拾', '佰', '仟', '亿',
				'拾', '佰', '仟', '万' };
		String str = String.valueOf(Math.round(money * 100 + 0.00001));
		String result = "";

		for (int i = 0; i < str.length(); i++) {
			int n = str.charAt(str.length() - 1 - i) - '0';
			result = s1[n] + "" + s4[i] + result;
		}
		result = result.replaceAll("零仟", "零");
		result = result.replaceAll("零佰", "零");
		result = result.replaceAll("零拾", "零");
		result = result.replaceAll("零亿", "亿");
		result = result.replaceAll("零万", "万");
		result = result.replaceAll("零元", "元");
		result = result.replaceAll("零角", "零");
		result = result.replaceAll("零分", "零");

		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零亿", "亿");
		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零万", "万");
		result = result.replaceAll("零零", "零");
		result = result.replaceAll("零元", "元");
		result = result.replaceAll("亿万", "亿");

		result = result.replaceAll("零$", "");
		result = result.replaceAll("元$", "元整");
		result = result.replaceAll("角$", "角整");

		return result;
	}
%>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
  
 
%>
<script type="text/javascript">
	
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
	
	function normalPrint() {
		/*
			目前铁通发票需要打印的内容
			1、年		2、月		3、日		4、操作流水号
			5、用户名称		6、电话部数（暂时为空）
			7、电话号码（固话号码，暂时为空）	8、户头号码（铁通宽带账号）	9、支票号码
			10、话费总额（大写）		11、￥（金额小写）
			12、业务名称
			13、项目（备注区）
		*/
		var infoStr="<%=infoStr%>";
		try{
			printctrl.Setup(0);
			printctrl.StartPrint();
			printctrl.PageStart();
			printctrl.Print(67,6,9, 1, "本次发票号码：<%=bill_number%>");
			//打印开始
			printctrl.Print(20,9,9,0,oneTok(infoStr,"|",1)+"年");
			printctrl.Print(25,9,9,0,oneTok(infoStr,"|",2)+"月");
			printctrl.Print(28,9,9,0,oneTok(infoStr,"|",3)+"日");
			printctrl.Print(50,9,9,0,"邮电通信业");
			printctrl.Print(13,11,9,0, "防伪码：<%=ran%>");
			printctrl.Print(13,12,9,0, "工    号：<%=workNo%>");
			printctrl.Print(33,12,9,0, "操作流水：" + oneTok(infoStr,"|",4));
			printctrl.Print(53,12,9,0, "业务名称：" + oneTok(infoStr,"|",12));
			printctrl.Print(13,13,9,0, "客户名称："+oneTok(infoStr,"|",5));
			printctrl.Print(13,14,9,0, "宽带账号："+oneTok(infoStr,"|",8));
			printctrl.Print(53,14,9,0, "支票号码："+oneTok(infoStr,"|",9));
			
			printctrl.Print(13,16,9,0, "合计金额：(大写)"+"<%=moneyRMB%>");
			printctrl.Print(53,16,9,0, "(小写)"+"￥"+oneTok(infoStr,"|",11)+"元整");
										
			printctrl.Print(13,18,9,0, "(项目)");
			var busiStr=oneTok(infoStr,"|",13);//项目，以~分隔
			var row = 0;
			for(var i=0;i<getTokNums(busiStr,"~");i++) {
				printctrl.Print(13,19+row,9,0,oneTok(busiStr,"~",i+1));  //业务项目
				row ++;
			}
			
			var payType =oneTok(infoStr,"|",14);
			if (payType=="BX"||payType=="BY") {
				printctrl.Print(13, 25, 9, 0, "商户名称（中英文)："+oneTok(infoStr,"|",20));
				printctrl.Print(13, 26, 9, 0, "交易卡号（屏蔽）： "+oneTok(infoStr,"|",21));
				printctrl.Print(43, 26, 9, 0, "商户编码："+oneTok(infoStr,"|",22));
				printctrl.Print(69, 26, 9, 0, "批次号："+oneTok(infoStr,"|",23));
				printctrl.Print(13, 27, 9, 0, "发卡行号："+oneTok(infoStr,"|",24));
				printctrl.Print(43, 27, 9, 0, "终端编码："+oneTok(infoStr,"|",25));
				printctrl.Print(69, 27, 9, 0, "授权号："+oneTok(infoStr,"|",26));
				printctrl.Print(13, 28, 9, 0, "回应日期时间："+oneTok(infoStr,"|",27));
				printctrl.Print(43, 28, 9, 0, "参考号："+oneTok(infoStr,"|",28));
				printctrl.Print(69, 28, 9, 0, "流水号："+oneTok(infoStr,"|",29));
				printctrl.Print(13, 29, 9, 0, "收单行号："+oneTok(infoStr,"|",30));
				printctrl.Print(60, 29, 9, 0, "签字：");
			}
			/********tianyang add at 20090928 for POS缴费需求****end*******/
			//打印结束
			printctrl.PageEnd();
			printctrl.StopPrint();
		}catch(e) {
			alert("发票打印错误,请使用补打发票功能打印发票!");
		} finally {
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
		}
	}
	
	function printCommit() {
		if ("<%=submitCfm%>" == "submitCfm") {
			normalPrint();
		}
	}
	function doPrint() {
		var infoStr = "<%=infoStr%>";
		var inDbPacket = new AJAXPacket("pubBillPrint_broad_ajaxInDb.jsp","正在进行发票入库，请稍候......");
		inDbPacket.data.add("inParams0", "<%=inParas0[0]%>");
		inDbPacket.data.add("inParams1", "<%=inParas0[1]%>");
		inDbPacket.data.add("inParams2", "<%=inParas0[2]%>");
		inDbPacket.data.add("inParams3", "<%=inParas0[3]%>");
		inDbPacket.data.add("inParams4", "<%=inParas0[4]%>");	
		inDbPacket.data.add("inParams5", "<%=inParas0[5]%>");
		inDbPacket.data.add("inParams6", "<%=inParas0[6]%>");
		inDbPacket.data.add("inParams7", "<%=inParas0[7]%>");
		inDbPacket.data.add("inParams8", "<%=inParas0[8]%>");
		inDbPacket.data.add("inParams9", "<%=inParas0[9]%>");
		inDbPacket.data.add("inParams10", "<%=inParas0[10]%>");
		inDbPacket.data.add("inParams11", "<%=inParas0[11]%>");	
		inDbPacket.data.add("inParams12", "<%=inParas0[12]%>");
		inDbPacket.data.add("inParams13", "<%=inParas0[13]%>");
		inDbPacket.data.add("inParams14", "<%=inParas0[14]%>");
		inDbPacket.data.add("inParams15", "<%=inParas0[15]%>");
		inDbPacket.data.add("inParams16", "<%=inParas0[16]%>");
		inDbPacket.data.add("inParams17", "<%=inParas0[17]%>");
		inDbPacket.data.add("inParams18", "<%=inParas0[18]%>");	
		inDbPacket.data.add("numCount", "<%=numCount%>");	
	<%
		for(int i=0;i<numCount;i++) {
	%>
		  inDbPacket.data.add("inParams<%=19+i%>", "<%=inParas0[19+i]%>");
	<%
		}
		if( _temp != null && !_temp.equals("") && (oneTok(infoStr,13).equals("BX") || oneTok(infoStr,13).equals("BY"))) {
	%>
			inDbPacket.data.add("bxy", "bxy");
			inDbPacket.data.add("inParams26", "<%=inParas0[26]%>");	
			inDbPacket.data.add("inParams27", "<%=inParas0[27]%>");	
			inDbPacket.data.add("inParams28", "<%=inParas0[28]%>");		
			inDbPacket.data.add("inParams29", "<%=inParas0[29]%>");	
			inDbPacket.data.add("inParams30", "<%=inParas0[30]%>");	
			inDbPacket.data.add("inParams31", "<%=inParas0[31]%>");	
			inDbPacket.data.add("inParams32", "<%=inParas0[32]%>");		
			inDbPacket.data.add("inParams33", "<%=inParas0[33]%>");	
			inDbPacket.data.add("inParams34", "<%=inParas0[34]%>");	
			inDbPacket.data.add("inParams35", "<%=inParas0[35]%>");	
			inDbPacket.data.add("inParams36", "<%=inParas0[36]%>");		
			inDbPacket.data.add("inParams37", "<%=inParas0[37]%>");	
	<%	
		}
	%>
		core.ajax.sendPacket(inDbPacket, printIt);
		inDbPacket = null;	
	}
	function  printIt(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if (retCode != "000000" && retCode != "0") {
			alert("e005PrintInDB发票入库失败："+retCode+"，"+retMsg+"，请联系管理员和开发人员。");
			var cfmInfo = "<%=submitCfm%>";
			var retValue = "";
			if(cfmInfo == "Yes")
			{	retValue = "confirm";	}
			window.returnValue= retValue;
			window.close();
			return false;
		} else {
			alert("电子发票入库成功.");
			printCommit();	
		}	
	}
</script>	
	</head>
	<body>
	</body>
<!-------引入打印控件---------->
<OBJECT
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
	codebase="/ocx/printatl.dll#version=1,0,0,1"
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT
>
</OBJECT>
</html>



