<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:��������ƱԤ��
   * �汾: 1.0
   * ����: 2009/5/13
   * ����: wangjya
   * ��Ȩ: si-tech
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
	String opName = "��������ƱԤ��";
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
	 	rdShowMessageDialog("��ѯƱ������ʧ�ܣ�" + "[<%=retCode1%>]"+ "<%=retMsg1%>");	
	 	removeCurrentTab();
		</script>
<%		
		return;				 			
	}
	if(0 == roleDetailData.length)
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯƱ������ʧ�ܣ�");	
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

// ��ʼ��
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
			rdShowMessageDialog("������Ԥ����!");
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
			rdShowMessageDialog("��ɾ��Ԥ����!");
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
			rdShowMessageDialog("ͬһƱ��ֻ�����һ��!");	
	 		return;
		}
		if(arrtkttag[i] != document.all.groupTag.value)
		{
			rdShowMessageDialog("һ������ֻ�����һ����Ʊ����!");	
	 		return;
		}
	}
	
	if((document.all.sRoleCode.value != "03") && (document.all.groupTag.value == "1"))
	{
		rdShowMessageDialog("ֻ��ƽ����ͨƱ������������Ʊ!");
		document.all.groupTag.value="0";
	 	return;
	}
	if(document.all.groupTag.value==1 && document.all.tkt_sum.value < 30)
	{
		rdShowMessageDialog("����Ʊ����Ʊ����������ڻ����30��!");
		document.all.tkt_sum.value = "";
		document.all.groupTag.value="0";
	 	return;
	}
	
	if(document.all.tkt_sum.value.trim()=="")
	{
	  rdShowMessageDialog("������Ʊ��");	
	  return;
	}
	if(document.all.tkt_sum.value > 50000)
	{
		rdShowMessageDialog("Ʊ�����ܴ���50000��");
		return;
	}
	
	if(document.all.sRoleCode.selectedIndex < 2)
	{
		if(document.all.tkt_date.value.trim()=="")
		{
			rdShowMessageDialog("����������");
			return;
		}
		var date = document.all.tkt_date.value.trim();
  		//2010��5��1��-5��3�ա�10��1��-10��7�ա�10��25��-10��31��
  		if( !((date <= 20100503 && date >=20100501) || (date <= 20101007 && date >=20101001) || (date <= 20101031 && date >=20101025)))
  		{
  			rdShowMessageDialog("Ʊ�ڲ�������ע��Ʊ��ȡֵ��Χ��");	
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
 
<title>��������ƱԤ��</title>
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
		<div id="title_zi">��������ƱԤ��</div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr> 
		<td class="blue" width="15%">Ʊ��:</td>
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
		<td class="blue" width="15%">Ʊ��:</td>
		<td> 
			<input name="tkt_sum" type="text" id="tkt_sum" size="17" maxlength="8"  onKeyPress="return isKeyNumberdot(0)"><font color="red"> *</font></td>
    	</td>
	</tr>
	<tr id="tr_ticket_date">
		<td class="blue" width="15%">����(YYYYMMDD):</td>
		<td>
			<input name="tkt_date" type="text" id="tkt_date" size="17"  maxlength="8" onKeyPress="return isKeyNumberdot(0)"> <font color="red"> *</font>
		</td>
	</tr>
	<tr id="tr_ticket_note"> 
		<td class="blue" width="15%">Ʊ��ȡֵ��Χ:</td>
		<td class="blue" width="85%">2010��5��1��-5��3�ա�10��1��-10��7�ա�10��25��-10��31�գ���17�졣</td>
	</tr>
	<tr>
		<td class="blue">��Ʊ����:</td>
		<td>
			<select type="text" name="groupTag" class="button" id="groupTag">
				<option value="0" selected>0->����Ʊ</option>
				<option value="1">1>����Ʊ</option>
			</select><font color="red"> *</font></td>
		</td>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="add"  class="b_foot" value="����" onclick="AddRow()">
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="ɾ��" onclick="DeleteRow()">
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="commitJsp()">			
		</td>
	</tr>
</table>
<table " border="4" align="center" cellPadding=0 cellSpacing=0  width="95%">
   <tr>
   <td>
   <table  id="IList" align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
   	<tr><th align="center">Ʊ��</th><th align="center">Ʊ��</th><th align="center">����</th><th align="center">��ʶ</th></tr>
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
