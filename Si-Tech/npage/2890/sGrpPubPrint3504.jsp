<%
/*
功能: 公共工单打印程序(IDC3505集团专用)
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
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.StringTokenizer"%>

<%
	
	String region_code=(String)session.getAttribute("regCode");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String regCode = (String)session.getAttribute("regCode");


	String smName="";
	String custName="";
	String smCode        = request.getParameter("sm_code");
	String cust_id        = request.getParameter("cust_id");
	String sqlStr="select sm_name from sSmCode where sm_code='"+smCode + "' and region_code='"+region_code+"'";
	String sqlStr1="select cust_name from dCustDoc where cust_id ='"+cust_id + "'";
	String[] inParams = new String[2];
	inParams[0] = "select cust_name from dCustDoc where cust_id =:cust_id";
	inParams[1] = "cust_id="+cust_id;
	//retList = callView.sPubSelect("1",sqlStr1); 
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	custName = result1[0][0];

	String name_list=request.getParameter("nameList_usr");
	String grp_list=request.getParameter("nameGroupList_usr");
	String fieldName_List=request.getParameter("fieldNamesList_usr");
	
	//取运行省份代码 -- 为吉林增加，山西可以使用session
	
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
	//result2 = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
<%
	String ProvinceRun = "";
	if (result2 != null && result2.length != 0) 
	{
		ProvinceRun = result2[0][0];
	}
	String mode_code = "";
	String add_mode = "";

	mode_code  = request.getParameter("product_code");
		
	StringTokenizer token=new StringTokenizer(name_list,"|");
	StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
	StringTokenizer token_fnl=new StringTokenizer(fieldName_List,"|");
	int length2=token.countTokens();

	String  in_op_code = "3504";
	String  in_phone_no = request.getParameter("grp_userno");
	String  in_function_name = "EC产品定购";
	String  in_work_no = workno;
	String  cust_code = request.getParameter("cust_code");
	String  in_cust_name = custName;
	String 	mainProduct =  request.getParameter("mainProduct");
	String  in_login_accept = request.getParameter("login_accept");
	String  in_idIccid = request.getParameter("iccid");
	String  in_hand_fee = request.getParameter("totalPay2");
	String  in_mode_name = mode_code;
	String  in_custAddress = request.getParameter("cust_address");
	String  in_system_note = request.getParameter("sysnote");
	//String  in_nameValueList = request.getParameter("nameValueList");
	String  in_op_note = request.getParameter("tonote");  
	String  in_space = "";
	String  in_copynote = "";

	if (in_copynote.equals("1")) {
	   in_system_note = in_op_note;
	}

	String vOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String vYear = vOpTime.substring(0,4);
	String vMonth = vOpTime.substring(4,6);
	String vDay = vOpTime.substring(6,8);
	String vHms = vOpTime.substring(9,17);


%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工单打印</title>
</head>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<SCRIPT language="JavaScript">
function printInvoice() {

	printctrl.Setup(0) ;
	printctrl.StartPrint();
	printctrl.PageStart();
	
	printctrl.Print(10,9,10,0,"集团编码: <%=in_phone_no%>");
	printctrl.Print(40,9,10,0,"申请业务: <%=in_function_name%>");
	
	printctrl.Print(10,10,10,0,"成员用户编码: <%=cust_code%>");
	printctrl.Print(40,10,10,0,"受理时间: <%=vOpTime%>");
	
	printctrl.Print(10,11,10,0,"受理工号: <%=in_work_no%>");
	printctrl.Print(40,11,10,0,"工单流水: <%=in_login_accept%>");
	
	
	printctrl.Print(10,12,10,0,"客户名称: <%=in_cust_name%>");
	printctrl.Print(40,12,10,0,"收取费用: <%=in_hand_fee%> 元");
	
	
	printctrl.Print(10,13,10,0,"证件号码: <%=in_idIccid%>");
	printctrl.Print(40,13,10,0,"集团主产品: <%=in_mode_name%>");
	
	printctrl.Print(10,14,10,0,"客户地址: <%=in_custAddress%>");
	printctrl.Print(40,14,10,0,"主套餐: <%=mainProduct%>");
	
	printctrl.Print(10,15,10,0,"系统备注: ");
    
	<%
	  
	   System.out.println(in_system_note);
	   
	   
	   StringTokenizer st = new StringTokenizer(in_system_note, "#");
	   int countNumber = 15;
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

   <%
  
   		String 	userType=request.getParameter("userType");
   		System.out.println("$$$$$$$$$$$$$$$$$$$userType="+userType);
   		String fieldCodes[] = new String [length2];
		String fieldValues[]= new String [length2];
		String fieldRowNo[]= new String [length2];
		String fieldName[] = new String[length2];
		ArrayList fieldValueAry = new ArrayList();
		Vector vec = new Vector();
		int i=0;	//总数组个数
		int k=0;	//组号个数，与域个数相同
		int p=0;	//每个组中的一个域的记录条数
		int q=0;
		//解析组名字符串
		while (token_fnl.hasMoreElements()){
			fieldName[q]=(String)token_fnl.nextElement();
			q++;
		}
		//解析组号字符串
		while (token_grp.hasMoreElements()){
			fieldRowNo[k]=(String)token_grp.nextElement();
			//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
			k++;
		}
		//解析名字和值字符串
		System.out.println("********66666************");	
		int countNumber2 = 19;
		while (token.hasMoreElements()){
		 ++countNumber2;
			fieldCodes[i]=(String)token.nextElement();
			//System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
			//System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
			%>
			printctrl.Print(10,<%=countNumber2%>,10,0,"<%=fieldName[i]%>");
			<%
			
			if(!vec.contains(fieldCodes[i]))
			{
			System.out.println("F"+userType+fieldCodes[i]);
			
				String[] tempValues = (String[])request.getParameterValues("F"+userType+fieldCodes[i]);
			
			
				if(!fieldRowNo[i].equals("0"))	//行号从1开始
				{
					
					for(p=0;p<tempValues.length;p++)
					{
						fieldValueAry.add(tempValues[p]);
						//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
						%>
						printctrl.Print(40,<%=countNumber2%>,10,0,"<%=tempValues[p]%>");
						<%
					}
				}
				else
				{
					fieldValueAry.add(request.getParameter("F"+userType+fieldCodes[i]));
				//	System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
					%>
					printctrl.Print(40,<%=countNumber2%>,10,0,"<%=tempValues[p]%>");
					<%
				}
				vec.add(fieldCodes[i]);
			}
			i++;
		}
	
		%>
         
	     	
	printctrl.PageEnd() ;
	printctrl.StopPrint(); 
}

function ifprint() {

   printInvoice();
   	
   	history.go(-1);
   //window.close();
} 
</SCRIPT>

<body onload="ifprint()">
<OBJECT ID="printctrl" CLASSID="CLSID:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05" 
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
	codebase="/ocx/printatl.dll#version=1,0,0,1"
	id="printctrl"
	style="DISPLAY: none"
	VIEWASTEXT>
</OBJECT>
<font>正在打印工单，请稍等......</font>
</body>
</html>