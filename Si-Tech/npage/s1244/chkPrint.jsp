<!-------------------------------------------->
<!---日期:  2003-10-23                    ---->
<!---作者:  sunzhe                        ---->
<!---代码:  fPubSimpSel.jsp               ---->
<!---功能： 打印确认界面                  ---->
<!---修改： qidp @ 2009-01-06             ---->



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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1210";
	 /* 记录发票补打操作日志（doucm）*/
	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
		
	 	String paraStr[]=new String[6];
		paraStr[0] = request.getParameter("workNo");
		paraStr[1] = request.getParameter("phoneNo");
		paraStr[2] = request.getParameter("loginAccept");
		paraStr[3] = request.getParameter("totalDate");
		paraStr[4] = "1244";
		paraStr[5] = "发票补打！";
		
		//SPubCallSvrImpl callView =new SPubCallSvrImpl();
		for(int i = 0; i<paraStr.length; i++)
		{
			System.out.println("params = " + paraStr[i]);
		}
		//callView.callService("s1244Print",paraStr, "1", "phone",paraStr[1]);
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="printAccept"/>
<%
%>
<wtc:service name="s1244Print" routerKey="phone" routerValue="<%=paraStr[1]%>" retcode="s1244PrintCode" retmsg="s1244PrintMsg" outnum="1">
    <wtc:param value="<%=paraStr[0]%>"/>
    <wtc:param value="<%=paraStr[1]%>"/>
    <wtc:param value="<%=paraStr[2]%>"/>
    <wtc:param value="<%=paraStr[3]%>"/>
    <wtc:param value="<%=paraStr[4]%>"/>
    <wtc:param value="<%=paraStr[5]%>"/>
</wtc:service>
<wtc:array id="s1244PrintArr" scope="end" />
<%
		String retCode = s1244PrintCode;
		String retMsg  = s1244PrintMsg;	
		System.out.println(" -----------------   in chkPrint: "+retCode+" : "+retMsg);	
		if(!"000000".equals(retCode)){
%>
<SCRIPT type=text/javascript>
	rdShowMessageDialog("返回信息:<%=retCode%>-><%=retMsg%>",2);
	location="<%=dirtPage%>";
</SCRIPT>
<%
	}else{
 %>
<SCRIPT type=text/javascript>
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	
	var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=开始打印发票！";
	var loginAccept = "<%=printAccept%>";
	var path = path + "&infoStr=<%=retInfo%>&loginAccept="+loginAccept+"&opCode=1244&submitCfm=Single";
	var ret=window.showModalDialog(path, "", prop)
	location="<%=dirtPage%>";
function doPrint()
{
  if("<%=retCode%>" == "000000")
  {
  	rdShowMessageDialog("返回信息:<%=retCode%>-><%=retMsg%>",2);
	location="<%=dirtPage%>";
  }
  
  var infoStr="<%=retInfo%>";
  try
  {
     //打印初始化
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var startCol=20;
    var startRow=5;
      
  	    printctrl.Print(startCol-10,startRow,10,0,oneTok(infoStr,"|",1));         //工号 
        printctrl.Print(startCol+42,startRow,10,0,oneTok(infoStr,"|",2));      //年/月/日
        printctrl.Print(startCol-5,startRow+3,10,0,oneTok(infoStr,"|",3));    //用户姓名
        printctrl.Print(startCol+38,startRow+3,10,0,oneTok(infoStr,"|",4));     //卡号
        printctrl.Print(startCol-5,startRow+6,10,0,oneTok(infoStr,"|",5));     //手机号码 
        printctrl.Print(startCol+26,startRow+6,10,0,oneTok(infoStr,"|",6));    //协议号码  
		printctrl.Print(startCol+52,startRow+6,10,0,oneTok(infoStr,"|",7));    //支票

        //大小写金额
		printctrl.Print(startCol+2,startRow+9,10,0,chineseNumber(oneTok(infoStr,"|",8)));
		printctrl.Print(startCol+43,startRow+9,10,0,oneTok(infoStr,"|",8));     

        //业务项目1
	    var busiStr=oneTok(infoStr,"|",9);
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
        printctrl.Print(startCol-5,startRow+12+i*1,9,0,oneTok(busiStr,"*",i+1));  
        //业务项目2
	    var busiStr=oneTok(infoStr,"|",10);
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
        printctrl.Print(startCol+26,startRow+12+i*1,9,0,oneTok(busiStr,"*",i+1));  
        //备注 
		printctrl.Print(startCol-5,startRow+20,10,0,oneTok(infoStr,"|",11)); 
        //开票人姓名 
		printctrl.Print(startCol-12,startRow+23,10,0,oneTok(infoStr,"|",12));  
 
	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	rdShowMessageDialog("打印机故障，无法打印发票！",0);
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
    <!--BODY  onload="doPrint()"-->
    <BODY>
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

<%}%>