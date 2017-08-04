<!-------------------------------------------->
<!---日期:  2003-10-23                    ---->
<!---作者:  sunzhe                        ---->
<!---代码:  fPubSimpSel.jsp               ---->
<!---功能： 打印确认界面                  ---->
<!---修改：                               ---->



<!--
Setup 显示打印设置对话框 1 显示 0 不显示
StartPrint 开始打印
PageStart 新的页
Print 
参数1 x坐标（0 - 100归一化坐标）
参数2 y坐标（0 - 100归一化坐标）
参数3 字号（0 - 100，0为系统缺省字号）
参数4 字粗细（0 - 10，0为系统缺省）
参数5 要打印的字符串

PageEnd 页结束
StopPrint 停止打印
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=gb2312" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>

<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	String op_code = "1210";
	String nopass = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[37];

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gb2312");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>
<SCRIPT type=text/javascript>

function doPrint()
{
  var infoStr="<%=retInfo%>";
  
  try
  {
     //打印初始化
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var startCol=20;
    var startRow=7;
      
  	    //printctrl.Print(startCol-2,startRow,0,0,oneTok(infoStr,"|",1));      //证件号码 
        printctrl.Print(startCol+10,startRow+1,10,0,oneTok(infoStr,"|",2));      //年
		printctrl.Print(startCol+18,startRow+1,10,0,oneTok(infoStr,"|",3));      //月
		printctrl.Print(startCol+23,startRow+1,10,0,oneTok(infoStr,"|",4));      //日

        printctrl.Print(startCol-5,startRow+3,10,0,oneTok(infoStr,"|",5));      //手机号码 
        printctrl.Print(startCol+30,startRow+3,10,0,oneTok(infoStr,"|",6));   //合同号码  

        printctrl.Print(startCol-10,startRow+4,10,0,oneTok(infoStr,"|",7));     //客户姓名 

        printctrl.Print(startCol-10,startRow+6,10,0,oneTok(infoStr,"|",8));     //联系地址

		printctrl.Print(startCol-10,startRow+8,10,0,oneTok(infoStr,"|",9));     //付款方式

        //大小写金额
		printctrl.Print(startCol,startRow+10,10,0,chineseNumber(oneTok(infoStr,"|",10)));
		printctrl.Print(startCol+35,startRow+10,10,0,oneTok(infoStr,"|",10));     

        //业务项目
	    var busiStr=oneTok(infoStr,"|",11);
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
          printctrl.Print(startCol-15,startRow+12+i*1,9,0,oneTok(busiStr,"*",i+1));  
       
	    //操作员、收款员
	    printctrl.Print(10,32,9,0,"<%=work_no%>");
		printctrl.Print(35,32,9,0,"<%=work_no%>");
         
 
	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	//rdShowMessageDialog("打印机故障，无法打印发票！");
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}

 </SCRIPT>
<!--**************************************************************************************-->
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY  onload="doPrint()">
          
    </BODY>
</FORM>
<!-------引入打印控件---------->
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</HTML>    
