<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
		Logger logger = Logger.getLogger("s2894_qryProdCode.jsp");
		
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String org_code = orgCode;
		String impRegion = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String regionCode = impRegion;
	
		ArrayList retList1 = new ArrayList();  
		String sqlStr1="";
		
		String prodCode = request.getParameter("prodCode");
		String smCode = request.getParameter("smCode");
		
		sqlStr1 = " SELECT distinct A.OFFER_ID, A.OFFER_NAME, A.OFFER_COMMENTS "
				+" FROM PRODUCT_OFFER A, BAND B, REGION C, SREGIONCODE D "
				+" WHERE A.BAND_ID = B.BAND_ID "
				+" AND A.OFFER_ID = C.OFFER_ID "
				+" AND C.GROUP_ID = D.GROUP_ID(+) "
				+" AND A.OFFER_ATTR_TYPE = 'JT' "
				+" AND A.OFFER_TYPE = '10' and (d.region_code ='"+regionCode+"' or C.GROUP_ID = '10014')  "
				+" AND A.EXP_DATE > SYSDATE "
				+" AND B.SM_CODE = '" + smCode + "'   "
				+" AND NOT EXISTS (SELECT 1 FROM sSrvCodeOfferDeploy e WHERE a.offer_id=e.offer_id AND e.isyear = 1 ) "
				+" ORDER BY A.OFFER_ID ";
		
		
		//retList1 = impl.sPubSelect("3",sqlStr1,"region",impRegion);
    %>
        <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr1%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
		String[][] retListString1 = retArr;
		String errCode=retCode;
		String errMsg=retMsg;
		
	    String op_name = "产品列表";
        String opName = op_name;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<div id="Operation_Table">
<table cellspacing=0 id="tab1">
	<tr>
		<th nowrap>选择</th>
		<th nowrap>产品代码</th>
		<th nowrap>产品名称</th>
		<th nowrap>产品描述</th>
	</tr>
</table>
<table cellspacing=0>
<tr id="footer">
    <td>
        <input type="button" class="b_foot" name="commit" onClick="doCommit();" value=" 确定 ">
        <input type="button" class="b_foot" name="back" onClick="doClose();" value=" 关闭 ">
    </td>
</tr>
</table>
</div>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="prodCode" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="prodName" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="prodNote" value="<%=retListString1[i][2]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		<%}%>

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
