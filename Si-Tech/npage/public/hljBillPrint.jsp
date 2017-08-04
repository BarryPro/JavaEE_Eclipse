<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
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
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>
<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>
 <%!
 	/**将字符串按照tok分解取值**/
   public String oneTok(String str,int loc){
  
		   String temStr="";
		   temStr=str;
		   if(str.charAt(0)=='|')  temStr=str.substring(1,str.length());
		   
		   if(str.charAt((str.length())-1)=='|')  temStr=temStr.substring(0,(temStr.length()-1));
		    
		
			 int temLoc;
			 int temLen;
			 
		    for(int ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length();
		       temLoc=temStr.indexOf("|");
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf("|")==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf("|"));
		    }

		    
  
 /**将字符串按照tok分解后,取得子字符串总数**/
	public int getTokNums(String str){
	    String temStr="";
		   temStr=str;
	   if(str.charAt(0)=='~') temStr=str.substring(1,str.length());
	   if(str.charAt((str.length())-1)=='~') temStr=temStr.substring(0,(temStr.length()-1));
	
	   int temLen;
	   int temNum=1;
	   int temLoc;
	   while(temStr.indexOf("~")!=-1)
	   {	
	      temLen=temStr.length();
	      temLoc=temStr.indexOf("~");
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}
 %>

<% 

    String work_no =(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String org_code =(String)session.getAttribute("orgCode");
    String op_code = "1210";
    String regionCode = org_code.substring(0,2);
		String nopass = (String)session.getAttribute("password");	
		String paraStr[]=new String[37];

		 	paraStr[0]=op_code;
			paraStr[1]=work_no;
			paraStr[2]=nopass;
			paraStr[3]=org_code;


	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
	
	//Billing提供取随机数规则
	java.util.Random r = new java.util.Random();
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	
	String print_workNo = "";
	String print_accept = "";
	String print_opName = "";
	String printMessage = oneTok(retInfo,1);
	if(printMessage.length()>0){
	    String resSplitMsg[] = printMessage.split("\\s{1,}")  ;
	    if(resSplitMsg.length==3){
	      print_workNo = resSplitMsg[0];
        print_accept = resSplitMsg[1];
        print_opName = resSplitMsg[2];
       
	    }else if(resSplitMsg.length==2){
        print_workNo = resSplitMsg[0];
        print_accept = resSplitMsg[1];
        print_opName = "";
	    }else{
	      print_workNo = resSplitMsg[0];
        print_accept = "";
        print_opName = "";
	    }
	     System.out.println("-------------1143----------print_workNo="+print_workNo);
        System.out.println("-------------1143----------print_accept="+print_accept);
        System.out.println("-------------1143----------print_opName="+print_opName);
	}else{
%>
	  <SCRIPT type=text/javascript>
      rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!",0);
      location="<%=dirtPage%>";
	  </SCRIPT>
<%
	}
  
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
	/*liujian 2013-3-7 9:00:35 打印发票logo和发票号码 end*/
   var rowInit = Number('<%=rowInit%>');
		var fontSizeInit = Number('<%=fontSizeInit%>');//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = Number('<%=fontStrongInit%>');//字体粗细
		var vR = 0;
		var lineSpace = 0; 
		
	  var startCol=20;
    var startRow=7;
	
    printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
	  printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "邮电通信业");
	  printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "本次发票号码：<%=bill_number%>");
		 
		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "防伪码：<%=ran%>");	//发票防伪码
		
        printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"工    号：<%=print_workNo%>");  //工号
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"操作流水：<%=print_accept%>");//流水
		printctrl.PrintEx(100, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"业务名称：<%=print_opName%>");//业务名称
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客户名称："+oneTok(infoStr,"|",5));//用户名称
		printctrl.PrintEx(100, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"卡    号："+oneTok(infoStr,"|",6));//卡号
 
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"手机号码："+oneTok(infoStr,"|",7));//移动台号
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"协议号码："+oneTok(infoStr,"|",8));//协议号码
		printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"支票号码：");//支票号码	
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"合计金额：(大写)"+oneTok(infoStr,"|",10));//合计金额(大写)
		printctrl.PrintEx(100,rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(小写)"+"￥"+oneTok(infoStr,"|",11));//金额(小写)
		
		
        printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(项目)");//项目 
        printctrl.PrintEx(50, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",9)); 
    
		 var imei_temp = oneTok(infoStr,"|",15);
		 if( imei_temp != null && imei_temp != "") {
			printctrl.PrintEx(20, rowInit + 8, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,imei_temp);//IMEINo
		 }
	    var busiStr=oneTok(infoStr,"|",12);
	    for(var i=0;i<getTokNums(busiStr,"~");i++)
	    	printctrl.PrintEx(20, rowInit + 9 +i*1, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(busiStr,"~",i+1));  //业务项目
        //  printctrl.Print(20,rowInit + 8 +i*1,9,0,oneTok(busiStr,"~",i+1));  //业务项目
        
		/********tianyang add at 20090928 for POS缴费需求****start*****/
		var payType = oneTok(infoStr,"|",17);
		if (payType=="BX"||payType=="BY") {
			printctrl.PrintEx(13, 24, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"商户名称（中英文)："+oneTok(infoStr,"|",18));
		  
		  printctrl.PrintEx(13, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "交易卡号（屏蔽）： "+oneTok(infoStr,"|",19));
			printctrl.PrintEx(62, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "商户编码："+oneTok(infoStr,"|",20));
			printctrl.PrintEx(100, 25, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "批次号："+oneTok(infoStr,"|",21));
			
			printctrl.PrintEx(13, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,  "发卡行号："+oneTok(infoStr,"|",22));
			printctrl.PrintEx(62, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "终端编码："+oneTok(infoStr,"|",23));
			printctrl.PrintEx(100, 26, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"授权号："+oneTok(infoStr,"|",24));
			
			printctrl.PrintEx(13, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "回应日期时间："+oneTok(infoStr,"|",25));
			printctrl.PrintEx(62, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "参考号："+oneTok(infoStr,"|",26));
			printctrl.PrintEx(100, 27, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "流水号："+oneTok(infoStr,"|",27));
			
			printctrl.PrintEx(13, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "收单行号："+oneTok(infoStr,"|",28));
			printctrl.PrintEx(62, 28, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "签字：");
		}
    /********tianyang add at 20090928 for POS缴费需求****end*******/

                 
                 




	    printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票："+oneTok(infoStr,"|",13)); //操作员
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"收款："+oneTok(infoStr,"|",14));//收款员 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"复核：");//是否参与赠送礼品活动
		   
 
	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	  rdShowMessageDialog("发票打印错误,请使用补打发票交易打印发票!",0);
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
