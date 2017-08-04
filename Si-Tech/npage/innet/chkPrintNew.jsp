<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080919
********************/
%>
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
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html;charset=GB2312"%>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>

<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    /**
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	String op_code = "1210";
	String nopass = ((String[][])arrSession.get(4))[0][0];
	**/
	String op_code = "1210";
	String work_no =(String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");
	
	
	String paraStr[]=new String[37];
	

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gb2312");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
	String phone = request.getParameter("activePhone");
	dirtPage = dirtPage + "&activePhone=" + phone;
 %>
<SCRIPT type=text/javascript>
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
  var infoStr="<%=retInfo%>";
  
  try
  {
     //打印初始化
		printctrl.Setup(0);
		printctrl.StartPrint();
		printctrl.PageStart();
		/*liujian 2013-3-7 9:00:35 打印发票logo和发票号码 begin*/
		<%
			if(printLogoFlag.equals("N"))
			{
				%>
				//	getXML("<%=request.getContextPath()%>/images/billLogo.jpg");
					printctrl.DrawImage(localPath,8,10,40,18);//左上右下
				<%
			}
		%>
		var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
		var vR = 0;
		var lineSpace = 0;
		/*liujian 2013-3-7 9:00:35 打印发票logo和发票号码 end*/
		
		/*liujian 2012-3-24 9:36:20 发票优化 begin */
		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",2));
 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "邮电通信业");
		printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "本次发票号码：<%=bill_number%>");

		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "防伪码：");
		
		printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"工    号："+oneTok(infoStr,"|",1));//工号
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"操作流水：");//流水
		printctrl.PrintEx(100, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"业务名称：");//业务名称
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客户名称："+oneTok(infoStr,"|",3));//用户名称
		printctrl.PrintEx(100,rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"卡    号："+oneTok(infoStr,"|",4));//卡号
		
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"手机号码："+oneTok(infoStr,"|",5));//移动号码
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"协议号码："+oneTok(infoStr,"|",6));//协议号码
		printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"支票号码："+oneTok(infoStr,"|",7));//支票号码
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"合计金额：(大写)"+chineseNumber(oneTok(infoStr,"|",8)));//合计金额(大写)
		printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(小写)￥"+oneTok(infoStr,"|",8));//金额(小写)
		
		printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(项目)");//项目
		
		var busiStr=oneTok(infoStr,"|",9);
		var row = 0;
		var f = 0;
		for(var i=0;i<getTokNums(busiStr,"~");i++) {
			if (i % 2 == 0) {
				f = 1;
				printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
			} else if (i % 2 == 1) {
				f = 0;
				printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
				row ++;
			}
		}
		    
		if(f == 1) {
		  row++;
		}
	  busiStr=oneTok(infoStr,"|",10);
		for(var i=0;i<getTokNums(busiStr,"~");i++) {
			if (i % 2 == 0) {
				printctrl.PrintEx(20, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
			} else if (i % 2 == 1) {
				printctrl.PrintEx(90, rowInit + 9 + row, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
				row ++;
			}
		}
		
		printctrl.PrintEx(13,27,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",11));
		
		printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票：" +　oneTok(infoStr,"|",12)); //操作员
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"收款："); //收款员 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"复核：");
		/*liujian 2012-3-24 9:36:20 发票优化 end */
		
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
<FORM method=post name="spubPrint">
<!------------------------------------------------------>

    <BODY  onload="doPrint()">
          
    </BODY>
    
</FORM>
<!-------引入打印控件---------->
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
		codebase="/ocx/PrintEx.dll#version=1,1,0,5" 
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

</HTML>    
