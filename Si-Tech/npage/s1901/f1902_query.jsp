<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2000.01.13
 模块：集团合同协议录入
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<% request.setCharacterEncoding("gbk");%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String opName = "集团合同协议录入";
	 
	String regionCode= (String)session.getAttribute("regCode");
	String formtype = request.getParameter("formtype");
	String IccidValeus = request.getParameter("IccidValeus");
	
	String sqlStr1="";
	sqlStr1 ="SELECT to_char(a.cust_id),a.cust_name,a.cust_address FROM dcustdoc a WHERE a.id_iccid='"+IccidValeus+"'";
	System.out.println("MMMMMMMM"+sqlStr1);
	String[] inParams = new String[2];
	inParams[0] = "SELECT to_char(a.cust_id),a.cust_name,a.cust_address FROM dcustdoc a WHERE a.id_iccid=:IccidValeus";
	inParams[1] = "IccidValeus=" + IccidValeus;
	//retList1 = impl.sPubSelect("3",sqlStr1,"region",regionCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String[][] retListString1 = result1;
	String errCode=retCode1;
	String errMsg=retMsg1;

%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>人员列表</title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>

</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %> 
<table id="tab1"  cellspacing="0">
	<tr>
		<th align="center">
			选择
		</th>
		<th align="center">
			客户编号
		</th>
		<th  align="center">
			客户名称
		</th>
		<th align="center">
			客户地址
		</th>
	</tr>
</table>
<table align="center" cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input class="b_foot" type="button" name="commit" onClick="doCommit();" value=" 确定 ">
			      &nbsp;
			      <input class="b_foot" type="button" name="back" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
var formtype='<%=formtype%>';  
		<%for(int i=0;i < retListString1.length;i++){ 
			String tdClass = (i%2==0)?"Grey":"";
		%>
			var str='<input type="hidden" name="person_id" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="id_type" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="person_name" value="<%=retListString1[i][2]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  	newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  	
		<%}%>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0")
			{
				rdShowMessageDialog("您没有选择人员！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1")
			{//值为一条时不需要用数组
				if(document.all.num.checked)
				{
					if(formtype=="form2")
					{
						window.opener.form2.QryValues.value=document.all.person_id.value;
						window.close();
					}
					else if(formtype=="form3")
					{
						window.opener.form3.QryValues.value=document.all.person_id.value;
						window.close();
					}
				}
				else
				{
					rdShowMessageDialog("您没有选择人员！！");
					return false;
				}
			}
			else
			{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++)
				{
					if(document.all.num[i].checked)
					{
						a=i;
						break;
					}
				}
				if(a!=-1)
				{
					if(formtype=="form2")
					{
						window.opener.form2.QryValues.value=document.all.person_id[a].value;
						window.close();
					}
					else if(formtype=="form3")
					{
						window.opener.form3.QryValues.value=document.all.person_id[a].value;
						window.close();
					}
					
				}
				else
				{
					rdShowMessageDialog("您没有选择人员！！");
					return false;
				}
			}
		}
	
	function doClose()
	{
		window.close();
	}
</script>
