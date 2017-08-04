<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:世博会取票二维码补发
   * 版本: 1.0
   * 日期: 2009/5/13
   * 作者: wangjya
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6922";
	String opName = "世博会取票二维码补发";
	String orgCode =(String)session.getAttribute("orgCode");
	String workNo =(String)session.getAttribute("workNo");
	String custType = request.getParameter("cust_type");
	
	String  phoneNo = request.getParameter("phone_no");

	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

	insql.append("select idtype_code,idtype_name ");
	insql.append(" from sidcardcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by idtype_code  ");
	System.out.println("insql====="+insql);
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />
<%
	
	String  inputParsm [] = new String[4];
	String  phone_no = request.getParameter("phone_no");
	String  password = request.getParameter("phone_password");
	
	if(custType.equals("0"))
	{
		inputParsm[0] = workNo;
		inputParsm[1] = opCode;
		inputParsm[2] = phone_no;
		inputParsm[3] = password;
	%>	
	    <wtc:service name="s6922Query" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2">			
		<wtc:param value="<%=inputParsm[0]%>"/>	
		<wtc:param value="<%=inputParsm[1]%>"/>	
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>	
		</wtc:service>	
		<wtc:array id="tempArr" start="0" length="2"  scope="end"/>
	<% 		
		if(!(errCode.equals("000000")))
		{
	%>
			<script language="javascript">
		 	rdShowMessageDialog("校验失败！" + "[<%=errCode%>]"+ "<%=errMsg%>",0);	
		 	window.location="f6922_1.jsp?opCode=6922&opName=世博会取票二维码补发";
			</script>
	<%		
			return;				 			
		}
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
function commitJsp()
{	
	if(document.all.code_type.value == "")
	{
		rdShowMessageDialog("请选择二维码类型!");
		return false;					
	}
	getAfterPrompt();
	frm6922.submit();
}



function Clear()
{
	document.all.idcard.value = "";
}
</script> 
 
<title>世博会取票二维码补发</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6923_1.jsp" method="post" name="frm6922"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="phone_no" value="<%=phone_no%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会取票二维码补发</div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr> 
		<td class="blue" >手机号码:</td>
		<td class="blue" ><%=phone_no%></td>	
  	</tr>
  	<tr id="tr_code_type">				
		<td width="20%" class="blue">二维码类型</td>
		<td> 
			<select type="text" name="code_type" class="button" id="code_type" v_must="1" > 
			  <option value="">--请选择--</option>	
		      <option value="00">其他品牌</option>
		      <option value="01">诺基亚手机</option>
		      <option value="02">您的手机不支持彩信</option>		
			</select>
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commitJsp()">	
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="清除" onclick="Clear()">		
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
