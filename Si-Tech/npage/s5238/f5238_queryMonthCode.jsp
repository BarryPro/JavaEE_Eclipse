<%
   /*
   * 功能: 查询月租优惠代码
　 * 版本: v1.0
　 * 日期: 2007/01/16
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page errorPage="/page/common/error.jsp" %>
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
	
	String detail_type = request.getParameter("detail_type");   //优惠类型
	String region_code = request.getParameter("region_code");   //优惠类型
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	String whereSql="";
	String monthCodeCond="",monthNameCond="",queryFlag="";
	String monthFlagCond="",dayFlagCond="",monthFeeCond="",feeCodeCond="",detailCodeCond="";

    String retToField = request.getParameter("retToField");
    queryFlag = request.getParameter("queryFlag")==null?"":request.getParameter("queryFlag");
	monthCodeCond = request.getParameter("monthCodeCond")==null?"":request.getParameter("monthCodeCond");
	monthNameCond = request.getParameter("monthNameCond")==null?"":request.getParameter("monthNameCond");
	monthFlagCond = request.getParameter("monthFlagCond")==null?"":request.getParameter("monthFlagCond");
	dayFlagCond = request.getParameter("dayFlagCond")==null?"":request.getParameter("dayFlagCond");
	monthFeeCond = request.getParameter("monthFeeCond")==null?"":request.getParameter("monthFeeCond");
	feeCodeCond = request.getParameter("feeCodeCond")==null?"":request.getParameter("feeCodeCond");
	detailCodeCond = request.getParameter("detailCodeCond")==null?"":request.getParameter("detailCodeCond");

	if(!(queryFlag.equals("Y")))
	{
	    whereSql = whereSql + " and 1=2";
	}

    if(!(monthCodeCond.equals("")))
	{
	    whereSql = whereSql + " and a.month_code like '%"+monthCodeCond+"%' ";
	}

	if(!(monthNameCond.equals("")))
	{
	    whereSql = whereSql + " and a.note like '%"+monthNameCond+"%' ";
	}

	if(!(monthFlagCond.equals("")))
	{
	    whereSql = whereSql + " and a.month_flag = "+monthFlagCond+" ";
	}

	if(!(dayFlagCond.equals("")))
	{
	    whereSql = whereSql + " and a.day_flag = '"+dayFlagCond+"' ";
	}

	if(!(monthFeeCond.equals("")))
	{
	    whereSql = whereSql + " and a.month_fee = "+monthFeeCond+" ";
	}

	if(!(feeCodeCond.equals("")) && (detailCodeCond.equals("")))
	{
	    whereSql = whereSql + " and a.acc_detail in (select detail_code from sFeeCodeDetail where fee_code='"+feeCodeCond+"') ";
	}

	if(!(detailCodeCond.equals("")))
	{
	    whereSql = whereSql + " and a.acc_detail = '"+detailCodeCond+"' ";
	}

	whereSql = whereSql + " and rownum < 51 order by month_code";

	sqlStr1 ="select a.month_code,a.note,a.acc_detail,b.detail_name from sbillMonthcode a,sFeeCodeDetail b where a.acc_detail=b.detail_code and a.region_code='"+region_code+"'";

	sqlStr1 = sqlStr1 + whereSql ;
	
	retList1 = impl.sPubSelect("4",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>月租优惠代码列表</title>
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
<table width="99%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">月租代码：</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="代码"  name=monthCodeCond maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%">月租名称：</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="名称"  name=monthNameCond maxlength=25 value="">
		  </input>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">帐务周期：</TD>
	  	<TD width="34%">
		  <input type=text  v_type="0_9" v_must=0 v_minlength=1 v_maxlength=15 v_name="帐务处理月周期" name=monthFlagCond maxlength=15 ></input> (单位:月)
		</TD>
		<TD width="16%">日收标志：</TD>
	  	<TD width="34%">
		   <select name="dayFlagCond" class="button" id="dayFlagCond">
				<option value="">--请选择--</option>
				<option value="0">0->按月收</option>
				<option value="1">1->按日收</option>
           </select>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">月费用：</TD>
	  	<TD width="34%">
		  <input type=text  v_type="money" v_must=0 v_minlength=1 v_maxlength=15 v_name="月费用" name=monthFeeCond maxlength=15 ></input> (单位:元)
		</TD>
		<TD width="16%"> </TD>
	  	<TD width="34%"> </TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD>一级账目项</TD>
	  	<TD colspan="3">
		  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=4 v_name="一级账目"  name=feeCodeCond value="" maxlength=10 size="10" >
	  	  <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="账目名称"  name=feeNameCond value="" maxlength=20 readonly>
		  <input class="button" type="button" name="query_feecode" onclick="queryFeeCode()" value="选择">
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD>二级账目项</TD>
	  	<TD colspan="3">
		  <input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=5 v_name="账目明细"  name=detailCodeCond maxlength=5 size="10" value="" >
		  </input>
		 <input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="明细名称"  name=detailNameCond value="" maxlength=20 readonly>
		 <input class="button" type="button" name="query_detailcode" onclick="queryDetailCode()" value="选择">
		</TD>
	</tr>

	<tr>
		<td colspan=4>
		    <div align="center">
			  <input type="button" name="commit" onClick="doQuery();" value=" 查询 ">
			  &nbsp;
			  <input type="button" name="back" onClick="doReset();" value=" 重置 ">
		    </div>
		</td>
	</tr>
	<tr>
		<td colspan=4 align="center"><font color="red"><<-最大查询记录为50条！->></font></td>
	</tr>
</table>
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			选择
		</td>
		<td  align="center">
			月租代码
		</td>
		<td align="center">
			月租名称
		</td>
		<td align="center">
			账目项
		</td>
		<td align="center">
			账目名称
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
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="sel_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="sel_name" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择月租优惠代码！");
				return false;
			}
			
			var selCodeArr = document.getElementsByName("sel_code");
			var selNameArr = document.getElementsByName("sel_name");
			var numArr = document.getElementsByName("num");

			var a=-1;
			for(i=0;i<numArr.length;i++){
			  if(numArr[i].checked){
			      a=i;
				  break;
			  }
			}
            var retInfo=selCodeArr[a].value+"|"+selNameArr[a].value+"|";
			var retToField = "<%=retToField%>";
			var chPos_field = retToField.indexOf("|");
            var chPos_retStr;
            var valueStr;
            var obj;
            while(chPos_field > -1)
            {
               obj = retToField.substring(0,chPos_field);
               chPos_retInfo = retInfo.indexOf("|");
               valueStr = retInfo.substring(0,chPos_retInfo);
               window.opener.document.all(obj).value = valueStr;
               retToField = retToField.substring(chPos_field + 1);
               retInfo = retInfo.substring(chPos_retInfo + 1);
               chPos_field = retToField.indexOf("|");        
             }

			 window.close();
		}
	
	function doClose(){
		window.close();
	}
function doQuery(){
    var monthCodeCond = document.all.monthCodeCond.value;
	var monthNameCond = document.all.monthNameCond.value;
	var monthFlagCond = document.all.monthFlagCond.value;
	var dayFlagCond = document.all.dayFlagCond.value;
	var monthFeeCond = document.all.monthFeeCond.value;
	var feeCodeCond = document.all.feeCodeCond.value;
	var detailCodeCond = document.all.detailCodeCond.value;
	this.location="f5238_queryMonthCode.jsp?queryFlag=Y&retToField=<%=retToField%>&region_code=<%=region_code%>&detail_type=<%=detail_type%>"+"&monthCodeCond="+monthCodeCond+"&monthNameCond="+monthNameCond+"&monthFlagCond="+monthFlagCond+"&dayFlagCond="+dayFlagCond+"&monthFeeCond="+monthFeeCond+"&feeCodeCond="+feeCodeCond+"&detailCodeCond="+detailCodeCond;
}

function doReset(){
	document.all.monthCodeCond.value="";
	document.all.monthNameCond.value="";
}

//选择一级账目代码
function queryFeeCode()
{
	var retToField = "feeCodeCond|feeNameCond|";
	var url = "f5238_queryFeeCode.jsp?retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
//选择二级账目代码
function queryDetailCode()
{
	if(!checkElement("feeCodeCond")) 
    {
        document.all.feeCodeCond.focus();
	    return;
    }
	var retToField = "detailCodeCond|detailNameCond|";
	var url = "f5238_queryFeeDetailCode.jsp?fee_code="+document.all.feeCodeCond.value+"&retToField="+retToField;
    window.open(url,'','height=600,width=500,scrollbars=yes');	
}
</script>