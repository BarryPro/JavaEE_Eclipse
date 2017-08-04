<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 网站预约办理查询
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
String opCode="e407";
String opName="网站预约办理查询";
String region_code = (String)session.getAttribute("regCode");
String phone_no=		request.getParameter("phone_no");		
String booking_id=		request.getParameter("booking_id");	

/*服务信息*/
String serviceName = "sE385Qry";
String sevRouteValue = region_code;
String outnum = "7";

/*标准入参*/
String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=      	opCode;
String iLoginNo=		work_no;       								/*查询工号*/
String iLoginPwd=		"";     
String iPhoneNo=		phone_no;										/*标准入参，暂时不用*/    
String iUserPwd=   		"";										/*标准入参，暂时不用*/

String inOpNote=		"";								/*开始时间 YYYY-MM-DD HH:mi:ss*/
String iIdIccid=		"";
String inLoginAccept=	booking_id;

System.out.println("zhangyan add iLoginAccept= 	["+iLoginAccept+"]");
System.out.println("zhangyan add iChnSource = 	["+iChnSource+"]");
System.out.println("zhangyan add iOpCode = 		["+iOpCode+"]");
System.out.println("zhangyan add iLoginNo = 	["+iLoginNo+"]");
System.out.println("zhangyan add iLoginPwd = 	["+iLoginPwd+"]");
System.out.println("zhangyan add iPhoneNo = 	["+iPhoneNo+"]");
System.out.println("zhangyan add iUserPwd = 	["+iUserPwd+"]");

System.out.println("zhangyan add inOpNote = 	["+inOpNote+"]");
System.out.println("zhangyan add iIdIccid = 	["+iIdIccid+"]");
System.out.println("zhangyan add inLoginAccept=	["+inLoginAccept+"]");
%>

<wtc:service name="sE385QryAll" routerKey="regionCode" routerValue="<%=region_code%>" 
	retcode="retcode" retmsg="retmsg"  outnum="9">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>	
			
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=inLoginAccept%>"/>				
</wtc:service>
<wtc:array id="resultList" scope="end" />

<%
	System.out.println("zhangyan add resultList.length =["+resultList.length+"]");
	for ( int i=0; i< resultList.length ; i++)
	{
		System.out.println("zhangyan add resultList[i][5]=["+resultList[i][5]+"]");
	}
	

	if (!"000000".equals(retcode)  )
	{
		System.out.println("zhangyan add retcode = 	["+retcode+"]");
		%>
			<script>
			rdShowMessageDialog(retcode+":"+retmsg , 0);
			history.go(-1);
			</script>
		<%
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>黑龙江BOSS-业务查询-网站预约办理查询</title>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script>

</script>
</head>
<body>
<div id="divBody">
<form action="" method=post name="form1">  
	<DIV id="Operation_Table">   
		<div class="title">
			<div id="title_zi">网站预约办理查询
		</div>
	</div>

	<table cellspacing="0" id = "tabList">
	<tr>
		<th class="blue">业务名称</th>
		<th class="blue">预约ID</th>
		<th class="blue">手机号码</th>
		<th class="blue">证件号码</th>
		<th class="blue">营业厅名称</th>
		<th class="blue">是否有效</th>	
		<th class="blue">查看明细</th>	
	</tr>
	<%
		for ( int i = 0 ; i < resultList.length ; i ++  )
		{
		%>
		<tr>
			<td ><%=resultList[i][6]%></td>
			<td ><%=resultList[i][1]%></td>
			<td ><%=resultList[i][2]%></td>
			<td ><%=resultList[i][4]%></td>
			<td ><%=resultList[i][8]%></td>
			<td ><%=resultList[i][7]%></td>
			<td >
				<input type="button" class="b_text" 
					name="getDetail" id="getDetail" value=" 查 询 "
					onClick="showDetail('<%=resultList[i][1]%>' , '<%=resultList[i][0]%>');">

			</td>
		</tr>	
		<%
		}
	%>

	<tr>
		<td align=center colspan="8"> 
			<input class="b_foot" name=sure  type=button value="导出"  onClick="printTable(tabList)" >
			<input class="b_foot" name=close onClick="iframeClose()" type=button value=关闭>
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
	function iframeClose()
	{
		var 	divBody = document.getElementById("divBody");
		divBody.style.display="none"
	}
	
	
	function showDetail(bookingId , bookingOpCode)
	{
		var bookingInfo = new Object();
		bookingInfo.id = bookingId;
        window.showModalDialog("fe407_3.jsp?rnd="+Math.random()
        	+"&bookingId="+bookingId
        	+"&bookingOpCode="+bookingOpCode,bookingInfo,
        	"dialogWidth=600px;dialogHeight=400px");
	}
	
	var excelObj;
	function printTable(obj)
	{
		
		var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		total_row = 0;
		if(document.all.tabList.length > 1)	/*多个table*/
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
						cells=obj.rows[i].cells.length-1 	;
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



