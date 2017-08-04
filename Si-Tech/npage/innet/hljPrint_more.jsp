<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-27 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<HTML>
<HEAD>
    <TITLE>打印</TITLE>
</HEAD>

<%
    String DlgMsg = request.getParameter("DlgMsg");
    String printInfo = request.getParameter("printInfo");
    String submitCfm = request.getParameter("submitCfm");
%>
<SCRIPT type=text/javascript>
onload = function()
{
    var rdBackColor = "#E3EEF9";

  // If IE version >=5.5, This will be works
    // gradient start color
    var rdGradientStartColor = "#FFFFFFFF";

  // gradient end color
    var rdGradientEndColor = "#FFFDEDC1";

  // gradient type, 1 represents from left to right, 0 reresents from top to bottom
    var rdGradientType = "0";

    var fillter = "progid:DXImageTransform.Microsoft.Gradient(startColorStr=" + rdGradientStartColor + ",endColorStr=" + rdGradientEndColor + ", gradientType=" + rdGradientType + ")";

    document.bgColor = rdBackColor;
    document.body.style.filter = fillter;
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
        infoStr = "<%=printInfo%>";

        var startCol = 18;
        var startRow = 10;
       //基本信息 	
        //printctrl.Print(startCol + 45, startRow - 6, 10, 0, oneTok(infoStr, "|", 1));       //登陆名称
        //printctrl.Print(startCol + 3, startRow - 6, 10, 0, oneTok(infoStr, "|", 2));        //日期
        var phone = new Array(9);
        phone[0] ="";
        phone[1] ="";
        phone[2] ="";
        phone[3] ="";
        phone[4] ="";
        phone[5] ="";
        phone[6] ="";
        phone[7] ="";
        phone[8] ="";
        
        var phones = oneTok(infoStr, "|", 5) ;//获得手机号
        var phoneArr = phones.split(","); 
        var fl = Math.floor((phoneArr.length-1)/6);//控制每行显示6个
        for(var i=0;i<=fl;i++){
        	if(i == fl){// 到最后一行时，不满足6个的话  会打出 undefined，这样来避免
        		for(var j=i*6;j<(phoneArr.length-1);j++){
        			    if(j == phoneArr.length-2){
        	  	     	   phone[i] = phone[i] + phoneArr[j] ;
        	  	         }else{
        	  		  	   phone[i] = phone[i] + phoneArr[j] + ",";
        	  	         }	  
        	    }
        	}else{
        	  for(var j=i*6;j<(i+1)*6;j++){
        	  	if(j == (i+1)*6 - 1){
        	  	   	phone[i] = phone[i] + phoneArr[j] ;
        	  	}else{
        	  		phone[i] = phone[i] + phoneArr[j] + ",";
        	  	}
        	  }
            }
            
        }
        
        
        printctrl.Print(startCol - 2, startRow, 10, 0, oneTok(infoStr, "|", 1));  	        //客户姓名 
        printctrl.Print(startCol + 40, startRow  , 10, 0, oneTok(infoStr, "|", 2));        //手机号码
        printctrl.Print(startCol - 2, startRow + 3, 10, 0, oneTok(infoStr, "|", 3));        //联系地址
        printctrl.Print(startCol + 40, startRow + 3, 10, 0, oneTok(infoStr, "|", 4));        //证件号码
        for(var i=0;i<phone.length-1;i++){
        	if(i ==0){
        		printctrl.Print(startCol - 2, startRow + 6 + i*2, 10, 0,phone[i]);
        	}else{
        	    printctrl.Print(startCol + 3, startRow + 6 + i*2, 10, 0,phone[i]);	
        	}
        	
        }
        
        printctrl.Print(startCol - 2, startRow + 9, 10, 0, oneTok(infoStr, "|", 6));      //
        printctrl.Print(startCol - 2, startRow + 10, 10, 0, oneTok(infoStr, "|", 7));      //
        printctrl.Print(startCol - 2, startRow + 11, 10, 0, oneTok(infoStr, "|", 8));      //
        printctrl.Print(startCol - 2, startRow + 12, 10, 0, oneTok(infoStr, "|", 9));      //
        printctrl.Print(startCol - 2, startRow + 13, 10, 0, oneTok(infoStr, "|",10));      //
        printctrl.Print(startCol - 2, startRow + 14, 10, 0, oneTok(infoStr, "|", 11));      //
        //受理类
        printctrl.Print(startCol - 2, startRow + 27, 10, 0, oneTok(infoStr, "|", 12));      //
        printctrl.Print(startCol - 2, startRow + 30, 10, 0, oneTok(infoStr, "|", 13));      //
        printctrl.Print(startCol - 2, startRow + 33, 10, 0, oneTok(infoStr, "|", 14));      //
        printctrl.Print(startCol - 2, startRow + 36, 10, 0, oneTok(infoStr, "|", 15));      //
        printctrl.Print(startCol - 2, startRow + 39, 10, 0, oneTok(infoStr, "|", 16));      //
        printctrl.Print(startCol - 2, startRow + 40, 10, 0, oneTok(infoStr, "|", 17));      //
        printctrl.Print(startCol - 2, startRow + 41, 10, 0, oneTok(infoStr, "|", 18));      //
        printctrl.Print(startCol - 2, startRow + 42, 10, 0, oneTok(infoStr, "|", 19));      //
        //备注类    
        printctrl.Print(startCol - 2, startRow + 43, 10, 0, oneTok(infoStr, "|", 20));      //系统备注
        //printctrl.Print(startCol-2,startRow+42,10,0,oneTok(infoStr,"|",30));      //操作备注
        //换行打印广告词
        

	 
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
        if (cfmInfo == "Yes")
        {
            retValue = "confirm";
        }
        window.returnValue = retValue;
        window.close();
    }
}

function doSub()
{
    window.returnValue = "continueSub";
    window.close();
}


function oneTok(str,tok,loc)
{

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
</SCRIPT>

		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
<BODY>
<FORM method=post name="spubPrint">
		<div class="popup">
			<div class="popup_qu" id="rdImage" align=center>
			  <div class="popup_zi orange" id="message"><%=DlgMsg%></div>
			</div>
    	<div align="center">
				<input class="b_foot" name=commit onClick="doPrint()" type=button value="打印">
        <input class="b_foot" name=back onClick="doSub()" type=button value="取消">
			</div>
			<br>
		</div>
</FORM>
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
