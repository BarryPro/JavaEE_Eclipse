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
<%@ page import="com.sitech.boss.util.page.*"%>

<%
String opCode 			= "e665";
String opName 			= "集团产品托收关系维护 ";
String regCode			= WtcUtil.repNull((String)session.getAttribute("regCode"));
String tableHeads		= WtcUtil.repStr(request.getParameter("tableHeads"), "");
String postBankName	= WtcUtil.repStr(request.getParameter("postBankName"), "");
String sqlStr				=		 "select POST_BANK_CODE,BANK_NAME , rownum id "
	+"from sPostCode " 
	+"where REGION_CODE = '" 
	+ regCode+ "'";
if(!postBankName.equals("") )
{
	sqlStr = sqlStr + " and BANK_NAME like '%" 
		+ postBankName+ "%'";
}
sqlStr = sqlStr + "  order by POST_BANK_CODE " ;

												
String tHeads[]		=	tableHeads.split("\\|");    

int iPageNumber = request.getParameter("pageNumber")
	==null?1:Integer.parseInt(request.getParameter("pageNumber"));
int iPageSize = 25;
int iStartPos = (iPageNumber-1)*iPageSize;
int iEndPos = iPageNumber*iPageSize;
String sqlRst			= "select *  from  ( "+ sqlStr +" )   where id <"+iEndPos
	+" and id>="+iStartPos;
String sqlCnt			="select count(1) from ( "+ sqlStr +" ) "; 	
%>

<wtc:pubselect name="sPubSelect" 
	routerKey="region" routerValue="<%=regCode%>" 
	retcode="retCode1" retmsg="retMsg1" outnum="8">
<wtc:sql><%=sqlRst%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArr1" scope="end"/>
	
<wtc:pubselect name="sPubSelect" 
	routerKey="region" routerValue="<%=regCode%>" 
	retcode="retCode1" retmsg="retMsg1" outnum="8">
<wtc:sql><%=sqlCnt%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retCnt" scope="end"/>		
	
<%
String allRecordsNum=retCnt[0][0];
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
	%>
		<tr class="<%=strClass%>">
			<td align="center">
				<input type="radio" id ="" name="RdoSelCust" 
					value="<%=custInfos[i]%>">
				<%=retArr1[i][0]%>
			</td>
			<td align="center"><%=retArr1[i][1]%></td>
		</tr>	
	<%
	}
	%>
	
	<tr>
		<td colspan = "2">
		<%	
			int iQuantity = Integer.parseInt(allRecordsNum);
			//int iQuantity = 500;
			Page pg = new Page(iPageNumber,25,iQuantity);
			PageView view = new PageView(request,out,pg); 
			view.setVisible(true,true,0,0);       
		%>
		</td>	
	</tr>	
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
	opener.getPostBankInfo(strCustInfo);
	window.close();
}
</script>