<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
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
	String[][] result = new String[][]{};
	 
	String regionCode = (String)session.getAttribute("regCode");	
	String region_code = request.getParameter("region_code");
	String clear_mode_use = request.getParameter("clear_mode_use");
	
	String sqlStr1="";
	sqlStr1 ="select sm_code,sm_name from sSmCode where region_code='"+region_code+"' and sm_code in ('gn','dn','zn') order by sm_code asc";
	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
<title>品牌列表</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table  id="tab1"  cellpadding="0" >
	<tr>
		<th height="26" align="center">
			选择
		</th>
		<th  align="center">
			品牌代码
		</th>
		<th align="center">
			品牌名称
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 "  class="b_foot">
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
			var str='<input type="hidden" name="sm_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="sm_name" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择品牌代码！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.sm_code.value=document.all.sm_code.value;
					window.opener.form1.sm_name.value=document.all.sm_name.value;
				}
				else{
					rdShowMessageDialog("您没有选择品牌代码！");
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
					window.opener.form1.sm_code.value=document.all.sm_code[a].value;
					window.opener.form1.sm_name.value=document.all.sm_name[a].value;
				}
				else{
					rdShowMessageDialog("您没有选择品牌代码！");
					return false;
				}
			}
			if("<%=clear_mode_use%>"=="1")
			{
				window.opener.form1.mode_use.value="";
				window.opener.form1.use_name.value="";
			}
			window.close();
		}
	
	function doClose(){
		window.close();
	}
</script>