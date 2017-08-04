<%@ page contentType="text/html;charset=GB2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1210.viewBean.S1210Impl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>



<%
 
  String retInfo=(String)request.getParameter("retInfo");
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<SCRIPT language="JavaScript">
function printInvoice() {
	  
	  
	  var infoStr="<%=retInfo%>";

    printctrl.Setup(0) ;
	  printctrl.StartPrint();
	  printctrl.PageStart();

		var startCol=20;
    var startRow=7;

      printctrl.Print(startCol+10,startRow+1,10,0,oneTok(infoStr,"|",2));      //年
		  printctrl.Print(startCol+18,startRow+1,10,0,oneTok(infoStr,"|",3));      //月
		  printctrl.Print(startCol+23,startRow+1,10,0,oneTok(infoStr,"|",4));      //日
      printctrl.Print(startCol-5,startRow+3,10,0,oneTok(infoStr,"|",5));      //客户号码 
      printctrl.Print(startCol+30,startRow+3,10,0,oneTok(infoStr,"|",6));     //合同号码  
      printctrl.Print(startCol-10,startRow+4,10,0,oneTok(infoStr,"|",7));     //客户姓名 
      printctrl.Print(startCol-10,startRow+6,10,0,oneTok(infoStr,"|",8));     //联系地址
		  printctrl.Print(startCol-10,startRow+8,10,0,oneTok(infoStr,"|",9));     //付款方式

     //大小写金额
		  printctrl.Print(startCol,startRow+10,10,0,chineseNumber(oneTok(infoStr,"|",10)));
		  printctrl.Print(startCol+35,startRow+10,10,0,oneTok(infoStr,"|",10));     

      printctrl.Print(startCol-15,startRow+12,10,0,oneTok(infoStr,"|",11));
       
      
      printctrl.Print(startCol-10,startRow+25,9,0,oneTok(infoStr,"|",12));
      printctrl.Print(startCol+15,startRow+25,9,0,oneTok(infoStr,"|",12));
      
      
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
	classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"

	codebase="/ocx/printatl.dll#version=1,0,0,1"

	id="printctrl"
	
	VIEWASTEXT>
</OBJECT>

</body>
</html>