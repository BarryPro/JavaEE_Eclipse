<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:一卡多号绑定信息查询
   * 日期: 2009/4/14
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "4514";
	String opName = request.getParameter("opName");
    
	String loginNo = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String phoneNo = request.getParameter("phoneNo");
	String user_passwd = request.getParameter("user_passwd");
	System.out.println("phoneNo= " + phoneNo);
	System.out.println("user_passwd= " + user_passwd);
	
	String  inputParsm [] = new String[9];
	inputParsm[0] = "S45140";
	inputParsm[1] = "site";
	inputParsm[2] = "0";
	inputParsm[3] = "0";
	inputParsm[4] = loginNo;
	inputParsm[5] = pass;
	inputParsm[6] = opCode;
	inputParsm[7] = phoneNo;
	inputParsm[8] = user_passwd;
%>	
    <wtc:service name="s4514Qry" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">			
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
	<wtc:array id="tempArr" scope="end"/>
<%  
	System.out.println("121312312321:"+tempArr[0][2]+"4444444:"+tempArr[0][3]);
		
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
	
	
</script>
<BODY>
<body>
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td  align='center' class="blue"><div ><b>是否主卡</b></div></td>
				<td  align='center' class="blue"><div ><b>是否绑定</b></div></td>
				<td  align='center' class="blue"><div ><b>主卡号码</b></div></td>
				<td  align='center' class="blue"><div ><b>副卡号码</b></div></td>
				<td  align='center' class="blue"><div ><b>绑定时间</b></div></td>
			</tr>
		
			<tr>				
				<td  align='center' class="blue"><%=tempArr[0][2]%>&nbsp;</td>
				<td  align='center' class="blue"><%=tempArr[0][3]%>&nbsp;</td>
				<td  align='center' class="blue"><%=tempArr[0][4]%>&nbsp;</td>
				<td  align='center' class="blue"><%=tempArr[0][5]%>&nbsp;</td>
				<td  align='center' class="blue"><%=tempArr[0][6]%>&nbsp;</td>
			</tr>			
		</table>		

</form>
</BODY>
</HTML>