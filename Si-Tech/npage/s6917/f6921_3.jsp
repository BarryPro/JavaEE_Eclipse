<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票配送信息更改
   * 版本: 1.0
   * 日期: 2009/5/14
   * 作者: wangjya
   * 版权: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6921";
	String opName = "世博会门票配送信息更改";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
	String orderCode = request.getParameter("order_code");
	
	String mobile_no = null == request.getParameter("mobile_no") ? "" : request.getParameter("mobile_no");
	String cust_name = null == request.getParameter("cust_name") ? "" : request.getParameter("cust_name");
	String id_type = null == request.getParameter("id_type") ? "" : request.getParameter("id_type");
	String id_card = null == request.getParameter("id_card") ? "" : request.getParameter("id_card");
	String ticket_type = null == request.getParameter("ticket_type") ? "" : request.getParameter("ticket_type");
	String ticket_sum = null == request.getParameter("ticket_sum") ? "" : request.getParameter("ticket_sum");
	String ticket_date = null == request.getParameter("ticket_date") ? "" : request.getParameter("ticket_date");

	StringBuffer  insql = new StringBuffer();
	
	insql.append("select idtype_code,idtype_name ");
	insql.append(" from sidcardcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by idtype_code  ");
	System.out.println("insql====="+insql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="idtypearray" scope="end" />
	
	
	
<%	String inputParsm[] = new String[3];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = orderCode;
%>

   <wtc:service name="s6921Query" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="2"  scope="end"/>
<% 		

	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("<%=errCode%>" + "<%=errMsg%>",0);	
	 	window.location="f6923_1.jsp?opCode=6921&opName=世博会门票配送信息更改";
		</script>
<%		
		return;				 			
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
onload=function()
{		
	init();
}

// 初始化
function init()
{

}

function doNothing()
{
	
}	
function getBytesLength(str) { 
	return str.replace(/[^\x00-\xff]/gi, "--").length; 
}
function commitJsp()
{
	getAfterPrompt();
	if(document.all.id_card.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入证件号码!",1);
		return;
	}
	if(document.all.cust_name.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入收票人姓名!",1);
		return;
	}
	if(document.all.mobile_no.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入手机号码!",1);
		return;
	}
	if(document.all.phone_no.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入固话号码!",1);
		return;
	}
	if(document.all.cust_address.value.trim().length == 0)
	{
		rdShowMessageDialog("请输入详细地址!",1);
		return;
	}
	if(document.all.post_code.value.trim().length != 6)
	{
		rdShowMessageDialog("邮编必须为6位!",1);
		return;
	}
	if(getBytesLength(document.all.post_code.value.trim()) != 6)
	{
		rdShowMessageDialog("邮编必须为数字!",1);
		return;
	}
	if(getBytesLength(document.all.id_card.value.trim()) > 32)
	{
		rdShowMessageDialog("证件号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}
	if(getBytesLength(document.all.cust_name.value.trim()) > 32)
	{
		rdShowMessageDialog("收票人姓名必须少于32个英文字符或16个中文字符!",1);
		
		return;
	}
	if(getBytesLength(document.all.mobile_no.value.trim()) > 32)
	{
		rdShowMessageDialog("手机号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}
	if(getBytesLength(document.all.phone_no.value.trim()) > 32)
	{
		rdShowMessageDialog("固话号码必须少于32个英文字符或16个中文字符!",1);
		return;
	}
	if(getBytesLength(document.all.cust_address.value.trim()) > 128)
	{
		rdShowMessageDialog("详细地址必须少于128个英文字符或64个中文字符!",1);
		return;
	}
	document.all.mobileNo.value=document.all.mobile_no.value;
	document.all.phoneNo.value=document.all.phone_no.value;
	document.all.custName.value=document.all.cust_name.value;
	document.all.idType.value=document.all.sid_type.value;
	document.all.idCard.value=document.all.id_card.value;
	document.all.custAddress.value=document.all.cust_address.value;
	document.all.postCode.value=document.all.post_code.value;
	form6921.submit();
}
function resetjsp()
{
	with(document.form6921)
	{
		mobile_no.value = "";
		phone_no.value="";
		cust_name.value="";
		id_card.value="";
		cust_address.value="";
		post_code.value="";
	}	
	
}
	
</script> 
 
<title>世博会门票配送信息更改</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form6921" method="post" action="f6921_4.jsp">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会门票配送信息更改</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>				
				<td width="20%" class="blue"><b>收票人手机号码</b></td>
				<td> 
					<input name="mobile_no" type="text" id="mobile_no" size="32" maxlength="32" value="<%=mobile_no%>"><font color="red"> *</font></td>
    			</td>
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>收票人固话号码</b></td>
				<td> 
					<input name="phone_no" type="text" id="phone_no" size="32" maxlength="32" ><font color="red"> *</font></td>
    			</td>
    		</tr>
			<tr>				
				<td width="20%" class="blue"><b>收票人姓名</b></td>
				<td> 
					<input name="cust_name" type="text" id="cust_name" size="32" maxlength="32" value="<%=cust_name%>" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人有效证件类型</b></td>
				<td>
					<select type="text" name="sid_type" class="button" id="sid_type" v_must="1" onchange="doNothing()"> 
					<%for (int i = 0; i < idtypearray.length; i++) 
					{
					  if(idtypearray[i][0].trim().equals(id_type.trim()))	
					  {%>
					  	<option value="<%=idtypearray[i][0]%>" selected><%=idtypearray[i][0]%>-><%=idtypearray[i][1]%></option>
				      <%}
				      else
				      {%>
				      	<option value="<%=idtypearray[i][0]%>"><%=idtypearray[i][0]%>-><%=idtypearray[i][1]%></option>
				      
				      <%}
				    }%> 
					</select>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人有效证件号码</b></td>
				<td> 
					<input name="id_card" type="text" id="id_card" size="32" maxlength="32" value="<%=id_card%>"><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人详细地址</b></td>
				<td> 
					<input name="cust_address" type="text" id="cust_address" size="32" maxlength="128" ><font color="red"> *</font></td>
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人邮政编码</b></td>
				<td> 
					<input name="post_code" type="text" id="post_code" onKeyPress="return isKeyNumberdot(0)"  size="32" maxlength="6" ><font color="red"> *</font>
    			</td>
    		</tr>
	<tr> 
		<td align="center" id="footer" colspan="3"> 
			<input type="button" name="delete" class="b_foot" value="确认" onclick=commitJsp();>
				&nbsp;
			<input type="button" name="delete" class="b_foot" value="清除" onclick=resetjsp()>
				&nbsp;
			<input type="button" name="delete" class="b_foot" value="关闭" onclick=removeCurrentTab();>
		
		</td>
	</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="order_code" value="<%=orderCode%>">
<input type="hidden" name="mobileNo" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="custName" value="">
<input type="hidden" name="idType" value="">
<input type="hidden" name="idCard" value="">
<input type="hidden" name="custAddress" value="">
<input type="hidden" name="postCode" value="">
<input type="hidden" name="ticket_type" value="<%=ticket_type%>">
<input type="hidden" name="ticket_sum" value="<%=ticket_sum%>">
<input type="hidden" name="ticket_date" value="<%=ticket_date%>">	
</form>
</BODY>
</HTML>
