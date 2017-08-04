<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>


<%
	String contractno = request.getParameter("contractno");
	String workNo = request.getParameter("workno");
	String payAccept = request.getParameter("payAccept");
	String total_date = request.getParameter("total_date");
	String checkno = request.getParameter("checkNo");
	String op_code="1302";

	String org_code = (String)session.getAttribute("orgCode");

	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
 
	String[] inParas = new String[4];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = total_date;
	inParas[3] = payAccept;
    
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) ,  "s1300Print", "15" , inParas ) ;
%>
	<wtc:service name="s1300Print" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="15">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%   

	String return_code = retCode1;

 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));

if ( return_code.equals("000000") && result.length>0)
{
	
    String phoneNo =result[0][5].trim();
	if(phoneNo.equals("99999999999"))
         phoneNo="";


%>
<META http-equiv=Content-Type content="text/html; charset=gbk">

<SCRIPT language="JavaScript">

function printInvoice()
{
 
        printctrl.Setup(0) ;
		printctrl.StartPrint();
		printctrl.PageStart();
		printctrl.Print(13,5,9,0,"<%=workNo%>");
		printctrl.Print(65,5,9,0,"<%=year%>");
		printctrl.Print(74,5,9,0,"<%=month%>");
		printctrl.Print(80,5,9,0,"<%=day%>");
		
		printctrl.Print(18,7,10,0,"<%=result[0][4]%>");
 
		printctrl.Print(18,10,10,0,"<%=phoneNo%>");
		printctrl.Print(50,10,10,0,"<%=result[0][6]%>");
		printctrl.Print(66,10,10,0,"<%=result[0][7]%>");
		
		printctrl.Print(25,13,10,0,"<%=result[0][8]%>");
		printctrl.Print(66,13,10,0,"￥<%=result[0][9]%>");

        printctrl.Print(20,17,9,9,"<%=result[0][10]%>") ;
        printctrl.Print(20,19,9,9,"<%=result[0][11]%>") ;
        printctrl.Print(20,21,9,9,"<%=result[0][12]%>") ;
        printctrl.Print(20,23,9,9,"<%=result[0][13]%>") ;
        printctrl.Print(20,25,9,9,"<%=result[0][14]%>") ;
  
 		printctrl.PageEnd() ;
		printctrl.StopPrint() ; 
}

function ifprint()
{
  			printInvoice();
 			document.location.replace("s1354.jsp?opCode=1354&opName=陈账.死帐回收");
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
<%}
else
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
		document.location.replace("s1300.jsp");
	</script>
<%
	}
%>


