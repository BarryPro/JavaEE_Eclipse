<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>赠送预存款方案审批</title>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String opCode = "8378";
	String opName = "赠送预存款方案审批";
	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode  = (String)session.getAttribute("regCode");
	String belongName = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	String pass = (String)session.getAttribute("password");
	String tMemberProperty = "";
	String PrintAccept="";
	PrintAccept = getMaxAccept();

	String paraAray[] = new String[7];
	paraAray[0] = PrintAccept;
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = workNo;
	paraAray[4] = pass;
	paraAray[5] = " ";
	paraAray[6] = " ";

%>

<wtc:service name="s8378Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg" outnum="12">
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
</wtc:service>
<wtc:array id="rows" start="2" length="10" scope="end" />

<%
	if(!errCode.equals("000000") && !errCode.equals("0"))
	{%> 
	<script language="JavaScript">
  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
    </script>
<%}%>
<script>
function selAccept(accept)
{
	document.all.inLoginAccept.value=accept;
	document.getElementById('oprAuditTable').style.display="";
}
function doReset()
{
		document.frm.reset();
}
function doCheckAcc()
{
	if(document.all.sIsAuditPass.value!="none")
	{
		document.all.confirmButton.disabled = false;
	}else{

		document.all.confirmButton.disabled = true;	
	}
}
function FindInfo(vProjectType,vProjectCode,vRegionCode,obj)
{
	var opCode='8378';
	frm.action="f8377_Detail.jsp?projectcode="+vProjectCode+"&opcode="+opCode+"&projecttype="+vProjectType+"&RegionCode="+vRegionCode+"";
	frm.submit();
}
function doConfirm()
{
	if(document.frm.sAuditSuggestion.value.trim().len()==0)
	{
		rdShowMessageDialog("审批意见不可为空!");
		return false;	
	}
	frm.submit();
	return true;
}
</script>
</head>
<body>
<form name="frm" method="post" action="f8378_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div id="productList" >
<div class="title">
    <div id="title_zi">赠送预存款方案审批</div>
</div>
<table cellspacing="0">
	<tr align="center">
		<th nowrap>请选择</th>
		<th nowrap>区域名称</th>
		<th nowrap>活动类型</th>
		<th nowrap>类型名称</th>
		<th nowrap>活动代码</th>
		<th nowrap>活动名称</th>
		<th nowrap>操作流水</th>
		<th nowrap>入网时间</th>
		<th nowrap>操作</th> 
	</tr>
	<%
	for(int i=0;i<rows.length;i++)
	{
	%>
		<tr align="center">
			<td nowrap><input type="radio" name="SelAccept" value="<%=rows[i][5]%>" onclick="selAccept(this.value);"/></td>
	        	<input type="hidden" name="tMemberProperty" id="tMemberProperty" value="<%=tMemberProperty%>" >
	        	<input type="hidden" name="vRegionCode" id="vRegionCode" value="<%=rows[i][6]%>" >
	        </td>
	        <td nowrap name="vRegionname"	><%=rows[i][0]%></td>
	        <td nowrap name="vProjectType"	><%=rows[i][1]%></td>
	        <td nowrap name="vTypeName"		><%=rows[i][2]%></td> 
	        <td nowrap name="vProjectCode"	><%=rows[i][3]%></td>   
	        <td nowrap name="vProjectName"	><%=rows[i][4]%></td>   
	        <td nowrap name="vLoginAccept"	><%=rows[i][5]%></td>
	        <td nowrap name=""	><%=rows[i][7]%></td>
	        <td nowrap>
	         <input type="button" name="Find" onclick="FindInfo('<%=rows[i][1]%>','<%=rows[i][3]%>','<%=rows[i][6]%>',this)" class="b_text" value="查询详细信息" >&nbsp;&nbsp;
	        </td>   
		</tr>
	<%}%>
	</tr>
</table>
</div>	
<br/>
<div class="title">
    <div id="title_zi">审批意见</div>
</div>
<table id="oprAuditTable" style="display:none" cellspacing="0">
	<tr>
		<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审核是否通过</td>
		<td>
			<select name="sIsAuditPass" onchange="doCheckAcc()">
				<option value="none">-请选择-</option>
				<option value="Y">是</option>
				<option value="N">否</option>
			</select>						
		</td>
	</tr>
	<tr>
		<td width="15%" class="blue" nowrap>&nbsp;&nbsp;审批意见</td>
		<td>
			<input type="text" name="sAuditSuggestion" value="" size="80" maxlength="60">					
		</td>
	</tr>
		<input type="hidden" name="systemNote" value="" size="80" maxlength="60" readonly>
	<tr>
		<td class="blue" nowrap>&nbsp;&nbsp;操作备注</td>
		<td><input type="text" name="opNote" value="" size="80" maxlength="60"></td>
	</tr>
</table>	

<table cellSpacing="0">
	<tr> 
		<td id="footer"> 
			<input type="button" name="resetButton"   class="b_foot" value="重置"  onclick="doReset()" >&nbsp;
			<input type="button" name="confirmButton" class="b_foot" value="确定"  onClick="doConfirm()" disabled>&nbsp;
			<input type="button" name="closeButton"   class="b_foot" value="关闭" onClick="removeCurrentTab()" >&nbsp;
		</td>
	</tr>
</table>
</div>
		<input type="hidden" name="inLoginAccept" id="inLoginAccept" value="" />
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>