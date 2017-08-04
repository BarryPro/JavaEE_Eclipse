
<%
	/********************
	 version v2.0
	 开发商: si-tech
	 update:liutong@2008.09.04
	 ********************/
%>
<!-------------------------------------------->
<!---日期:  2003-10-23                    ---->
<!---作者:  sunzhe                        ---->
<!---代码:  fPubSimpSel.jsp               ---->
<!---功能： 打印确认界面                  ---->
<!---修改：                               ---->



<!--
Setup 显示打印设置对话框 1 显示 0 不显示
StartPrint 开始打印
PageStart 新的页
Print 
参数1 x坐标（0 - 100归一化坐标）
参数2 y坐标（0 - 100归一化坐标）
参数3 字号（0 - 100，0为系统缺省字号）
参数4 字粗细（0 - 10，0为系统缺省）
参数5 要打印的字符串

PageEnd 页结束
StopPrint 停止打印
<!-------------------------------------------->
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<HTML>
	<HEAD>
		<TITLE>发票打印</TITLE>
	</HEAD>

	<%
		int ran = 0;
		java.util.Random r = new java.util.Random();
		ran = r.nextInt(9999);
		int ran1 = r.nextInt(10) * 1000;
		if ((ran + "").length() < 4) {
			ran = ran + ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey：" + realKey);

		String bill_type = "2";

		String work_no = (String) session.getAttribute("workNo");
		String loginName = (String) session.getAttribute("workName");
		String org_code = (String) session.getAttribute("orgCode");
		String regionCode = org_code.substring(0, 2);
		String nopass = (String) session.getAttribute("password");
		String groupId = (String) session.getAttribute("groupId");//取营业厅用
		request.setCharacterEncoding("GBK");
		String retInfo = request.getParameter("retInfo");//发票打印参数

		String dirtPage = request.getParameter("dirtPage");
		String op_code = request.getParameter("op_code");
		String loginAccept = request.getParameter("loginAccept");
		String prNum = request.getParameter("prNum");
		if (prNum == null || prNum.equals("")) {
			prNum = "";
		}

		String infoStr = "";
		infoStr = retInfo;
		int tiaozhuan = 0;
		String strs = oneTok(infoStr, 12);
		String bill_number = request.getParameter("bill_number");
		String bill_code = request.getParameter("bill_code");
		String printLogoFlag = request.getParameter("printLogoFlag");

		//打印初始值
		int rowInit = 9;
		int fontSizeInit = 9;
		int fontStrongInit = 0;//0为不加粗
		String fontType = "宋体";
		String vR = "0";
	%>
	<%!/**将字符串按照tok分解取值**/
	public String oneTok(String str, int loc) {

		String temStr = "";
		temStr = str;
		if (str.charAt(0) == '|')
			temStr = str.substring(1, str.length());

		if (str.charAt((str.length()) - 1) == '|')
			temStr = temStr.substring(0, (temStr.length() - 1));

		int temLoc;
		int temLen;

		for (int ii = 0; ii < loc - 1; ii++) {
			temLen = temStr.length();
			temLoc = temStr.indexOf("|");
			temStr = temStr.substring(temLoc + 1, temLen);
		}
		if (temStr.indexOf("|") == -1)
			return temStr;
		else
			return temStr.substring(0, temStr.indexOf("|"));
	}

	/**将字符串按照tok分解后,取得子字符串总数**/
	public int getTokNums(String str) {
		String temStr = "";
		temStr = str;
		if (str.charAt(0) == '~')
			temStr = str.substring(1, str.length());
		if (str.charAt((str.length()) - 1) == '~')
			temStr = temStr.substring(0, (temStr.length() - 1));

		int temLen;
		int temNum = 1;
		int temLoc;
		while (temStr.indexOf("~") != -1) {
			temLen = temStr.length();
			temLoc = temStr.indexOf("~");
			temStr = temStr.substring(temLoc + 1, temLen);
			temNum++;
		}
		return temNum;
	}%>
	<%
		String print_workNo = "";
		String print_accept = "";
		String print_opName = "";
		String printMessage = oneTok(retInfo, 1);

		if (printMessage.length() > 0) {
			String resSplitMsg[] = printMessage.split("\\s{1,}");
			if (resSplitMsg.length == 3) {
				print_workNo = resSplitMsg[0];
				print_accept = resSplitMsg[1];
				print_opName = resSplitMsg[2];
			} else if (resSplitMsg.length == 2) {
				print_workNo = resSplitMsg[0];
				print_accept = resSplitMsg[1];
				print_opName = "";
			} else {
				print_workNo = resSplitMsg[0];
				print_accept = "";
				print_opName = "";
			}
		} else {
	%>
	<SCRIPT type=text/javascript>
      rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!",0);
      location="<%=dirtPage%>";
	</SCRIPT>
	<%
		}
	%>
	<%
		String sqlss = " select * from dcustmsg where phone_no ='"
				+ oneTok(infoStr, 7) + "'";
		String id_no = "";
	%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region"
		routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11">
		<wtc:sql><%=sqlss%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1111" scope="end" />
	<%
		if (retCode11.equals("000000")) {
			if (result1111.length > 0) {
				id_no = result1111[0][0];
			} else {
				id_no = oneTok(infoStr, 7);
			}
			//out.println(id_no);
		} else {
			//out.println("去id失败了啊啊");
		}
		//xl add 根据组织节点查询营业厅名称
		String[] inParam_yyt = new String[2];
		inParam_yyt[0] = "select group_name from dchngroupmsg where group_id=:s_group_id";
		inParam_yyt[1] = "s_group_id=" + groupId;
		String s_yyt_name = "";
	%>
	<wtc:service name="TlsPubSelCrm" outnum="1">
		<wtc:param value="<%=inParam_yyt[0]%>" />
		<wtc:param value="<%=inParam_yyt[1]%>" />
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
	<%
		if (yyt_name_arr != null && yyt_name_arr.length > 0) {
			s_yyt_name = yyt_name_arr[0][0];
		}
	%>
	<SCRIPT type=text/javascript>
var locat ="";
var ranss="";
	/**将字符串按照tok分解取值**/
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
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

	/**将字符串按照tok分解后,取得子字符串总数**/
	function getTokNums(str,tok){
	   var temStr=str;
	   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
	   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
	
	   var temLen;
	   var temNum=1;
	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length;
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}
function loc() {
locat="2";
}
function rans() {
ranss="2";
}



 function printInvoice(ss)
    {
    	var infoStr=ss;
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = 0;//字体粗细
		var vR = 0;
		var lineSpace = 0;
        //alert(3);
        /*20100528 liuxmc 添加发票防伪码*/
		<%/*
			 if(s_flag.equals("O"))
			 {%>
				<%}
			 if(s_flag.equals("N"))
			 {%>
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
 
				<%}*/%>
		//printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,'20130202');
    printctrl.Print(20, 10, 9, 0, "开票日期:"+oneTok(infoStr,"|",2)+"年"+oneTok(infoStr,"|",3)+"月"+oneTok(infoStr,"|",4)+"日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=bill_number%>"); 
        /*******************************************/
        //printctrl.Print(13, 12, 9, 0, "防伪码：<%=ran%>");

		
		printctrl.Print(13, 13, 9, 0, "客户名称:"+oneTok(infoStr,"|",5));
		printctrl.Print(72, 13, 9, 0, "业务类别:<%=print_opName%>");
		printctrl.Print(115, 13, 9, 0, "客户品牌:");

		printctrl.Print(13, 15, 9, 0, "用户号码："+oneTok(infoStr,"|",7));	
		printctrl.Print(48, 15, 9, 0, "协议号码：");
		printctrl.Print(82, 15, 9, 0, "话费账期:");
		printctrl.Print(115, 15, 9, 0, "合同号:");

		printctrl.Print(115, 16, 9, 0, "支票号:");
		printctrl.Print(115, 17, 9, 0, "集团统付号码:");//只有opcode=d340的
		printctrl.Print(16, 18, 9, 0, "通信服务费合计:");
		printctrl.Print(16, 19, 9, 0, "本次发票金额:(小写)￥"+oneTok(infoStr,"|",11)+" 大写金额合计:"+oneTok(infoStr,"|",10)+" 滞纳金:");
		
		
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13, 30, 9, 0, "流水号：<%=loginAccept%>");
		printctrl.Print(54, 30, 9, 0, "开票人："+oneTok(infoStr,"|",13));
		printctrl.Print(85, 30, 9, 0, "工号：<%=print_workNo%>");
		printctrl.Print(110, 30, 9, 0, "营业厅：<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
    }

    function doPrint(ss)
    {
      //alert(1);
        printInvoice(ss);
        document.location.replace("<%=dirtPage%>");
    }










	function replaceStr(str){
			str = str.replace(/\s+/g, " ");
			return str;
		}

 </SCRIPT>
	<!--**************************************************************************************-->
	<body onload="doPrint('<%=infoStr %>')">
		<OBJECT classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
			codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display: none;"
			id="printctrl" VIEWASTEXT>
		</OBJECT>

	</body>

</HTML>



<%
	
	//发票电子化添加入库服务
	//inParas0[0] = realKey+"";
		String[] inParas0 = new String[29];
		//inParas0[0] = realKey+"";
		inParas0[0] = loginAccept;//流水
		inParas0[1] = op_code;//
		inParas0[2] = print_workNo;
		inParas0[3] = "";//没有用
		inParas0[4] = oneTok(infoStr,7);
		inParas0[5] = id_no;//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = "0";//contract_no
		 
		inParas0[7] = "";//支票号码
		
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = bill_number;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] ="";//品牌
		inParas0[11] =  oneTok(infoStr,11);//小写金额
		inParas0[12] = oneTok(infoStr,10);//大写金额
		inParas0[13] = "" ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end


		inParas0[14] ="1";//发票打印
		inParas0[15] = "";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//增值税的
		inParas0[18] = "0";//打印年月
		inParas0[19] =oneTok(infoStr,5);//cust_name
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = regionCode;
		inParas0[25] = groupId; 
		inParas0[26] = "1";
		inParas0[27] ="0";//通用机打 
		 

		System.out.println("====执行 s1300PrintInDB 开始=======");
		String[][] result2 = new String[][]{};
		//打印的时候 按流水更新状态 预占的更新为已打印
%>
<wtc:service name="sinvoiceInDB" routerKey="region"
	routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=inParas0[0]%>" />
	<wtc:param value="<%=inParas0[1]%>" />
	<wtc:param value="<%=inParas0[2]%>" />
	<wtc:param value="<%=inParas0[3]%>" />
	<wtc:param value="<%=inParas0[4]%>" />
	<wtc:param value="<%=inParas0[5]%>" />
	<wtc:param value="<%=inParas0[6]%>" />
	<wtc:param value="<%=inParas0[7]%>" />
	<wtc:param value="<%=inParas0[8]%>" />
	<wtc:param value="<%=inParas0[9]%>" />
	<wtc:param value="<%=inParas0[10]%>" />
	<wtc:param value="<%=inParas0[11]%>" />
	<wtc:param value="<%=inParas0[12]%>" />
	<wtc:param value="<%=inParas0[13]%>" />
	<wtc:param value="<%=inParas0[14]%>" />
	<wtc:param value="<%=inParas0[15]%>" />
	<wtc:param value="<%=inParas0[16]%>" />
	<wtc:param value="<%=inParas0[17]%>" />
	<wtc:param value="<%=inParas0[18]%>" />
	<wtc:param value="<%=inParas0[19]%>" />
	<wtc:param value="<%=inParas0[20]%>" />
	<wtc:param value="<%=inParas0[21]%>" />
	<wtc:param value="<%=inParas0[22]%>" />
	<wtc:param value="<%=inParas0[23]%>" />
	<wtc:param value="<%=inParas0[24]%>" />
	<wtc:param value="<%=inParas0[25]%>" />
	<wtc:param value="<%=inParas0[26]%>" />
	<wtc:param value="<%=inParas0[27]%>" />
</wtc:service>
<wtc:array id="RetResult" scope="end" />
<%
		System.out.println("====执行 szg12InDB 结束=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,错误代码"+"<%=result2[0][0]%>"+",错误原因:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("<%=dirtPage%>");
					</script>
<%			
			}else{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库成功","",0);
					</script>
			<%			
			}
			
		}else if(RetResult == null || RetResult.length == 0){
%>
<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,szg12InDB_pt服务返回结果为空.",0);
					    document.location.replace("<%=dirtPage%>");
					</script>
<%			
		}
			
		//////////////////////////////////////////////
%>



