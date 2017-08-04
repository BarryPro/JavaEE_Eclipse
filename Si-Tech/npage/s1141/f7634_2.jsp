<%
/********************
 version v2.0
 开发商: si-tech
 update sunaj at 2009.9.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>TD修改IMEI绑定关系</title>
<%
	
    String opCode = "7634";
    String opName = "TD修改IMEI绑定关系";
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode"); 
  	String passWord = (String)session.getAttribute("password");   
  	String phoneNo = request.getParameter("srv_no");
  	String printAccept="";
	printAccept = getMaxAccept(); 

	String paraAray[] = new String[7];
	paraAray[0] = printAccept;
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = loginNo;
	paraAray[4] = passWord;
	paraAray[5] = phoneNo;
	paraAray[6] = " ";

%>
<wtc:service name="s7634Qry" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg" outnum="11">
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
</wtc:service>
<wtc:array id="rows" start="2" length="9" scope="end" />
<%
	if(!errCode.equals("000000") && !errCode.equals("0"))
	{%> 
	<script language="JavaScript">
  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
  		history.go(-1);
    </script>
<%}%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>

function controlButt(subButton)
{
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}

//----------------验证及提交函数-----------------
function doReset()
{
		document.frm.reset();
}
function doConfirm()
{
	if(document.frm.new_imei.value.trim().length > 0 && document.frm.new_imei.value.trim().length !=15)
	{
	   rdShowMessageDialog("新IMEI码位数不正确，请重新输入!");
	   document.frm.new_imei.value="";
	   document.frm.new_imei.focus();
	   return false;
	}
	if(isNaN(document.frm.new_imei.value.trim()))
	{
		 rdShowMessageDialog("新IMEI码请输入数字!");
		 return false;
	}

  	//controlButt(subButton); //延时控制按钮的可用性
	document.frm.action="f7634_3.jsp"
	frm.submit();
	document.frm.confirm.disabled=true;
	return true;
}
</script>
</head>
<body>
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div id="productList" >
<div class="title">
    <div id="title_zi">基本信息</div>
</div>
<table cellspacing="0">
	<tr align="center">
		<th nowrap>品牌型号</th>
		<th nowrap>营销案名称</th>
		<th nowrap>IMEI码</th>
		<th nowrap>营销案生效时间</th>
		<th nowrap>营销案结束时间</th>
	</tr>
	<%
	for(int i=0;i<rows.length;i++)
	{
	%>
		<tr align="center">
	        <td nowrap name="vTypeName"	><%=rows[i][0]%></td>
	        <td nowrap name="vSaleName"	><%=rows[i][1]%></td>
	        <td nowrap name="vOldImei"	><%=rows[i][2]%></td> 
	        <td nowrap name="vBeginTime"><%=rows[i][3]%></td>   
	        <td nowrap name="vEndTime"	><%=rows[i][4]%></td>   
		</tr>
	<%}%>
</table>
</div>	
<br/>
<div class="title">
    <div id="title_zi">新IMEI码</div>
</div>
<table id="oprAuditTable" style="display:" cellspacing="0">
	<tr>
		<td width="15%" class="blue" nowrap>新IMEI码</td>
		<td>
			<input type="text" name="new_imei"  name="new_imei" size="15" maxlength="15">
			<font color="orange">*</font>					
		</td>
</table>	
<table cellSpacing="0">
	<tr> 
		<td id="footer"> 
			<input type="button" name="confirm" class="b_foot" value="确定"  onClick="doConfirm()">&nbsp;
			<input type="button" name="resetButton"   class="b_foot" value="清除"  onclick="doReset()" >&nbsp;
			<input type="button" name="closeButton"   class="b_foot" value="关闭" onClick="removeCurrentTab()" >&nbsp;
		</td>
	</tr>
</table>
</div>
		<input type="hidden" name="login_accept" value="<%=printAccept%>" />
		<input type="hidden" name="phone_no" value="<%=phoneNo%>" />  
		<input type="hidden" name="opCode" value="<%=opCode%>" />
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>