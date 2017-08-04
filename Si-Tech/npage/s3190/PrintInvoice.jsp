   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-11
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<%
 
  String payAccept = (String)request.getParameter("payAccept");//流水
  String contractno = (String)request.getParameter("contractno");
  
  //读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");          								//工号
	String workName =(String)session.getAttribute("workName"); 
  String regionCode = (String)session.getAttribute("regCode");
  

  
  
	String returnPage = "f3190_1.jsp";
	String total_date=new java.text.SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
	String year = total_date.substring(0,4);
	String month = total_date.substring(4,6);
	String day = total_date.substring(6,8);
  
  String result0  =  "";			//0	返回码                
	String result1 =  "";				//1	返回信息	            
	String result2  =  "";         
	String result3  = "";     
	String result4  =  "";          
	String result5  =  "";           
	String result6  = "";       
	String result7  =  "";             
	String result8  =  "";
	String result9  = "";
	String result10  =  "";
	String result11  =  "";  
	String result12  = "";
	String result13  =  "";
	String result14  =  "";     
	String result15  = "";   
	String result16  =  "";   
	String result17  =  "";
  
  
   
	String[] inParas = new String[3];
	inParas[0] = workNo;
	inParas[1] = contractno;
	inParas[2] = payAccept; 
    
  for(int i=0;i<inParas.length;i++){
 		System.out.println("--------------------------inParas["+i+"]:------------------"+inParas[i]);
 	}
	//acceptList = callView.callFXService("s3185Cfm", inParas, "16");
%>

    <wtc:service name="s3190Print" outnum="15" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inParas[0]%>" />
			<wtc:param value="<%=inParas[1]%>" />
			<wtc:param value="<%=inParas[2]%>" />
			<wtc:param value="<%=inParas[2]%>" />			
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%	
	
	String return_code = code;
	String error_msg = msg;
	
	
	
	
 	System.out.println("--------------------return_code:-----------------"+return_code);
 	System.out.println("--------------------error_msg:------------------"+error_msg);
 	
 	
 	
if ( return_code.equals("000000")||return_code.equals("0") )
{

	result0 	= result_t[0][0];	//0	返回码 
	result1 	= result_t[0][1];    //1	返回信息
	result2 	= result_t[0][2];            
	result3  	= result_t[0][3];
	result4  	= result_t[0][4];
	result5  	= result_t[0][5];    
	result6 	= result_t[0][6];
	result7 	= result_t[0][7];
	result8 	= result_t[0][8];             
	result9 	= result_t[0][9];
	result10 	= result_t[0][10];
	result11	= result_t[0][11];
	result12	= result_t[0][12];
	result13	= result_t[0][13];
	result14	= result_t[0][14];
	//result15	= result_t[0][15];
	//result16	= result_t[0][16];


  String phoneNo =result5.trim();
	if(phoneNo.equals("99999999999"))
    phoneNo="";

System.out.println("--------------------------phoneNo:------------------"+phoneNo);
%>


<SCRIPT language="JavaScript">

function printInvoice()
{ 
    printctrl.Setup(0) ;
		printctrl.StartPrint();
		printctrl.PageStart();
		printctrl.Print(13,5,9,0,"<%=workNo%>");  
		//printctrl.Print(20,5,9,0,"<%=result15%>");

    printctrl.Print(40,5,9,0,"<%=result2%>");

		printctrl.Print(65,5,9,0,"<%=year%>");
		printctrl.Print(74,5,9,0,"<%=month%>");
		printctrl.Print(80,5,9,0,"<%=day%>");
		
		printctrl.Print(18,7,10,0,"<%=result4%>");
 
		printctrl.Print(18,10,10,0,"<%=phoneNo%>");

		printctrl.Print(50,10,10,0,"<%=result6%>");
		printctrl.Print(66,10,10,0,"<%=result7%>");
		
		printctrl.Print(25,13,10,0,"<%=result8%>");
		printctrl.Print(66,13,10,0,"￥<%=result9%>");

    printctrl.Print(20,17,9,9,"<%=result10%>") ;
    printctrl.Print(20,18,9,9,"<%=result11%>") ;
    printctrl.Print(20,19,9,9,"<%=result12%>") ;
    printctrl.Print(20,20,9,9,"<%=result13%>") ;
    printctrl.Print(20,26,9,9,"<%=result14%>") ;


		printctrl.Print(13,28,9,0,"<%=workName%>") ;
		
 		printctrl.PageEnd() ;
		printctrl.StopPrint() ; 
}

function ifprint()
{
  printInvoice();
  document.location.replace("<%=returnPage%>");
  //window.close();
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
			rdShowMessageDialog("发票打印错误,请联系管理员!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
			window.close();
	 </script>
<%
	}
%>


