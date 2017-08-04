<%
  /*
   * 功能:宽带订单状态信息查询-查询结果页面
   * 版本: 1.0
   * 日期: 20121015
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**
 * 服务名:sQryKdState
 * input : 
 *			0 业务流水			iLoginAccept
 *			1 渠道标识			iChnSource
 *			2 操作代码			iOpCode
 *			3 工号					iLoginNo
 *			4 工号密码			iLoginPwd
 *			5 号码					iPhoneNo
 *			6 号码密码			iUserPwd
 *			7 组织机构代码	iGroupId
 *			8 宽带账号			sKdUser
 *			9 异常单				sErrFlag (标识仅查询异常订单，1为查询异常单，0为全部)
 *		 10 开始时间			iStartTime
 *     11 结束时间			iEndTime

*/

	/*===========获取参数============*/
	String regionCode = (String)session.getAttribute("regCode");
  String  iLoginAccept = (String)request.getParameter("iLoginAccept");  
  String  iChnSource = (String)request.getParameter("iChnSource");  
  String  opCode = (String)request.getParameter("iOpCode");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iLoginPwd = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iUserPwd = (String)request.getParameter("iUserPwd");		
  String  opName = 	(String)request.getParameter("iOpName");     
  String  iGroupId =   (String)request.getParameter("iGroupId");     
  String  sKdUser =   (String)request.getParameter("iSKdUser"); 
  String  sErrFlag =   (String)request.getParameter("sErrFlag"); 
  String  iStartTime =   (String)request.getParameter("iStartTime"); 
  String  iEndTime =   (String)request.getParameter("iEndTime"); 
%>
<wtc:service name="sQryKdState" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="9">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iGroupId%>" />
		<wtc:param value="<%=sKdUser%>" />
		<wtc:param value="<%=sErrFlag%>" />
		<wtc:param value="<%=iStartTime%>" />
		<wtc:param value="<%=iEndTime%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
	</script>
	</head>
	
<%
		if("000000".equals(errCode)){
			System.out.println("============ fg215Qry.jsp ==========" + result1.length);
			
		}else{
%>
			<script language="javascript">
	      rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
	      window.location = '/npage/sg215/fg215Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	   	</script>
<%
		}
%>	
<body>
	<form action="" method="post" name="form_g215">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0" name="t1" id="t1">
		<tr>
			<th>宽带账号</th>
			<th>订单编号</th>
			<th>订单类型</th>
			<th>订单创建时间</th>
			<th>CRM系统订单状态</th>
			<th>当前所在系统</th>
			<th>当前状态</th>
			<th>异常标识</th>
			<th>异常原因</th>
		</tr>
		<%
				int nowPage = 1;
				int allPage = 0;
				if(result1.length==0){
					out.println("<tr height='25' align='center'><td colspan='15'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(result1.length>0){
					String tbclass = "";
					String styleCol = "";
					for(int i=0;i<result1.length;i++){
							tbclass = (i%2==0)?"Grey":"";
							if("1".equals(result1[i][7]))
							{
								styleCol="red";
							}
						else if("0".equals(result1[i][7]))
							{
								styleCol="";
							}
							String tempStr = "";
		%>
		<tr id="row_<%=i%>">
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][0]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][1]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][2]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][3]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][4]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][5]%></td>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][6]%></td>
			
			<%
					if("0".equals(result1[i][7].trim()))
					{
			%>
				<td class="<%=tbclass%>" style="color:<%=styleCol%>">正常</td>
			<%
					}
				else if("1".equals(result1[i][7].trim())){
			%>
				<td class="<%=tbclass%>" style="color:<%=styleCol%>">异常</td>
			<%
					}
			%>
			<td class="<%=tbclass%>" style="color:<%=styleCol%>"><%=result1[i][8]%>&nbsp;</td>
		</tr>
		<%
				}
				allPage = (result1.length - 1) / 10 + 1 ;
				}
		%>
		
	</table>
	<table align="center">
				<tr>
					<td align="center">
						总记录数：<font name="totalPertain" id="totalPertain"><%=result1.length%></font>&nbsp;&nbsp;
						总页数：<font name="totalPage" id="totalPage"><%=allPage%></font>&nbsp;&nbsp;
						当前页：<font name="currentPage" id="currentPage">1</font>&nbsp;&nbsp;
						每页行数：10
						<a href="javascript:setPage('1');">[第一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('-1');">[上一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('+1');">[下一页]</a>&nbsp;&nbsp;
						<a href="javascript:setPage('<%=allPage%>');">[最后一页]</a>&nbsp;&nbsp;
						跳转到
						<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
							<%
							for (int i = 1; i <= allPage; i ++) {
							%>
								<option value="<%=i%>">第<%=i%>页</option>
							<%
							}
							%>
						</select>
						页
					</td>
				</tr>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<!--
			<input type="button" class="b_foot" value="查询" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			-->
			<input type="button" class="b_foot"  value="返回" onclick="javascript:window.location.href='/npage/sg215/fg215Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>'"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot"  value="导出" onclick="printTable(t1);"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="nowPage" />
	<input type="hidden" id="allPage" value="<%= allPage %>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<script language="javascript">
	$(document).ready(function(){
		var nowp = "<%= nowPage %>";
		$("#nowPage").val(nowp);
		setPage(nowp);
	});
	function setPage(goPage){
		if (goPage == "-1") {
			setPage(parseInt($("#nowPage").val()) - 1);
			return;
		} else if (goPage.length == 2 && "+1" == goPage) {
			setPage(parseInt($("#nowPage").val()) + 1);
			return;
		}else{ 
			goPage = parseInt(goPage);
			if(goPage < 1){
				return false;
			}else if(goPage > $("#allPage").val()){
				return false;
			}else{
				pageNo = parseInt(goPage);
				//所有行隐藏
				$("[id^='row_']").hide();
				//显示行
				var startRow = (pageNo - 1) * 10;
				var endRow = pageNo * 10 - 1;
				for(var i = startRow; i <= endRow; i++ ){
					var pageStr = "#row_" + i;
					$(pageStr).show();
				}
				$("#nowPage").val(pageNo);
				$("#currentPage").text(pageNo);
			}
		}
	}
</script>

<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
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
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =20;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =20;//设置列宽 
  sheet.Columns("C").ColumnWidth =15;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =20;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =20;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =20;//设置列宽 
  sheet.Columns("G").ColumnWidth =20;//设置列宽 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

</script>

</html>
