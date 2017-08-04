<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-20 页面改造,修改样式
*1270,1255等模块使用过的弹出对话框
*
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<HTML>
<HEAD>
    <TITLE>打印</TITLE>
</HEAD>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% 
	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	String submitCfm = request.getParameter("submitCfm");
	System.out.println("printInfo="+printInfo);
	
%>
<SCRIPT type="text/javascript">

onload=function()
{
  var rdBackColor = "#E3EEF9";

  // If IE version >=5.5, This will be works
  // gradient start color
  var rdGradientStartColor = "#FFFFFFFF";

  // gradient end color
  var rdGradientEndColor = "#FFFDEDC1";

  // gradient type, 1 represents from left to right, 0 reresents from top to bottom
  var rdGradientType = "0";

  var fillter = "progid:DXImageTransform.Microsoft.Gradient(startColorStr="+rdGradientStartColor+",endColorStr="+rdGradientEndColor+", gradientType="+rdGradientType+")";

  document.bgColor = rdBackColor;
  document.body.style.filter = fillter;	

}

	/**将字符串按照tok分解取值**/
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }

	/**将字符串按照tok分解后,取得子字符串总数**/
	function getTokNums(str,tok){
	   var temStr=str;
	   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
	   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
	
	   var temLen;
	   var temNum=1;
	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length;
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}

function doPrint()
{
  try
  {
  	
	//打印初始化
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var chPos = -1;
	var tempObj = new Array(5);
	var temp;
	var strLen,fontSize,fontStyle;
	var printStr,InfoStr; 
	//infoStr = "<%=printInfo%>";
	infoStr=window.dialogArguments;
    

	var startCol=18;
	var startRow=20;
    //基本信息 	
    
    printctrl.Print(startCol+45,startRow-6,10,0,oneTok(infoStr,"|",1));       //登陆名称
    printctrl.Print(startCol+3,startRow-6,10,0,oneTok(infoStr,"|",2));        //日期
    printctrl.Print(startCol-2,startRow,10,0,oneTok(infoStr,"|",3));  	      //客户姓名 
 	printctrl.Print(startCol-2,startRow+1,10,0,oneTok(infoStr,"|",4));        //手机号码
    printctrl.Print(startCol-2,startRow+2,10,0,oneTok(infoStr,"|",5));        //联系地址
    printctrl.Print(startCol-2,startRow+3,10,0,oneTok(infoStr,"|",6));        //证件号码
    printctrl.Print(startCol-2,startRow+4,10,0,oneTok(infoStr,"|",7));        //证件地址
    printctrl.Print(startCol-2,startRow+5,10,0,oneTok(infoStr,"|",8));        //联系电话
    printctrl.Print(startCol-2,startRow+6,10,0,oneTok(infoStr,"|",9));        //新客户姓名
    printctrl.Print(startCol-2,startRow+7,10,0,oneTok(infoStr,"|",10));       //新手机号码
    printctrl.Print(startCol-2,startRow+8,10,0,oneTok(infoStr,"|",11));       //新证件号码  
    printctrl.Print(startCol-2,startRow+9,10,0,oneTok(infoStr,"|",12));       //新证件地址  
  //  printctrl.Print(startCol-2,startRow+11,10,0,oneTok(infoStr,"|",13));      //新联系地址  
  //  printctrl.Print(startCol-2,startRow+12,10,0,oneTok(infoStr,"|",14));      //新联系电话  
  //  printctrl.Print(startCol-2,startRow+13,10,0,oneTok(infoStr,"|",15));      //新付费方式
  //  printctrl.Print(startCol-2,startRow+14,10,0,oneTok(infoStr,"|",16));      //
  //  printctrl.Print(startCol-2,startRow+15,10,0,oneTok(infoStr,"|",17));      //
  //  printctrl.Print(startCol-2,startRow+16,10,0,oneTok(infoStr,"|",18));      //
 //   printctrl.Print(startCol-2,startRow+17,10,0,oneTok(infoStr,"|",19));      //
 //   printctrl.Print(startCol-2,startRow+18,10,0,oneTok(infoStr,"|",20));      //
    //受理类
    printctrl.Print(startCol-2,startRow+19,10,0,oneTok(infoStr,"|",13));      //
    printctrl.Print(startCol-2,startRow+20,10,0,oneTok(infoStr,"|",14));      //
    printctrl.Print(startCol-2,startRow+21,10,0,oneTok(infoStr,"|",15));      //
    printctrl.Print(startCol-2,startRow+22,10,0,oneTok(infoStr,"|",16));      //
    printctrl.Print(startCol-2,startRow+23,10,0,oneTok(infoStr,"|",17));      //
    printctrl.Print(startCol-2,startRow+24,10,0,oneTok(infoStr,"|",18));      //
    printctrl.Print(startCol-2,startRow+25,10,0,oneTok(infoStr,"|",19));      //
    printctrl.Print(startCol-2,startRow+26,10,0,oneTok(infoStr,"|",20));      //
    
   
	//备注类    
	printctrl.Print(startCol-2,startRow+32,10,0,oneTok(infoStr,"|",21));      //系统备注
    //printctrl.Print(startCol-2,startRow+42,10,0,oneTok(infoStr,"|",30));      //操作备注

    //换行打印广告词
	var lineLen=45;
	  var lenlen=33;
 
	 
   for(var ll=22;ll<=getTokNums(infoStr,"|");ll++){
 
  
    var temStr=oneTok(oneTok(infoStr,"|",ll));//广告词
   
    if(temStr.length - lineLen<0)
    {
        //printctrl.Print(startCol-2,startRow+lenlen,10,0,tempStr);
		printctrl.Print(startCol-2,startRow+lenlen,10,0,oneTok(infoStr,"|",ll)); 
	}else
	{
        var nums=Math.ceil((temStr.length/lineLen));
		for(var k=0;k<nums;k++)
		{
			if(k<(nums*1-1))
			{
		         printctrl.Print(startCol-2,startRow+lenlen+k*1,10,0,temStr.substring(lineLen*k,(lineLen*k+lineLen)));	
			}else
			{
             printctrl.Print(startCol-2,startRow+lenlen+k*1,10,0,temStr.substring(lineLen*k,temStr.length));				  
			}
		}
	}	
	if(nums>2){
		lenlen=lenlen+nums;
	}else
		lenlen=lenlen+2;
	
}	
	
	
	
	
	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
     //rdShowMessageDialog("打印机故障，无法打印工单！");
  }
  finally
  {
	//返回打印确认信息
	var cfmInfo = "<%=submitCfm%>";
	var retValue = "";
	if(cfmInfo == "Yes")
	{	retValue = "confirm";	}
	window.returnValue= retValue;     
	window.close(); 
  }
}

function doSub()
{
  window.returnValue="continueSub";
  window.close();
}
</SCRIPT>
<!--**************************************************************************************-->
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>黑龙江移动BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
	<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
	  	<div class="popup_qu" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>
		  </div>

	    <div align="center">
	       <input class="b_foot" name=commit onClick="doPrint()"  type=button  value="打印">
	  		 <input class="b_foot" name=back onClick="doSub()"   type=button  value="下一步">
	    </div>
	    <br>   
	 </div>
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
</BODY>
</HTML>    
