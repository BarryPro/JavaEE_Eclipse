<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:查询彩铃用户信息（彩铃平台）
   * 日期: 2009/11/09
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

	String opCode = "8358";
	String opName = "查询彩铃用户信息（彩铃平台）";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String sInCreateType = "9";	  //业务受理渠道:00:BOSS
	String vstatus=""; //用户业务状态
	String vshow=""; //是否是彩铃秀用户
	
	String  inputParsm [] = new String[5];
	inputParsm[0] = workNo;
	inputParsm[1] = orgCode;
	inputParsm[2] = opCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = sInCreateType;
%>	
    <wtc:service name="s8358Qry" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="13">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="2" length="11"  scope="end"/>
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
	else
	{
		for(int i = 0; i < tempArr.length; i++)
		{
			if((tempArr[i][7].trim()).equals("1"))
			{
				vstatus="彩铃开通";
			}
			else if((tempArr[i][7].trim()).equals("2"))
			{
				vstatus="彩铃取消";
			}
			else
			{
				vstatus="";
			}
			
			if((tempArr[i][8].trim()).equals("0"))
			{
				vshow="是";
			}
			else if((tempArr[i][8].trim()).equals("1"))
			{
				vshow="否";
			}
			else
			{
				vshow="";
			}
		}
	}
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--
</script>

<title>查询彩铃用户信息（彩铃平台）</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>

</head>
<BODY>
	<div id="Operation_Table">
		<table id="tabList" cellspacing=0>			
			<tr>
				<td  align='center' class="blue"><div ><b>服务号码</b></div></td>
				<td  align='center' class="blue"><div ><b>当前产品标识</b></div></td>
				<td  align='center' class="blue"><div ><b>预约产品标识</b></div></td>
				<td  align='center' class="blue"><div ><b>当前产品开始时间</b></div></td>
				<td  align='center' class="blue"><div ><b>当前产品结束时间</b></div></td>
				<td  align='center' class="blue"><div ><b>预约产品开始时间</b></div></td>
				<td  align='center' class="blue"><div ><b>预约产品结束时间</b></div></td>
				<td  align='center' class="blue"><div ><b>用户业务状态</b></div></td>
				<td  align='center' class="blue"><div ><b>是否彩铃秀用户</b></div></td>
				<td  align='center' class="blue"><div ><b>业务办理时间</b></div></td>
				<td  align='center' class="blue"><div ><b>集团ID</b></div></td>
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
				<td nowrap align='center'><%=tempArr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=vstatus%>&nbsp;</td>
				<td nowrap align='center'><%=vshow%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][9].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][10].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>
			
		</table>
	</div>
</BODY>
</HTML>
