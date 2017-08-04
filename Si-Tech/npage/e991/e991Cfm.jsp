<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*"%>
<%@ page import="java.math.*"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Calendar"%>

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

String custPasswd = WtcUtil.repNull(request.getParameter("password"));//用户帐户密码
System.out.println("---------------------------custPasswd---------------------------"+custPasswd);
System.out.println("wxy="+custPasswd);
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
String rtnPage = "/npage/e991/e991_1.jsp";
String password="";
int row_count = 51;
 
 
 
//xl add begin new
String unid_id=request.getParameter("phoneNo");
String cust_id="";
String[] inParas2 = new String[2];
inParas2[0]="select to_char(cust_id) from dgrpcustmsg where unit_id=:unidId";
inParas2[1]="unidId="+unid_id;
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
	
	<%
		if(ret_val==null )
		  {
			  
			   %>
				<script language="javascript">
					rdShowMessageDialog("查询cust_id报错");
					
				</script>
			  <%
		  }
  else
  {			
  	
	 cust_id=ret_val[0][0];
 
     
   
	String id_no="";
	String[] args=new String[4];
	args[0]=cust_id;
	args[1]=beginDate;
	args[2]="e991";
	args[3]=workno;
	//resultTemp1=(String[][])coTemp1.spubqry32("1",tempSQL1).get(0);
 
 
 

	int flag = 0;  //查询结果标签 0：正确 1：出错
%>
<wtc:service name="se991" outnum="11" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=args[0]%>" />
			<wtc:param value="<%=args[1]%>" />	
			<wtc:param value="<%=args[2]%>" />
			<wtc:param value="<%=args[3]%>" />	
	 
		</wtc:service>

	<wtc:array id="cust_name"   start="0"  length="1" scope="end"/>	 
	<wtc:array id="fee_item"  start="1"  length="1" scope="end"/>
	<wtc:array id="should"   start="2"  length="1" scope="end"/>
	<wtc:array id="favour"   start="3"  length="1" scope="end"/>
	<wtc:array id="ss"  start="4"  length="1" scope="end"/>
	<wtc:array id="fee_grade"   start="5"  length="1" scope="end"/>
	<wtc:array id="row_num"   start="6"  length="1" scope="end"/>
	<wtc:array id="total_fee"   start="7"  length="1" scope="end"/>	
	<wtc:array id="manager_name"   start="8"  length="1" scope="end"/>
	<wtc:array id="manager_phone"   start="9"  length="1" scope="end"/> 
	<wtc:array id="show_num"   start="10"  length="1" scope="end"/> 
	<%
 
	errCode=code2;
	errMsg=msg2;
	/*System.out.println("--------------errCode-------------s1351.jsp----------------"+errCode);
	 s_show_num 用这个值判断
	*/
	if(!errCode.equals("000000"))
	{  
		flag=1;
%>
		<script>		
			rdShowMessageDialog('<%=errCode%>:<%=errMsg%>',0);
			document.location.replace('<%=rtnPage%>');
		</script>
<%
    } 
	else
	{
		flag=0;
		int num0=fee_item.length; 
		int show_nums = Integer.parseInt(show_num[0][0]);
		int i_page = show_nums/4+1;
		int i_last = show_nums%4;
		int i_start=0;
		
	    %>
			<script language="javascript">
				//alert("test 产品个数 is "+"<%=show_nums%>"+" and 分页共 "+"<%=i_page%>"+" and 最后一页 "+"<%=i_last%>");		 
			</script>
		<%
		
			 
	 
%>
<HTML>
<HEAD>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<TITLE><%=opName%></TITLE>
<link rel="stylesheet" href="reset.css" media="all" />
<link rel="stylesheet" href="bills1.css" media="all" />
<link rel="stylesheet" href="print-reset.css" media="print" />
<style type="text/css" media=print> 

  

</style>
<%
	if (flag==0){
%>
 
</HEAD>
<BODY class="email" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<!-------------------                  新账单内容开始                    -------------------------->

<%
	if(show_nums<=4)
	{
		%>
		<br><br> 
		<div class="container" id="article">
	   尊敬的<%=cust_name[0][0]%>:<p>
	   贵单位本月费用合计为: <%=total_fee[0][0]%>元;
	 <table width="70%"    >
	<tr>
		<td align="center"><h2><b>中国移动通信集团客户帐单</b></h2></td>
	</tr>
</table>
	 
		<table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
		  <tr>
			<th width="100"><font color="black">集团客户名称：</font></th>
			<td width="250"><%=cust_name[0][0]%> </td>

			<th width="100" align="left"> <font color="black">客户编码：</font> </th>
			<td width="250"> <%=unid_id%> </td>
		  </tr>
		  <tr>
			<th width="100"> <font color="black">计费周期：</font> </th>
			<td width="250"><%=zy%>年 <%=zm%>月 <%=zdf%>日 至<%=zy%>年 <%=zm%>月 <%=zdl%>日  </td>

			<th width="100" align="left"><font color="black">打印日期：</font> </th>
			<td width="250"><%=ny%> 年 <%=nm%> 月 <%=nd%> 日  </td>
		  </tr>	
		  
		  
	</table> 

		   
	   <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
		
		  <tr>
			 <td colspan=1>集团产品</td><td colspan=1>费用项目</td> <td rowspan=2>应收费用</td><td rowspan=2>优惠费用</td><td rowspan=2>实收费用</td>
		  </tr>
		  <tr>
			 <td>名称</td> <td>名称</td>  
		  </tr>
		  <%
			for(int i=0;i<num0;i++)
			{
			  %>
				<%
					if((fee_grade[i][0]=="1")||fee_grade[i][0].equals("1"))
					{
						
						%>
						<tr>
							<td rowspan="<%=Integer.parseInt(row_num[i][0])%>"><%=fee_item[i][0]%>    </td>
							<%
								
								if((fee_grade[i+1][0]=="2")||fee_grade[i+1][0].equals("2"))
								{
									 
									%>
										<td rowspan="<%=Integer.parseInt(row_num[i+1][0])%>"><%=fee_item[i+1][0]%>    </td>
										<td><%=should[i+1][0]%></td>
										<td><%=favour[i+1][0]%></td>
										<td><%=ss[i+1][0]%></td>
									<%  
								} 
							%>
							 
						</tr>
						<%  i=i+1;
						continue;
					}
					if((fee_grade[i][0]=="2")||fee_grade[i][0].equals("2"))
					{
						 %>
						<tr>
							<td  >  <%=fee_item[i][0]%> </td>
								 <td  >  <%=should[i][0]%></td>
								 <td  >  <%=favour[i][0]%></td>
								 <td  >  <%=ss[i][0]%></td> 
						</tr>
						<% //i=i+Integer.parseInt(row_num[i][0]); 
						//i=i+1;
						continue; 
					}
				%>
			  <%
			}  
		  %> 

		  <tr>
			 <td colspan=5><div align="left">费用合计：<%=total_fee[0][0]%>元</div></td> 
		  </tr>
		  
		 <!--end 参数取值--> 
	 </table>
	 <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
		<tr>
			<td colspan=5>客户经理信息</td>
		  </tr>
		  <tr>
			<td width=35%>客户经理姓名</td><td width=35%><%=manager_name[0][0]%></td>
		  </tr>
		  <tr>
			<td width=35%>联系电话</td><td width=35%><%=manager_phone[0][0]%></td>
		  </tr>
	 </table>
	</div>
		<%
	}
	else
	{
		//begin 分页
		 
			%>
			<br><br>
			<div class="container" width=80% id="article">
   尊敬的<%=cust_name[0][0]%>:<p>
   贵单位本月费用合计为: <%=total_fee[0][0]%>元;
<table width="70%"    >
	<tr>
		<td align="center"><h2><b>中国移动通信集团客户帐单</b></h2></td>
	</tr>
</table>
 
 
	<table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01" style="margin-bottom:0;">
      <tr>
        <th width="100"><font color="black">集团客户名称：</font></th>
        <td width="250"><%=cust_name[0][0]%> </td>

		<th width="100" align="left"> <font color="black">客户编码：</font> </th>
        <td width="250"> <%=unid_id%> </td>
      </tr>
      <tr>
        <th width="100"> <font color="black">计费周期： </font></th>
        <td width="250"><%=zy%>年 <%=zm%>月 <%=zdf%>日 至<%=zy%>年 <%=zm%>月 <%=zdl%>日  </td>

		<th width="100" align="left"> <font color="black">打印日期： </font></th>
        <td width="250"><%=ny%> 年 <%=nm%> 月 <%=nd%> 日  </td>
      </tr>	
	  
	  
</table> 

	   
   <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
    
      <tr>
         <td >集团产品</td>  <td >应收费用</td><td  >优惠费用</td><td  >实收费用</td>
	  </tr>
	  
	  <%
		for(int i=0;i<num0;i++)
	    {
		  %>
			<%
				 
				if((fee_grade[i][0]=="1")||fee_grade[i][0].equals("1"))
                {
					 %>
					<tr>
						<td  >  <%=fee_item[i][0]%> </td>
							 <td  >  <%=should[i][0]%></td>
							 <td  >  <%=favour[i][0]%></td>
							 <td  >  <%=ss[i][0]%></td> 
					</tr>
					<% //i=i+Integer.parseInt(row_num[i][0]); 
					//i=i+1;
					continue; 
				}
			%>
		  <%
	    }  
	  %> 

	  <tr>
		 <td colspan=5><div align="left">费用合计：<%=total_fee[0][0]%>元</div></td> 
	  </tr>
	  
	  
 </table>
 <table width="70%" border="0" cellpadding="0" cellspacing="0" class="left table-01">
	<tr>
		<td colspan=5>客户经理信息</td>
	  </tr>
	  <tr>
		<td width=35%>客户经理姓名</td><td width=35%><%=manager_name[0][0]%></td>
	  </tr>
	  <tr>
		<td width=35%>联系电话</td><td width=35%><%=manager_phone[0][0]%></td>
	  </tr>
 </table>
</div>
	 
		 
		<%
		//end 分页
	}	
%>

	
    
  
 
<br><br><br><br>    
 <script language="javascript">
 	function print(){
 			 eval("div0").style.visibility="hidden"; 
 			document.all.wb.ExecWB(6,6);
 			eval("div0").style.visibility="visible";
 		}
 	</script>
   
 

	<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 id=wb name=wb width=0>
</OBJECT>
	<object ID='WebBrowser' style="display:none" WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' VIEWASTEXT></object>
	<object id=factory viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
  codebase="smsx.cab#Version=6,3,436,14">
    </object>
	<div id ="div0">
	<table width="70%">
	<tr >
		<td align="center"><input type="button" name="print"  id="print" class="b_foot" value="打印" onclick="print(); ">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="b_foot" onClick="exportExcel('article')" value="导出EXCEL"> &nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button"  class="b_foot"value="返回" title="返回" onClick="window.location='e991_1.jsp?opCode=e991&opName=集团客户综合账单打印&crmActiveOpCode=e991'" /> &nbsp;&nbsp;&nbsp;&nbsp;
 
		 
	 <input type="button"  class="b_foot"value="关闭" title="关闭" onClick="window.close()" />
		</td>
	</tr>
	 </table>
	</div>
 

 
 

<!-------------------                  新账单内容结束                    -------------------------->

</BODY>
</HTML>
<%}
}

 }%>

<script language="javascript">
function preview(oper){ 
if (oper < 10){ 
  bdhtml = window.document.body.innerHTML;//获取当前页的html代码 
  sprnstr = "<!--startprint"+oper+"-->";//设置打印开始区域 
  eprnstr = "<!--endprint"+oper+"-->";//设置打印结束区域 
  prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html 

  prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html 
  window.document.body.innerHTML=prnhtml; 
  window.print(); 
  //window.document.all.wb.execwb(7,1); 
  //window.document.body.innerHTML=bdhtml; 
} else{ 
window.print(); 
} 
}
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
 myWorksheet.name="NP统计";
 
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
</script>