<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 垃圾信息举报查询
   * 版本: 1.0
   * 日期: 2011-11-8 8:15:06
   * 作者: zhangyan
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String work_no =(String)session.getAttribute("workNo");//工号
String opCode="e410";
String opName="呼叫转移操作日志查询";
String region_code = (String)session.getAttribute("regCode");
String phone_no=		request.getParameter("phone_no");		
String login_no=		request.getParameter("login_no");		
String begin_time=		request.getParameter("begin_time");	
String end_time=		request.getParameter("end_time");	
System.out.println("begin_time========================="+begin_time);
String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=        	opCode;
String iLoginNo=		work_no;       								/*查询工号*/
String iLoginPwd=		(String)session.getAttribute("password");     
String iPhoneNo=		"";										/*标准入参，暂时不用*/    
String iUserPwd=   		"";										/*标准入参，暂时不用*/


String iStartTime=begin_time;/*开始时间 YYYY-MM-DD HH:mi:ss*/
String iEndTime=end_time;/*结束时间 YYYY-MM-DD HH:mi:ss*/
String iShiftPhoneNo=phone_no;/*受理号码*/
String iOpLoginNo=login_no;/*操作工号*/

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 	["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 	["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");
System.out.println("zhangyan add iStartTime =	["+iStartTime+"]");
System.out.println("zhangyan add iEndTime = 	["+iEndTime+"]");
System.out.println("zhangyan add iShiftPhoneNo = 	["+iShiftPhoneNo+"]");
System.out.println("zhangyan add iOpLoginNo = 	["+iOpLoginNo+"]");
%>

<wtc:service name="s1240Qry" routerKey="regionCode" routerValue="<%=region_code%>" 
	retcode="errCode" retmsg="errMsg"  outnum="8">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iStartTime%>"/>
		<wtc:param value="<%=iEndTime%>"/>
		<wtc:param value="<%=iShiftPhoneNo%>"/>
		<wtc:param value="<%=iOpLoginNo%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end" />


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>黑龙江BOSS-业务查询-呼叫转移操作日志查询 </title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">   
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">呼叫转移操作日志查询 
		</div>
	</div>
	<table cellspacing="0" id = "tabList">
	<tr>
		<th class="blue">手机号码</th>
		<th class="blue">操作工号</th>
		<th class="blue">操作时间</th>
		<th class="blue">呼转设置</th>
		<th class="blue">呼转类型</th>
		<th class="blue">呼转号码</th>		
	</tr>
	<%
	for ( int i=0 ; i<resultList.length ; i++ )
	{
		if (resultList[i][4].equals("0"))
		{
			resultList[i][4]="取消";
		}else if (  resultList[i][4].equals("1") )
		{
			resultList[i][4]="申请";
		}else if (  resultList[i][4].equals("2") )
		{
			resultList[i][4]="取消";
		}else if (  resultList[i][4].equals("3") )
		{
			resultList[i][4]="申请";
		}else if (  resultList[i][4].equals("4") )
		{
			resultList[i][4]="取消";
		}else if (  resultList[i][4].equals("5") )
		{
			resultList[i][4]="申请";
		}
		
		if (  resultList[i][5].equals("51") )
		{
			resultList[i][5]="无条件呼转";
		}else if (  resultList[i][5].equals("52") )
		{
			resultList[i][5]="不可及呼转";
		}else if (  resultList[i][5].equals("53") )
		{
			resultList[i][5]="无应答呼转";
		}else if (  resultList[i][5].equals("54") )
		{
			resultList[i][5]="遇忙呼转";
		}
		
		
	%>
		<tr>
			<td ><%=resultList[i][1]%></td>
			<td ><%=resultList[i][3]%></td>			
			<td ><%=resultList[i][0]%></td>			
			<td ><%=resultList[i][4]%></td>	
			<td ><%=resultList[i][5]%></td>
			<td ><%=resultList[i][2]%></td>			
		</tr>		
	
	<%
	}
	%>
	
	<tr>
		<td align=center colspan="6"> 
			<input class="b_foot" name=sure  type=button value="导出"  onClick="printTable(tabList)" >
			<input class="b_foot" name=close onClick="window.close()" type=button value=关闭>
		</td>
	</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>

</form>
</div>
</body>
</html>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
	var excelObj;
	function printTable(obj)
	{
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		total_row = 0;
		if(document.all.tabList.length > 1)	
		{
			excelObj = new ActiveXObject('excel.Application');
			excelObj.Visible = true;
 			excelObj.WorkBooks.Add;
			for(a=0;a<document.all.tabList.length;a++)
			{
				rows=obj[a].rows.length;
				if(rows>0)
				{
	 				try
					{
						for(i=0;i<rows;i++)					{
							cells=obj[a].rows[i].cells.length;
							for(j=0;j<cells;j++)
								excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
						}
					}
					catch(e)
					{
						//alert('生成excel失败!');
					}
				}
				else
				{
					alert('no data');
	 			}
	 			total_row = eval(total_row+rows);
			}
		}
		else
		{
			excelObj = new ActiveXObject('excel.Application');
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			rows=obj.rows.length;
			if(rows>0)
			{
	 			try
				{
					for(i=0;i<rows;i++)
					{
						cells=obj.rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
				total_row = eval(total_row+rows);
			}
			else
			{
				alert('no data');
			}
		}
	}
</script>



