<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:��������Ʊ��Ʊ��ѯ
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
 
	String opCode = "6919";
	String opName = "��������Ʊ��Ʊ��ѯ";
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

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	


var arrtktname = new Array(); 
var arrtktcode = new Array();  
var arrtkttype = new Array();
var arrtktdate = new Array();  

<%  
	for(int i=0;i<roleDetailData.length;i++)
  	{
		out.println("arrtktcode["+i+"]='"+roleDetailData[i][0]+"';\n");
		out.println("arrtktname["+i+"]='"+roleDetailData[i][1]+"';\n");
	}
%>
onload=function()
{		
	init();
}

// ��ʼ��
function init()
{
	selectInput(document.all.sRoleCode);
	
}
function commitJsp()
{
	getAfterPrompt();
		var tmpStr="";
		var procSql = "";
		if(IList.rows.length <=1)
		{
			rdShowMessageDialog("�����Ӳ�ѯ����!");
			return false;					
		}	
		for(var i = 0; i < IList.rows.length - 1; i++)
		{
			if("" == document.all.tkt_type_array.value)
			{
				document.all.tkt_type_array.value = arrtkttype[i];
				document.all.tkt_date_array.value = arrtktdate[i];
			}
			else
			{
				document.all.tkt_type_array.value = document.all.tkt_type_array.value + "|" + arrtkttype[i];
				document.all.tkt_date_array.value = document.all.tkt_date_array.value + "|" + arrtktdate[i];
			}
		}
		if(document.all.tkt_type_array.value.length > 256
		   || document.all.tkt_date_array.value.length > 256
		   )
		{
			rdShowMessageDialog("��ɾ����ѯ����!");
			document.all.tkt_type_array.value="";
		    document.all.tkt_date_array.value="";
			return false;
		}
		frm6919.submit();
}


function AddRow()
{
	if(document.all.sRoleCode.value.trim() == "01" ||  document.all.sRoleCode.value.trim() == "02" )
	{
		if(document.all.ticket_date.value.trim() == "")
	  	{
	  		rdShowMessageDialog("������Ʊ��");	
	  		return;
	  	}
	  	else
	  	{
	  		var date = document.all.ticket_date.value.trim();
	  		//2010��5��1��-5��3�ա�10��1��-10��7�ա�10��25��-10��31��
	  		if( !((date <= 20100503 && date >=20100501) || (date <= 20101007 && date >=20101001) || (date <= 20101031 && date >=20101025)))
	  		{
	  			rdShowMessageDialog("Ʊ�ڲ�������ע��Ʊ��ȡֵ��Χ��");	
	  			return;
	  		}
	  	}
	  	arrtktdate.push(document.all.ticket_date.value);
	}
	else
	{
		document.all.ticket_date.value = "-";
		arrtktdate.push("00000000");
	}
	newRow=IList.insertRow();   
	newCell=newRow.insertCell();   
	newCell.innerHTML="<tr><th align='center'>"+document.all.sRoleCode.text+"</th>";
	newCell = newRow.insertCell();
	newCell.innerHTML="<th align='center'>"+("" == document.all.ticket_date.value ? "��" : document.all.ticket_date.value)+"</th></tr>"; 
	arrtkttype.push(document.all.sRoleCode.value);

}
function DeleteRow()
{
	if(IList.rows.length >1)
	{
		IList.deleteRow();
		arrtktdate.pop();
      	arrtkttype.pop();
    }
}
function selectInput(choose)
{ 
	document.all.sRoleCode.text = choose.options[choose.selectedIndex].text; 
	if(choose.selectedIndex < 2)
	{
		document.getElementById("tr_ticket_date").style.display = "";
		document.getElementById("tr_ticket_note").style.display = "";
		document.getElementById("ticket_date").value="";
	}
	else
	{
		document.getElementById("tr_ticket_date").style.display = "none";
		document.getElementById("tr_ticket_note").style.display = "none";
		document.getElementById("ticket_date").value="";
	}
}
</script> 
 
<title>��������Ʊ��Ʊ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6919_2.jsp" method="post" name="frm6919"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="tkt_type_array" value="">
	<input type="hidden" name="tkt_date_array" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��������Ʊ��Ʊ��ѯ</div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr> 
		<td class="blue" width="15%">Ʊ��</td>
		<td> 
			<select type="text" name="sRoleCode" class="button" id="sRoleCode" v_must="1" onchange="selectInput(this)"> 
			    <%for (int i = 0; i < roleDetailData.length; i++) {%>
			      <option value="<%=roleDetailData[i][0]%>"><%=roleDetailData[i][0]%>-><%=roleDetailData[i][1]%>
			      </option>
			    <%}%>
      		</select>
    	</td>
  	</tr>
	<tr id="tr_ticket_date">
		<td class="blue" width="15%">Ʊ��(YYYYMMDD):</td>
		<td> 
			<input name="ticket_date" type="text" id="ticket_date" size="15" maxlength="8"  onKeyPress="return isKeyNumberdot(0)" ><font color="red"> *</font></td>
    	</td>
	</tr>
	<tr id="tr_ticket_note"> 
		<td class="blue" width="15%">Ʊ��ȡֵ��Χ:</td>
		<td class="blue" width="85%">2010��5��1��-5��3�ա�10��1��-10��7�ա�10��25��-10��31�գ���17�졣</td>
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
<table  border="3" align="center" cellPadding=0 cellSpacing=0  width="95%">
   <tr>
   <td>
   <table  id="IList" align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
   	<tr><th align="center"  width="50%">Ʊ��<th align="center" width="50%">Ʊ��</th></tr>
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
