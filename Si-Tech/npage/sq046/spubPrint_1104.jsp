<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>

<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
<HEAD>
    <TITLE>黑龙江移动BOSS</TITLE>
    	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	    <link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
<meta http-equiv="Content-Type" content="text/html; charset=GBK"></HEAD>

<%
	request.setCharacterEncoding("GBK");
    
 /**   ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
 	String nopass = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[37];
    String op_code="1210"; 
 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;

	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = WtcUtil.repStr(request.getParameter("printInfo"),"");
	String printInfo1 = WtcUtil.repStr(request.getParameter("printInfo1"),"");
	String submitCfm = request.getParameter("submitCfm");
	**/
	
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
	
	String paraStr[]=new String[37];
   String op_code="1210"; 
   String opName="开户成功";
 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;

	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = WtcUtil.repStr(request.getParameter("printInfo"),"");
	String printInfo1 = WtcUtil.repStr(request.getParameter("printInfo1"),"");
	String submitCfm = request.getParameter("submitCfm");
	

%>
<SCRIPT>
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
	var chPos = -1;
	var chPos1 = -1;
	var tempObj = new Array(5);
    var tempObj1 = new Array(5);
	 
	var strLen,strLen1,fontSize,fontStyle;
	var infoStr="";
	var InfoStr1="";
	var printFlag=false;
	var printFlag1=false;

    //rdShowMessageDialog("<%=printInfo%>");
	infoStr = "<%=printInfo%>";
	infoStr1 = "<%=printInfo1%>";
	strLen = infoStr.length;
    strLen1 = infoStr1.length;

	if(strLen>0) printFlag=true;
	if(strLen1>0) printFlag1=true;
		
	try
	{
		//rdShowMessageDialog("infoStr1====1===="); 
 		if(printFlag==true || printFlag1==true)
		{
			//rdShowMessageDialog("infoStr1====2===="); 
			//打印初始化
			printctrl.Setup(0);
			printctrl.StartPrint();

            //print infoStr===================
			if(printFlag==true)
			  printctrl.PageStart();
            
			while(strLen > 0)
			{
				for(var i=0;i<5;i++)
				{
					chPos = infoStr.indexOf("|");
					tempObj[i] = infoStr.substring(0,chPos);
					infoStr = infoStr.substring(chPos + 1);
				}
            	printctrl.Print(1*tempObj[0],1*tempObj[1],1*tempObj[2],1*tempObj[3],tempObj[4]);
				strLen = infoStr.length;
			}

			if(printFlag==true)
			{
			    //操作员、收款员
				//printctrl.Print(10,32,9,0,"<%=work_no%>");
				//printctrl.Print(35,32,9,0,"<%=work_no%>");

 			    printctrl.PageEnd();
			}

			//print infoStr1===================
/**
			if(printFlag1==true)
			  printctrl.PageStart();

			while(strLen1 > 0)
			{
				for(var i=0;i<5;i++)
				{
					chPos1 = infoStr1.indexOf("|");
					tempObj1[i] = infoStr1.substring(0,chPos1);
					infoStr1 = infoStr1.substring(chPos1 + 1);
				}
				printctrl.Print(1*tempObj1[0],1*tempObj1[1],1*tempObj1[2],1*tempObj1[3],tempObj1[4]);
				strLen1 = infoStr1.length;
			}
			if(printFlag1==true)
			{
			    //操作员、收款员
				printctrl.Print(10,32,9,0,"<%=work_no%>");
				printctrl.Print(33,32,9,0,"<%=work_no%>");

 			    printctrl.PageEnd();
			}
*/

			printctrl.StopPrint();
	  }
	}
	catch(e)
	{
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
</SCRIPT>
<!--**************************************************************************************-->
<BODY >
<head>
		<title>黑龙江移动BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
	  	<div class="popup_ok" id="rdImage" align=center>
		  	<div class="popup_zi blue" id="message"><%=DlgMsg%></div>
		  </div>

	    <div align="center">
	     <%
				if(!submitCfm.equals("Single"))
				{
%>
          <input class="b_foot" name=commit onClick="doPrint()"   type=button value="打印">
		  <input class="b_foot" name=back onClick="window.close()"   type=button value="下一步">

          <%
				}
                else
				{
%>
          <input class="b_foot" name=commit2 onClick="doPrint()"   type=button value="确定">
          &nbsp;
          <%
				}
%>
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
