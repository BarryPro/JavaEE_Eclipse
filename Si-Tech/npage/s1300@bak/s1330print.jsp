<%
	/********************
	 version v2.0
	������: si-tech
	update:zhaoht@2009-03-10 ҳ�����,�޸���ʽ
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gbk" %>

<%
    //String opCode = "1352";
	//String opName = "�мۿ����۷�Ʊ����";
		String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String belongName = (String)session.getAttribute("orgCode");
	
	String op_code = "1352";
	
	String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
    cal.add(Calendar.MONTH,-1);
    String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-�мۿ����۷�Ʊ����</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<script language="JavaScript">
<!--
function docheck() {   
	getAfterPrompt();
   if(document.form.login_accept.value.length ==0) {
	  rdShowMessageDialog("��ˮ���벻��Ϊ�գ����������룡");
	  document.form.login_accept.focus();
	  return false;
   }

   if(document.form.total_date.value.length == 0) {
	  rdShowMessageDialog("�������ڲ���Ϊ�գ����������룡");
	  document.form.total_date.focus();
	  return false;
   }

   document.form.submit();
}
//-->
</script>
</HEAD>
<BODY>
<FORM action="s1330print_print.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
  <INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
  <INPUT TYPE="hidden" name="opCode" value="<%=opCode%>">
  <INPUT TYPE="hidden" name="opName" value="<%=opName%>">
  

             <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue">ҵ������</td>
                  <td>�мۿ����۷�Ʊ����</td>
                  <td>����</wl:cache><%=belongName%><wl:cache name="s1352_3" timeout="1d"></td>
                </tr>
                </tbody> 
              </table>
              <table id=tbs9 cellspacing="0">
                <tr> 
                  <td class="blue">��ˮ����</td>
                  <td> 
                    <input type="text" name="login_accept" size="20" maxlength="20" onKeyPress="return isKeyNumberdot(0)">
                  </td>
                  <td class="blue">��������</td>
                  <td>
                  	<input type="text" name="total_date" size="20" maxlength="8" onKeyPress="return isKeyNumberdot(0)">
                  </td>
                </tr>
              </table>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td id="footer"> 
                    <input class="b_foot" name=sure type="button" value=ȷ�� onclick="docheck()">
                    &nbsp;
                    <input class="b_foot" name=clear type=reset value=���>
                    &nbsp;
                    <input class="b_foot" name=reset type=button value=�ر� onClick="removeCurrentTab()">
                  </td>
                </tr>
                </tbody> 
              </table>
             <%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</BODY>
 </HTML>