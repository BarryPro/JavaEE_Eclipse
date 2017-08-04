<%
   /*
   * 功能: 查询一级账目项代码
　 * 版本: v1.0
　 * 日期: 2007/01/23
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
	
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	sqlStr1 ="select fee_code,fee_name from sFeeCode order by fee_code asc";
	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>一级账目项列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
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
			一级账目项代码
		</td>
		<td align="center">
			一级账目项名称
		</td>
	</tr>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td>
			<div align="center">
				<input name="allCheckButton" type="button" class="button" value="全部选中" onClick="allSelect()" >
	          	 	    &nbsp;
	      <input name="calcelCheckButton" type="button" class="button" value="全部取消" onClick="noSelect()" >
	      &nbsp;
			   <input type="button" name="commit"  class="button" onClick="doCommit();" value=" 确定 ">
			   &nbsp;
			   <input type="button" name="back" class="button" onClick="doClose();" value=" 关闭 ">
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
			rdShowMessageDialog("您没有选择一级账目项代码！");
			return false;
		}
		else if("<%=retListString1.length%>"=="1")   //值为一条时不需要用数组
		{
			if(document.all.num.checked)
			{
				window.opener.form1.fee_code.value=document.all.fee_code.value+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name.value;
			}
			else
			{
				rdShowMessageDialog("您没有选择一级账目项代码！");
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
				window.opener.form1.fee_code.value=fee_codes+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name[a].value;
			}
			else
			{
				rdShowMessageDialog("您没有选择一级账目项代码！");
				return false;
			}
		}
		window.close();
	}
	
	function doClose()
	{
		window.close();
	}
	
//--------全选--------------
function allSelect()
{
 var i = 0;

 //一行都没有
 if(document.all.num==undefined)
 {
  rdShowMessageDialog("此目录下没有权限,无法全部选中！");
  return;
 }
 //只有一行
 if(document.all.num.length==undefined)
 {
  document.all.num.checked=true; 
 }
 
 for(i=0;i<document.all.num.length;i++)
 {
  document.all.num[i].checked=true; 
 }

 
}

//----------全部去掉--------
function noSelect()
{
 var i = 0;
 
 //一行都没有 
 if(document.all.num==undefined)
 {
  rdShowMessageDialog("此目录下没有权限,无法全部取消！");
  return;
 }

 //只有一行
 if(document.all.num.length==undefined)
 {
  document.all.num.checked=false; 
 }
  
 for(i=0;i<document.all.num.length;i++)
 {
  document.all.num[i].checked=false;
 }
 
} 

</script>