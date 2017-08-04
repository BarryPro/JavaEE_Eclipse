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
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = (String)session.getAttribute("workNo");
	System.out.println("111111111111111信息录入开始~~~~~~~~~~~~~~~~~···"+work_no);
   /* String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1210";
	  记录发票补打操作日志（doucm）*/
	request.setCharacterEncoding("GBK");
	String s_Invoice_number=request.getParameter("s_Invoice_number");
	String e_Invoice_number=request.getParameter("e_Invoice_number");
	String Invoice_code=request.getParameter("Invoice_code");
  String result[][] = new String[][]{};
    
	
	%>
<wtc:service name="sInvoiceInDB" routerKey="phone" routerValue="15004678912" retmsg="retMsg" retcode="retCode1"  outnum="2" >
	<wtc:param value="<%=s_Invoice_number%>"/>
	<wtc:param value="<%=e_Invoice_number%>"/>
	<wtc:param value="<%=Invoice_code%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="9493"/>
	<wtc:param value="O"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	result = sVerifyTypeArr;
	if(result!=null&&result.length>0){
		//if(result[0][0].length()>0){
		 
		  if(result[0][0].length()>0)
	  {
		  if(result[0][0]=="000000" ||result[0][0].equals("000000"))
		  {
			  %>
			<script language="javascript">
			rdShowMessageDialog("发票信息录入成功");
			window.location.href="s9493_4.jsp";
			</script>
			<%	
		  }
		  else{
	%>
			<script language="javascript">
			rdShowMessageDialog("发票信息录入失败!错误原因："+"<%=retMsg%>"+";错误代码："+"<%=retCode1%>");
			window.location.href="s9493_4.jsp";
			</script>
			<%
	}	
	
			
		}
	}
	
%>
	 
<SCRIPT type=text/javascript>

function doPrint()
{
  alert("hello!!");
 
  
  
  
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
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY  ><!--onload="doPrint()"-->
          
    </BODY>
</FORM>


</HTML>    
