<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:sp业务办理结果查询
   * 日期: 2009/9/30
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = "9898";
	String opName = "sp业务办理结果查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
  	String beginDt = "";
  	String endDt = "";
  	String spType = "";
	String spCode = "";
	
	String  inputParsm [] = new String[9];
	inputParsm[0] = workNo;
	inputParsm[1] = regionCode;
	inputParsm[2] = opCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = beginDt;
	inputParsm[5] = endDt;
	inputParsm[6] = spType;
	inputParsm[7] = spCode;
	inputParsm[8] = "1";
%>	
    <wtc:service name="s9898Qry" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="10">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	<wtc:param value="<%=inputParsm[8]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="2" length="6"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<%
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="JavaScript">
			rdShowMessageDialog("错误信息:<%=tempArr1[0][1]%>");
		</script>
<%
		return;
	}
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--
</script>

<title>sp业务办理结果查询</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>

</head>
<BODY>
	<div id="Operation_Table">
		<table id="tabList" cellspacing=0>			
			<tr>
				<td  align='center' class="blue"><div ><b>手机号码</b></div></td>
				<td  align='center' class="blue"><div ><b>营销案名称</b></div></td>
				<td  align='center' class="blue"><div ><b>增值业务类别</b></div></td>
				<td  align='center' class="blue"><div ><b>操作结果</b></div></td>
				<td  align='center' class="blue"><div ><b>操作时间</b></div></td>
			</tr>
	<%
		for(int i = 0; i < tempArr.length; i++)
		{
	%>
			<tr>
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>
			<tr>
				<td colspan="5" align="center" id="foot">
					<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
				</td>
			</tr>
		</table>
	</div>
</BODY>
</HTML>

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