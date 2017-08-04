<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
		
		String spCode = request.getParameter("spCode");
		
		
		
	  String opName = "商品规格列表";
	  String opCode = "";
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>


<wtc:pubselect name="sPubSelect" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		select distinct a.Pospec_number,a.pospec_name ,decode(a.status,'A','正常商用','S','内部测试','T','测试待审','R','试商用','未知') ,
		a.pospec_desc,c.sm_code,c.sm_name 
		from dPospecInfo a,sbiztypecode b,ssmcode c 
		where a.end_date>=sysdate 
		and pospec_number ='?' 
		and a.srv_code=b.external_code 
		and b.sm_code=c.sm_code
	</wtc:sql>
	<wtc:param value="<%=spCode%>" />
</wtc:pubselect>
<wtc:array id="retListString1" scope="end" />

<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>


</head>



<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header_pop.jsp" %> 
<table  width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<th height="26" align="center">
			选择
		</th>
		<th  align="center">商品规格编码</th>
		<th align="center">商品规格名称</th>
		<th align="center">商品规格状态</th>
		<th align="center">商品规格描述</th>
	</tr>
	
		<%for(int i=0;i < retListString1.length;i++){%>
		<input type="hidden" name="spCode" value="<%=retListString1[i][0]%>">
		<input type="hidden" name="spName" value="<%=retListString1[i][1]%>">
		<input type="hidden" name="ownPerson" value="<%=retListString1[i][2]%>">
		<input type="hidden" name="linkPerson" value="<%=retListString1[i][3]%>">
		<input type="hidden" name="smCode" value="<%=retListString1[i][4]%>">
		<input type="hidden" name="smName" value="<%=retListString1[i][5]%>">
		<tr>
			<td><input type="radio" name="num" value="<%=i%>"></td>
			<td><%=retListString1[i][0]%></td>
			<td><%=retListString1[i][1]%></td>
			<td><%=retListString1[i][2]%></td>
			<td><%=retListString1[i][3]%></td>
	  </tr>
	  <%}%>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td id="footer">
				<div align="center">
			      <input class='b_foot'  type="button" name="commit" onClick="doCommit();" value=" 确定 ">
			      &nbsp;
			      <input class='b_foot' type="button" name="back" onClick="doClose();" value=" 关闭 ">
		    </div>
		</td>
	</tr>
</table>

</form>
<%@ include file="/npage/include/footer.jsp" %> 
</body>
</html>

<script>
	  


		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("请选择一条记录！");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.form1.spCode.value=document.all.spCode.value;
					window.opener.form1.spName.value=document.all.spName.value;
					window.opener.doSmCode(document.all.smCode.value,document.all.smName.value);
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
					window.opener.form1.spCode.value=document.all.spCode[a].value;
					window.opener.form1.spName.value=document.all.spName[a].value;
					window.opener.doSmCode(document.all.smCode[a].value,document.all.smName[a].value);
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
