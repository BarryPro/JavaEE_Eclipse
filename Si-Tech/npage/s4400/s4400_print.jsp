
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "4400";
  String opName = "电子VIP积分受理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<!--%@ page errorPage="/page/common/errorpage.jsp" %-->
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%
//在此处读取session信息

%>

<%
    
String busi_type = request.getParameter("busi_type");// 
String work_no = request.getParameter("work_no");// 
String accept_no = request.getParameter("accept_no");//
String send_accept = request.getParameter("send_accept");// 
String cur_date = request.getParameter("date");// 
String phone = request.getParameter("phone");//
String cust_name = request.getParameter("cust_name");//
String pay_money = request.getParameter("pay_money");//
String chinaFee = "";
	//MyLog.debugLog("work_no="+work_no);
String firstCode=request.getParameter("tmpR1");
String secondCode=request.getParameter("tmpR2");
String secondName=request.getParameter("tmpR3");
String servContent=request.getParameter("tmpR4");
String servAmount=request.getParameter("tmpR5");
String servMark=request.getParameter("tmpR6");

String servLevel=request.getParameter("servLevel");    
String attendant= request.getParameter("attendant");  

String airportName=request.getParameter("airportName");
String airNo=request.getParameter("airNo"); 
String sumTimes=request.getParameter("sumTimes");



        
%>


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

<body onload="ifprint();">
<form action="" name="form" method="post">
</form>
</body>
</html>
<script language="javascript">
function ifprint()
{
 printInvoice();
 rdShowMessageDialog('打印成功!',2);

 window.returnValue=1;
 window.close();

}

function printInvoice()
{

    var startRow=5;
    var startCol=10;
    
  try
  { 
     //打印初始化  
             printctrl.Setup(0);
             printctrl.StartPrint();
             printctrl.PageStart();
             printctrl.Print(startCol+0,startRow+0,12,0,"业务类别：<%=busi_type%>");//业务类别
             printctrl.Print(startCol+35,startRow+0,12,0,"操作时间：<%=cur_date.substring(0,4)%>年");//年
             printctrl.Print(startCol+52,startRow+0,12,0,"<%=cur_date.substring(4,6)%>月");//月
             printctrl.Print(startCol+57,startRow+0,12,0,"<%=cur_date.substring(6,8)%>日");//日
             
             printctrl.Print(startCol+0,startRow+3,12,0,"业务流水：<%=accept_no%>"); //受理流水号
            // printctrl.Print(startCol+35,startRow+3,12,0,"发起方交易流水：<%=send_accept%>"); 
             
             printctrl.Print(startCol+0,startRow+5,12,0,"客户标识：<%=phone%>");//移动号码
             printctrl.Print(startCol+35,startRow+5,12,0,"客户名称：<%=cust_name%>");//客户名称
             
             printctrl.Print(startCol+0,startRow+7,12,0,"服务级别：<%=servLevel%>");        
             printctrl.Print(startCol+35,startRow+7,12,0,"是否随员：<%=attendant%>");  
             
            
             printctrl.Print(startCol+0,startRow+11,12,0,"扣除积分：<%=pay_money%>");  //（<%=chinaFee%>）");//大写-交费金额
             printctrl.Print(startCol+35,startRow+11,12,0,"使用免费次数：<%=sumTimes%>");
<%           int i=14;
             if(firstCode!=null && firstCode.length()>0){
		      StringTokenizer firstCodeToken = new StringTokenizer(firstCode, "|");
		      StringTokenizer secondCodeToken = new StringTokenizer(secondCode, "|");
		      StringTokenizer secondNameToken = new StringTokenizer(secondName, "|");
		      StringTokenizer servContentToken = new StringTokenizer(servContent, "|");
		      StringTokenizer servAmountToken = new StringTokenizer(servAmount, "|");
		      StringTokenizer servMarkToken = new StringTokenizer(servMark, "|");
		      
%>
		printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"一级服务");
		printctrl.Print(startCol+8,startRow+<%=i%>,12,0,"二级服务");
		printctrl.Print(startCol+18,startRow+<%=i%>,12,0,"服务条目");
		printctrl.Print(startCol+43,startRow+<%=i%>,12,0,"服务内容");

<%	
		      i=i+2;	      
		      while (firstCodeToken.hasMoreElements()) {
			        String svcFirstCode = firstCodeToken.nextToken();
			        String svcSecondCode = secondCodeToken.nextToken();
			        String svcSecondName = secondNameToken.nextToken();
			        String svcContent = servContentToken.nextToken();
			        String svcAmount = servAmountToken.nextToken();
			        String svcMark = servMarkToken.nextToken();
%>
		printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"<%=svcFirstCode%>");
		printctrl.Print(startCol+8,startRow+<%=i%>,12,0,"<%=svcSecondCode%>");
		printctrl.Print(startCol+18,startRow+<%=i%>,12,0,"<%=svcSecondName%>");
		printctrl.Print(startCol+43,startRow+<%=i%>,12,0,"<%=svcContent%>");	
<%			        
		        	i=i+2;
		        }
		        
             }
             i=i+5;
%>             
             printctrl.Print(startCol+0,startRow+<%=i%>,12,0,"受理工号：<%=work_no%>");//受理工号
             printctrl.Print(startCol+35,startRow+<%=i%>,12,0,"受理时间：<%=cur_date%>");//交费时间
 //打印结束
             printctrl.PageEnd();
             printctrl.StopPrint();

  }
  catch(e)
  {
  }
  finally
  {
  }

	return true;
}
</script>