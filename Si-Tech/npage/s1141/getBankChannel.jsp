<%
 /**
 * 获取银行渠道
 * version v2.0
 * 开发商: si-tech
 * author: huangrong
 * date  : 20101103
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opCode = "8375";
  String opName = "赠送预存款方案配置";
  String regionCode = (String)session.getAttribute("regCode");
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<title>渠道选择</title>
	</head>
<script type="text/javascript">
//Load RPC Lib
window.onload=function()
{

}

function doChange()
{ 
	var checkboxs=document.getElementsByName("checkbox");
	if(document.all.bankCheck.checked)
	{
		for(var i=0;i<checkboxs.length;i++)
		{
			checkboxs[i].checked=true;
		}
	}else{
		for(var i=0;i<checkboxs.length;i++)
		{
			checkboxs[i].checked=false;
		}				
	}
}

function commitForm(){

	var checkboxs=document.getElementsByName("checkbox");
	var checkedCon=0;
	for(var i=0;i<checkboxs.length;i++)
	{
		if(checkboxs[i].checked)
		{
			checkedCon++;
		}
	}	
	if(checkedCon==0)
	{
		rdShowMessageDialog("请至少选择一个渠道");	
		return false;
	}	
	var retValue="";
	document.all.confirm.disabled = true;	
	for(var i=0;i<checkboxs.length;i++)
	{
		if(checkboxs[i].checked)
		{
			var tab=document.getElementById("tab");
  		var tr=tab.rows[i+1];
  		var tds=tr.childNodes;
  		var num=tds[1].innerHTML;
  		if(retValue=="")
  		{
  			retValue=num;
  		}else
			{
				retValue=retValue+"|"+num;
			}
		}
	}
	window.returnValue = retValue;
	window.close();		
}

</script>
<body>
<%@ include file="/npage/include/header_pop.jsp" %>
 <table cellspacing="0" id="tab">
  <tr align="center">
    <th class="Grey">&nbsp;<input type="checkbox"  name="bankCheck" checked=true style="cursor:hand;" onclick="doChange()"></th>
    <th>渠道代码</th>
    <th>渠道名称</th>
	</tr>
<%
        String tbclass="";
        String bankSql = "select ch_code, ch_name from sChnIdentityMsg where rowid not in ( "+
                         "select  a.rowid from sChnIdentityMsg a,sChnIdentityMsg b "+
                         "where a.ch_code=b.ch_code and a.ch_name=b.ch_name and a.rowid>b.rowid) "+
                         "order by ch_code, ch_name ";
%>			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
			<wtc:sql><%=bankSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="bankArr" scope="end" />			
<%
	  if (retCode.equals( "000000") && bankArr.length>0)
	  {
	  	if(!(bankArr==null))
	  	{
	  	   for(int i=0;i<bankArr.length;i++){
	   		 	if(i%2==0)
					{
						tbclass="Grey";
					}
					else
					{
						tbclass="";
					}
%>	 
					<tr align="center">
					<td class="<%=tbclass%>" ><%=i+1%><input type="checkbox"   checked=true name="checkbox" value="<%=i%>"></td>
					<td class="<%=tbclass%>"><%=bankArr[i][0]%></TD>
					<td class="<%=tbclass%>"><%=bankArr[i][1]%></TD>
					</tr>
<% 	   
				}
	  	}
	  }	
%>		
</table>
<table cellspacing="0">
<tr>
	<td align="center" id="footer">
	<input class="b_foot" type="button" name="confirm" onclick="commitForm();" value="确认">
</td></tr></table>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</body>
</html>

