 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ��ѯ1506
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
	String opCode="1506";
	String opName="������Ϣ��ѯ";
	//String phoneNo = (String)request.getParameter("activePhone");			//�ֻ�����
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>������Ϣ��ѯ</TITLE>
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
		if (RefString.indexOf(TempChar, 0)==-1)  
		return (false);
	}
	return true;
}

function doCheck()
{			
	document.frm1506.Button1.disabled=true;
	
	if(!forMobil(document.frm1506.phoneNo))
  {
  	document.frm1506.Button1.disabled=false;
  	return false;
  }
	document.frm1506.action="f1506_2.jsp";
	frm1506.submit();
}

</SCRIPT>

<FORM method=post name="frm1506" OnSubmit="return doCheck()"">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="1506">
	<div class="title">
		<div id="title_zi">������Ϣ��ѯ</div>
	</div>
<table cellspacing="0">
	<TR> 
		<TD class="blue">�������</TD>
		<TD>
			<input type="text"  name="phoneNo" value="" size="20" maxlength="11">
			<input type="submit" class="b_text" name="Button1" value="��ѯ" onclick="doCheck()">
		</TD>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" class="InputGrey" readOnly name="group_id" size="20" maxlength="11">
		</TD>
	</TR>
	<TR>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="noType" size="20" maxlength="11">
		</TD>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="typeName" size="20" maxlength="30">
		</TD>                 
	</TR>
	<TR> 
		<TD class="blue">����״̬</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="resCode" size="20" maxlength="15">
		</TD>
		<TD class="blue">ѡ�ŷ�</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="choiceFee" size="20" maxlength="7">
		</TD>
	</TR>
	<TR> 
		<TD class="blue">����ʱ��</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="beginTime" size="20" maxlength="20">
		</TD>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="loginNo" size="20" maxlength="30">
		</TD>
	</TR>   
	<TR>
		<TD class="blue">������ˮ</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="loginAccept" size="20" maxlength="30">
		</TD>
		<TD class="blue">������ˮ</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="assignAccept" size="20" maxlength="30">
		</TD>
	</TR>   
	<TR>
		<TD class="blue">��������</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="totalDate" size="20" maxlength="30">
		</TD>
		<TD class="blue">����ʱ��</TD>
		<TD>
			<input type="text" readonly class="InputGrey" name="opTime" size="20" maxlength="30">
		</TD>
	</TR>                   
	<tr> 
		<td align="center" id="footer" colspan="4">
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
