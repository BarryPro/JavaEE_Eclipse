<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "e630";
	String opName = "�����������ʲ�ѯ";
 
 	String[] inParas2 = new String[2];
	String contract_no = request.getParameter("contract_no").trim();
	String year_month = request.getParameter("year_month").trim();
	inParas2[0] = "select to_char(fetch_no),to_char(login_accept),to_char(total_date),to_char(login_no) from wGrpConOpr where contract_no = :contractNo and year_month=:yearMonth and back_flag in('00','0')";
	inParas2[1]="contractNo="+contract_no+",yearMonth="+year_month;
	boolean canPrint = false;
	String fetch_no = "";
	String login_accept = "";
	String total_date = "";
	String login_no = "";

%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="ret_val2" scope="end" />

 
<%
	if(ret_val2==null||ret_val2.length==0)
	{
		%><script language="javascript">
			//rdShowMessageDialog("û�в������ݣ������²�ѯ!");
			window.location="e630_4.jsp?contractNo="+"<%=contract_no%>";
		  </script><%
	}
	else
	{
		fetch_no = ret_val2[0][0];
	    login_accept = ret_val2[0][1];
	    total_date =	ret_val2[0][2];
	    login_no = ret_val2[0][3];
	    canPrint = true;
		
		%> 
			<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>�����������ʲ�ѯ</TITLE>
</HEAD>
<body>
<FORM action="e630_3.jsp" method="post" name="form" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������ʱ���</div>
	</div>
	<table cellspacing="0" id="tabList">
 
    <tr>
		<td>��ͬ���룺</td>
		<td><input type="text" name="contract_no" class="button" value="<%=contract_no%>" readonly></td>
		<td>�������£�</td>
		<td><input type="text" name="year_month"  class="button" value="<%=year_month%>" readonly></td>
	</tr>
	<tr>
		<td>ȷ�����Σ�</td>
		<td><input type="text" class="button" value="<%=fetch_no%>" readonly></td>
		<td>ȷ����ˮ��</td>
		<td><input type="text" class="button" value="<%=login_accept%>" readonly></td>
	</tr>
	<tr>
		<td>ȷ�����ڣ�</td>
		<td><input type="text" class="button" value="<%=total_date%>" readonly></td>
		<td>ȷ�Ϲ��ţ�</td>
		<td><input type="text" class="button" value="<%=login_no%>" readonly></td>
	</tr>
		 
		 
		 
 

 
	<tr>
		<td align="center" id="footer" colspan="8">
			<input class="b_foot" name="sure" type="button" value="ȷ��" onClick="dosubmit()">
		&nbsp; <input class="b_foot" name=back onClick="window.location='e630_1.jsp'" type="button" value="����">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
		<%
	}
%> 

<SCRIPT type="text/javascript">
function dosubmit() {
   var contract_no = document.form.contract_no.value;
   var year_month = document.form.year_month.value;

   if (contract_no.length == 0) {
       rdShowMessageDialog("��ͬ���벻��Ϊ�գ����������룡");
       document.form.contract_no.focus();
       return false;   
   } else if (year_month.length == 0){
       rdShowMessageDialog("�������²���Ϊ�գ����������룡");
       document.form.year_month.focus();
       return false;
   } else if (year_month.length < 6){
       rdShowMessageDialog("�������¸�ʽ����ȷ�����������룡");
       document.form.year_month.focus();
       return false;
   } else {
      document.form.sure.disabled=true;
      form.submit();
   }
}
</script>