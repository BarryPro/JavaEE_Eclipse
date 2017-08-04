<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%> 
 

<%
 String opCode = "e610";
  String opName = "统一账单打印"; 
String workno = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");

System.out.println("---------------------------s1351Cfm.jsp---------------------------");
DecimalFormat df = new DecimalFormat("#0.00");
String sm_code = new String();
String printway=request.getParameter("printway");//打印方式
String phoneNo = request.getParameter("phoneNo");
System.out.println("phoneNo="+phoneNo);
String contract_no = request.getParameter("contract_no");
System.out.println("contract_no="+contract_no);
String contract_no_sign = contract_no;
String beginDate= request.getParameter("beginDate");
/*
String custPasswd = WtcUtil.repNull(request.getParameter("password"));//用户帐户密码
System.out.println("---------------------------custPasswd---------------------------"+custPasswd);
System.out.println("wxy="+custPasswd);*/
	String custPass = request.getParameter("password");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAaa custPass is "+custPass);
	custPass = Encrypt.encrypt(custPass);
	System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbb custPass is "+custPass);  
String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String ny = dateStr.substring(0,4);
String nm = dateStr.substring(4,6);
String nd = dateStr.substring(6,8);
Calendar cd = Calendar.getInstance();
Calendar cr = Calendar.getInstance();
cr.setTime(new Date());
String crd = cr.get(cr.DATE) < 10 ? "0" + cr.get(cr.DATE) : "" + cr.get(cr.DATE);
String zy = beginDate.substring(0,4);
String zm = beginDate.substring(4,6);
cd.clear();
cd.set(cd.YEAR,Integer.parseInt(zy));
cd.set(cd.MONTH,Integer.parseInt(zm)-1);
String zdf = cd.getActualMinimum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMinimum(cd.DAY_OF_MONTH) : "" + cd.getActualMinimum(cd.DAY_OF_MONTH);
String zdl = cd.getActualMaximum(cd.DAY_OF_MONTH) < 10 ? "0" + cd.getActualMaximum(cd.DAY_OF_MONTH) : "" + cd.getActualMaximum(cd.DAY_OF_MONTH);
String errCode="";
String sql="";
String errMsg="";
String rtnPage = "/npage/zg15/zg15_1.jsp";
String password="";
int row_count = 51;
int num=0;
 
 
//System.out.println("phoneNo="+phoneNo);
 
 
String[] args=new String[4];
args[0]=phoneNo;
args[1]=contract_no;
args[2]=beginDate;
args[3]=workno; 

String ll_code="";
String ll_msg="";
String s_ll="";
String s_lled="";
String s_llshow="";


	int flag = 0;  //查询结果标签 0：正确 1：出错
%>

<%
 //xl add 流量账单
%>
 <wtc:service name="sGprsSelect" outnum="12" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args[0]%>" />
			<wtc:param value="<%=args[2]%>" />
 </wtc:service>
<wtc:array id="swfzyys" scope="end" start="0"  length="1" />	
<wtc:array id="swfzyss" scope="end" start="1"  length="1" />	 
<wtc:array id="tcmc" scope="end" start="2"  length="1" />
<wtc:array id="tcyzf" scope="end" start="3"  length="1" />
<wtc:array id="tcyyh" scope="end" start="4"  length="1" />
<wtc:array id="tcyyhed" scope="end" start="5"  length="1" />
<wtc:array id="per" scope="end" start="6"  length="1" />
<wtc:array id="tcdw" scope="end" start="7"  length="1" />
<wtc:array id="ifshare" scope="end" start="8"  length="1" />
<wtc:array id="tcwll" scope="end" start="9"  length="1" />
<wtc:array id="tcwsc" scope="end" start="10"  length="1" />	
<wtc:array id="tcwfy" scope="end" start="11"  length="1" />	
 


 
  
	 
 
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=opName%></TITLE>
<link rel="stylesheet" href="../e610/reset.css" media="all" />
<link rel="stylesheet" href="../e610/bills1.css" media="all" />
<link rel="stylesheet" href="../e610/print-reset.css" media="print" />
<%
	if (flag==0){
%>
 
</HEAD>
<BODY class="email" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<!-------------------                  新账单内容开始                   <div id="article"> -------------------------->

<div  id="article">
 
 
	

	   
    
 

 <table width="94%" align="center">
    <div align="center"><h2><b>中国移动通信客户流量账单</b></h2></div>
	
	 

	<table width="94%" border="0" cellpadding="0" cellspacing="0" class="left table-01" >
		<tr>
			<td>上网总费用</td>
			<td>应收 <%=swfzyys[0][0]%></td>
			<td>实收 <%=swfzyss[0][0]%></td>
		</tr>
		<tr>
			<td colspan="3">上网套餐</td>
		</tr>
		<%
			for(int i =0;i<tcmc.length;i++)
			{
				%>
					<tr>
						<td> </td>
						<td><%=tcmc[i][0]%></td>
						<td><%=tcyzf[i][0]%></td>
					</tr>
				<%
			}
		%>
		
		<tr>
			<td colspan="3">套餐外流量费</td>
			 
		</tr>
		<tr>
			<td> </td>
			<td>套餐外流量费</td>
			<td><%=tcwfy[0][0]%></td>
		</tr>
	</table>

	<table width="94%" border="0" cellpadding="0" cellspacing="0" class="left table-01" >
		<tr>
			<td colspan="4">使用明细</td>
	 
		</tr>
		<tr>
			<td>套餐使用明细</td>
			<td>总流量(时长)</td>
			<td>实际使用</td>
			<td>使用百分比</td>
		</tr>
		<%
			for(int i=0;i<tcyyh.length;i++)
			{
				if(tcdw[i][0]=="1" ||tcdw[i][0].equals("1"))
				{
					s_ll=tcyyh[i][0]+"M";
					s_lled=tcyyhed[i][0]+"M";
				}
				else
				{
					s_ll=tcyyh[i][0]+"分钟";
					s_lled=tcyyhed[i][0]+"分钟";
				}
				
				if(ifshare[i][0]=="1" ||ifshare[i][0].equals("1"))
				{
					s_llshow ="" ;
				}
				%>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=tcmc[i][0]%></td>
						<td><%=s_ll%></td>
						<td><%=s_lled%></td>
						<td><%=per[i][0]%></td>
					</tr>
				<%
			}
		%>
		<tr>
			<td>套餐外流量</td>
			<td colspan=3>总流量(时长)</td>
		 
		</tr>
		<%
			if(Float.parseFloat(tcwll[0][0])>0)
			{
				%>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;套餐外数据流量</td>
					<td colspan=3><%=tcwll[0][0]%>M</td><!-- tcwll tcwsc -->
				 
				</tr>
				<%
			}
		%>
		
		<%
			if(Integer.parseInt(tcwsc[0][0])>0)
			{
				%>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;套餐外WLAN</td>
					<td colspan=3><%=tcwsc[0][0]%>分钟</td><!-- tcwll tcwsc -->
				 
				</tr>
				<%
			}
		%>
		
	</table>
 </table> 	

 <table align="center">
<div align="center">
	<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" width="0" height="0" id="wb" name="wb"></OBJECT> 
	<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
	<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
  codebase="smsx.cab#Version=6,3,436,14">
    </object>
 
	<input type="button" name="print"  class="b_foot" value="打印" onclick="javascript:window.print();" align="center">
	<!--
	<input type="button" onClick="exportExcel('article')" value="导出EXCEL">	 
	<input type="button" value="打印设置" class="b_foot" title="打印设置" onClick="document.all.wb.ExecWB(8,1)"/>
	<input type="button" value="打印预览" class="b_foot" title="打印预览" onClick="PageSetup_Null();document.all.wb.ExecWB(7,1)"/>
    -->
	 &nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button"  name="back"  class="b_foot" value="返回" onClick="location='zg15_1.jsp?activePhone=<%=phoneNo%>'">
	 &nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button"  class="b_foot"value="关闭" title="关闭" onClick="window.close()" align="center"/>
</div>

	</table>

	 
 
		 
	</div>
</div>

 

<!-------------------                  新账单内容结束                    -------------------------->

</BODY>
</HTML>
<%}
 %>


<script language="javascript">
function exportExcel(DivID){
 //先声明Excel插件、Excel工作簿等对像
 var jXls, myWorkbook, myWorksheet;
 
 try {
  //插件初始化失败时作出提示
  jXls = new ActiveXObject('Excel.Application');
 }catch (e) {
	return false;
 }
 
 //不显示警告 
 jXls.DisplayAlerts = false;
 
 //创建AX对象excel
 myWorkbook = jXls.Workbooks.Add();
 //myWorkbook.Worksheets(3).Delete();//删除第3个标签页(可不做)
 //myWorkbook.Worksheets(2).Delete();//删除第2个标签页(可不做)
 
 //获取DOM对像
 var curTb = document.getElementById(DivID);
 
 //获取当前活动的工作薄(即第一个)
 myWorksheet = myWorkbook.ActiveSheet; 
 
 //设置工作薄名称
 myWorksheet.name="新版账单打印";
 
 //获取BODY文本范围
 var sel = document.body.createTextRange();
 
 //将文本范围移动至DIV处
 sel.moveToElementText(curTb);
 
 //选中Range
 sel.select();
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 
 //将文本范围的内容拷贝至剪贴板
 sel.execCommand("Copy");
 
 //将内容粘贴至工作簿
 myWorksheet.Paste();
 
 //打开工作簿
 jXls.Visible = true;
 
 //清空剪贴板
 window.clipboardData.setData('text','');
 jXls = null;//释放对像
 myWorkbook = null;//释放对像
 myWorksheet = null;//释放对像
}
</script>