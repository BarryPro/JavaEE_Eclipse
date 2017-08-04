<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-27 页面改造,修改样式
     *
     ********************/
%>
<!-------------------------------------------->
<!---日期: 2003-10-23 ---->
<!---作者: sunzhe ---->
<!---代码: fPubSimpSel.jsp ---->
<!---功能： 打印确认界面 ---->
<!---修改： ---->


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
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<%
    ArrayList arrSession = (ArrayList) session.getAttribute("allArr");
    String[][] busInfoSession = (String[][]) arrSession.get(2);
    String busiSpot = busInfoSession[0][5] + busInfoSession[0][6] + busInfoSession[0][7];//找不到替代的,暂时用这个.20080827
    String work_no = (String) session.getAttribute("workNo");
    request.setCharacterEncoding("gb2312");
    String retInfo = request.getParameter("retInfo");
    String dirtPage = request.getParameter("dirtPage");
    String backDate = request.getParameter("backDate");
    String phone = request.getParameter("activePhone");  //这个参数就是为了向f1213.jsp传递phone
    System.out.println("##########################################phone->" + phone);

	//Billing提供取随机数规则
	java.util.Random r = new java.util.Random();
	int key = 99999;
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int realKey = ran ^ key;
	
	int ran2 = r.nextInt(9999);
	int ran3 = r.nextInt(10)*1000;
	if ((ran2+"").length()<4) {
		ran3 = ran2+ran3;
	}
	int realKey2 = ran2 ^ key;
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== 随机取realKey = " + realKey);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== 随机取realKey2 = " + realKey2);
	String accept = request.getParameter("accept");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	
	String sqlIdNo ="select * from dcustmsg where phone_no ='"+phone+"'";
	String idNo="";
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sqlIdNo = " + sqlIdNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeIdNo" retmsg="retMsgIdNo">
		<wtc:sql><%=sqlIdNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultIdNo" scope="end"/>
<%
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sPubSelect retCodeIdNo = " + retCodeIdNo);
	if(retCodeIdNo.equals("000000") && resultIdNo.length > 0){
		idNo=resultIdNo[0][0];
  }else {
	}

%>
<SCRIPT type=text/javascript>

function doPrint()
{
  var infoStr = "<%=retInfo%>";
	var inDbPacket = new AJAXPacket("/npage/innet/pubBillPrint_ajaxInDb.jsp","正在进行发票入库，请稍候......");
	inDbPacket.data.add("inParams0", "<%=realKey%>");							//随机码
	inDbPacket.data.add("inParams1", "<%=accept%>");					//业务流水
	inDbPacket.data.add("inParams2", "<%=opCode%>");								//opCode
	inDbPacket.data.add("inParams3", "<%=work_no%>");								//工号
	inDbPacket.data.add("inParams4", oneTok(infoStr, "|", 2) + oneTok(infoStr, "|", 3) + oneTok(infoStr, "|", 4));	//年月日
	inDbPacket.data.add("inParams5", "<%=phone%>");		//移动号码
	inDbPacket.data.add("inParams6", "<%=idNo%>");									//用户idNo
	inDbPacket.data.add("inParams7", "1");		//多发票添加
	<%
		for (int j = 1;j <= (retInfo.split("\\|").length); j ++) {
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j = " + j);
		%>
			inDbPacket.data.add("inParams<%=7+j%>", oneTok(infoStr, "|", <%=j%>));
		<%
		}
	%>
	inDbPacket.data.add("inParamsNo", "<%=retInfo.split("\\|").length + 8%>");
	core.ajax.sendPacket(inDbPacket, printIt);
	inDbPacket.data.add("inParams0", "<%=realKey2%>");							//随机码
	core.ajax.sendPacket(inDbPacket, printIt);
	inDbPacket = null;
}
var successNo = 0;
function printIt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retCode != "000000" && retCode != "0") {
		alert("s1300PrintInDB发票入库失败："+retCode+"，"+retMsg+"，请联系管理员和开发人员。");
		window.close();
		return false;
	} else {
		successNo ++;
	}
	
	if (successNo != 2) {
		return false;
	} else {
    var infoStr = "<%=retInfo%>";
    try
    {
        //打印初始化
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
				
        /*liujian 2012-3-26 10:17:24 修改发票 begin */
        printctrl.Print(20,9,9, 0, oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
		 		printctrl.Print(50,9,9, 0, "邮电通信业");
	
				printctrl.Print(13,11,9,0, "防伪码：<%=ran%>");	//发票防伪码
				
				printctrl.Print(13,12,9,0,"工    号：");//工号
				printctrl.Print(33,12,9,0,"操作流水：");//流水
				printctrl.Print(53,12,9,0,"业务名称：");//业务名称
				
				printctrl.Print(13,13,9,0,"客户名称：" + oneTok(infoStr, "|", 7));//用户名称
				printctrl.Print(53,13,9,0,"卡    号：");//卡号
				
				printctrl.Print(13,14,9,0,"手机号码：" + oneTok(infoStr, "|", 5));//移动号码
				printctrl.Print(33,14,9,0,"协议号码：");//协议号码
				printctrl.Print(53,14,9,0,"支票号码：");//支票号码
				
				printctrl.Print(13,15,9,0,"合计金额：(大写)" + chineseNumber(oneTok(infoStr, "|", 10)));//合计金额(大写)
				printctrl.Print(55,15,9,0,"(小写)￥" + oneTok(infoStr, "|", 10));//金额(小写)
				
				printctrl.Print(13,17,9,0,"(项目)");//项目
				
				var busiStr = oneTok(infoStr, "|", 11);
				var row = 0;
				for(var i=0;i<getTokNums(busiStr,"~");i++) {
					if (i % 2 == 0) {
						printctrl.Print(20,17+row,9,0,oneTok(busiStr,"~",i+1));  //业务项目
					} else if (i % 2 == 1) {
						printctrl.Print(50,17+row,9,0,oneTok(busiStr,"~",i+1));  //业务项目
						row ++;
					}
				}
				printctrl.Print(20,24,9,0,oneTok(infoStr, "|", 8));  //联系地址
				printctrl.Print(20,25,9,0,"现金:");  //付款方式
				
				printctrl.Print(13,29,9,0,"开票：<%=work_no%>"); //操作员
				printctrl.Print(43,29,9,0,"收款：<%=work_no%>");//收款员 
				printctrl.Print(69,29,9,0,"复核：");
 				/*liujian 2012-3-26 10:17:24 修改发票 end */
 				
	//打印结束
        printctrl.PageEnd();
        printctrl.PageStart();
        
        /*liujian 2012-3-26 10:17:24 修改发票 begin */        
        printctrl.Print(20,9,9, 0, "<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>");
		printctrl.Print(50,9,9, 0, "邮电通信业");

		printctrl.Print(13,11,9,0, "防伪码：<%=ran%>");	//发票防伪码
		
		printctrl.Print(13,12,9,0,"工    号：<%=work_no%>");//工号
		printctrl.Print(33,12,9,0,"操作流水：");//流水
		printctrl.Print(53,12,9,0,"业务名称：");//业务名称
		
		printctrl.Print(13,13,9,0,"客户名称：" + oneTok(infoStr, "|", 7));//用户名称 0
		printctrl.Print(53,13,9,0,"卡    号：");//卡号
		
		printctrl.Print(13,14,9,0,"手机号码：" + oneTok(infoStr, "|", 5));//移动号码 0
		printctrl.Print(33,14,9,0,"协议号码：");//协议号码
		printctrl.Print(53,14,9,0,"支票号码：");//支票号码
		
		printctrl.Print(13,15,9,0,"合计金额：(大写)" + chineseNumber(oneTok(infoStr, "|", 10)));//合计金额(大写)
		printctrl.Print(55,15,9,0,"(小写)￥" + oneTok(infoStr, "|", 10));//金额(小写)
		
		printctrl.Print(13,17,9,0,"(项目)");//项目
		
		printctrl.Print(20, 17, 9, 0, "用户地址：" + oneTok(infoStr, "|", 8));
		printctrl.Print(20, 18, 9, 0, "证件号码：" + oneTok(infoStr, "|", 9));
		printctrl.Print(50, 18, 9, 0, "退款日期：<%=backDate%>");
		printctrl.Print(20, 19, 9, 0, "营业厅：<%=busiSpot%>");
		printctrl.Print(20, 20, 9, 0, "备注：" + oneTok(infoStr, "|", 1));
		printctrl.Print(20, 21, 9, 0, "客户提醒：结算话费时请机主本人持本回执单");
		printctrl.Print(20, 22, 9, 0, "及有效身份证件前来办理。");

		printctrl.Print(13,29,9,0,"开票：<%=work_no%>"); //操作员
		printctrl.Print(43,29,9,0,"收款：<%=work_no%>");//收款员 
		printctrl.Print(69,29,9,0,"复核：");
        /*liujian 2012-3-26 10:17:24 修改发票 end */
        
        printctrl.PageEnd();
        printctrl.StopPrint();
    }
    catch(e)
    {
        //rdShowMessageDialog("打印机故障，无法打印发票！");
    }
    finally
    {
        location = "<%=dirtPage%>?activePhone=<%=phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
  }
}

function oneTok(str, tok, loc)
{

    var temStr = str;
    if (str.charAt(0) == tok) temStr = str.substring(1, str.length);
    if (str.charAt(str.length - 1) == tok) temStr = temStr.substring(0, temStr.length - 1);

    var temLoc;
    var temLen;
    for (ii = 0; ii < loc - 1; ii++)
    {
        temLen = temStr.length;
        temLoc = temStr.indexOf(tok);
        temStr = temStr.substring(temLoc + 1, temLen);
    }
    if (temStr.indexOf(tok) == -1)
        return temStr;
    else
        return temStr.substring(0, temStr.indexOf(tok));
}


function chineseNumber(num)
{
    if (parseFloat(num) <= 0.01) return "零圆整"
    if (isNaN(num) || num > Math.pow(10, 12)) return ""
    var cn = "零壹贰叁肆伍陆柒捌玖"
    var unit = new Array("拾佰仟", "分角")
    var unit1 = new Array("万亿", "")
    var numArray = num.toString().split(".")
    var start = new Array(numArray[0].length - 1, 2)

    function toChinese(num, index)
    {
        var num = num.replace(/\d/g, function ($1)
        {
            return cn.charAt($1) + unit[index].charAt(start-- % 4 ? start % 4 : -1)
        })
        return num
    }

    for (var i = 0; i < numArray.length; i++)
    {
        var tmp = ""
        for (var j = 0; j * 4 < numArray[i].length; j++)
        {
            var strIndex = numArray[i].length - (j + 1) * 4
            var str = numArray[i].substring(strIndex, strIndex + 4)
            var start = i ? 2 : str.length - 1
            var tmp1 = toChinese(str, i)
            tmp1 = tmp1.replace(/(零.)+/g, "零").replace(/零+$/, "")
            tmp1 = tmp1.replace(/^壹拾/, "拾")
            tmp = (tmp1 + unit1[i].charAt(j - 1)) + tmp
        }
        numArray[i] = tmp
    }

    numArray[1] = numArray[1] ? numArray[1] : ""
    numArray[0] = numArray[0] ? numArray[0] + "圆" : numArray[0],numArray[1] = numArray[1].replace(/^零+/, "")
    numArray[1] = numArray[1].match(/分/) ? numArray[1] : numArray[1] + "整"
    return numArray[0] + numArray[1]
}


  function getTokNums(str,tok)
{
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
</SCRIPT>
<FORM method=post name="spubPrint">
    <BODY onload="doPrint()">

    </BODY>
</FORM>
<OBJECT
        classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
        codebase="/ocx/printatl.dll#version=1,0,0,1"
        id="printctrl"
        style="DISPLAY: none"
        VIEWASTEXT
        >
</OBJECT>

</HTML>    
