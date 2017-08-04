<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
	
	String detail_type = request.getParameter("detail_type");   //优惠类型
	String region_code = request.getParameter("region_code");   //优惠类型
	
	String sqlStr1="";
	String whereSql="";
	String rateCodeCond="",rateNameCond="",queryFlag="";
    
	String retToField = request.getParameter("retToField");
    queryFlag = request.getParameter("queryFlag")==null?"":request.getParameter("queryFlag");
	rateCodeCond = request.getParameter("rateCodeCond")==null?"":request.getParameter("rateCodeCond");
	rateNameCond = request.getParameter("rateNameCond")==null?"":request.getParameter("rateNameCond");

	if(!(queryFlag.equals("Y")))
	{
	    whereSql = whereSql + " and 1=2";
	}

    if(!(rateCodeCond.equals("")))
	{
	    whereSql = whereSql + " and rate_code like '%"+rateCodeCond+"%' ";
	}

	if(!(rateNameCond.equals("")))
	{
	    whereSql = whereSql + " and note like '%"+rateNameCond+"%' ";
	}
	whereSql = whereSql + " and rownum < 51 order by rate_code";
	
	sqlStr1 ="select rate_code,0,note from sbillratecode where region_code='"+region_code+"' ";

	sqlStr1 = sqlStr1 + whereSql ;
	
	//retList1 = impl.sPubSelect("3",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	String[][] retListString1 = new String[][]{};
	if(result_t.length>0&&code.equals("000000"))
	retListString1 = result_t;
%>

<html>
<head>
<title>批价优惠代码列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         
		

	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table   id="mainThree" cellspacing="0" >
	<tr  height="22">	    
		<TD width="16%" class="blue">批价优惠代码</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=4 v_name="代码"  name=rateCodeCond maxlength=4 value="">
		</TD>
		<TD width="16%" class="blue">批价优惠名称</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="名称"  name=rateNameCond maxlength=25 value="">
		</TD>
	</tr>
	<tr>
		<td colspan=4>
		    <div align="center">
			  <input type="button" name="commit" onClick="doQuery();" value=" 查询 " class="b_text">
			  &nbsp;
			  <input type="button" name="back" onClick="doReset();" value=" 重置 " class="b_text">
		    </div>
		</td>
	</tr>
		<tr>
		<td colspan=4 align="center"><font class="orange"><<-最大查询记录为50条！->></font></td>
	</tr>
</table>
<table  id="tab1" border="0" cellspacing="0">
	<tr >
		<th height="26" align="center">
			选择
		</th>
		<th  align="center">
			批价优惠代码
		</th>
		<th  align="center">
			批价类别
		</th>
		<th align="center">
			批价优惠名称
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 " class="b_foot">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="sel_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="sel_name" value="<%=retListString1[i][2]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择批价优惠代码！");
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
    var rateCodeCond = document.all.rateCodeCond.value;
	var rateNameCond = document.all.rateNameCond.value;
	this.location="f5238_queryRateCode.jsp?queryFlag=Y&retToField=<%=retToField%>&region_code=<%=region_code%>&detail_type=<%=detail_type%>"+"&rateCodeCond="+rateCodeCond+"&rateNameCond="+rateNameCond;
}

function doReset(){
	document.all.rateCodeCond.value="";
	document.all.rateNameCond.value="";
}
</script>
