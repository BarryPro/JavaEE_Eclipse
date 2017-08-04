<%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-12 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
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

<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    
    	String work_no = (String)session.getAttribute("workNo");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>
<SCRIPT type=text/javascript>
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
		printctrl.Print(startCol+35,startRow+10,0,0,oneTok(infoStr,"|",10));     

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
 	rdShowMessageDialog("打印机故障，无法打印发票！");
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}
function chineseNumber(num)
{
if(parseFloat(num)<=0.01) return "零圆整"
if (isNaN(num) || num > Math.pow(10, 12)) return ""
var cn = "零壹贰叁肆伍陆柒捌玖"
var unit = new Array("拾佰仟", "分角")
var unit1= new Array("万亿", "")
var numArray = num.toString().split(".")
var start = new Array(numArray[0].length-1, 2)

	function toChinese(num, index)
	{
	var num = num.replace(/\d/g, function ($1)
	{
	return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1)
	})
	return num
	}

for (var i=0; i<numArray.length; i++)
{
var tmp = ""
for (var j=0; j*4<numArray[i].length; j++)
{
var strIndex = numArray[i].length-(j+1)*4
var str = numArray[i].substring(strIndex, strIndex+4)
var start = i ? 2 : str.length-1
var tmp1 = toChinese(str, i)
tmp1 = tmp1.replace(/(零.)+/g, "零").replace(/零+$/, "")
tmp1 = tmp1.replace(/^壹拾/, "拾")
tmp = (tmp1+unit1[i].charAt(j-1)) + tmp
}
numArray[i] = tmp 
}

numArray[1] = numArray[1] ? numArray[1] : ""
numArray[0] = numArray[0] ? numArray[0]+"圆" : numArray[0], numArray[1] = numArray[1].replace(/^零+/, "")
numArray[1] = numArray[1].match(/分/) ? numArray[1] : numArray[1]+"整"
return numArray[0]+numArray[1]
}
 </SCRIPT>
<!--**************************************************************************************-->
 <BODY  onload="doPrint()">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
   
          
  
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
