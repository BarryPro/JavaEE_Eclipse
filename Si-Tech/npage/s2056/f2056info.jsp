<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:内置卡停机原因查询
   * 日期: 2009/4/21
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

	String opCode = "2056";
	String opName = "内置卡停机原因查询";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String phone_no = request.getParameter("phone_no");
	
	String[][] allNumStr = new String[][]{};
	String[][] result = new String[][]{};
	
	String  inputParsm [] = new String[2];
	inputParsm[0] = opCode;
	inputParsm[1] = phone_no;
%>
    <wtc:service name="s2056Query" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="8">
		<wtc:param value="<%=inputParsm[0]%>"/>	
		<wtc:param value="<%=inputParsm[1]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" scope="end"/>
<%
	if(!(tempArr[0][0]).equals("000000") )
	{
%>
		<script language="javascript">
	 		rdShowMessageDialog("<%=tempArr[0][1]%>");		
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

<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Expires" content="0">

</head>
<STYLE>
	.Button 
	{
		font-size: 12px;
	}
	#Operation_Table td{background-color: #EEEEEE;	font-size: 12px;padding: 4px; border-right:1px solid #FFFFFF; border-bottom:1px solid #FFFFFF;}
</STYLE> 

<script type=text/javascript>

function MoveLayer(layerName) 
{
	var x = 10;
	var x = document.body.scrollLeft + x;		
	eval("document.all." + layerName + ".style.posLeft = x");
}

</script>

<body onload="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
	<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
		<tr>		
			<td nowrap align='center' width="12%" class="blue"><div ><b>手机号码</b></div></td>
			<td nowrap align='center' width="20%" class="blue"><div ><b>停机原因</b></div></td>
			<td nowrap align='center' width="12%" class="blue"><div ><b>操作流水</b></div></td>
			<td nowrap align='center' width="30%" class="blue"><div ><b>操作时间</b></div></td>
			<td nowrap align='center' width="13%" class="blue"><div ><b>操作工号</b></div></td>
			<td nowrap align='center' width="13%" class="blue"><div ><b>操作代码</b></div></td>
		</tr>
		<tr>
			<td nowrap align='center' width="12%" class="blue"><%=tempArr[0][2].trim()%>&nbsp;</td>
			<td nowrap align='center' width="20%" class="blue"><%=tempArr[0][3].trim()%>&nbsp;</td>
			<td nowrap align='center' width="12%" class="blue"><%=tempArr[0][4].trim()%>&nbsp;</td>
			<td nowrap align='center' width="30%" class="blue"><%=tempArr[0][5].trim()%>&nbsp;</td>
			<td nowrap align='center' width="13%" class="blue"><%=tempArr[0][6].trim()%>&nbsp;</td>
			<td nowrap align='center' width="13%" class="blue"><%=tempArr[0][7].trim()%>&nbsp;</td>
			
		</tr>
	</table>
	</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>