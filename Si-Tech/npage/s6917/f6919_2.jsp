<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票余票查询
   * 版本: 1.0
   * 日期: 2009/5/13
   * 作者: wangjya
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
 
	String opCode = "6919";
	String opName = "世博会门票余票查询";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	
	String  tktType = request.getParameter("tkt_type_array");
	String  tktDate = request.getParameter("tkt_date_array");

	
	String  inputParsm [] = new String[4];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = tktType;
	inputParsm[3] = tktDate;
%>	
    <wtc:service name="s6919Query" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="6">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="6"  scope="end"/>
		
		
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="JavaScript">
	 	rdShowMessageDialog("查询失败！" + "<%=errMsg%>",0);	
	 	window.location="f6919_1.jsp?opCode=6919&opName=世博会门票余票查询";
		</script>
<%		
		return;				 			
	}
	if(!(tempArr[0][0].equals("0000"))){
%>
		<script language="JavaScript">
	 	rdShowMessageDialog("查询失败！" + "<%=tempArr[0][1]%>",0);
	 	window.location="f6919_1.jsp?opCode=6919&opName=世博会门票余票查询";	
		</script>
<%		
		return;				 			
	}
	StringBuffer insql = new StringBuffer();
	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="tktTypeArray" scope="end" />
	<%
	Map tktTypeName = new HashMap();
	for(int j = 0; j < tktTypeArray.length; j++)
	{
		tktTypeName.put(tktTypeArray[j][0],tktTypeArray[j][1]);
	}

	String[] tktTypeList = tempArr[0][2].split("[|]");
	String[] tktSumList = tempArr[0][3].split("[|]");
	String[] tktDateList = tempArr[0][4].split("[|]");
	String[] tktPriceList = tempArr[0][5].split("[|]");
	String[] tktSumList1 = new String[tktTypeList.length];
	int j;
	int k;
	System.out.println("tktTypeList.length============="+tktTypeList.length);
	System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
	for(k=0;k<tktSumList1.length;k++)
	{
		tktSumList1[k] = "-";
	}
	for(j=0;j<tktSumList.length;j++)
	{
		tktSumList1[j] = tktSumList[j];
		System.out.println("tktSumList1============="+tktSumList1[j]);
	}
%>		
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--
</script> 
 
<title>世博会门票余票查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会门票余票查询</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td nowrap align='center' class="blue"><div ><b>票种</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>余票数</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>门票时间</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>票价</b></div></td>
			</tr>
	<%	
	if(tktTypeList.length >0)
	{
		for(int i = 0; i < tktTypeList.length; i++)
		{
		%>			
			<tr>				
				<td nowrap align='center'><%=tktTypeName.get(tktTypeList[i].trim())%>&nbsp;</td>
				<td nowrap align='center'><%=tktSumList1[i].trim().equals("") ? "-" : tktSumList1[i].trim() %>&nbsp;</td>
				<td nowrap align='center'><%=tktDateList[i].trim().equals("00000000") ? "-" : tktDateList[i].trim() %>&nbsp;</td>
				<td nowrap align='center'><%=tktPriceList[i].trim()%>&nbsp;</td>
			</tr>
		<%
		}
	}%>	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="add"  class="b_foot" value="返回" onclick=history.go(-1);>
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="关闭" onclick=removeCurrentTab();>
		</td>
	</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
