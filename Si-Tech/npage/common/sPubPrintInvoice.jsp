<%
/*
功能: 公共发票打印程序
版本: 1.8.2
日期: 2005/12/05
作者: xiezw
版权: sitech

入参:     
     GPARM32_0  , op_code         , 操作代码
	 GPARM32_1  , work_no         , 工号
	 GPARM32_2  , maxAccept       , 流水
	 GPARM32_3  , phoneNo         , 手机号码
	 GPARM32_4  , smName          , 品牌名称						
     GPARM32_5  , custName        , 客户姓名
	 GPARM32_6  , tmpMoney        , 交费合计
	 GPARM32_7  , innetFee        , 入网费
	 GPARM32_8  , simFee          , SIM卡费
	 GPARM32_9  , selectFee       , 选号费
     GPARM32_10 , insuranceFee    , 保险费
	 GPARM32_11 , checkMachineFee , 验机费
	 GPARM32_12 , handFee         , 手续费
	 GPARM32_13 , machineFee      , 机器费
	 GPARM32_14 , otherFee        , 其他费
	 GPARM32_15 , totalPrepay     , 预存款
     GPARM32_16 , cashPay         , 现金方式
	 GPARM32_17 , checkPay        , 支票方式
	 GPARM32_18 , systemNote      , 系统备注
	 GPARM32_19 , opNote          , 用户备注
*/
%>

<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.MoneyUtil"%>

<%
	String  in_op_code = request.getParameter("op_code");
	String  in_work_no = request.getParameter("work_no");	
	String  in_maxAccept = request.getParameter("maxAccept");
	String  in_phoneNo = request.getParameter("phoneNo");
	String  in_smName = request.getParameter("smName");
	String  in_custName = request.getParameter("custName");
	String  in_tmpMoney = request.getParameter("tmpMoney");
	String  in_innetFee = request.getParameter("innetFee");
	String  in_simFee = request.getParameter("simFee");
	String  in_selectFee = request.getParameter("selectFee");
	String  in_insuranceFee = request.getParameter("insuranceFee");
	String  in_checkMachineFee = request.getParameter("checkMachineFee");	
	String  in_handFee = request.getParameter("handFee");
	String  in_machineFee = request.getParameter("machineFee");
	String  in_otherFee = request.getParameter("otherFee");
	String  in_totalPrepay = request.getParameter("totalPrepay");
	String  in_cashPay = request.getParameter("cashPay");
	String  in_checkPay = request.getParameter("checkPay");
	String  in_systemNote = request.getParameter("systemNote");
	String  in_opNote = request.getParameter("opNote");

	String vOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String vYear = vOpTime.substring(0,4);
	String vMonth = vOpTime.substring(4,6);
	String vDay = vOpTime.substring(6,8);
	String vHms = vOpTime.substring(9,17);

	MoneyUtil mon = new MoneyUtil();
%>

<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<SCRIPT language="JavaScript">
function printInvoice() { 
    printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	/* 打印：工号 流水 日期 */
    printctrl.Print(13,4,10,0,"<%=in_work_no%>              <%=in_maxAccept%>      <%=vYear%>   <%=vMonth%>     <%=vDay%>  <%=vHms%>");

	/* 打印：手机号码、业务名称、客户名称 */
    printctrl.Print(13,6,10,0,"<%=in_phoneNo%>                    <%=in_smName%>                             <%=in_custName%>");
	
	/* 打印：大小写金额 */
	printctrl.Print(33,8,10,0,"   <%=mon.NumToRMBStr(Double.parseDouble(in_tmpMoney))%>                                      ￥<%=in_tmpMoney%>");
	
	/* 打印：发票题头 */
    printctrl.Print(23,11,10,0,"开户交款明细项目");
	
	/* 打印：明细费用项 */
	printctrl.Print(15,13,10,0,"入 网 费： <%=in_innetFee%>  SIM 卡费: <%=in_simFee%>");
    printctrl.Print(15,14,10,0,"保 险 费:  <%=in_insuranceFee%>  验 机 费: <%=in_checkMachineFee%>");
	printctrl.Print(15,15,10,0,"手 续 费: <%=in_handFee%>  其 他 费: <%=in_otherFee%>");
	printctrl.Print(15,16,10,0,"预 存 款: <%=in_totalPrepay%>");
	printctrl.Print(15,17,10,0,"现金方式: <%=in_cashPay%> 支票方式: <%=in_checkPay%>");
	
	/* 打印：备注 */
	printctrl.Print(15,22,10,0,"备    注:  <%=in_systemNote%>");
    
	/* 打印：发票公共信息 */
    <%
	   StringTokenizer st = new StringTokenizer(in_opNote, "#");
	   int countNumber = 22;
	   while(st.hasMoreTokens()) {
	      ++countNumber;
	%>
         printctrl.Print(15,<%=countNumber%>,10,0,"<%=String.valueOf(st.nextElement())%>");
	
	<% } %>
	
	printctrl.PageEnd() ;
	printctrl.StopPrint(); 
}

function ifprint() {
   printInvoice();
   window.close();
} 
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</body>
</html>