<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:限额告警查询
   * 日期: 2009/4/1
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4260";
	String opName = "限额告警查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
	/**************** 分页设置 ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	String[][] allNumStr = new String[][]{};
	String[][] result = new String[][]{};
	
	String  inputParsm [] = new String[3];
	inputParsm[0] = workNo;
	inputParsm[1] = orgCode;
	inputParsm[2] = opCode;
%>	
    <wtc:service name="s4257Query" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="7">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="2" length="5"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<% 		
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("错误信息:<%=tempArr1[0][1]%>");	
	 	removeCurrentTab();	
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
 
<title>限额告警查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">限额告警查询</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td nowrap align='center' class="blue"><div ><b>手机号码</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>客户名称</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>号码类型</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>限额告警值</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>费用告警值</b></div></td>
			</tr>
	<%	
	if(tempArr.length<=10){
		for(int i = 0; i < tempArr.length; i++)
			{
		%>			
				<tr>				
					<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<%	if(tempArr[i][2].equals("0")){   %>
						<td nowrap align='center'>测试号&nbsp;</td>
				<%	}else{ 	%>
					<td nowrap align='center'>公务号&nbsp;</td>
				<%	}   	%>	
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
			<%	if(tempArr[i][2].equals("0")){   %>
					<td nowrap align='center'>测试号&nbsp;</td>
			<%	}else{ 	%>
				<td nowrap align='center'>公务号&nbsp;</td>
			<%	}   	%>	
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
			<%	if(tempArr[i][2].equals("0")){   %>
					<td nowrap align='center'>测试号&nbsp;</td>
			<%	}else{ 	%>
				<td nowrap align='center'>公务号&nbsp;</td>
			<%	}   	%>	
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
			</tr>
	<%
		}
		}
	%>		
			<tr>	
				<td colspan="10">
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
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
