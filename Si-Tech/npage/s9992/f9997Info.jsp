<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 手机支付账户交易查询
　 * 版本: 
　 * 日期: 2009-07-20
　 * 作者: dujl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**需要清楚缓存.如果是新页面,可删除*
response.setHeader("Pragma","No-Cache");
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); */

String opCode = "9997";
String opName = "手机支付账户交易查询";

/**需要regionCode来做服务的路由**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

String orgCode =(String)session.getAttribute("orgCode");
String workNo = (String)session.getAttribute("workNo");
String pass = (String)session.getAttribute("password");
String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String beginDt = WtcUtil.repNull(request.getParameter("beginDt"));
String endDt = WtcUtil.repNull(request.getParameter("endDt"));

%>
<wtc:service name="s9997Qry" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="13" >
<wtc:param value="<%=workNo%>"/>
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=beginDt%>"/>
<wtc:param value="<%=endDt%>"/>
<wtc:param value="<%=pass%>"/>
<wtc:param value="<%=orgCode%>"/>
<wtc:param value="<%=opCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(!(errCode.equals("000000")))
	{
%>
		<script language="javascript">
		 	rdShowMessageDialog("查询失败！" + "<%=errMsg%>");	
		</script>
<%
		return;
	}
	if(!(result[0][0].equals("000000")))
	{
%>
		<script language="javascript">
		 	rdShowMessageDialog("查询失败！" + "<%=result[0][1]%>");	
		</script>
<%
		return;
	}
	
	String exCode1 = "";
	String oprNum1 = "";
	String exSeq1 = "";
	String opTime1 = "";
	String exFee1 = "";
	String accType1 = "";
	String cashType1 = "";
	String[] oprNum = new String[]{};
	String[] exSeq = new String[]{};
	String[] opTime = new String[]{};
	String[] exCode = new String[]{};
	String[] exFee = new String[]{};
	String[] accType = new String[]{};
	String[] cashType = new String[]{};
	
	if(result[0][2].equals("|"))
	{
		oprNum1 = result[0][2].replaceAll("|","-|-");
	}else 
	{
		oprNum1 = result[0][2];
	}
	
	if(result[0][5].equals("|"))
	{
		exSeq1 = result[0][5].replaceAll("|","-|-");
	}else 
	{
		exSeq1 = result[0][5];
	}
	
	if(result[0][6].equals("|"))
	{
		opTime1 = result[0][6].replaceAll("|","-|-");
		System.out.println("opTime1!!!!!!!!!!!!!!!!!!!!"+opTime1);
	}else 
	{
		opTime1 = result[0][6];
		System.out.println("opTime1@@@@@@@@@@@@@@@@@@@@@@"+opTime1);
	}
	
	if(result[0][7].equals("|"))
	{
		exCode1 = result[0][7].replaceAll("|","-|-");
		System.out.println("exCode3@@@@@@@@@@@@@@@@@@@@@@"+exCode1);
	}else if (result[0][7].indexOf("||") != -1)
	{
		exCode1 = result[0][7].replaceAll("||","|-|");
		System.out.println("exCode2&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+exCode1);
	}
	else 
	{
		exCode1 = result[0][7];
	}
	
	if(result[0][8].equals("|"))
	{
		exFee1 = result[0][8].replaceAll("|","-|-");
	}else 
	{
		exFee1 = result[0][8];
	}
	
	if(result[0][9].equals("|"))
	{
		accType1 = result[0][9].replaceAll("|","-|-");
	}else 
	{
		accType1 = result[0][9];
	}
	
	if(result[0][10].equals("|"))
	{
		cashType1 = result[0][10].replaceAll("|","-|-");
	}else 
	{
		cashType1 = result[0][10];
	}
	
 	oprNum = oprNum1.split("[|]");
	exSeq = exSeq1.split("[|]");
	opTime = opTime1.split("[|]");
	exCode = exCode1.split("[|]");
	exFee = exFee1.split("[|]");
	accType = accType1.split("[|]");
	cashType = cashType1.split("[|]");
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
		<table cellspacing="0" id="tabList">
			<tr align="center">
				<th nowrap>BOSS流水号</th>
				<th nowrap>交易手机号</th>
				<th nowrap>手机支付流水号</th>
				<th nowrap>交易日期</th>
				<th nowrap>交易码</th>
				<th nowrap>交易金额（厘）</th>
				<th nowrap>账户类型</th>
				<th nowrap>资金属性</th>
			</tr>
	<%
			if(exSeq.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='8'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
				
			}else if(exSeq.length>0)
			{
				String tbclass = "";
				for(int i=0;i<exSeq.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
					<tr align="center" length="500">
						<td class="<%=tbclass%>"><%=result[0][2]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=result[0][4]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=exSeq[i].trim()%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=opTime[i].trim()%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=exCode[i].trim()%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=exFee[i].trim()%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=accType[i].trim()%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=cashType[i].trim()%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
  	</div>
</body>
</html>    

