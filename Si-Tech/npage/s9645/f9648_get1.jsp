<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 注意事项库查询-根据界面查询信息
　 * 版本: 
　 * 日期: 2009-05-26
　 * 作者: dujl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**需要清楚缓存.如果是新页面,可删除**/
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 

String opCode = "9648";
String opName = "注意事项库查询";

/**需要regionCode来做服务的路由**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

 
String op_code = WtcUtil.repNull(request.getParameter("op_code1"));
String op_time_begin = WtcUtil.repNull(request.getParameter("op_time_begin1"));
String op_time_end = WtcUtil.repNull(request.getParameter("op_time_end1"));
String region_code = WtcUtil.repNull(request.getParameter("region_code1"));

%>
<wtc:service  name="s9648Qry"  routerKey="region"  routerValue="<%=regionCode%>" outnum="14">
	<wtc:param  value="1"/>
	<wtc:param  value="<%=op_code%>"/>
	<wtc:param  value="<%=region_code%>"/>
	<wtc:param  value="<%=op_time_begin%>"/>
	<wtc:param  value="<%=op_time_end%>"/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>
	<wtc:param  value=""/>	     		
</wtc:service>
<wtc:array  id="sVerifyTypeArr1" start="0" length="2"  scope="end"/>
<wtc:array  id="sVerifyTypeArr" start="2" length="11"  scope="end"/>
<%	
System.out.println("retCode===="+retCode);
System.out.println("retMsg===="+retMsg);
System.out.println("sVerifyTypeArr.length=" + sVerifyTypeArr.length);
%>

<html>
<head>
<title><%=opName%></title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">
<!--

//-->
</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0" id="tabList" vColorTr='set'>
			<tr align="center">
				<th nowrap>界面代码</th>
				<th nowrap>界面名称</th>
				<th nowrap>适用渠道</th> 
				<th nowrap>注意事项内容</th>
				<th nowrap>提醒方式</th>
				<th nowrap>打印选择</th>
				<th nowrap>生效时间</th>
				<th nowrap>失效时间</th>
				<th nowrap>配置单位</th>
				<th nowrap>操作人</th>
				<th nowrap>操作工号</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
				
			}else if(sVerifyTypeArr.length>0)
			{
				for(int i=0;i<sVerifyTypeArr.length;i++)
				{
	%>
					<tr align="center">
						<td ><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][10]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][9]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						<td ><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
 		<table>
			<tr>
				<td>
					<div align="center">
					<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
					</div>
				</td>
			</tr>
		</table>
  	</div>
  	
</body>
</html>    

<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
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
