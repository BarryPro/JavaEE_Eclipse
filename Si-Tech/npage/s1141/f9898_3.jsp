<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:sp业务办理结果查询
   * 日期: 2009/10/02
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
 
	String opCode = "9898";
	String opName = "sp业务办理结果查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String phoneNo = "";
  	String beginDt = request.getParameter("beginDt");
  	String endDt = request.getParameter("endDt");
  	String spType = request.getParameter("spType");
	String spCode = request.getParameter("spCode");
	
	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	String  inputParsm [] = new String[9];
	inputParsm[0] = workNo;
	inputParsm[1] = regionCode;
	inputParsm[2] = opCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = beginDt;
	inputParsm[5] = endDt;
	inputParsm[6] = spType;
	inputParsm[7] = spCode;
	inputParsm[8] = "2";
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
	<wtc:array id="tempArr" start="2" length="7"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<%
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="JavaScript">
			rdShowMessageDialog("错误信息:<%=tempArr1[0][1]%>");
			
			location="f7471_1.jsp";
		</script>
<%
		
	}
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">

function goBack()
{
	location="f7471_1.jsp";
}

<!--
</script>

<title>sp业务办理结果查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">sp业务办理结果查询</div>
	</div>
	<table cellspacing=0>
		<tr>
				<td class="blue" nowrap>开始时间</td>
				<td>
		    		<input name="beginDt" type="text" class="InputGrey" id="beginDt" size="25" value="<%=beginDt%>" readonly>
		    	</td>
		    	<td class="blue" nowrap>结束时间</td>
		    	<td>
		    		<input name="endDt" type="text" class="InputGrey" id="endDt" size="25" value="<%=endDt%>" readonly>
		    	</td>
			</tr>	
	</table>
		<table id="tabList" cellspacing=0>
			<tr>
				<td  align='center' class="blue"><div ><b>手机号码</b></div></td>
				<td  align='center' class="blue"><div ><b>营销案名称</b></div></td>
				<td  align='center' class="blue"><div ><b>增值业务类别</b></div></td>
				<td  align='center' class="blue"><div ><b>操作结果</b></div></td>
				<td  align='center' class="blue"><div ><b>操作时间</b></div></td>
			</tr>
			
			<%
	if(tempArr.length<=10){
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
		}else if(tempArr.length-iStartPos<10){
		
		for(int i = iStartPos; i < tempArr.length; i++)
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
	}else{
		for(int i = iStartPos; i < iStartPos+iPageSize; i++)
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
		}
	%>

			<tr>
				<td colspan="7">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
					    //实现分页
					    int iQuantity = tempArr.length;
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg);
					   	view.setVisible(true,true,0,0);
	%>
					</div>
				</td>				
			</tr>
			<tr>
				<td colspan="7" align="center" id="foot">
					<input name="back" onClick="goBack();" type="button" class="b_foot" value="返回">
					&nbsp;
					<input class="b_foot" name="sure" type="button" value="导出" onClick="printTable(tabList);">
				</td>
			</tr>
		</table>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</BODY>
</HTML>

<script language="JavaScript">
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	excelObj = new ActiveXObject('excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add; 
	
	for(j=0;j<5;j++)
	{
		excelObj.Cells(1,j+1).Value=obj.rows[0].cells[j].innerText;
	}
	
	<%	
	for(int i = 0; i < tempArr.length; i++)
	{
	%>
		try
		{
			<%	
			for(int j = 0; j < 5; j++)
			{
			%>
				excelObj.Cells(<%=i%>+2,<%=j%>+1).Value="<%=tempArr[i][j].trim()%>";
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
	%>
	
	excelObj.Range('A1:'+str.charAt(5-1)
+1+<%=tempArr.length%>).Borders.LineStyle=1;
}
</script>