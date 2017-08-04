<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:世博会门票预定
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
 
	String opCode = "6917";
	String opName = "世博会门票预定";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />

<% 		
	if(!(retCode1.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("查询票种名称失败！" + "[<%=retCode1%>]"+ "<%=retMsg1%>");	
	 	removeCurrentTab();
		</script>
<%		
		return;				 			
	}
	if(0 == roleDetailData.length)
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("查询票种名称失败！");	
	 	removeCurrentTab();
		</script>
<%		
		return;				 			
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	


//var arrtktname = new Array(); 
//var arrtktcode = new Array();  
var arrtkttype = new Array();
var arrtktsum = new Array();  
var arrtktdate = new Array();
var arrtkttag = new Array();

onload=function()
{		
	init();
}

// 初始化
function init()
{
	selectInput(document.all.sRoleCode);
	//arrtktbegindate.clear();
	//arrtkttype.clear();
	//arrtktenddate.clear();
}
function commitJsp()
{
	getAfterPrompt();
		if(IList.rows.length <=1)
		{
			rdShowMessageDialog("请增加预定项!");
			return false;					
		}	
		for(var i = 0; i < IList.rows.length - 1; i++)
		{
			if("" == document.all.tkt_type_array.value)
			{
				document.all.tkt_type_array.value = arrtkttype[i];
				document.all.tkt_sum_array.value = arrtktsum[i];
				document.all.tkt_date_array.value = arrtktdate[i];
				document.all.tkt_tag_array.value = arrtkttag[i];
			}
			else
			{
				document.all.tkt_type_array.value = document.all.tkt_type_array.value + "|" + arrtkttype[i];
				document.all.tkt_sum_array.value = document.all.tkt_sum_array.value + "|" + arrtktsum[i];
				document.all.tkt_date_array.value = document.all.tkt_date_array.value + "|" + arrtktdate[i];
				document.all.tkt_tag_array.value = document.all.tkt_tag_array.value + "|" + arrtkttag[i];
			}
		}
		if(document.all.tkt_type_array.value.length > 256
		   || document.all.tkt_sum_array.value.length > 256
		   || document.all.tkt_date_array.value.length > 256
		   || document.all.tkt_tag_array.value.length > 256
		   )
		{
			rdShowMessageDialog("请删除预定项!");
			document.all.tkt_type_array.value="";
		    document.all.tkt_sum_array.value="";
		    document.all.tkt_date_array.value="";
		    document.all.tkt_tag_array.value="";
			return false;
		}
	
		frm6917.submit();
}

function AddRow()
{
	
	var i = 0;
	for(;i < arrtkttype.length;i++)
	{
		if(arrtkttype[i] == document.all.sRoleCode.value)
		{
			rdShowMessageDialog("同一票种只能添加一次!");	
	 		return;
		}
		if(arrtkttag[i] != document.all.groupTag.value)
		{
			rdShowMessageDialog("一个订单只能添加一种售票类型!");	
	 		return;
		}
	}
	
	if((document.all.sRoleCode.value != "03") && (document.all.groupTag.value == "1"))
	{
		rdShowMessageDialog("只有平日普通票才允许购买团体票!");
		document.all.groupTag.value="0";
	 	return;
	}
	if(document.all.groupTag.value==1 && document.all.tkt_sum.value < 30)
	{
		rdShowMessageDialog("团体票订单票张数必须大于或等于30张!");
		document.all.tkt_sum.value = "";
		document.all.groupTag.value="0";
	 	return;
	}
	
	if(document.all.tkt_sum.value.trim()=="")
	{
	  rdShowMessageDialog("请输入票数");	
	  return;
	}
	if(document.all.tkt_sum.value > 50000)
	{
		rdShowMessageDialog("票数不能大于50000张");
		return;
	}
	
	if(document.all.sRoleCode.selectedIndex < 2)
	{
		if(document.all.tkt_date.value.trim()=="")
		{
			rdShowMessageDialog("请输入日期");
			return;
		}
		var date = document.all.tkt_date.value.trim();
  		//2010年5月1日-5月3日、10月1日-10月7日、10月25日-10月31日
  		if( !((date <= 20100503 && date >=20100501) || (date <= 20101007 && date >=20101001) || (date <= 20101031 && date >=20101025)))
  		{
  			rdShowMessageDialog("票期不符！请注意票期取值范围。");	
  			return;
  		}
  		arrtktdate.push(document.all.tkt_date.value); 
	}
	else
	{
		arrtktdate.push("00000000"); 
	}	
	newRow=IList.insertRow();   
	newCell=newRow.insertCell();   
	newCell.innerHTML="<tr ><th align='center'>"+document.all.sRoleCode.text+"</th>";
	newCell = newRow.insertCell();
	newCell.innerHTML="<th align='center'>"+document.all.tkt_sum.value+"</th>";
	newCell = newRow.insertCell();
	newCell.innerHTML="<th align='center'>"+document.all.tkt_date.value+"</th></tr>";
	newCell = newRow.insertCell();
	newCell.innerHTML="<th align='center'>"+document.all.groupTag.value+"</th></tr>";
	arrtkttype.push(document.all.sRoleCode.value);
	arrtktsum.push(document.all.tkt_sum.value);
	arrtkttag.push(document.all.groupTag.value);
	

}
function DeleteRow()
{
	if(IList.rows.length >1)
	{
		IList.deleteRow();
		arrtkttype.pop();
      	arrtktsum.pop();
      	arrtktdate.pop();
      	arrtkttag.pop();
    }
}
function selectInput(choose)
{ 
	document.all.sRoleCode.text = document.all.sRoleCode.options[document.all.sRoleCode.selectedIndex].text; 
	if(choose.selectedIndex < 2)
	{
		document.getElementById("tr_ticket_note").style.display = "";
		document.getElementById("tr_ticket_date").style.display = "";
		document.all.tkt_date.value = "";
	}
	else
	{
		document.getElementById("tr_ticket_note").style.display = "none";
		document.getElementById("tr_ticket_date").style.display = "none";
		document.all.tkt_date.value = "-";
	}
}
</script> 
 
<title>世博会门票预定</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6917_2.jsp" method="post" name="frm6917"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="tkt_type_array" value="">
	<input type="hidden" name="tkt_sum_array" value="">
	<input type="hidden" name="tkt_date_array" value="">
	<input type="hidden" name="tkt_tag_array" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会门票预定</div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr> 
		<td class="blue" width="15%">票种:</td>
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
		<td class="blue" width="15%">票数:</td>
		<td> 
			<input name="tkt_sum" type="text" id="tkt_sum" size="17" maxlength="8"  onKeyPress="return isKeyNumberdot(0)"><font color="red"> *</font></td>
    	</td>
	</tr>
	<tr id="tr_ticket_date">
		<td class="blue" width="15%">日期(YYYYMMDD):</td>
		<td>
			<input name="tkt_date" type="text" id="tkt_date" size="17"  maxlength="8" onKeyPress="return isKeyNumberdot(0)"> <font color="red"> *</font>
		</td>
	</tr>
	<tr id="tr_ticket_note"> 
		<td class="blue" width="15%">票期取值范围:</td>
		<td class="blue" width="85%">2010年5月1日-5月3日、10月1日-10月7日、10月25日-10月31日，共17天。</td>
	</tr>
	<tr>
		<td class="blue">售票类型:</td>
		<td>
			<select type="text" name="groupTag" class="button" id="groupTag">
				<option value="0" selected>0->个人票</option>
				<option value="1">1>团体票</option>
			</select><font color="red"> *</font></td>
		</td>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="add"  class="b_foot" value="增加" onclick="AddRow()">
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="删除" onclick="DeleteRow()">
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commitJsp()">			
		</td>
	</tr>
</table>
<table " border="4" align="center" cellPadding=0 cellSpacing=0  width="95%">
   <tr>
   <td>
   <table  id="IList" align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
   	<tr><th align="center">票种</th><th align="center">票数</th><th align="center">日期</th><th align="center">标识</th></tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>

</td>
</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
