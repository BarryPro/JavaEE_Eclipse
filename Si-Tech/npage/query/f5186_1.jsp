 <!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ������Ϣ��ѯ5186
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
	String opCode="5186";
	String opName="�Ż���Ϣ��ѯ";
	//String phoneNo = (String)request.getParameter("activePhone");			//�ֻ�����
	activePhone = request.getParameter("activePhone");
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>�Ż���Ϣ��ѯ</TITLE>
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
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	var s_year_month = document.frm5186.yearmonth.value;
	if(document.frm5186.phoneNo.value=="")
	{	rdShowMessageDialog("�������ѯ������");
		document.frm5186.phoneNo.focus();
		return false;
	}
	else if(s_year_month=="")
	{
		rdShowMessageDialog("�������ѯ���£�");
		document.frm5186.s_year_month.focus();
		return false;
	}
	else{
	document.frm5186.action="f5186_2.jsp";
	document.frm5186.Button1.disabled=true;
	frm5186.submit();
	}
	return true;
}

</SCRIPT>

<FORM method=post name="frm5186">
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode"  value="5186">
<input type="hidden" name="custPass"  value="">
	<div class="title">
		<div id="title_zi">�Ż���Ϣ��ѯ</div>
	</div>
<table cellspacing="0">
		<TR> 
	      <td class="blue">�������</TD>
          <td>
          	<input type="text"  name="phoneNo" readonly size="20" maxlength="11" onKeyDown="if(event.keyCode==13){doCheck();return false}" value="<%=activePhone%>">
		 
          </td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;
          </td>
          </TR>
		 
		  <TR> 
	      <td class="blue">��ѯ����</TD>
          <td>
          	
			<input type="text"  name="yearmonth" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="6"  >
			<input type="submit" class="b_text" name="Button1" value="��ѯ" onclick="doCheck()">
          </td>
          <td class="blue">&nbsp;</td>
          <td>&nbsp;
          </td>
          </TR>
			
			<TR>
		      	<td class="blue">�ͻ�����</TD>
		       	<TD><input class="InputGrey" type="text" name="cust_name"  maxlength="25" size=20 readonly></TD>
		      	<td class="blue">����ʱ��</TD>
		      	<TD><input class="InputGrey" type="text" name="open_time"  maxlength="25" size=20 readonly></TD>
		    </TR>
			<tr>
				<td class="blue">��ͨ����Ӧ�Żݷ�����</TD>
		    	<TD><input class="InputGrey"  type="text" name="totalFav"  maxlength="25" size=20 readonly></TD>
		   		<td class="blue">��ͨ�������Żݷ�����</TD>
				<TD><input class="InputGrey" type="text" name="usedFav" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">���ӵ绰Ӧ�Żݷ�����</TD>
		    	<TD><input class="InputGrey"  type="text" name="totalCmwap"  maxlength="25" size=20 readonly></TD>
		   		<td class="blue">���ӵ绰���Żݷ�����</TD>
				<TD><input class="InputGrey" type="text" name="usedCmwap" maxlength="25" size=20 readonly></TD>
			</tr>
			
			<tr>
				<td class="blue">Ӧ�Żݶ�����</TD>
		    	<TD><input class="InputGrey" type="text" name="totalMessFav" maxlength="25" size=20 readonly></TD>
		    	<td class="blue">���Żݶ�����</TD>
		    	<TD><input class="InputGrey" type="text" name="usedMessFav" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">�ײ���Ӧ�Ż�GPRS����</TD>
		    	<TD><input class="InputGrey" type="text" name="totalGprsFav" maxlength="25" size=20 readonly></TD>
		    	<td class="blue">�ײ������Ż�GPRS����</TD>
		    	<TD><input class="InputGrey" type="text" name="usedGprsFav" maxlength="25" size=20 readonly></TD>
			</tr>
			<tr>
				<td class="blue">�ײ�����ʹ��GPRS����</TD>
		    	<TD><input class="InputGrey" type="text" name="otherGprsFav" maxlength="25" size=20 readonly></TD>
		    	<TD><input class="InputGrey" type="text" name="partUsedGprsFav" maxlength="25" size=20 readonly></TD>
		    	<TD><input class="InputGrey" type="text" name="partUsedGprsFav" maxlength="25" size=20 readonly></TD>
			</tr>		  
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
	        &nbsp;<input class="b_foot" name=reset  type=reset onClick="" value=���>
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	        &nbsp; 
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 
