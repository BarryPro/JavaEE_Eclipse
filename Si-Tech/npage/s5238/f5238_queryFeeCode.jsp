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
<%    
String regionCode = (String)session.getAttribute("regCode");

	String clear_mode_use = request.getParameter("clear_mode_use")==null?"":request.getParameter("feeNameCond");;

	String whereStr=" and 1=1 ";
	String feeTypeCond="",feeCodeCond="",feeNameCond="",retToField="";
	feeTypeCond = request.getParameter("feeTypeCond")==null?"":request.getParameter("feeTypeCond");
	feeCodeCond = request.getParameter("feeCodeCond")==null?"":request.getParameter("feeCodeCond");
	feeNameCond = request.getParameter("feeNameCond")==null?"":request.getParameter("feeNameCond");
	retToField = request.getParameter("retToField");

	if(!(feeTypeCond.equals(""))){
        whereStr = whereStr + " and a.fee_type="+feeTypeCond;
	}
	if(!(feeCodeCond.equals(""))){
	    whereStr = whereStr + " and a.fee_code like '%" + feeCodeCond + "%'";
	}
	if(!(feeNameCond.equals(""))){
	    whereStr = whereStr + " and a.fee_name like '%" + feeNameCond + "%'";
	}

	String sqlStr1="";
	sqlStr1 ="select a.fee_type,b.fee_name,a.fee_code,a.fee_name from sFeeCode a,sFeeType b where a.fee_type=b.fee_type";
	sqlStr1 = sqlStr1 + whereStr;

	//retList1 = impl.sPubSelect("4",sqlStr1,"region",regionCode);
	%>
	
			<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	
	<%
	String[][] retListString1 = result_t;
%>

<html>
<head>
<title>账目列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>

<table id="mainThree" cellspacing="0" >
    <tr height="22">
	    <TD width="16%">账目类型</TD>
	  	<TD width="34%">
		    <select name="feeTypeCond"  class="button" >
			    <option value="">---请选择---</option>
			    <option value="0">0->基本通话费</option>
				<option value="1">1->长途费</option>
				<option value="2">2->信息费</option>
			</select>
		</TD>
		<TD width="16%">账目代码</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=5 v_name="账目代码"  name=feeCodeCond maxlength=5 value="">
		  </input>
		</TD>
	</tr>
	<tr height="22">	    
		<TD>账目名称</TD>
	  	<TD>
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="账目名称"  name=feeNameCond maxlength=25 value="">
		  </input>
		</TD>
		<TD></TD>
	  	<TD></TD>
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
</table>
<table id="tab1"   cellspacing="0">
	<tr >
		<td height="26" align="center">
			选择
		</td>
		<td  align="center">
			账目类型
		</td>
		<td align="center">
			类型名称
		</td>
		<td align="center">
			账目代码
		</td>
		<td align="center">
			账目名称
		</td>
	</tr>
</table>
<table  cellspacing="0">
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
			var str='<input type="hidden" name="sel_code" value="<%=retListString1[i][2]%>">';
			str+='<input type="hidden" name="sel_name" value="<%=retListString1[i][3]%>">';
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
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
				rdShowMessageDialog("您没有选择代码！",0);
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
		var feeTypeCond = document.all.feeTypeCond.value;
		var feeCodeCond = document.all.feeCodeCond.value;
		var feeNameCond = document.all.feeNameCond.value;
	    this.location="f5238_queryFeeCode.jsp?queryFlag=Y&feeTypeCond="+feeTypeCond+"&feeCodeCond="+feeCodeCond+"&feeNameCond="+feeNameCond+"&retToField=<%=retToField%>";
	}

	function doReset(){
	    document.all.feeTypeCond.value="";
		document.all.feeCodeCond.value="";
		document.all.feeNameCond.value="";
	}
</script>