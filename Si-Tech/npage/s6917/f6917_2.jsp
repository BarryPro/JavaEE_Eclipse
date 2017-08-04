<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票预定
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
 
	String opCode = "6917";
	String opName = "世博会门票预定";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	Map errType = new HashMap();
	errType.put("00","成功");
	errType.put("01","票种错误");
	errType.put("02","票数错误");
	errType.put("03","门票时间错误");
	errType.put("04","票数不足");
	errType.put("05","客户未订购该票");
	errType.put("06","已出票，不能退定");
	errType.put("98","落地方内部错误");
	errType.put("99","其它错误");


	String  tktType = request.getParameter("tkt_type_array");
	String  tktSum = request.getParameter("tkt_sum_array");
	String  tktDate = request.getParameter("tkt_date_array");
	String  tktTag = request.getParameter("tkt_tag_array");
	String  inputParsm [] = new String[8];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = "0";
	inputParsm[3] = "";
	inputParsm[4] = tktType;
	inputParsm[5] = tktSum;
	inputParsm[6] = tktDate;
	inputParsm[7] = tktTag;
%>	
    <wtc:service name="s6917Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="8">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="8"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("预定失败！" + "<%=errMsg%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=世博会门票预定";
		</script>
<%		
		return;				 			
	}
	if((tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("预定成功！",2);		
		</script>
<%		
	}
	else if(tempArr[0][0].equals("2998"))
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("预定失败！",0);	
		</script>
<%		
	}
	else
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("预定失败！" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=世博会门票预定";	
		</script>
<%		
		return;				 			
	}
	ArrayList tktTypeArray = new ArrayList();
	String[] tktTypeList = tempArr[0][4].split("[|]");
	String[] tktSumList = tempArr[0][5].split("[|]");
	String[] tktDateList = tempArr[0][6].split("[|]");
	Map tktTypeMap = new HashMap();
	if(tempArr[0][3].trim().equals("04"))//票数不足，查询票种名称
	{
		StringBuffer  insql = new StringBuffer();
		insql.append("select tickettype_code,tickettype_name ");
		insql.append(" from sticketcode ");
		insql.append(" where use_flag='Y' and biz_type='01' ");
		insql.append(" order by tickettype_code  ");
		System.out.println("insql====="+insql);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:sql><%=insql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="roleDetailData" scope="end" />
		<%	
		if(retCode2.equals("000000"))
		{	
			for(int j = 0;j < roleDetailData.length;j++)
			{
				tktTypeMap.put(roleDetailData[j][0],roleDetailData[j][1]);
			}
		}
	}
%>
		
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
function commitJsp()
{
	getAfterPrompt();
	document.all.opr_numb.value="<%=tempArr[0][2].trim()%>";
	form6917.submit();
}
function unOrder()
{
	window.location="f6918_1.jsp?oprnumb=<%=tempArr[0][2].trim()%>&tkt_type=<%=tktType%>&tkt_sum=<%=tktSum%>&tkt_Date=<%=tktDate%>&tkt_tag=<%=tktTag%>";	
}		
</script> 
 
<title>世博会门票预定</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form6917" method="post" action="f6920_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会门票预定</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>			
				<td nowrap align='center' class="blue"><b><%=null == errType.get(tempArr[0][3].trim()) ? "未知类型错误" : errType.get(tempArr[0][3].trim())%></b></td>
			</tr>
		
			</table>
			<table width="100%" id="tabList" border=0 align="center" cellspacing=0>
			<%
			if(tempArr[0][3].trim().equals("04"))
			{%>
			
				<tr>				
					<td nowrap align='center' class="blue"><div ><b>不足门票票种</b></div></td>
					<td nowrap align='center' class="blue"><div ><b>剩余门票票数</b></div></td>
					<td nowrap align='center' class="blue"><div ><b>不足门票门票时间</b></div></td>
				</tr>
				<%	
				if(tktTypeList.length >0)
				{
					for(int i = 0; i < tktTypeList.length; i++)
					{
					%>			
						<tr>				
							<td nowrap align='center'><%=tktTypeList[i].trim() + "->" + tktTypeMap.get(tktTypeList[i].trim())%>&nbsp;</td>
							<td nowrap align='center'><%=tktSumList[i].trim()%>&nbsp;</td>
							<td nowrap align='center'><%=tktDateList[i].trim()%>&nbsp;</td>
						</tr>
					<%
					}
				}	
			}
			else if(tempArr[0][3].trim().equals("00"))
			{%>
				<tr>				
				<td nowrap align='center' class="blue"><div ><b>预定请求操作流水号</b></div></td>
				<td nowrap align='center' class="blue"><div ><b><%=tempArr[0][2].trim()%></b></div></td>
				</tr>
				<tr>				
				<td nowrap align='center' class="blue"><div ><b>票价</b></div></td>
				<td nowrap align='center' class="blue"><div ><b><%=tempArr[0][7].trim()%>元</b></div></td>
				</tr>
			<%
			}%>
			
	<tr> 
		<td align="center" id="footer" colspan="3"> 
			<%
			if(tempArr[0][3].trim().equals("00"))//预定成功
			{%>
				<input type="button" name="delete" class="b_foot" value="付款" onclick=commitJsp();>
				&nbsp;
				<input type="button" name="delete" class="b_foot" value="退订" onclick=unOrder()>
			<%
			}
			else
			{%>
			<input type="button" name="add"  class="b_foot" value="返回" onclick=history.go(-1);>
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="关闭" onclick=removeCurrentTab();>
			<%
			}
			%>
		</td>
	</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="opr_numb" value="">
<input type="hidden" name="tkt_type" value="<%=tktType%>">
<input type="hidden" name="tkt_sum" value="<%=tktSum%>">
<input type="hidden" name="tkt_date" value="<%=tktDate%>">
<input type="hidden" name="tkt_tag" value="<%=tktTag%>">
<input type="hidden" name="price" value="<%=tempArr[0][7].trim()%>">
<input type="hidden" name="commit_type" value="0">
</form>
</BODY>
</HTML>
