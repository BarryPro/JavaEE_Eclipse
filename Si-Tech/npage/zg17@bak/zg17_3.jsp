<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	MoneyUtil mon = new MoneyUtil();
	String opName = "月结发票打印";
	String phoneno= request.getParameter("phoneno");
	String returnPage="zg17_1.jsp?activePhone="+phoneno;
	String return_code="";       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	String workno = (String)session.getAttribute("workNo");
	String check_seq= request.getParameter("check_seq");
	String bill_code= request.getParameter("bill_code");
	String login_accept= request.getParameter("login_accept");
	
	String print_begin= request.getParameter("print_begin");//账务年月
	String nopass = (String)session.getAttribute("password");
	String invoice_money= request.getParameter("invoice_money");//发票打印金额
	String s_time= request.getParameter("s_time");
	String cust_name = request.getParameter("cust_name"); 
	//cust_name="佳木斯东方希望金豆动物营养有限公司";
	String sm_name = request.getParameter("sm_name"); 
	String txfwf = request.getParameter("txfwf"); 
	String xszk = request.getParameter("xszk"); 
	String hj = request.getParameter("hj"); 
	String ykjje = request.getParameter("ykjje"); 
	String yckykjje = request.getParameter("yckykjje"); 
	String czkykjje = request.getParameter("czkykjje"); 
	String xtcz = request.getParameter("xtcz"); 
	String qt = request.getParameter("qt"); 
	String groupId = (String)session.getAttribute("groupId");
	String s_yyt_name="";
	//xl add 根据组织节点查询营业厅名称
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;

	//xl add hytcf
	String hytcf = request.getParameter("hytcf"); 
	String s_flag = request.getParameter("s_flag");
	//s_flag="N";
	//hytcf="10";
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}

	String paraAray[] = new String[16]; 
	paraAray[0] = login_accept;
	paraAray[1] = "01";
	paraAray[2] = "zg17";
	paraAray[3] = workno;
	paraAray[4] = nopass;
	paraAray[5] = phoneno;
	paraAray[6] = "";
	paraAray[7] = "月结账单打印";
	paraAray[8] = s_time;  
	paraAray[9] = print_begin;  
	paraAray[10] = invoice_money;  
	paraAray[11] = check_seq; 
	paraAray[12] = bill_code; 
    paraAray[13] = ""; 
	paraAray[14] = ""; 
	paraAray[15] = hytcf; 
	String year = s_time.substring(0, 4);
    String month = s_time.substring(4, 6);
    String day = s_time.substring(6, 8);
 
%>
<wtc:service name="bs_zg17Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode2" retmsg="sMsg2" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode2= sCode2;
	String retMsg2 = sMsg2;
	return_code=sCode2;
    if (return_code.equals("000000")) {
     
	 
			String result[][] = new String[][]{};
			 
			if(result==null||result.length==0){
		     
		        
	
		   
			  
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
    function printInvoice()
    {
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
		printctrl.DrawImage(localPath,8,10,40,18); 
        printctrl.Print(20, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=check_seq%>"); 
		/*******************************************/
 
		printctrl.Print(13, 13, 8, 0, "客户名称:<%=cust_name%>");
		printctrl.Print(13, 14, 8, 0, "业务类别:<%=opName%>");
		printctrl.Print(115, 14, 8, 0, "客户品牌:<%=sm_name%>");

		printctrl.Print(13, 15, 8, 0, "用户号码：<%=phoneno%>");	
		printctrl.Print(62, 15, 8, 0, "话费账期:<%=print_begin%>");
		printctrl.Print(115, 15, 8, 0, "合同号:");

		printctrl.Print(13, 16, 8, 0, "通信服务费:<%=txfwf%>");
		printctrl.Print(13, 17, 8, 0, "合约套餐费:<%=hytcf%>");
		printctrl.Print(13, 18, 8, 0, "销售折扣:<%=xszk%>");
		printctrl.Print(13, 19, 8, 0, "合计:<%=hj%>");
		
		printctrl.Print(13, 20, 8, 0, "已出具发票金额:<%=ykjje%>"); 
		printctrl.Print(15, 21, 8, 0, "其中:预存款已出具发票金额:<%=yckykjje%>"); 
		printctrl.Print(75, 21, 8, 0, "充值卡已出具发票金额:<%=czkykjje%>");
		printctrl.Print(15, 22, 8, 0, "扣减:系统充值已出具:<%=xtcz%>");
		printctrl.Print(75, 22, 8, 0, "其他:<%=qt%>");
		
		printctrl.Print(13, 23, 8, 0, "本次发票金额:<%=invoice_money%>");
		printctrl.Print(13, 24, 8, 0, "大写金额合计:<%=mon.NumToRMBStr(Double.parseDouble(invoice_money))%>");
		//备注
		printctrl.Print(13, 25, 8, 0, "注意：本次已开具的发票金额，我公司不再提供月结发票和增值税专用发票。");
 
 
		printctrl.Print(13, 29, 8, 0, "流水号：<%=login_accept%>");
		printctrl.Print(54, 29, 8, 0, "开票人：<%=loginName%>");
		printctrl.Print(85, 29, 8, 0, "工号：<%=workno%>");
		printctrl.Print(110, 29, 8, 0, "营业厅：<%=s_yyt_name%>");
	 
        printctrl.PageEnd();
        printctrl.StopPrint();
  
    }
	
	function print_jf()
	{
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
		printctrl.DrawImage(localPath,8,10,40,18);
        printctrl.Print(20, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码:<%=check_seq%>"); 
		printctrl.Print(13, 12, 9, 0, "客户名称:<%=cust_name%>");
		printctrl.Print(13, 13, 9, 0, "业务类别:<%=opName%>");
		printctrl.Print(125, 13, 9, 0, "客户品牌:<%=sm_name%>");

		printctrl.Print(13, 15, 9, 0, "用户号码：<%=phoneno%>");	
 
		printctrl.Print(82, 15, 9, 0, "话费账期:<%=print_begin%>");
		printctrl.Print(115, 15, 9, 0, "合同号:");

		printctrl.Print(115, 16, 9, 0, "支票号: ");
		printctrl.Print(115, 17, 9, 0, "集团统付号码:");//只有opcode=d340的
		printctrl.Print(16, 18, 9, 0, "通信服务费合计:");
		printctrl.Print(16, 19, 9, 0, "本次发票金额:(小写)￥<%=invoice_money%> 大写金额合计:<%=mon.NumToRMBStr(Double.parseDouble(invoice_money))%>");
		//备注
		printctrl.Print(13, 25, 8, 0, "注意：本次已开具的发票金额，我公司不再提供月结发票和增值税专用发票。");
		printctrl.Print(13, 29, 8, 0, "流水号：<%=login_accept%>");
		printctrl.Print(54, 29, 8, 0, "开票人：<%=loginName%>");
		printctrl.Print(85, 29, 8, 0, "工号：<%=workno%>");
		printctrl.Print(110, 29, 8, 0, "营业厅：<%=s_yyt_name%>");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
 
	}
    function ifprint()
    {
		//alert("test hytcf is "+"<%=hytcf%>");
		if("<%=s_flag%>"=="Y")
		{
			//alert("打印月结的");
			printInvoice();
		}
        else
		{
			//alert("打印缴费的");
			print_jf();
		}
        document.location.replace("<%=returnPage%>");
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>

<%
	 
	 		}else{
%>
					<script language="JavaScript">
					    rdShowMessageDialog("333发票打印失败,s1300Print服务返回结果为空.错误代码:"+"<%=return_code%>"+"<br>请使用补打发票交易打印发票!",0);
					    document.location.replace("<%=returnPage%>");
					</script>
<%
				}
		} else {//s1300Print服务调用失败
%>
		<script language="JavaScript">
		    rdShowMessageDialog("s1300Print发票打印错误,请使用补打发票交易打印发票!<br>错误代码：'<%=return_code%>'，错误信息：'111'",0);
		    document.location.replace("<%=returnPage%>");
		</script>
<%
    }
%>