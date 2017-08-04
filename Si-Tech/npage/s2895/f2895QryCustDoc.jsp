<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.14
 模块:集团订购信息管理(修改)
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
		String opName = "集团订购信息管理(修改)";
		
		String impRegion = (String)session.getAttribute("regCode");
		
		String idIccid = request.getParameter("idIccid");
		
		String sqlStr1="";
		sqlStr1 = "select a.cust_id, b.unit_id, b.unit_name, to_char(a.create_time,'yyyy-mm-dd') from dcustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id and   a.id_iccid = '" + idIccid + "'";;
		System.out.println("Doc.jsp->sqlStr1======="+sqlStr1);
		String[] inParams = new String[2];
		inParams[0] = "select a.cust_id, b.unit_id, b.unit_name, to_char(a.create_time,'yyyy-mm-dd') from dcustDoc a, dCustDocOrgAdd b where a.cust_id = b.cust_id and   a.id_iccid =:idIccid";
		inParams[1] = "idIccid="+idIccid;
		//retList1 = impl.sPubSelect("4",sqlStr1,"region",impRegion);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=impRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
		String[][] retListString1 = result1;
		String errCode=retCode1;
		String errMsg=retMsg1;
		
	  String op_name = "客户资料列表";

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>
<table id="tab1" cellspacing="0">
	<tr>
		<th nowrap align="center">选择</th>
		<th nowrap align="center">集团客户ID</th>
		<th nowrap align="center">集团编号</th>
		<th nowrap align="center">名称</th>
		<th nowrap align="center">建档日期</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td>
			<div align="center">
		      <input type="button" class="b_foot" name="commit" onClick="doCommit();" value=" 确定 ">
		      &nbsp;
		      <input type="button" class="b_foot" name="back" onClick="doClose();" value=" 关闭 ">
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
			var str='<input type="hidden" name="custId" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="unitId" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="custName" value="<%=retListString1[i][2]%>">';
			str+='<input type="hidden" name="createTime" value="<%=retListString1[i][3]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		    newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		    newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		    newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		    newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		<%}%>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("请选择一条记录！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.custId.value=document.all.custId.value;
					window.opener.form1.custName.value=document.all.custName.value;
					window.opener.form1.unitId.value = document.all.unitId.value;
					//window.close();
				}
				else{
					rdShowMessageDialog("请选择一条记录！");
					return false;
				}
			}
			else{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.custId.value=document.all.custId[a].value;
					window.opener.form1.custName.value=document.all.custName[a].value;
					//window.close();
				}
				else{
					rdShowMessageDialog("请选择一条记录！");
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