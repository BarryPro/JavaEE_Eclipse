<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:�������ֻ�Ʊ֧��
   * �汾: 1.0
   * ����: 2009/8/17
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6946";
	String opName = "�������ֻ�Ʊ֧��";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String printAccept="";
	printAccept = getMaxAccept();
	
	StringBuffer  insql = new StringBuffer();
	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select to_char(sysdate,'YYYYMMDDHH24MMSS') ");
	sql.append(" from dual ");
	System.out.println("sql====="+sql);
	
	StringBuffer insql1 = new StringBuffer();
	insql1.append("select idtype_code,idtype_name ");
	insql1.append(" from sidcardcode ");
	insql1.append(" where use_flag='Y' and biz_type='01' ");
	insql1.append(" order by idtype_code  ");
	System.out.println("insql1====="+insql1);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="dateResult" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
<wtc:sql><%=insql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="idtypearray" scope="end" />
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
<% 
	if(!(retCode2.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯ��ǰʱ��ʧ�ܣ�" + "[<%=retCode2%>]"+ "<%=retMsg2%>");
	 	removeCurrentTab();
		</script>
<%
		return;
	}
	if(0 == dateResult.length)
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("��ѯ��ǰʱ��ʧ�ܣ�");
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

var arrtkttype = new Array();
var arrtktsum = new Array();  
var arrtktdate = new Array();

onload=function()
{	
	var pe = "<%=printAccept%>";
	var pr = pe.substr(pe.length-6,6);
	var oprNumb = "451BIP5A010"+"<%=dateResult[0][0]%>"+pr;
	document.all.login_accept.value=oprNumb;
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
	if(IList.rows.length <=1)
	{
		rdShowMessageDialog("������Ԥ����!");
		return false;
	}
	
	if(document.all.pay_fee.value == "")
	{
		rdShowMessageDialog("������Ӧ�����!");
		return false;
	}
	if(document.all.cust_name.value == "")
	{
		rdShowMessageDialog("��������Ʊ������!");
		return false;
	}
	if(document.all.id_card.value == "")
	{
		rdShowMessageDialog("��������Ʊ��֤������!");
		return false;
	}
	
	for(var i = 0; i < IList.rows.length - 1; i++)
	{
		if("" == document.all.tkt_type_array.value)
		{
			document.all.tkt_type_array.value = arrtkttype[i];
			document.all.tkt_sum_array.value = arrtktsum[i];
			document.all.tkt_date_array.value = arrtktdate[i];
		}
		else
		{
			document.all.tkt_type_array.value = document.all.tkt_type_array.value + "|" + arrtkttype[i];
			document.all.tkt_sum_array.value = document.all.tkt_sum_array.value + "|" + arrtktsum[i];
			document.all.tkt_date_array.value = document.all.tkt_date_array.value + "|" + arrtktdate[i];
		}
	}
	if(document.all.tkt_type_array.value.length > 256
	   || document.all.tkt_sum_array.value.length > 256
	   || document.all.tkt_date_array.value.length > 256
	   )
	{
		rdShowMessageDialog("��ɾ��Ԥ����!");
		document.all.tkt_type_array.value="";
	    document.all.tkt_sum_array.value="";
	    document.all.tkt_date_array.value="";
		return false;
	}
		
	document.all.mobileNo.value=document.all.mobile_no.value;
	document.all.phoneNo.value=document.all.phone_no.value;
	document.all.custName.value=document.all.cust_name.value;
	document.all.idType.value=document.all.sid_type.value;
	document.all.idCard.value=document.all.id_card.value;
	document.all.custAddress.value=document.all.cust_address.value;
	document.all.postCode.value=document.all.post_code.value;
	document.all.pay_fee1.value=document.all.pay_fee.value;
	document.all.commit_type.value=document.all.transTag.value;
	document.all.opr_numb.value=document.all.login_accept.value;
	document.all.set_tlement.value=document.all.settlement.value;
	document.all.s_voucher.value=document.all.svoucher.value;
	document.all.getType.value=document.all.sget_type.value;
	frm.submit();
}


function AddRow()
{
	if(document.all.tkt_sum.value >= 6)
	{
		rdShowMessageDialog("�ֻ�Ʊ�������ɳ���5��!");
		document.all.tkt_sum.value = "";
		return false;
	}
	var i = 0;
	for(;i < arrtkttype.length;i++)
	{
		if(arrtkttype[i] == document.all.sRoleCode.value)
		{
			rdShowMessageDialog("ͬһƱ��ֻ�����һ��!");	
	 		return;
		}
		if(i >= 0)
		{
			rdShowMessageDialog("ÿ������ֻ�����һ��Ʊ��!");	
 			return;
		}
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
	arrtkttype.push(document.all.sRoleCode.value);
	arrtktsum.push(document.all.tkt_sum.value);
	

}
function DeleteRow()
{
	if(IList.rows.length >1)
	{
		IList.deleteRow();
		arrtkttype.pop();
      	arrtktsum.pop();
      	arrtktdate.pop();
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
 
<title>�������ֻ�Ʊ֧��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6946Cfm.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="tkt_type_array" value="">
	<input type="hidden" name="tkt_sum_array" value="">
	<input type="hidden" name="tkt_date_array" value="">
	<input type="hidden" name="printAccept" value="<%=printAccept%>">
	<input type="hidden" name="getType" value="2">
	<input type="hidden" name="mobileNo" value="">
	<input type="hidden" name="phoneNo" value="">
	<input type="hidden" name="custName" value="">
	<input type="hidden" name="idType" value="">
	<input type="hidden" name="idCard" value="">
	<input type="hidden" name="voucher" value="">
	<input type="hidden" name="custAddress" value="">
	<input type="hidden" name="postCode" value="">
	<input type="hidden" name="pay_fee1" value="">
	<input type="hidden" name="commit_type" value="">
	<input type="hidden" name="opr_numb" value="">
	<input type="hidden" name="set_tlement" value="">
	<input type="hidden" name="s_voucher" value="">
	<input type="hidden" name="getType" value="">
	<input type="hidden" name="transTag" value="0">
	<input type="hidden" name="settlement" value="0">
	<input type="hidden" name="svoucher" value="1">
	<input type="hidden" name="sget_type" value="2">
	<input type="hidden" name="post_code" value=" ">
	<input type="hidden" name="cust_address" value=" ">
	<input type="hidden" name="mobile_no" value=" ">
	<input type="hidden" name="phone_no" value=" ">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������ֻ�Ʊ֧��</div>
	</div>
<table cellspacing="0" id="sel"  >             
	<tr>
		<td class="blue">������ˮ��</td>
		<td colspan="3">
			<input name="login_accept" type="text" class="InputGrey" id="login_accept" size="35" maxlength="32" readonly></td>
		</td>
	</tr>
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
    	<td class="blue" width="15%">Ʊ��:</td>
		<td> 
			<input name="tkt_sum" type="text" id="tkt_sum" size="17" maxlength="8"  onKeyPress="return isKeyNumberdot(0)"><font color="red"> *</font></td>
    	</td>
  	</tr>
	<tr id="tr_ticket_date">
		<td class="blue" width="15%">����(YYYYMMDD):</td>
		<td colspan="3">
			<input name="tkt_date" type="text" id="tkt_date" size="17"  maxlength="8" onKeyPress="return isKeyNumberdot(0)"> <font color="red"> *</font>
		</td>
	</tr>
	<tr id="tr_ticket_note"> 
		<td class="blue" width="15%">Ʊ��ȡֵ��Χ:</td>
		<td class="blue" colspan="3">2010��5��1��-5��3�ա�10��1��-10��7�ա�10��25��-10��31�գ���17�졣</td>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="4"> 
		<input type="button" name="add"  class="b_foot" value="����" onclick="AddRow()">
		&nbsp;
		<input type="button" name="delete" class="b_foot" value="ɾ��" onclick="DeleteRow()">
		</td>
	</tr>
	<tr>
		<td  class="blue">Ӧ�����</td>
    	<td><input class="button" name="pay_fee" type="text" id="pay_fee" maxlength="13"  value=""><font color="red"> *</font></td>   			
		<td class="blue">��Ʊ������</td>
		<td> 
			<input name="cust_name" type="text" id="cust_name" size="32" maxlength="32" ><font color="red"> *</font></td>
		</td>
	</tr>
	
	<tr>
		<td class="blue">��Ʊ��֤������</td>
		<td>
			<select type="text" name="sid_type" class="button" id="sid_type" v_must="1"> 
			<%for (int i = 0; i < idtypearray.length; i++) 
			{%>
		      <option value="<%=idtypearray[i][0]%>"><%=idtypearray[i][0]%>-><%=idtypearray[i][1]%>
		      </option>
		    <%}%> 
			</select>
		</td>
		<td class="blue">��Ʊ��֤������</td>
		<td> 
			<input name="id_card" type="text" id="id_card" size="32" maxlength="32" ><font color="red"> *</font></td>
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="commitJsp()">			
		</td>
	</tr>
</table>
<table " border="4" align="center" cellPadding=0 cellSpacing=0  width="95%">
	<tr>
   		<td>
	   		<table  id="IList" align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
	   			<tr><th align="left">Ʊ��</th><th align="left">Ʊ��</th><th align="left">����</th></tr>
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
