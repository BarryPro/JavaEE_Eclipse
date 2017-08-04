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
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>
<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<%
    String work_no = (String) session.getAttribute("workNo");
    request.setCharacterEncoding("gb2312");
    String retInfo = request.getParameter("retInfo");
    String dirtPage = request.getParameter("dirtPage");
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
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== 随机取realKey = " + realKey);
	String accept = request.getParameter("accept");
	String opCode = request.getParameter("opCode");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String sqlIdNo ="select id_no from dcustmsg where phone_no ='"+phone+"'";
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
	inDbPacket.data.add("inParams7", "0");		//多发票添加
	<%
	System.out.println("==== " + retInfo);
		for (int j = 1;j <= (retInfo.split("\\|").length); j ++) {
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j = " + j);
		%>
			inDbPacket.data.add("inParams<%=7+j%>", oneTok(infoStr, "|", <%=j%>));
		<%
		}
	%>
	inDbPacket.data.add("inParamsNo", "<%=retInfo.split("\\|").length + 8%>");
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
	
	if (successNo != 1) {
		return false;
	} else {
    var infoStr = "<%=retInfo%>";
    try
    {
        //打印初始化
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();

		/*liujian 2013-3-7 9:00:35 打印发票logo和发票号码 begin*/
		<%
			if(printLogoFlag.equals("N"))
			{
				%>
				//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
				<%
			}
		%>
		var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
		var fontType = "<%=fontType%>";//字体
		var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
		var vR = 0;
		var lineSpace = 0;
		/*liujian 2013-3-7 9:00:35 打印发票logo和发票号码 end*/
		
        var startCol = 20;
        var startRow = 7;
		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,  oneTok(infoStr, "|", 2)+oneTok(infoStr, "|", 3)+oneTok(infoStr, "|", 4));
		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "邮电通信业");
		printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "本次发票号码：<%=bill_number%>");
		
		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,  "防伪码：<%=ran%>");	//发票防伪码
		
		printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,  "工    号：");
        printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "操作流水：<%=accept%>");      //流水
        printctrl.PrintEx(100,rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "业务名称：");
        
        printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "客户名称："+oneTok(infoStr, "|", 7));     //客户姓名 
        printctrl.PrintEx(100,rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "卡    号："); 
		
        printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "手机号码：");      //手机号码 
        printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "协议号码："+oneTok(infoStr, "|", 5));
	    printctrl.PrintEx(100,rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "支票号码：");
		
        printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "合计金额：(大写)");
	    printctrl.PrintEx(100,rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "(小写)￥");
		
		printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(项目)");//项目
		printctrl.PrintEx(30, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"销号用户预存款退款结算单据");

        var allPayStr = oneTok(infoStr, "|", 6);

        var ij = 0 ;
        var payPos = 0;
        var payPos1 = 0;
        var zz = 0;
        for (ij = 0; ij < allPayStr.length; ij ++) {
            if (allPayStr.charAt(ij) == "*") {
                if (zz == 0) {
                    payPos = ij;
                    zz = 1;

                }
                else {
                    payPos1 = ij;
                    zz = 0;
                }
            }
        }

        var benjin = allPayStr.substring(0, payPos);
        var lixi = allPayStr.substring(payPos + 1, payPos1);
        var zonghe = eval(benjin) + eval(lixi);

        var noBack = allPayStr.substring(payPos1 + 1, allPayStr.length);

        printctrl.PrintEx(20, rowInit + 9, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "应退金额大写:"+chineseNumber(zonghe));
        printctrl.PrintEx(20, rowInit + 10, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "应退金额小写(元):"+zonghe);
        printctrl.PrintEx(20, rowInit + 11, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "其中    本金(元):"+benjin);
        printctrl.PrintEx(20, rowInit + 12, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "利息(元):"+lixi);
        printctrl.PrintEx(20, rowInit + 13, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "不可退预存(卡类预存或赠送预存):"+noBack);
        
		//操作员、收款员
        printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票：<%=work_no%>"); //操作员
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"收款：");//收款员 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"复核：");
        printctrl.PageEnd();
        printctrl.StopPrint();
    }
    catch(e)
    {
        rdShowMessageDialog("打印机故障，无法打印发票！");
    }
    finally
    {
        location = "<%=dirtPage%>?activePhone=<%=phone%>";
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
</SCRIPT>
<FORM method=post name="spubPrint">
    <BODY onload="doPrint()">

    </BODY>
</FORM>
<OBJECT
		classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
		codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
        id="printctrl"
        style="DISPLAY: none"
        VIEWASTEXT
        >
</OBJECT>

</HTML>    
