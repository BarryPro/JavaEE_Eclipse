<%
/*
功能: 公共工单打印程序(IDC集团专用)
版本: 1.8.2
日期: 2005/12/05
作者: libin
版权: sitech

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

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="java.util.*"%>

<%
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

	if (in_copynote.equals("1")) {
	   in_system_note = in_op_note;
	}

	String vOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String vYear = vOpTime.substring(0,4);
	String vMonth = vOpTime.substring(4,6);
	String vDay = vOpTime.substring(6,8);
	String vHms = vOpTime.substring(9,17);
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String[][] result2  = null;
	String sqlStr = "";
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
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
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<SCRIPT language="JavaScript">
function printInvoice() {
    printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
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
<OBJECT ID="printctrl" CLASSID="CLSID:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05" 
	<%if(!ProvinceRun.equals("20"))  //吉林
	  {
	%>
	codebase="/ocx/printatl.cab#version=1,0,0,4"
	<%
	}else
		{
	%>
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"

	codebase="/ocx/printatl.dll#version=1,0,0,1"

	id="printctrl"
	<%
	  }
	%>
	style="DISPLAY: none"
	VIEWASTEXT>
</OBJECT>
<font>正在打印工单，请稍等......</font>
</body>
</html>