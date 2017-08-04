<%
/********************
  version v2.0
  开发商: si-tech
  update:diling@2012-06-08
********************/
%>
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
<%
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), "");
  String phoneNo = WtcUtil.repStr(request.getParameter("activePhone"), "");
  String applicationNo = WtcUtil.repStr(request.getParameter("applicationNo"), ""); //申请编号
  System.out.println("----------d877--fd877_printApplicationNo.jsp---applicationNo="+applicationNo);
%>
<HTML>
<HEAD>
    <TITLE></TITLE>
</HEAD>

<SCRIPT type=text/javascript>
window.onload=function()
{
  try
  {
    //打印初始化
  	printctrl.Setup(0);
  	printctrl.StartPrint();
  	printctrl.PageStart();
      
  	printctrl.Print(78,3,7, 0, "<%=applicationNo%>");
   
  	//打印结束
  	printctrl.PageEnd();
  	printctrl.StopPrint();
  }
  catch(e)
  {
 	  rdShowMessageDialog("异常!",0);
  	alert(e.printstacktrace());	
  }
   finally
  {
    window.location = "fd877.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
  }
}
 </SCRIPT>
<!--**************************************************************************************-->
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY >
          
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
