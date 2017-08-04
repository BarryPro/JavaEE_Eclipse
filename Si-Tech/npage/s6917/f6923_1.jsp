<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:世博会门票定单查询
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
 
	String opCode = request.getParameter("opCode");//"6923";
	String opName = request.getParameter("opName");//"世博会门票定单查询";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();
	int nValueNum = 0;
	String InfoNum = request.getParameter("infoNum");
	String infoCode = request.getParameter("infoCode");
	String infoValue = request.getParameter("infoValue");
	String RoleIndex = request.getParameter("sRoleCode");
	String idcard = request.getParameter("idcard");
	String OriginalTime = request.getParameter("OriginalTime");
	String EndTime = request.getParameter("EndTime");
	String  phoneNo = request.getParameter("phone_no");
	String  codeType = request.getParameter("code_type");	
	int nInfoNum = 0;
	String[] infoCodeList = null;
	String[] infoValueList = null;
	if(null != InfoNum)
	{
		nInfoNum = Integer.parseInt(InfoNum.trim());
	}
	
	if(null == infoCode || "" == infoCode.trim())
	{
		infoCode = "01";
	}
	if(null == idcard)
	{
		idcard = "";
	}
	if(null == OriginalTime)
	{
		OriginalTime = "";
	}
	if(null == EndTime)
	{
		EndTime = "";
	}
	infoCodeList = infoCode.split("[|]");
	if(null != infoValue && infoValue.trim().length() > 0)
	{
		infoValueList = infoValue.split("[|]");
		nValueNum = infoValueList.length;
	}
	if(null != RoleIndex && RoleIndex.trim().length() > 0)
	{
	}
	else
	{
		RoleIndex = "0";
	}

	String[][] roleDetailData = new String[7][2];
	roleDetailData[0][0] = "00";
	roleDetailData[1][0] = "11";
	roleDetailData[2][0] = "12";
	roleDetailData[3][0] = "13";
	roleDetailData[4][0] = "98";
	roleDetailData[5][0] = "88";
	roleDetailData[6][0] = "99";
	roleDetailData[0][1] = "身份证";
	roleDetailData[1][1] = "军官证";
	roleDetailData[2][1] = "护照";
	roleDetailData[3][1] = "港澳台通行证";
	roleDetailData[4][1] = "定单号";
	roleDetailData[5][1] = "预定请求中的操作流水号";
	roleDetailData[6][1] = "其它";
	
	%>


<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
onload=function()
{		
	init();
}
var arrInfoCode = new Array();
var arrInfoValue = new Array();  
var infoNum = <%=nInfoNum%>;

// 初始化
function init()
{
	document.all.sRoleCode.options[<%=Integer.parseInt(RoleIndex)%>].selected = true;
	document.all.idcard.value = "<%=idcard%>";
	document.all.OriginalTime.value = "<%=OriginalTime%>";
	document.all.EndTime.value = "<%=EndTime%>";
	<%for(int i = 0; i<nValueNum ; i++)
	  {%>
	  	document.all.info_code[<%=i%>].options[<%=Integer.parseInt(infoCodeList[i])-1%>].selected = true;
	  	document.all.info_value[<%=i%>].value ="<%=infoValueList[i]%>";
	  <%}%>
	if(infoNum > 0)
	{
		document.getElementById("tr_value_note").style.display = "";
	}	
	else
	{
		document.getElementById("tr_value_note").style.display = "none";
	}
	
}
function getBytesLength(str) { 
	return str.replace(/[^\x00-\xff]/gi, "--").length; 
}
function addInfo()
{
	if(1 == infoNum)
	{
		document.all.info_code_array.value = document.all.info_code.value;
		document.all.info_value_array.value = document.all.info_value.value;
	}
	else
	{
		for(var i = 0; i < infoNum; i++)
		{
			if(document.all.info_value[i].value.trim() != "")
			{
				if("" == document.all.info_code_array.value)
				{
					document.all.info_code_array.value = document.all.info_code[i].value;
					document.all.info_value_array.value = document.all.info_value[i].value;
				}
				else
				{
					document.all.info_code_array.value = document.all.info_code_array.value + "|" + document.all.info_code[i].value;
					document.all.info_value_array.value = document.all.info_value_array.value + "|" + document.all.info_value[i].value;
				}
			}
		}
	}
	infoNum = infoNum + 1;
	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&infoNum="+infoNum+"&infoCode="+document.all.info_code_array.value+"&infoValue="+document.all.info_value_array.value+"&sRoleCode="+document.all.sRoleCode.selectedIndex+"&idcard="+document.all.idcard.value+"&OriginalTime="+document.all.OriginalTime.value+"&EndTime="+document.all.EndTime.value+"&phone_no="+document.all.phone_no.value+"&code_type="+document.all.code_type.value;
}
function commitJsp()
{
	getAfterPrompt();
		var tmpStr="";
		var procSql = "";
		if(document.all.idcard.value.trim().length <=0)
		{
			rdShowMessageDialog("请输入标识号码!");
			return false;					
		}	
		if(getBytesLength(document.all.idcard.value.trim()) > 32)
		{
			rdShowMessageDialog("证件号码必须少于32个英文字符或16个中文字符!",1);
			return;
		}
		if(document.all.OriginalTime.value.trim().length <=0)
		{
			rdShowMessageDialog("请输入起始日期!");
			return false;					
		}
		if(document.all.EndTime.value.trim().length <=0)
		{
			rdShowMessageDialog("请输入终止日期!");
			return false;					
		}
		if(1 == infoNum)
		{
			document.all.info_code_array.value = document.all.info_code.value;
			document.all.info_value_array.value = document.all.info_value.value;
			if(document.all.info_code.value == "06" && document.all.info_value.value.trim().length < 10 && document.all.info_value.value.trim().length != 0)
			{
				rdShowMessageDialog("营业厅编号必须为10位，不足请在前面补0!");
				return false;					
			}
		}
		else
		{
			for(var i = 0; i < infoNum; i++)
			{
				if(document.all.info_value[i].value.trim() != "")
				{
					if(document.all.info_code[i].value == "06" && document.all.info_value[i].value.trim().length < 10)
					{
						rdShowMessageDialog("营业厅编号必须为10位，不足请在前面补0!");
						return false;					
					}
					if("" == document.all.info_code_array.value)
					{
						document.all.info_code_array.value = document.all.info_code[i].value;
						document.all.info_value_array.value = document.all.info_value[i].value;
					}
					else
					{
						document.all.info_code_array.value = document.all.info_code_array.value + "|" + document.all.info_code[i].value;
						document.all.info_value_array.value = document.all.info_value_array.value + "|" + document.all.info_value[i].value;
					}
				}
			}
		}
		frm6923.submit();
}

function selectInput(choose)
{ 
	
}

function Clear()
{
	document.all.idcard.value = "";
	document.all.OriginalTime.value = "";
	document.all.EndTime.value = "";
	for(var i = 0; i < infoNum; i++)
	{
		document.all.info_code[i].options[0].selected = true;
		document.all.sRoleCode.options[0].selected = true;
		document.all.info_value[i].value = "";
	}
}
</script> 
 
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6923_2.jsp" method="post" name="frm6923"  >
	<input type="hidden" name="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_name" value="<%=opName%>">
	<input type="hidden" name="info_code_array" value="">
	<input type="hidden" name="info_value_array" value="">
	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
	<input type="hidden" name="code_type" value="<%=codeType%>">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr> 
		<td class="blue" nowrap width="20%">标识类型:</td>
		<td> 
			<select type="text" name="sRoleCode" class="button" id="sRoleCode" v_must="1" onchange="selectInput(this)"> 
			    <%for (int i = 0; i < roleDetailData.length; i++) {%>
			      <option value="<%=roleDetailData[i][0]%>"><%=roleDetailData[i][0]%>-><%=roleDetailData[i][1]%>
			      </option>
			    <%}%>
      		</select>
    	</td>
  	</tr>
	<tr >
		<td class="blue" width="20%">标识号码:</td>
		<td> 
			<input name="idcard" type="text" id="idcard" size="32" maxlength="32"  v_name="标识号码"><font color="red"> *</font></td>
    	</td>
	</tr>
	<tr >
		<td class="blue" width="20%">起始日期(YYYYMMDD):</td>
		<td> 
			<input name="OriginalTime" type="text" id="OriginalTime" size="32" maxlength="8" onKeyPress="return isKeyNumberdot(0)" ><font color="red"> *</font></td>
    	</td>
	</tr>
	<tr> 	
		<td class="blue" width="20%">终止日期(YYYYMMDD):</td>
		<td> 
			<input name="EndTime" type="text" id="EndTime" size="32" maxlength="8" onKeyPress="return isKeyNumberdot(0)" ><font color="red"> *</font></td>
    	</td>
	</tr>
	<%for(int i = 0; i<nInfoNum ; i++)
	  {%>
		  <tr> 
			<td class="blue" >附加查询条件<%=i+1%>:</td>
			<td> 
				<select type="text" name="info_code" class="button" id="info_code" v_must="1" onchange="selectInput(this)"> 
				   <option value="01">01->收票人姓名  </option>
				   <option value="02">02->收票人手机号码</option>
				   <option value="03">03->收票人有效证件类型</option>
				   <option value="04">04->收票人有效证件号码</option>
				   <option value="05">05->受理省份</option>
				   <option value="06">06->发起请求的营业厅编号</option>
				   <option value="07">07->操作员编号</option>
	      		</select>
	    	</td>
	  	</tr>
		<tr id="tr_value_input">
			<td class="blue" width="20%">值:</td>
			<td> 
				<input name="info_value" type="text" id="info_value" size="32" maxlength="128" text="">
	    	</td>
		</tr>
	  <%}%>
	 
	<tr >
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commitJsp()">	
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="增加条件" onclick="addInfo()">	
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="清除" onclick="Clear()">	
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="关闭" onclick=removeCurrentTab();>	
		</td>
	</tr>
	<tr id="tr_value_note">
       <td colspan="3" class="blue" >附加查询条件说明：<br>
              &nbsp;&nbsp;&nbsp;1、收票人有效证件类型为：<br>
              <%for (int t = 0; t < roleDetailData.length; t++) {%>
		      
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=roleDetailData[t][1]%>请填"<%=roleDetailData[t][0]%>"<br>
		   		
		    <%}%>
		   	 &nbsp;&nbsp;&nbsp;2、受理省份:黑龙江请填"451"<br>
		     &nbsp;&nbsp;&nbsp;3、不填具体值则此附加查询条件不生效<br>
	  </td>
	</tr>
</table>

	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
