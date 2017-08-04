<%
   /*
   * 功能: 查询优惠条件设置-用户属性为条件时的属性值
　 * 版本: v1.0
　 * 日期: 2007/01/24
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginName = baseInfoSession[0][3];
	String orgCode = baseInfoSession[0][16];
	String loginNo = baseInfoSession[0][2];
	String ip_Addr = request.getRemoteAddr();
	String org_code = baseInfoSession[0][16];
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String regionCode=org_code.substring(0,2);
	
	String region_code = request.getParameter("region_code");
	String favour_condition = request.getParameter("favour_condition");
	System.out.println("!!!!!!!!!!+"+favour_condition);
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	if(favour_condition.equals("01"))
	{
		sqlStr1 ="select sm_code,sm_name from sSmCode where region_code='"+region_code+"' order by sm_code asc";
	}
	else if(favour_condition.equals("04"))
	{
		sqlStr1 ="select run_code,run_name from sRunCode where region_code='"+region_code+"' order by run_code asc";
	}
	else if(favour_condition.equals("06"))
	{
		sqlStr1 ="select card_type,card_name from sBigCardCode order by card_type asc";
	}
	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>用户属性为条件时的属性列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head>
<body>
<form name="frm" method="POST" >
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			选择
		</td>
		<td  align="center">
			属性代码
		</td>
		<td align="center">
			属性名称
		</td>
	</tr>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td>
			<div align="center">
			   <input type="button" name="commit" onClick="doCommit();" value=" 确定 ">
			   &nbsp;
			   <input type="button" name="back" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>
</form>
</body>
</html>

<script>
	  
		<%	for(int i=0;i < retListString1.length;i++)
			{ 
		%>
			var str='<input type="hidden" name="fee_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="fee_name" value="<%=retListString1[i][1]%>">';
			
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="checkbox" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%	}
		%>

	function doCommit()
	{
		if("<%=retListString1.length%>"=="0"){
			rdShowMessageDialog("您没有选择属性代码！");
			return false;
		}
		else if("<%=retListString1.length%>"=="1")   //值为一条时不需要用数组
		{
			if(document.all.num.checked)
			{
				window.opener.form1.cond_attr.value=document.all.fee_code.value+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name.value;
			}
			else
			{
				rdShowMessageDialog("您没有选择属性代码！");
				return false;
			}
		}
		else   //值为多条时需要用数组
		{
			var fee_codes = new Array();
			
			var j=0;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					fee_codes[j]=document.all.fee_code[i].value;
					j++
				}
			}
			if(j>0)
			{
				window.opener.form1.cond_attr.value=fee_codes+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name[a].value;
			}
			else
			{
				rdShowMessageDialog("您没有选择属性代码！");
				return false;
			}
		}
		window.close();
	}
	
	function doClose()
	{
		window.close();
	}
</script>