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
	String opCode="zgau";
	String opName="�߶��˷ѽ�������";
 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>�߶��˷ѽ�������</TITLE>
 
</HEAD>

<body>
<SCRIPT language="JavaScript">

function doCheck()
{
	//if(jtrim(document.frm5186.cus_pass.value).length ==0)
	//	document.frm5186.cus_pass.value="123456";   
	var s_login_no = document.frm5186.s_login_no.value;
	if(s_login_no=="")
	{
		rdShowMessageDialog("�����������õĹ���!");
		return false;
	}
	else if (s_login_no.substr(0,2)!="80")
	{
		rdShowMessageDialog("ֻ�пͷ����ſ��Խ��д�����!");
		return false;
	}
	else{
		document.frm5186.action="zgau_2.jsp?s_login_no="+s_login_no;
		//alert(document.frm5186.action);
		document.frm5186.submit();
	}
	 
}
function qry()
{
	document.frm5186.action="zgau_3.jsp";
	document.frm5186.submit();
}

</SCRIPT>

<FORM name="frm5186"  method=post>
<%@ include file="/npage/include/header.jsp" %>
 
	<div class="title">
		<div id="title_zi">�߶��˷ѽ�������</div>
	</div>
<table cellspacing="0">
		<TR> 
	      <td class="blue">���ù���</TD>
          <td colspan=3>
			<input type="text" name="s_login_no" maxlength=6>	
		  </td>
		</TR>
		<tr>
			<td colspan=3>
				��ע�����óɹ��Ĺ��Ž����˷Ѳ��������˷��޶�Ϊ300Ԫ��δ�������õĹ����޶�Ϊ150Ԫ��
			</td>
		</tr> 	 
	    <TR> 
	      <TD align="center" id="footer" colspan="4"> 
		  <input type=button class="b_foot" name="Button1" value="���" onclick="doCheck()">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name="qry1" onClick="qry()" type=button value="�����ù�����Ϣ��ѯ">
	        &nbsp; 
	        &nbsp;&nbsp;<input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
	      </TD>
	    </TR>
	    </table> 
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</body>
</html> 
