<%
/********************
 version v2.0
开发商: si-tech
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
<%@ page contentType="text/html;charset=GBK"%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1984";
	String nopass = (String)session.getAttribute("password");
	String paraStr[]=new String[37];
	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;


	request.setCharacterEncoding("gbk");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
 %>

<!--**************************************************************************************-->
<body onload = "ifprint();">
<FORM method=post name="spubPrint">

<!------------------------------------------------------>
</FORM>
</body>
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
	// printctrl.Print(startCol+35,startRow+0,12,1,"操作时间：oneTok(infoStr,"|",3)年");//年
	// printctrl.Print(startCol+52,startRow+0,12,5,"oneTok(infoStr,"|",4)");//月
	// printctrl.Print(startCol+57,startRow+0,12,7,"oneTok(infoStr,"|",5)");//日
	
	// printctrl.Print(startCol+35,startRow+9,12,9,"手机号码：oneTok(infoStr,"|",4)");//移动号码
	// printctrl.Print(startCol+35,startRow+11,12,11,"移动信息服务开关受理"); 
	// printctrl.Print(startCol+35,startRow+43,12,13,"受理工号：oneTok(infoStr,"|",1)");//受理工号
	
	printctrl.Print(13,5,9,0,oneTok(infoStr,"|",1));  //工号
	printctrl.Print(20,5,9,0,oneTok(infoStr,"|",2));  //操作员
	//printctrl.Print(30,5,9,0,oneTok(infoStr,"|",3));//年
	//printctrl.Print(40,5,9,0,oneTok(infoStr,"|",4));//月
	//printctrl.Print(50,5,9,0,oneTok(infoStr,"|",5));//日
	printctrl.Print(60,5,9,0,oneTok(infoStr,"|",3));  //操作日期	
	printctrl.Print(20,10,18,0,oneTok(infoStr,"|",4));//协议号码
	printctrl.Print(60,10,18,0,"移动信息服务开关受理");//协议号码

         
 
	//打印结束
	printctrl.PageEnd();
	printctrl.StopPrint();
	

	
  }
  catch(e)
  {
 	rdShowMessageDialog("打印错误!",0);
  }
  finally
  {
  	 removeCurrentTab();
     //location="<%=dirtPage%>";
  }
}

 </SCRIPT>

   

