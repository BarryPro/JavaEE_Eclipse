<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-06
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
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/public/publicPrintBillNum.jsp" %>
<HTML>
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1210";
	String nopass = (String)session.getAttribute("password");
	String paraStr[]=new String[37];

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("GBK");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>

<!--**************************************************************************************-->
<body>
<FORM method=post name="spubPrint">

<!------------------------------------------------------>
</FORM>
</body>
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


<script language="javascript">
function ifprint()
{

 doPrint();
 rdShowMessageDialog('打印成功!',2);

 window.returnValue=1;
// window.close();

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
		var startRow=5;
	  var startCol=10;
	  
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
		
		/*liujian 2012-3-26 10:14:00 修改发票 begin */
 		printctrl.PrintEx(20, rowInit,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,oneTok(infoStr,"|",3));
 		printctrl.PrintEx(80, rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "邮电通信业");
		printctrl.PrintEx(100,rowInit, fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "本次发票号码：<%=bill_number%>");
		
		printctrl.PrintEx(13, rowInit + 2,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace, "防伪码：");	//发票防伪码
		
		printctrl.PrintEx(13, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"工    号："+oneTok(infoStr,"|",1));//工号
		printctrl.PrintEx(62, rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"操作流水：");//流水
		printctrl.PrintEx(100,rowInit + 3,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"业务名称：");//业务名称
		
		printctrl.PrintEx(13, rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"客户名称：");//用户名称
		printctrl.PrintEx(100,rowInit + 4,  fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"卡    号：");//卡号
		
		printctrl.PrintEx(13, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"手机号码："+oneTok(infoStr,"|",4));//移动号码
		printctrl.PrintEx(62, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"协议号码：");//协议号码
		printctrl.PrintEx(100, rowInit + 5, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"支票号码：");//支票号码
		
		
		printctrl.PrintEx(13, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"合计金额：(大写)");//合计金额(大写)
		printctrl.PrintEx(100, rowInit + 6, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(小写)￥");//金额(小写)
		
		printctrl.PrintEx(13, rowInit + 7, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"(项目)");//项目
		
		printctrl.PrintEx(20, rowInit + 9, fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"移动信息服务开关受理");//项目
		
		printctrl.PrintEx(13,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"开票：" +　oneTok(infoStr,"|",2)); //操作员
		printctrl.PrintEx(37,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"收款：");//收款员 
		printctrl.PrintEx(60,29,fontType, fontSizeInit,vR, fontStrongInit,lineSpace,"复核：");
		/*liujian 2012-3-26 10:14:00 修改发票 end */
		
		//打印结束
		printctrl.PageEnd();
		printctrl.StopPrint();
		rdShowMessageDialog('打印成功!',2);
 		window.returnValue=1;
  }
  catch(e)
  {
 	rdShowMessageDialog("打印错误!",0);
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}

 </SCRIPT>

   

