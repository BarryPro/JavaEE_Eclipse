<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.04
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GB2312"%>

<HTML>
<HEAD>
    <TITLE>��ӡ</TITLE>
</HEAD>

<% 
	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	String submitCfm = request.getParameter("submitCfm");
		System.out.println("printInfo="+printInfo);
%>
<SCRIPT type=text/javascript>
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

function doPrint()
{
  try
  {
	//��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var chPos = -1;
	var tempObj = new Array(5);
	var temp;
	var strLen,fontSize,fontStyle;
	var printStr,InfoStr; 
	infoStr = "<%=printInfo%>";

	//alert(infoStr);
	var startCol=18;
	var startRow=20;
    //������Ϣ 	
    printctrl.Print(startCol+45,startRow-6,10,0,oneTok(infoStr,"|",1));       //��½����
    printctrl.Print(startCol+3,startRow-6,10,0,oneTok(infoStr,"|",2));        //����
    printctrl.Print(startCol-2,startRow,10,0,oneTok(infoStr,"|",3));  	      //�ͻ����� 
 		printctrl.Print(startCol-2,startRow+1,10,0,oneTok(infoStr,"|",4));        //�ֻ�����
    printctrl.Print(startCol-2,startRow+2,10,0,oneTok(infoStr,"|",5));        //��ϵ��ַ
    printctrl.Print(startCol-2,startRow+3,10,0,oneTok(infoStr,"|",6));        //֤������
    printctrl.Print(startCol-2,startRow+4,10,0,oneTok(infoStr,"|",7));        //֤����ַ
    printctrl.Print(startCol-2,startRow+5,10,0,oneTok(infoStr,"|",8));        //��ϵ�绰
    printctrl.Print(startCol-2,startRow+6,10,0,oneTok(infoStr,"|",9));        //�¿ͻ�����
    printctrl.Print(startCol-2,startRow+7,10,0,oneTok(infoStr,"|",10));       //���ֻ�����
    printctrl.Print(startCol-2,startRow+8,10,0,oneTok(infoStr,"|",11));       //��֤������  
    printctrl.Print(startCol-2,startRow+9,10,0,oneTok(infoStr,"|",12));       //��֤����ַ  
    //������
    printctrl.Print(startCol-2,startRow+19,10,0,oneTok(infoStr,"|",13));      //
    printctrl.Print(startCol-2,startRow+20,10,0,oneTok(infoStr,"|",14));      //
    printctrl.Print(startCol-2,startRow+21,10,0,oneTok(infoStr,"|",15));      //
    printctrl.Print(startCol-2,startRow+22,10,0,oneTok(infoStr,"|",16));      //
    printctrl.Print(startCol-2,startRow+23,10,0,oneTok(infoStr,"|",17));      //
    printctrl.Print(startCol-2,startRow+24,10,0,oneTok(infoStr,"|",18));      //
    printctrl.Print(startCol-2,startRow+25,10,0,oneTok(infoStr,"|",19));      //
    printctrl.Print(startCol-2,startRow+26,10,0,oneTok(infoStr,"|",20));      //
    
    
	//��ע��    
		printctrl.Print(startCol-2,startRow+32,10,0,oneTok(infoStr,"|",21));      //ϵͳ��ע

    //���д�ӡ����
		var lineLen=45;
	  var lenlen=33;
 
	 
   	for(var ll=22;ll<=getTokNums(infoStr,"|");ll++){
 
  
    var temStr=oneTok(oneTok(infoStr,"|",ll));//����
   
    if(temStr.length - lineLen<0)
    {
		printctrl.Print(startCol-2,startRow+lenlen,10,0,oneTok(infoStr,"|",ll)); 
		}else{
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
				
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
  }
  finally
  {
	//���ش�ӡȷ����Ϣ
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

	/**���ַ�������tok�ֽ�ȡֵ**/
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

	/**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
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
</SCRIPT>
<!--**************************************************************************************-->
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>�������ƶ�BOSS</title>
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
           <input class="b_foot" name=commit onClick="doPrint()"   type=button value="��ӡ">
		  		<input class="b_foot" name=back onClick="doSub()"   type=button value="��һ��">
	    </div>
	    <br>   
	 </div>
</FORM>
<!-------�����ӡ�ؼ�---------->
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
