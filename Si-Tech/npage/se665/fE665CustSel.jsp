<%
/***************************************
***	version v1.0
***	开发商: si-tech
***	作	者：zhangyan
***	日	期：2012/3/5 9:23:14
***************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode 		= "e665";
String opName 		= "集团产品托收关系维护 ";

String pageTitle 	= request.getParameter("pageTitle");
																					
String idIccId 		= request.getParameter("idIccId");
String custId			= request.getParameter("custId");
String unitId 		= request.getParameter("unitId");
String unitName		=	request.getParameter("unitName");
String regionCode	=	request.getParameter("regCode");
String tableHeads	= request.getParameter("tableHeads");
String tHeads[]		=	tableHeads.split("\\|"); 
String sqlCustSel	= "select a.id_iccid,	"
	+"	a.cust_id,												"
	+"	a.cust_name,											"
	+"	b.unit_id,												"
	+"	b.unit_name,											"
	+"	a.org_code,												"
	+"	a.org_id,													"
	+"	rownum id													"
	+"	from dCustDoc a, dCustDocOrgAdd b	"
	+"	where a.cust_id = b.cust_id				";

if (idIccId.trim().length() > 0)
{
	sqlCustSel = sqlCustSel + " and a.id_iccid = '" + idIccId + "'";
}
if (custId.trim().length() > 0)
{
	sqlCustSel = sqlCustSel + " and b.cust_id = " + custId;
}
if (unitId.trim().length() > 0)
{
	sqlCustSel = sqlCustSel + " and b.unit_id = " + unitId;
}
if ( regionCode.trim().length() > 0 )
{
	sqlCustSel = sqlCustSel + " and substr(a.org_code,1,2) = '" 
		+ regionCode +"'"; 
}     	
%>

<wtc:pubselect name="sPubSelect" 
	routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode1" retmsg="retMsg1" outnum="8">
<wtc:sql><%=sqlCustSel%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArr1" scope="end"/>
<%
String custInfos[]=new String [retArr1.length];
for (int i=0;	i<custInfos.length; i++)
{
	custInfos[i]="";
}
for ( int i=0;	i<custInfos.length; i++ )
{
	for (int j=0; j<retArr1[i].length; j ++)
	{
		custInfos[i]+=retArr1[i][j]+"|";
	}
}
%>
<html>
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>
<body>
	
<form name="frmE665CustSel" method = "POST" action="#">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">选择客户</div>
</div>
<table>
	<tr>
	<%
	for (int i=0; i<tHeads.length; i++)
	{
	%>
			<th class="blue" align="center"><%=tHeads[i]%></th>
	<%
	}
	%>
	</tr>	
	<%
	String strClass="";
	for ( int i=0;i<retArr1.length;i++ )
	{
		if( 0==(i%2) )
		{
			strClass="Gray";
		}
		else
		{
			strClass="";
		}
	%>
		<tr class="<%=strClass%>">
			<td align="center">
				<input type="radio" id ="" name="RdoSelCust" 
					value="<%=custInfos[i]%>">
				<%=retArr1[i][0]%>
			</td>
			<td align="center"><%=retArr1[i][1]%></td>
			<td align="center"><%=retArr1[i][2]%></td>
			<td align="center"><%=retArr1[i][3]%></td>
			<td align="center"><%=retArr1[i][4]%></td>
			<td align="center"><%=retArr1[i][5]%></td>
		</tr>	
	<%
	}
	%>
	<tr>
	<td colspan="6" id="footer">
		<input type="radio" id ="" name="RdoSelCust" 
			value="" style="display:none">
		<input class="b_foot" type=button name="query" value="确认" 
			onclick="selCustCfm();">
		<input class="b_foot" type=button name="closeB" value="关闭" 
			onClick="window.close();">
			
			
	</td>
</tr>
</table>
</form>
</body>
</html>
<script language="javascript">
function selCustCfm()
{
	/*此处不能用document.getElementById方法*/
	var objCustInfo=document.frmE665CustSel.RdoSelCust;

	var strCustInfo = "";
	var chkflag = "1";

	for ( var i=0; i<objCustInfo.length; i++ )
	{			
		if (objCustInfo[i].checked)
		{
			strCustInfo=strCustInfo+objCustInfo[i].value+"|";
			chkflag="0";
		}
	}
	
	if ("1"==chkflag)
	{
		rdShowMessageDialog("必须选择客户！",0);
		return false;
	}
	opener.getCustInfo(strCustInfo);
	window.close();
}
</script>