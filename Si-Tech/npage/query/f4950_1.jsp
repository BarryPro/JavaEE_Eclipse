<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: SIM����Ϣ��ѯ1505
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "4950";
	String opName = "�տ���Ϣ��ѯ";
	String regionCode = (String)session.getAttribute("regCode");
                                                 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>�տ���Ϣ��ѯ</TITLE>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

</HEAD>

<body>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)  
		return (false);
	}
	return true;
}

function doCheck()

{	//alert(document.frm1505.querytype.value);
	
	if( document.frm1505.cardNo.value.length!=16) 
	{	alert("��������ȷ�Ĳ�ѯ������");
		
		return false;
	} 
	
	document.frm1505.action="f4950_2.jsp";
	document.frm1505.submit();
	
	//return true;
}

</SCRIPT>

<FORM method=post name="frm1505" ">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="1505">
	<div class="title">
		<div id="title_zi">�տ���Ϣ��ѯ</div>
	</div>
<TABLE cellSpacing="0">
	<!--<TR> 
		<TD class="blue">��ѯ���ͣ�</TD>
		<TD>
			<select name="querytype">
				<option value="0">SIM���� </option>
				<option value="1">�տ����к� </option>
			</select>
			<TD class="blue">&nbsp;</TD>
		<TD>
			&nbsp;
		</TD>
		
	</TR>-->
	<TR> 
		<TD class="blue">�տ����кţ�</TD>
		<TD>
			
			<input type="text" class="button" name="cardNo" size="20" maxlength="20">
			<input type="button" class="b_text" onclick="doCheck()" name="Button1" value="��ѯ" >
		</TD>
		<TD class="blue">��Ӧ��SIM������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="simNo" size="20" maxlength="11">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">�տ�����</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="cardType" size="20" maxlength="15">
		</TD>
		<TD class="blue">�տ�״̬</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="cardStatus" size="20" maxlength="7">
		</TD>
	</TR>
	
	<TR> 
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="regionCode" size="20" maxlength="20">
		</TD>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="disCode" size="20" maxlength="30">
		</TD>
	</TR>  
	<TR> 
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="townCode" size="20" maxlength="30">
		</TD>
		<TD class="blue">&nbsp;</TD>
		<TD>
			&nbsp;
		</TD>
	</TR>   
	
	
	           
	<tr> 
		<td id="footer" align="center" colspan="4">
		&nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=���>
		&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		&nbsp; 
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->
