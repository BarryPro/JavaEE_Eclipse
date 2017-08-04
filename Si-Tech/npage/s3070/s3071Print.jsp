   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "3074";
  String opName = "换卡";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>


<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : wangmei@si-tech.com.cn
* created : 2005-09-10
* revised : 2005-10-13
*/%>
<%
String workname = (String)session.getAttribute("workNo");
String workno = (String)session.getAttribute("workName");



String login_accept = request.getParameter("payAccept");
String dateStr = request.getParameter("total_date");
String opCode= request.getParameter("opCode");

String year = dateStr.substring(0,4);
String month = dateStr.substring(4,6);
String day = dateStr.substring(6,8);

String[] inParas = new String[3];
    inParas[0] = workno;
	inParas[1] = login_accept;
	inParas[2] = opCode;
System.out.println("-------------------------"+login_accept);
System.out.println("-------------------------"+dateStr);

	 int iErrorNo = 0;
    String sErrorMessage = "";
     int flag = 0; 
    
	CallRemoteResultValue callRemoteResultValue = null;
	
    try {
	    //callRemoteResultValue = viewBean.callService("0", null,"s3070Print","7",inParas);
%>

    <wtc:service name="s3070Print" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%
	iErrorNo = code;
 	sErrorMessage = msg;
    String result[][] = result_t;

	} catch(BOException e) {
	    System.out.println("调用EJB发生失败！");
	}


    System.out.println("2222222222222222222222222222222"+result[0][0]);
	System.out.println("2222222222222222222222222222222"+result[0][1]);
	System.out.println("2222222222222222222222222222222"+result[0][2]);
	System.out.println("2222222222222222222222222222222"+result[0][3]);
	System.out.println("2222222222222222222222222222222"+result[0][4]);
	System.out.println("2222222222222222222222222222222"+result[0][5]);
	
    
	String return_code = result[0][0];
 	String error_msg = result[0][1];
	if ( return_code.equals("000000")==false)
 	{
		flag=-1;
	}
    
%>
<SCRIPT language="JavaScript">
<!--
function printInvoice()
{
try{
<%
out.println("printctrl.Setup(0)");
out.println("printctrl.StartPrint()");
out.println("printctrl.PageStart()");

out.println("printctrl.Print(10,8,9,0,'"+workno+"')");
out.println("printctrl.Print(20,8,9,0,'"+login_accept+"')");
out.println("printctrl.Print(65,8,9,0,'"+year+"')");
out.println("printctrl.Print(73,8,9,0,'"+month+"')");
out.println("printctrl.Print(80,8,9,0,'"+day+"')");

out.println("printctrl.Print(25,12,9,0,'"+result[0][2]+"')");
out.println("printctrl.Print(25,17,9,0,'"+result[0][3]+"')"); 

out.println("printctrl.Print(65,17,9,0,'￥"+result[0][4]+"')");
out.println("printctrl.Print(25,20,9,0,'"+result[0][5]+"')"); 
out.println("printctrl.Print(45,20,9,0,'"+result[0][6]+"')"); 
out.println("printctrl.Print(30,22,9,0,'"+result[0][4]+"')"); 

out.println("printctrl.Print(10,31,9,0,'"+workname+"')"); 

out.println("printctrl.PageEnd()");
out.println("printctrl.StopPrint()");
%>
 }
  catch(e)
  {
  }
  finally
  {
  }
}
function ifprint(){
   <%  if ( flag == 0)
	{
    %>
	 printInvoice();
     rdShowMessageDialog('打印成功!',2);

	<% if(opCode.equals("3071")) {%>
		      document.location.replace("s3071.jsp");
				  return true;
	<%} else if(opCode.equals("3072")){%>
		      document.location.replace("s3072.jsp");
				  return true;
	<%} else {%>
			  document.location.replace("s3074.jsp");
				  return true;
   <% }}
	 else
	{%>
	  rdShowMessageDialog("打印失败！<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=error_msg%>'。" ,0);
	<% if(opCode.equals("3071")) {%>
		      document.location.replace("s3071.jsp");
				  return true;
	<%} else if(opCode.equals("3072")) {%>
		      document.location.replace("s3072.jsp");
				  return true;
	<%} else {%>
			  document.location.replace("s3074.jsp");
				  return true;

	<%}}%>
}
//-->
</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
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





