   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
              
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
//在此处读取session信息

%>

<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String[][] info = (String[][])arr.get(2);//读取登陆IP，角色名称，所在部门（组合）

String phone = ReqUtil.get(request,"phone");//手机号码
String date = ReqUtil.get(request,"date");//日期
String name = ReqUtil.get(request,"name");//姓名
String address = ReqUtil.get(request,"address");//地址
String cardno = ReqUtil.get(request,"cardno");//证件号码
String stream = ReqUtil.get(request,"stream");//流水
String toprintdata = ReqUtil.get(request,"kx_want") + ReqUtil.get(request,"kx_cancle") + ReqUtil.get(request,"kx_running") ;//传入的所有业务操作参数
String sysnote = ReqUtil.get(request,"sysnote");//取得系统日志
String donote = ReqUtil.get(request,"tonote");//取得操作日志
String work_no = ReqUtil.get(request,"work_no");//操作工号

String regionCode = (String)session.getAttribute("regCode");
%>
<%
      if(stream.equals("0"))//判断是否流水等于0 ，如果是0 表示第一次调用打印
		{

%>		
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="stream1" /> 
<%
		  stream = stream1;
		}
%>

<html>
<!---------------------------------引用JS--引用页面风格样式表----------------------------->

<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>

<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>
<script language="javascript">
function ifprint()
{
 printInvoice();
 rdShowMessageDialog('打印成功!',2);
 var end = true;
 var stream = <%=stream%>;
 var theend = "true" + stream;
 //alert(theend);
 window.returnValue=theend;
 window.close();

}

function printInvoice()
{
<%
out.println("try{");
out.println("printctrl.Setup(0)");
out.println("printctrl.StartPrint()");
out.println("printctrl.PageStart()");
out.println("printctrl.Print(18,11,10,0,'"+phone+"')");//手机号码
out.println("printctrl.Print(47,11,10,0,'"+date+"')"); //日期
out.println("printctrl.Print(12,14,10,0,'"+name+"')");//客户姓名
out.println("printctrl.Print(12,17,10,0,'"+address+"')");//联系地址
out.println("printctrl.Print(12,20,10,0,'"+cardno+"')");//证件号码
out.println("printctrl.Print(12,23,10,0,'"+address+"')");//证件地址

/*****************************循环打印业务操作内容************************************/
String retInfo = toprintdata;
		int chPos = 0;
		int row = 51;
		int col = 6;
		chPos = retInfo.indexOf("|"); 
		String valueStr =""; 
	    while(chPos > -1)
	    {
		 valueStr = retInfo.substring(0,chPos);
		 out.println("printctrl.Print('"+col+"','"+row+"',9,0,'"+valueStr+"')" );
		 row = row +1;

			retInfo = retInfo.substring(chPos + 1);
			chPos = retInfo.indexOf("|");
            if( !(chPos > -1)) break;
		}
out.println("printctrl.Print(6,'"+row+"',9,0,'"+sysnote+"')");//系统备注
out.println("printctrl.Print(6,53,9,0,'"+donote+"')");//操作备注
//out.println("printctrl.Print(12,60,10,0,'"+cardno+"')");//身份证号
out.println("printctrl.Print(12,76,10,0,'"+info[0][5]+info[0][6]+info[0][7]+"')");//受理营业厅
out.println("printctrl.Print(12,79,10,0,'"+work_no+"')");//营业员工号
/*******************************************************************************/
out.println("printctrl.PageEnd()");
out.println("printctrl.StopPrint()");
out.println("}catch(e){}finally{return true;}");
//out.println("sdfasdfsa");
%>
	return true;
}
</script>