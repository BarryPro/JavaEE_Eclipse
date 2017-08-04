<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		
		
		String prodCode = request.getParameter("prodCode");
		String smCode = request.getParameter("smCode");
		
		
		
	  String opName = "产品列表";
	  String opCode = "";
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>
<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		SELECT a.offer_id,a.offer_name,a.offer_comments FROM product_offer a, band b WHERE a.band_id = b.band_id AND a.offer_attr_type='JT' AND b.sm_code = '?' AND not exists(select 1 from SSRVCODEOFFERDEPLOY c where c.offer_id=a.offer_id) ORDER BY a.offer_id
	</wtc:sql>
	<wtc:param value="<%=smCode%>" />
</wtc:pubselect>
<wtc:array id="retListString1" scope="end" />
<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
//window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header_pop.jsp" %> 
<table width="99%" id="tab1" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
		<th height="26" align="center">
			选择
		</th>
		<th  align="center">产品代码</th>
		<th align="center">产品名称</th>
		<th align="center">产品描述</th>
	</tr>
	<%for(int i=0;i < retListString1.length;i++){ %>
		<input type="hidden" name="prodCode" value="<%=retListString1[i][0]%>">
		<input type="hidden" name="prodName" value="<%=retListString1[i][1]%>">
		<input type="hidden" name="prodNote" value="<%=retListString1[i][2]%>">
		<tr>
			<td><input type="radio" name="num" value="<%=i%>"></td>
			<td><%=retListString1[i][0]%></td>
			<td><%=retListString1[i][1]%></td>
			<td><%=retListString1[i][2]%></td>
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
</div>
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
					window.opener.form1.prodCode.value=document.all.prodCode.value;
					window.opener.form1.prodName.value=document.all.prodName.value;
					window.opener.form1.prodNote.value=document.all.prodNote.value;
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
					window.opener.form1.prodCode.value=document.all.prodCode[a].value;
					window.opener.form1.prodName.value=document.all.prodName[a].value;
					window.opener.form1.prodNote.value=document.all.prodNote[a].value;
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
