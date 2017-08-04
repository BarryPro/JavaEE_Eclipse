 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<%
/*
功能: 公共工单打印程序(IDC集团专用)
入参:     
     GPARM32_0 ,   op_code       ,  操作代码
	 GPARM32_1 ,   phone_no      ,  集团编码
	 GPARM32_2 ,   function_name ,  申请业务
	 GPARM32_3 ,   work_no       ,  受理工号
	 GPARM32_4 ,   cust_name     ,  客户名称
	 GPARM32_5 ,   login_accept  ,  工单流水
	 GPARM32_6 ,   idIccid       ,  证件号码
	 GPARM32_7 ,   hand_fee      ,  收取费用
	 //////GPARM32_8 ,   sm_code       ,  SIM 卡号
	 GPARM32_8 ,   mode_name     ,  套餐名称
	 GPARM32_9,   custAddress   ,  客户地址
	 GPARM32_10,   system_note   ,  系统备注
	 GPARM32_11,   op_note       ,  用户备注
	 GPARM32_12,   space         ,  空，不知道用途
	 GPARM32_13,   copynote      ,  系统备注拷贝给用户备注
*/
%>

<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String regionCode = (String)session.getAttribute("regCode");
	String  in_op_code = request.getParameter("op_code");
	String  in_phone_no = request.getParameter("phone_no");
	String  in_function_name = request.getParameter("function_name");
	String  in_work_no = request.getParameter("work_no");
	String  in_cust_name = request.getParameter("cust_name");
	String  in_login_accept = request.getParameter("login_accept");
	String  in_idIccid = request.getParameter("idIccid");
	String  in_hand_fee = request.getParameter("hand_fee");
	//String  in_sm_code = request.getParameter("sm_code");
	String  in_mode_name = request.getParameter("mode_name");
	String  in_custAddress = request.getParameter("custAddress");
	String  in_system_note = request.getParameter("system_note");
	String  in_op_note = request.getParameter("op_note");
	String  in_space = request.getParameter("space");
	String  in_copynote = request.getParameter("copynote");
	String  in_work_name= request.getParameter("work_name");
	String  in_pay_type= request.getParameter("pay_type");

	if (in_copynote.equals("1")) {
	   in_system_note = in_op_note;
	}

	String vOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String vYear = vOpTime.substring(0,4);
	String vMonth = vOpTime.substring(4,6);
	String vDay = vOpTime.substring(6,8);
	String vHms = vOpTime.substring(9,17);
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//String[][] result2  = null;
	String sqlStr = "";
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
	<%
	String ProvinceRun = "";
	if (result2 != null && result2.length != 0) 
	{
		ProvinceRun = result2[0][0];
	}
%>

<html>
<head>
<title>工单打印</title>
</head>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
function printInvoice() {
    printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	/*旧的///注释不是绝对的,注释中的jsp变量不能用,想用就全删了
	printctrl.Print(10,9,10,0,"集团编码: <%=in_phone_no%>");
	printctrl.Print(40,9,10,0,"申请业务: <%=in_function_name%>");

	printctrl.Print(10,10,10,0,"受理工号: <%=in_work_no%>");
	printctrl.Print(40,10,10,0,"受理时间: <%=vOpTime%>");
	
	printctrl.Print(10,11,10,0,"客户名称: <%=in_cust_name%>");
    printctrl.Print(40,11,10,0,"工单流水: <%=in_login_accept%>");

	printctrl.Print(10,12,10,0,"证件号码: <%=in_idIccid%>");
    printctrl.Print(40,12,10,0,"收取费用: <%=in_hand_fee%> 元");

	printctrl.Print(10,13,10,0,"客户地址: <%=in_custAddress%>");
    printctrl.Print(40,13,10,0,"集团主产品: <%=in_mode_name%>");
    
	printctrl.Print(10,14,10,0,"系统备注: ");
    
	<%
	   StringTokenizer st = new StringTokenizer(in_system_note, "#");
	   int countNumber = 14;
	   while(st.hasMoreTokens()) {
	      ++countNumber;
	%>
         printctrl.Print(19,<%=countNumber-1%>,10,0,"<%=String.valueOf(st.nextElement())%>");
	
	<% } %>

    printctrl.Print(10,<%=countNumber%>,10,0,"操作备注: ");
	
	<%
	   st = new StringTokenizer(in_op_note, "#");
	   while(st.hasMoreTokens()) {
	      ++countNumber;
	%>
         printctrl.Print(19,<%=countNumber-1%>,10,0,"<%=String.valueOf(st.nextElement())%>");
	
	<% } %>*/

/*新的开始*/

var startCol=18;
	var startRow=20;
    //基本信息 	
    printctrl.Print(startCol+45,startRow-6,10,0,"<%=in_work_no%>");       //登陆名称
    printctrl.Print(startCol+3,startRow-6,10,0,"<%=vOpTime%>");        //日期
    printctrl.Print(startCol-2,startRow,10,0,"证件号码: <%=in_idIccid%>");  	      //客户姓名 
 	printctrl.Print(startCol-2,startRow+1,10,0,"集团客户名称: <%=in_cust_name%>");        //手机号码
    printctrl.Print(startCol-2,startRow+2,10,0,"集团用户编号: <%=in_phone_no%> ");        //联系地址
    printctrl.Print(startCol-2,startRow+3,10,0,"");        //证件号码
    printctrl.Print(startCol-2,startRow+4,10,0,"");        //证件地址
    printctrl.Print(startCol-2,startRow+5,10,0,"");        //联系电话
    printctrl.Print(startCol-2,startRow+7,10,0,"");        //新客户姓名
    printctrl.Print(startCol-2,startRow+8,10,0,"");       //新手机号码
    printctrl.Print(startCol-2,startRow+9,10,0,"");       //新证件号码  
    printctrl.Print(startCol-2,startRow+10,10,0,"");       //新证件地址  
    printctrl.Print(startCol-2,startRow+11,10,0,"");      //新联系地址  
    printctrl.Print(startCol-2,startRow+12,10,0,"");      //新联系电话  
    printctrl.Print(startCol-2,startRow+13,10,0,"");      //新付费方式
    printctrl.Print(startCol-2,startRow+14,10,0,"");      //
    printctrl.Print(startCol-2,startRow+15,10,0,"");      //
    printctrl.Print(startCol-2,startRow+16,10,0,"");      //
    printctrl.Print(startCol-2,startRow+17,10,0,"");      //
    printctrl.Print(startCol-2,startRow+18,10,0,"");      //
    //受理类
    printctrl.Print(startCol-2,startRow+28,10,0,"申请业务: <%=in_function_name%>");      //
    printctrl.Print(startCol-2,startRow+29,10,0,"操作流水: <%=in_login_accept%>");      //
    printctrl.Print(startCol-2,startRow+30,10,0,"");      //
    printctrl.Print(startCol-2,startRow+31,10,0,"");      //
    printctrl.Print(startCol-2,startRow+32,10,0,"");      //
    printctrl.Print(startCol-2,startRow+33,10,0,"");      //
    printctrl.Print(startCol-2,startRow+34,10,0,"");      //
    printctrl.Print(startCol-2,startRow+35,10,0,"");      //
	//备注类    
	printctrl.Print(startCol-2,startRow+41,10,0,"备注: <%=in_system_note%>");  
	



/*新的开始的结束*/





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

<font>正在打印工单，请稍等......</font>
</body>
</html>
