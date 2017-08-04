<%
	/********************
	 version v2.0
	开发商: si-tech
	update:zhaoht@2009-03-10 页面改造,修改样式
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>

<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%

String workname = (String)session.getAttribute("workName");
String org_code = (String)session.getAttribute("orgCode");
String regCode = (String)session.getAttribute("regCode");

String opcode    = "1330";//操作码

String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");

System.out.println("opCode===="+opCode);
System.out.println("opName===="+opName);

String print_work_no = request.getParameter("print_work_no");
String print_total_date = request.getParameter("print_billdate");
String print_login_accept = request.getParameter("print_login_accept");

String year = print_total_date.substring(0,4);
String month = print_total_date.substring(4,6);
String day = print_total_date.substring(6,8);


String [][] result = new String[][]{};
String [][] result2 = new String[][]{};
String iErrorNo ="";
String error_msg ="";
int   	  flag = 0;

String [] inParas = new String[4];
inParas[0]  = print_work_no;
inParas[1]  = print_total_date;
inParas[2]  = print_login_accept;
inParas[3]  = "0";
int [] lens ={5,1};
HashMap map = new HashMap();
map.put("0","000000,137111");
	
	try
	{	
		//value  = viewBean.callService("1", org_code.substring(0,2), "s1330Print","6",lens, inParas,map);
%>
		<wtc:service name="s1330Print" routerKey="region" routerValue="<%=regCode%>" outnum="6">			
		<wtc:param value="<%=print_work_no%>"/>	
		<wtc:param value="<%=print_total_date%>"/>	
		<wtc:param value="<%=print_login_accept%>"/>	
		<wtc:param value=""/>	
		</wtc:service>	
		<wtc:array id="result1Temp" start="0" length="5" scope="end"/>
		<wtc:array id="result2Temp" start="5" length="1" scope="end"/>
<%
		//s1310Impl viewBean = new s1310Impl();
		//arlist = viewBean.s1330Print(print_work_no,org_code,print_total_date,print_login_accept);
		//System.out.println("-------------------------"+arlist.size());
		
		result = result1Temp;
		result2 = result2Temp;
		iErrorNo = result[0][0];
	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	
	//ArrayList list  = value.getList();

	if(iErrorNo.equals("000000")==false)
	{
		//error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(iErrorNo));
		error_msg = result[0][1];	
		flag = -1;
		//System.out.println("######### flag= "+flag);
		//System.out.println("######### error_msg= "+error_msg);
		%>
	    <SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("打印失败!<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=error_msg%>'。",0);
			document.location.replace("s1330print.jsp?opCode=<%=opCode%>&opName=<%=opName%>");

		//-->
		</SCRIPT>
		<%
		return;
	}else{
		//System.out.println("$$$$$$$$$$$$$$");
		//System.out.println("^^^^^^^^^^^^^^^^^^^^");
	
%>
<SCRIPT language="JavaScript">
<!--
function printInvoice() {
	
<%
/*
out.println("printctrl.Setup(0)");
out.println("printctrl.StartPrint()");
out.println("printctrl.PageStart()");
out.println("printctrl.Print(10,8,9,0,'"+print_work_no+"')");
out.println("printctrl.Print(20,8,9,0,'"+print_login_accept+"')");
out.println("printctrl.Print(45,8,9,0,'"+result[0][2]+"')");

out.println("printctrl.Print(65,8,9,0,'"+year+"')");
out.println("printctrl.Print(73,8,9,0,'"+month+"')");
out.println("printctrl.Print(80,8,9,0,'"+day+"')");

out.println("printctrl.Print(25,17,9,0,'￥"+result[0][3]+"')");
out.println("printctrl.Print(60,17,9,0,'￥"+result[0][4]+"')"); 

int ylen = 19;
for ( int i = 0; i < result2.length; i++ ) {
	ylen = ylen + 1;
	out.println("printctrl.Print(20,"+ylen+",9,0,'"+result2[i][0]+"')");
}

out.println("printctrl.Print(10,31,9,0,'"+workname+"')"); 

out.println("printctrl.PageEnd()");
out.println("printctrl.StopPrint()");
*/
%>
}
function ifprint(){
     <% 
    if (flag != 0){%>
    rdShowMessageDialog("打印失败,请使用补打发票交易打印发票!<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=error_msg%>'。",0);
    document.location.replace("s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
    <%}else{
     %>
     //printInvoice();
	//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	var infoStr = "";
	infoStr += "<%=print_work_no%>|";
	infoStr += "<%=print_login_accept%>|";
	infoStr += "<%=result[0][2]%>|";
	infoStr += "<%=year%>|";
	infoStr += "<%=month%>|";
	infoStr += "<%=day%>|";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += "<%=result[0][3]%>|";
	infoStr += "<%=result[0][3]%>|";
<%
	int ylen = 19;
	for (int i = 0; i < result2.length; i++ ) {
		ylen = ylen + 1;
		%>
			infoStr += "<%=result2[i][0]%>|";
		<%
	}
%>
	infoStr += "<%=workname%>|";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	
	var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=打印成功!";
	var loginAccept = "<%=print_login_accept%>";
	var path = path + "&infoStr="+infoStr+"&loginAccept="+loginAccept+"&opCode=1330&submitCfm=confim";
	var ret=window.showModalDialog(path, "", prop);
	location="s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
     //rdShowMessageDialog('打印成功!',2);
     //document.location.replace("s1330.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
	<%}%>
}
-->
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">
<META http-equiv=Content-Type content="text/html; charset=gbk">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body></html>
<%}%>