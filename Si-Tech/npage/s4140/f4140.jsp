 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page language="java" import="java.sql.*" %>
<html>
	<head>
	<title>Ͷ���˷�ԭ��ά������</title>
	<%@ include file="../../npage/s4140/head_4140_3_javascript.htm" %>
<%
	String opCode = "4140";
	String opName = "Ͷ���˷�ԭ��ά������";	//header.jsp��Ҫ�Ĳ���
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);
	String first_code="",str2="",second_code="",str3="";
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String str1 = "select first_name,first_code from SrefundFirst where region_code='"+regionCode+"' and valid_flag='1' order by first_code asc";
	System.out.println("str1==="+str1);
%>
<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:sql><%=str1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="returnStr1" scope="end" />

<%
	str2 = "select second_name,second_code from SrefundSecond where first_code in (select first_code from SrefundFirst where region_code='"+regionCode+"' and valid_flag='1') and valid_flag='1' order by second_code asc";
	System.out.println("str2==="+str2);
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
  String sysAccept = seq;
  System.out.println("sysAccept="+sysAccept);
%>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>

onload=function()
{
	document.all.opFlag[0].checked = true;
	document.all.opFlag1[0].checked = true;
	opchange1();
	document.all.confirm.focus();
	self.status="";
}

//----------------��֤���ύ����-----------------

function opchange()
{
	if(document.all.opFlag[0].checked==true)
	{
		document.all.add.style.display = "";
		document.all.opFlag1[0].checked = true;
		opchange1();
	
		document.all.add2.style.display = "none";
		document.all.classfirst_id2.style.display = "none";
		document.all.classsecond_id2.style.display = "none";
		document.all.classthird_id2.style.display = "none";
		
		document.all.classfirst_id3.style.display = "none";
		document.all.classsecond_id3.style.display = "none";
	}
	else if(document.all.opFlag[1].checked==true)
	{
		document.all.add.style.display = "none";
		document.all.classfirst_id.style.display = "none";
		document.all.classsecond_id.style.display = "none";
		document.all.classthird_id.style.display = "none";
		document.all.inclassfirst_id.style.display = "none";
		document.all.inclasssecond_id.style.display = "none";
		document.all.inclassthird_id.style.display = "none";
		
		document.all.add2.style.display = "";
		document.all.opFlag2[0].checked = true;
		opchange2();
		
		document.all.classfirst_id3.style.display = "none";
		document.all.classsecond_id3.style.display = "none";
	}
	else if(document.all.opFlag[2].checked==true)
	{
		document.all.add.style.display = "none";
		document.all.classfirst_id.style.display = "none";
		document.all.classsecond_id.style.display = "none";
		document.all.classthird_id.style.display = "none";
		document.all.inclassfirst_id.style.display = "none";
		document.all.inclasssecond_id.style.display = "none";
		document.all.inclassthird_id.style.display = "none";
	
		document.all.add2.style.display = "none";
		document.all.classfirst_id2.style.display = "none";
		document.all.classsecond_id2.style.display = "none";
		document.all.classthird_id2.style.display = "none";
		
		document.all.classfirst_id3.style.display = "";
		document.all.classsecond_id3.style.display = "";
	}
}

function opchange1()
{
	if(document.all.opFlag1[0].checked==true)
	{
		document.all.classfirst_id.style.display = "none";
		document.all.classsecond_id.style.display = "none";
		document.all.classthird_id.style.display = "none";
		document.all.inclassfirst_id.style.display = "block";
		document.all.inclasssecond_id.style.display = "none";
		document.all.inclassthird_id.style.display = "none";
	}
	else if(document.all.opFlag1[1].checked==true)
	{
		document.all.classfirst_id.style.display = "block";
		document.all.classsecond_id.style.display = "none";
		document.all.classthird_id.style.display = "none";
		document.all.inclassfirst_id.style.display = "none";
		document.all.inclasssecond_id.style.display = "block";
		document.all.inclassthird_id.style.display = "none";
	}
	else
	{
		document.all.classfirst_id.style.display = "block";
		document.all.classsecond_id.style.display = "block";
		document.all.classthird_id.style.display = "none";
		document.all.inclassfirst_id.style.display = "none";
		document.all.inclasssecond_id.style.display = "none";
		document.all.inclassthird_id.style.display = "block";
	}
}

function opchange2()
{
	if(document.all.opFlag2[0].checked==true)
	{
		document.all.classfirst_id2.style.display = "block";
		document.all.classsecond_id2.style.display = "none";
		document.all.classthird_id2.style.display = "none";
	}
	else if(document.all.opFlag2[1].checked==true)
	{
		document.all.classfirst_id2.style.display = "block";
		document.all.classsecond_id2.style.display = "block";
		document.all.classthird_id2.style.display = "none";
	}
	else if(document.all.opFlag2[2].checked==true)
	{
		document.all.classfirst_id2.style.display = "block";
		document.all.classsecond_id2.style.display = "block";
		document.all.classthird_id2.style.display = "block";
	}
}

function docomm(subButton)
{
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	if(!check(frm)) return false;
	if(document.all.opFlag[0].checked==true)
	{
		if(document.all.opFlag1[0].checked==true)
		{
			if(document.all.inclassfirst.value=="")
			{
				rdShowMessageDialog("������Ҫ���ӵ�һ��ԭ��!");
				return;
			}
			document.all.opFlag1[1].disabled=true;
			document.all.opFlag1[2].disabled=true;
		}
		else if(document.all.opFlag1[1].checked==true)
		{
			if (document.all.FirstClass.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
				return;
			}
			if(document.all.inclasssecond.value=="")
			{
				rdShowMessageDialog("������Ҫ���ӵĶ���ԭ��!");
				return;
			}
			document.all.opFlag1[0].disabled=true;
			document.all.opFlag1[2].disabled=true;
		}
		else if(document.all.opFlag1[2].checked==true)
		{
			if (document.all.FirstClass.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
				return;
			}
			if (document.all.SecondClass.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷Ѷ���ԭ��!");
				return;
			}	
			if(document.all.inclassthird.value=="")
			{
				rdShowMessageDialog("������Ҫ���ӵ�����ԭ��!");
				return;
			}
			document.all.opFlag1[0].disabled=true;
			document.all.opFlag1[1].disabled=true;
		}

		frm.action="f4140_1Cfm.jsp";
	}
	else if(document.all.opFlag[1].checked==true)
	{
		if(document.all.opFlag2[0].checked==true)
		{
			if (document.all.FirstClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
				return;
			}
			document.all.opFlag2[1].disabled=true;
			document.all.opFlag2[2].disabled=true;
		}
		else if(document.all.opFlag2[1].checked==true)
		{
			if (document.all.FirstClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
				return;
			}
			if (document.all.SecondClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷Ѷ���ԭ��!");
				return;
			}
			document.all.opFlag2[0].disabled=true;
			document.all.opFlag2[2].disabled=true;
		}
		else if(document.all.opFlag2[2].checked==true)
		{
			if (document.all.FirstClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
				return;
			}
			if (document.all.SecondClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷Ѷ���ԭ��!");
				return;
			}
			if (document.all.ThirdClass2.value == 0)
			{
				rdShowMessageDialog("��ѡ���˷�����ԭ��!");
				return;
			}
			document.all.opFlag2[0].disabled=true;
			document.all.opFlag2[1].disabled=true;
		}

		frm.action="f4140_2Cfm.jsp";
	}
	else if(document.all.opFlag[2].checked==true)
	{
		if (document.all.FirstClass3.value == 0)
		{
			rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
			return;
		}
		
		frm.action="f4140_3.jsp";
	}
	
	frm.submit();
	return true;
}

</script>
</head>

<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">Ͷ���˷�ԭ��ά������ </div>
</div>
	<table cellspacing="0" >

		<TR>
			<TD width="16%" class="blue">��������</TD>
			<TD width="34%" >
				<input type="radio" name="opFlag" value="0" onclick="opchange()" checked>����&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="1" onclick="opchange()" >ɾ��&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="2" onclick="opchange()" >��ѯ
			</TD>
		</TR>

		<TR id="add">
			<TD width="16%" class="blue">����ԭ��</TD>
			<TD width="34%" >
				<input type="radio" name="opFlag1" value="0" onclick="opchange1()" >����һ��ԭ��&nbsp;&nbsp;
				<input type="radio" name="opFlag1" value="1" onclick="opchange1()" >���Ӷ���ԭ��&nbsp;&nbsp;
				<input type="radio" name="opFlag1" value="2" onclick="opchange1()" >��������ԭ��
			</TD>
		</TR>

		<tr id="classfirst_id" style="display:none">
			<td nowrap class=blue>�˷�һ��ԭ��</td>
			<td nowrap>
				<select name="FirstClass" class="button" onChange="tochange('secondclass')">
					<option value="">--��ѡ��--</option>
					<%for(int i=0; i<returnStr1.length; i++){%>
					<option value="<%=returnStr1[i][1]%>"><%=returnStr1[i][0]%></option>
					<%}%>
				</select>
			</td>
		</tr>
		<tr id="classsecond_id" style="display:none">
			<td nowrap class=blue>�˷Ѷ���ԭ��</td>
			<td nowrap>
				<select name="SecondClass" class="button" onChange="tochange('thirdclass')" >
				<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>
		<tr id="classthird_id" style="display:none">
			<td nowrap class=blue>�˷�����ԭ��</td>
			<td nowrap>
				<select name="ThirdClass" class="button">
				<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>

		<tr id="inclassfirst_id" style="display:none">
			<td nowrap class=blue>�����˷�һ��ԭ��</td>
			<td colspan="3">
				<input type="text" name="inclassfirst" size="50"  maxlength=20 >
			</td>
		</tr>
		<tr id="inclasssecond_id" style="display:none">
			<td nowrap class=blue>�����˷Ѷ���ԭ��</td>
			<td colspan="3">
				<input type="text" name="inclasssecond"  size="50"  maxlength=20 >
			</td>
		</tr>
		<tr id="inclassthird_id" style="display:none">
			<td nowrap class=blue>�����˷�����ԭ��</td>
			<td colspan="3">
				<input type="text" name="inclassthird"  size="50"  maxlength=20 >
			</td>
		</tr>

		<TR id="add2" style="display:none">
			<TD width="16%" class="blue">ɾ��ԭ��</TD>
			<TD width="34%" >
				<input type="radio" name="opFlag2" value="0" onclick="opchange2()">ɾ��һ��ԭ��&nbsp;&nbsp;
				<input type="radio" name="opFlag2" value="1" onclick="opchange2()">ɾ������ԭ��&nbsp;&nbsp;
				<input type="radio" name="opFlag2" value="2" onclick="opchange2()">ɾ������ԭ��
			</TD>
		</TR>

		<tr id="classfirst_id2" style="display:none">
			<td nowrap class=blue>�˷�һ��ԭ��</td>
			<td nowrap>
				<select name="FirstClass2" class="button" onChange="tochange2('secondclass2')">
					<option value="">--��ѡ��--</option>
					<%for(int i=0; i<returnStr1.length; i++){%>
					<option value="<%=returnStr1[i][1]%>"><%=returnStr1[i][0]%>-><%=returnStr1[i][1]%></option>
					<%}%>
				</select>
			</td>
		</tr>
		<tr id="classsecond_id2" style="display:none">
			<td nowrap class=blue>�˷Ѷ���ԭ��</td>
			<td nowrap>
				<select name="SecondClass2" class="button"  onChange="tochange2('thirdclass2')" >
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>
		<tr id="classthird_id2" style="display:none">
			<td nowrap class=blue>�˷�����ԭ��</td>
			<td nowrap>
				<select name="ThirdClass2" class="button">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>

		<tr id="classfirst_id3" style="display:none">
			<td nowrap class=blue>�˷�һ��ԭ��</td>
			<td nowrap>
				<select name="FirstClass3" class="button" onChange="tochange3('secondclass3')">
					<option value="">--��ѡ��--</option>
					<%for(int i=0; i<returnStr1.length; i++){%>
					<option value="<%=returnStr1[i][1]%>"><%=returnStr1[i][0]%>-><%=returnStr1[i][1]%></option>
					<%}%>
				</select>
			</td>
		</tr>
		<tr id="classsecond_id3" style="display:none">
			<td nowrap class=blue>�˷Ѷ���ԭ��</td>
			<td nowrap>
				<select name="SecondClass3" class="button">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>

	</table>
	<table cellspacing="0" >
	<tr>
		<td id="footer">
			<input type=button name="confirm" value="ȷ��" class="b_foot" onClick="docomm(this)">
			<input type=button name=back value="���" class="b_foot" onClick="frm.reset()">
			<input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">
		</td>
	</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
