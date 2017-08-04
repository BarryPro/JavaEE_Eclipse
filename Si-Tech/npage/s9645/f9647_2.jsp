<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能:注意事项更新查询
   * 日期: 2009/5/21
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = "9647";
	String opName = "注意事项更新查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String typeCode = request.getParameter("typeCode");
  	String beginTime = request.getParameter("beginTime");
  	String endTime = request.getParameter("endTime");
  	String updateType = request.getParameter("updateType");
  	String op_code = request.getParameter("op_code");
	
	
	String  inputParsm [] = new String[4];
	inputParsm[0] = beginTime;
	inputParsm[1] = endTime;
	inputParsm[2] = updateType;
	inputParsm[3] = op_code;
%>	
  <wtc:service name="s9647Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="49">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="0" length="2"  scope="end"/>
	<wtc:array id="tempArr1" start="2" length="13"  scope="end"/>
	<wtc:array id="tempArr2" start="15" length="18"  scope="end"/>
	<wtc:array id="tempArr3" start="33" length="13"  scope="end"/>
<%
	if(!(tempArr[0][0].equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("错误信息:<%=tempArr[0][1]%>");
	 	history.go(-1);
		</script>
<%
		return;
	}
%>
	

<HEAD>
<script language="JavaScript">
<!--
</script>

<title>注意事项更新查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">注意事项更新查询</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>
				<td  align='center' class="blue"><div ><b>操作工号</b></div></td>
				<td  align='center' class="blue"><div ><b>操作时间</b></div></td>
				<td  align='center' class="blue"><div ><b>操作代码</b></div></td>
				<td  align='center' class="blue"><div ><b>操作名称</b></div></td>
				<td  align='center' class="blue"><div ><b>操作人员归属地市</b></div></td>
				<td  align='center' class="blue"><div ><b>操作类型</b></div></td>
				<td  align='center' class="blue"><div ><b>代码名称</b></div></td>
				<td  align='center' class="blue"><div ><b>字段域值</b></div></td>
				<td  align='center' class="blue"><div ><b>修改前的发布区域</b></div></td>
				<td  align='center' class="blue"><div ><b>修改后的发布区域</b></div></td>
				<td  align='center' class="blue"><div ><b>修改前的注意事项内容</b></div></td>
				<td  align='center' class="blue"><div ><b>修改后的注意事项内容</b></div></td>
				<td  align='center' class="blue"><div ><b>修改前渠道标识</b></div></td>
				<td  align='center' class="blue"><div ><b>修改后渠道标识</b></div></td>
				<td  align='center' class="blue"><div ><b>修改前的注意事项生效时间</b></div></td>
				<td  align='center' class="blue"><div ><b>修改后的注意事项生效时间</b></div></td>
				<td  align='center' class="blue"><div ><b>修改前的注意事项到期时间</b></div></td>
				<td  align='center' class="blue"><div ><b>修改后的注意事项到期时间</b></div></td>
			</tr>
	<%
		
			for(int i = 0; i < tempArr1.length; i++)
			{
	%>
				<tr>
					<td  align='center'><%=tempArr1[i][0].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][1].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][2].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][3].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][4].trim()%>&nbsp;</td>		
					<td  align='center'>新增&nbsp;</td>
					<td  align='center'><%=tempArr1[i][6].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][7].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][8].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][9].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][10].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][11].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr1[i][12].trim()%>&nbsp;</td>
				</tr>
	<%
			}
			for(int i2 = 0; i2 < tempArr2.length; i2++)
			{
	%>
				<tr>
					<td  align='center'><%=tempArr2[i2][0].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][1].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][2].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][3].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][4].trim()%>&nbsp;</td>		
					<td  align='center'>修改&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][6].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][7].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][8].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][9].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][10].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][11].trim()%>&nbsp;</td>
	<%
				if(tempArr2[i2][12].equals("01"))
				{
	%>
					<td  align='center'>营业前台&nbsp;</td>
	<%
				}else if(tempArr2[i2][12].equals("02"))
				{
	%>
					<td  align='center'>网站&nbsp;</td>
	<%
				}else{
	%>
					<td  align='center'>&nbsp;</td>
	<%
				}
				if(tempArr2[i2][13].equals("01"))
				{
	%>
					<td  align='center'>营业前台&nbsp;</td>
	<%
				}else if(tempArr2[i2][13].equals("02"))
				{
	%>
					<td  align='center'>网站&nbsp;</td>
	<%
				}else{
	%>
					<td  align='center'>&nbsp;</td>
	<%
				}
	%>
					<td  align='center'><%=tempArr2[i2][14].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][15].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][16].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr2[i2][17].trim()%>&nbsp;</td>
				</tr>
	<%
			}
		
			for(int i3 = 0; i3 < tempArr3.length; i3++)
			{
	%>
				<tr>
					<td  align='center'><%=tempArr3[i3][0].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][1].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][2].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][3].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][4].trim()%>&nbsp;</td>
					<td  align='center'>删除&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][6].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][7].trim()%>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][8].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][9].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][10].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][11].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
					<td  align='center'><%=tempArr3[i3][12].trim()%>&nbsp;</td>
					<td  align='center'>&nbsp;</td>
				</tr>
	<%
			}
	
	%>
		</table>
		<table>
			<tr>
				<td>
				<div align="center">
				<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
				&nbsp; 
				<input class="b_foot" name="goback"  onClick="history.go(-1)" type=button value="返回">
				</div>
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</BODY>
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
/*
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add; 

	for(j=0;j<16;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	<%
	if(updateType.equals("A"))
	{
	for(int i = 0; i < tempArr1.length; i++)
	{
	%>
		try
		{
			
			<%	
			for(int j = 0; j < 11; j++)
			{
			%>
				
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=tempArr1[i][j].trim().replace('\r',' ').replace('\n',' ')%>";
			<%	
			}
			%>
		}
		catch(e)
		{
			alert('生成excel失败!');
		}
	<%	
	}
	}else if(updateType.equals("U"))
	{
	for(int i = 0; i < tempArr2.length; i++)
	{
	%>
		try
		{
			
			<%	
			for(int j = 0; j < 16; j++)
			{
			%>
				
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=tempArr2[i][j].trim().replace('\r',' ').replace('\n',' ')%>";
			<%	
			}
			%>
		}
		catch(e)
		{
			alert('生成excel失败!');
		}
	<%	
	}
	}
	else if(updateType.equals("D"))
	{
	for(int i = 0; i < tempArr3.length; i++)
	{
	%>
		try
		{
			
			<%	
			for(int j = 0; j < 11; j++)
			{
			%>
				
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=tempArr3[i][j].trim().replace('\r',' ').replace('\n',' ')%>";
			<%	
			}
			%>
		}
		catch(e)
		{
			alert('生成excel失败!');
		}
	<%	
	}
	}
	%>
}*/

</script>
